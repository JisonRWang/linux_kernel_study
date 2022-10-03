#!/bin/bash

TERMINAL=gnome-terminal 

function qemu_debug()
{
    qemu-system-x86_64 -S -s \
        -m 1G \
        -smp 4 \
        -k en-us \
        -kernel build/arch/x86_64/boot/bzImage \
        -drive format=raw,file=build/jison-qemu/disk-master.raw \
        -append "root=/dev/sda init=/linuxrc nokaslr" &

    ${TERMINAL} -e "gdb -x gdbinit"
}

function qemu_run()
{
    qemu-system-x86_64 \
        -m 1G \
        -smp 4 \
        -k en-us \
        -kernel build/arch/x86_64/boot/bzImage \
        -drive format=raw,file=build/jison-qemu/disk-master.raw \
        -append "root=/dev/sda init=/linuxrc rw" &
}

function run_qemu_help()
{
    echo "You must pass one paremeter at one time."
    echo "Para 'run' means just running qemu."
    echo "Para 'debug' means you can debug by gdb."
}

if [ $# != 1  ];then
    run_qemu_help
    exit 0
fi

case $1 in 
    "run")
        qemu_run 
        ;;
    "debug")
        qemu_debug
        ;;
    *)
        run_qemu_help
        ;;
esac
