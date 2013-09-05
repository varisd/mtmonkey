#!/bin/bash

function qqsub1g() {
    qsub -cwd -o $2 -e $2 -S /bin/bash -V -j n -l h_vmem=1g -l mem_free=1g $1
}

langs=(cs en_cs fr en_fr de en_de)

c=1
    clients=$[10*$c]
    dir=logs_5
    mkdir $dir #!!!
    for p in {0..9..3}
    do
        begin=$[10*$p]

        # languages
        for l1 in {0..1}
        do        
        for l2 in $(eval echo {$[$l1+1]..2})
        do
        for l3 in $(eval echo {$[$l2+1]..3})
        do
        for l4 in $(eval echo {$[$l3+1]..4})
        do
        for l5 in $(eval echo {$[$l4+1]..5})
        do
            
            starttime=10
            starttime.pl $starttime #!!!
            for i in $(eval echo {1..${clients}})
            do
                client=$[$begin+$i-1]
                if [ $client -ge 100 ]
                then
                    client=$[$client-100]
                fi
                if [ $client -lt 10 ]
                then
                    client=0$client
                fi
                
                qqsub1g runBULK/testBULK_${langs[$l1]}_${client}.shc $dir #!!!
                qqsub1g runBULK/testBULK_${langs[$l2]}_${client}.shc $dir #!!!
                qqsub1g runBULK/testBULK_${langs[$l3]}_${client}.shc $dir #!!!
                qqsub1g runBULK/testBULK_${langs[$l4]}_${client}.shc $dir #!!!
                qqsub1g runBULK/testBULK_${langs[$l5]}_${client}.shc $dir #!!!

            done
            sleeptime=$[40*$c+$starttime]
            echo submitted langs ${langs[$l1]} ${langs[$l2]} ${langs[$l3]} ${langs[$l4]} ${langs[$l5]} with start $begin and $clients clients
            echo sleeping for $sleeptime
            sleep $sleeptime #!!!
        
        # end languages
        done
        done
        done
        done
        done

    done

