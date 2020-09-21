Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F358C2721E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIULKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:10:45 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:60551 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgIULKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:10:45 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 07:10:43 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id A23441C343B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:02:25 +0100 (IST)
Received: (qmail 19738 invoked from network); 21 Sep 2020 11:02:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.127])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2020 11:02:25 -0000
Date:   Mon, 21 Sep 2020 12:02:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, Mel Gorman <mgorman@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Jiri Vozar <jvozar@redhat.com>
Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
Message-ID: <20200921110222.GG3179@techsingularity.net>
References: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
 <20200907092717.GD3117@suse.de>
 <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
 <20200907123106.GA28232@linux.vnet.ibm.com>
 <20200908010717.12436-1-hdanton@sina.com>
 <CAE4VaGDVmAmSY1pkiDPGUm=F_0aTtaqjC7D11_ExCpSJ_Mhhmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGDVmAmSY1pkiDPGUm=F_0aTtaqjC7D11_ExCpSJ_Mhhmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:50:04PM +0200, Jirka Hladky wrote:
> 1) Threads stability has improved a lot. We see much fewer threads
> migrations. Check for example this heatmap based on the mpstat results
> collected while running sp.C test from the NAS benchmark. sp.C was run
> with 16 threads on a dual-socket AMD 7351 server with 8 NUMA nodes:
> 5.9 vanilla https://drive.google.com/file/d/10rojhTSQUSu-1aGQi-srr99SmVQ3Llgo/view?usp=sharing
> 5.9 with the patch
> https://drive.google.com/file/d/1eZdTBWvWMNvdvXqitwAlcKZ7gb-ySQUl/view?usp=sharing
> 
> The heatmaps are generated from the mpstat output (there are 5
> different runs at one picture). We collect CPU utilization every 5
> seconds. Lighter color corresponds to lower CPU utilization. Light
> color means that the thread may have run on different CPUs during that
> 5 seconds. Solid straight lines, on the other hand, mean that thread
> was running on the same CPU all the time. The difference is striking.
> 
> We see significantly fewer threads migrations across many different
> tests - NAS, SPECjbb2005, SPECjvm2008
> 

For all three, I see the point where it's better or worse depends on
overall activity. I looked at heatmaps for a variety of workloads and
visually the bigger differences tend to be with utilisation is relatively
low (e.g. one third of CPUs active).

> 2) We see also performance improvement in terms of runtime, especially
> at low load scenarios (number of threads being roughly equal to the 2*
> number of NUMA nodes). It fixes the performance drop which we see
> since 5.7 kernel, discussed for example here:
> https://lore.kernel.org/lkml/CAE4VaGB7+sR1nf3Ux8W=hgN46gNXRYr0uBWJU0oYnk7h00Y_dw@mail.gmail.com/
> 

This would make some sense given the original intent about allowing
imbalances that was later revised significantly. It depends on when
memory throughput is more important so the impact varies with the level
of untilisation.  For example, on a 2-socket machine running specjvm 2005
I see

specjbb
                               5.9.0-rc4              5.9.0-rc4
                                 vanilla        dstbalance-v1r1
Hmean     tput-1     46425.00 (   0.00%)    43394.00 *  -6.53%*
Hmean     tput-2     98416.00 (   0.00%)    96031.00 *  -2.42%*
Hmean     tput-3    150184.00 (   0.00%)   148783.00 *  -0.93%*
Hmean     tput-4    200683.00 (   0.00%)   197906.00 *  -1.38%*
Hmean     tput-5    236305.00 (   0.00%)   245549.00 *   3.91%*
Hmean     tput-6    281559.00 (   0.00%)   285692.00 *   1.47%*
Hmean     tput-7    338558.00 (   0.00%)   334467.00 *  -1.21%*
Hmean     tput-8    340745.00 (   0.00%)   372501.00 *   9.32%*
Hmean     tput-9    424343.00 (   0.00%)   413006.00 *  -2.67%*
Hmean     tput-10   421854.00 (   0.00%)   434261.00 *   2.94%*
Hmean     tput-11   493256.00 (   0.00%)   485330.00 *  -1.61%*
Hmean     tput-12   549573.00 (   0.00%)   529959.00 *  -3.57%*
Hmean     tput-13   593183.00 (   0.00%)   555010.00 *  -6.44%*
Hmean     tput-14   588252.00 (   0.00%)   599166.00 *   1.86%*
Hmean     tput-15   623065.00 (   0.00%)   642713.00 *   3.15%*
Hmean     tput-16   703924.00 (   0.00%)   660758.00 *  -6.13%*
Hmean     tput-17   666023.00 (   0.00%)   697675.00 *   4.75%*
Hmean     tput-18   761502.00 (   0.00%)   758360.00 *  -0.41%*
Hmean     tput-19   796088.00 (   0.00%)   798368.00 *   0.29%*
Hmean     tput-20   733564.00 (   0.00%)   823086.00 *  12.20%*
Hmean     tput-21   840980.00 (   0.00%)   856711.00 *   1.87%*
Hmean     tput-22   804285.00 (   0.00%)   872238.00 *   8.45%*
Hmean     tput-23   795208.00 (   0.00%)   889374.00 *  11.84%*
Hmean     tput-24   848619.00 (   0.00%)   966783.00 *  13.92%*
Hmean     tput-25   750848.00 (   0.00%)   903790.00 *  20.37%*
Hmean     tput-26   780523.00 (   0.00%)   962254.00 *  23.28%*
Hmean     tput-27  1042245.00 (   0.00%)   991544.00 *  -4.86%*
Hmean     tput-28  1090580.00 (   0.00%)  1035926.00 *  -5.01%*
Hmean     tput-29   999483.00 (   0.00%)  1082948.00 *   8.35%*
Hmean     tput-30  1098663.00 (   0.00%)  1113427.00 *   1.34%*
Hmean     tput-31  1125671.00 (   0.00%)  1134175.00 *   0.76%*
Hmean     tput-32   968167.00 (   0.00%)  1250286.00 *  29.14%*
Hmean     tput-33  1077676.00 (   0.00%)  1060893.00 *  -1.56%*
Hmean     tput-34  1090538.00 (   0.00%)  1090933.00 *   0.04%*
Hmean     tput-35   967058.00 (   0.00%)  1107421.00 *  14.51%*
Hmean     tput-36  1051745.00 (   0.00%)  1210663.00 *  15.11%*
Hmean     tput-37  1019465.00 (   0.00%)  1351446.00 *  32.56%*
Hmean     tput-38  1083102.00 (   0.00%)  1064541.00 *  -1.71%*
Hmean     tput-39  1232990.00 (   0.00%)  1303623.00 *   5.73%*
Hmean     tput-40  1175542.00 (   0.00%)  1340943.00 *  14.07%*
Hmean     tput-41  1127826.00 (   0.00%)  1339492.00 *  18.77%*
Hmean     tput-42  1198313.00 (   0.00%)  1411023.00 *  17.75%*
Hmean     tput-43  1163733.00 (   0.00%)  1228253.00 *   5.54%*
Hmean     tput-44  1305562.00 (   0.00%)  1357886.00 *   4.01%*
Hmean     tput-45  1326752.00 (   0.00%)  1406061.00 *   5.98%*
Hmean     tput-46  1339424.00 (   0.00%)  1418451.00 *   5.90%*
Hmean     tput-47  1415057.00 (   0.00%)  1381570.00 *  -2.37%*
Hmean     tput-48  1392003.00 (   0.00%)  1421167.00 *   2.10%*
Hmean     tput-49  1408374.00 (   0.00%)  1418659.00 *   0.73%*
Hmean     tput-50  1359822.00 (   0.00%)  1391070.00 *   2.30%*
Hmean     tput-51  1414246.00 (   0.00%)  1392679.00 *  -1.52%*
Hmean     tput-52  1432352.00 (   0.00%)  1354020.00 *  -5.47%*
Hmean     tput-53  1387563.00 (   0.00%)  1409563.00 *   1.59%*
Hmean     tput-54  1406420.00 (   0.00%)  1388711.00 *  -1.26%*
Hmean     tput-55  1438804.00 (   0.00%)  1387472.00 *  -3.57%*
Hmean     tput-56  1399465.00 (   0.00%)  1400296.00 *   0.06%*
Hmean     tput-57  1428132.00 (   0.00%)  1396399.00 *  -2.22%*
Hmean     tput-58  1432385.00 (   0.00%)  1386253.00 *  -3.22%*
Hmean     tput-59  1421612.00 (   0.00%)  1371416.00 *  -3.53%*
Hmean     tput-60  1429423.00 (   0.00%)  1389412.00 *  -2.80%*
Hmean     tput-61  1396230.00 (   0.00%)  1351122.00 *  -3.23%*
Hmean     tput-62  1418396.00 (   0.00%)  1383098.00 *  -2.49%*
Hmean     tput-63  1409918.00 (   0.00%)  1374662.00 *  -2.50%*
Hmean     tput-64  1410236.00 (   0.00%)  1376216.00 *  -2.41%*
Hmean     tput-65  1396405.00 (   0.00%)  1364418.00 *  -2.29%*
Hmean     tput-66  1395975.00 (   0.00%)  1357326.00 *  -2.77%*
Hmean     tput-67  1392986.00 (   0.00%)  1349642.00 *  -3.11%*
Hmean     tput-68  1386541.00 (   0.00%)  1343261.00 *  -3.12%*
Hmean     tput-69  1374407.00 (   0.00%)  1342588.00 *  -2.32%*
Hmean     tput-70  1377513.00 (   0.00%)  1334654.00 *  -3.11%*
Hmean     tput-71  1369319.00 (   0.00%)  1334952.00 *  -2.51%*
Hmean     tput-72  1354635.00 (   0.00%)  1329005.00 *  -1.89%*
Hmean     tput-73  1350933.00 (   0.00%)  1318942.00 *  -2.37%*
Hmean     tput-74  1351714.00 (   0.00%)  1316347.00 *  -2.62%*
Hmean     tput-75  1352198.00 (   0.00%)  1309974.00 *  -3.12%*
Hmean     tput-76  1349490.00 (   0.00%)  1286064.00 *  -4.70%*
Hmean     tput-77  1336131.00 (   0.00%)  1303684.00 *  -2.43%*
Hmean     tput-78  1308896.00 (   0.00%)  1271024.00 *  -2.89%*
Hmean     tput-79  1326703.00 (   0.00%)  1290862.00 *  -2.70%*
Hmean     tput-80  1336199.00 (   0.00%)  1291629.00 *  -3.34%*

Note as the utilisation reaches roughly half the CPUs that performance
is much better but then degrades for higher thread counts. Part of this
is that NUMA balancing activity is higher with the patch once roughly a
quarter of the CPUs are in use.

NAS is all over the map depending on the compute kernel and degree of
parallelisation. Sometimes it is much faster depending on the machine
and the degree of parallelisation, other times slower. Generally the
level of NUMA balancing activity is variable -- sometimes better,
sometimes worse and locality is generally lower (which is not a solid
conclusion as it's usually correlated with differences in hinting
faults).

There are counter-examples. On EPYC 2 running hackbench, locality and
scan activity is much worse with the patch. On hackbench using processes
and sockets, it is about 8% slower for small numbers of groups and 28%
slower for larger numbers of groups. On the same workload, NUMA activity
is much higher, locality goes from 50% to 1.5%. Bizarrely, with pipes
the patch is much better except in the opposite direction.

For something like dbench, it depends on the machine. All but one
machine showed an improvement. On EPYC 2, it's much worse.

> The biggest improvements are for the NAS and the SPECjvm2008
> benchmarks (typically between 20-50%). SPECjbb2005 shows also
> improvements, around 10%. This is again on NUMA servers at the low
> utilization. You can find snapshots of some results here:
> https://drive.google.com/drive/folders/1k3Gb-vlI7UjPZZcLkoL2W2VB_zqxIJ3_?usp=sharing
> 
> @Mel - could you please test the proposed patch? I know you have good
> coverage for the inter-process communication benchmarks which may show
> different behavior than benchmarks which we use. I hope that fewer
> threads migrations might show positive effects also for these tests.
> Please give it a try.
> 

Basically I see mixed bag depending on the workload, machine and overall
levels of utilisation. Sometimes it's better (sometimes much better),
other times it is worse (sometimes much worse). Given that there isn't a
universally good decision in this section and more people seem to prefer
the patch then it may be best to keep the LB decisions consistent and
revisit imbalance handling when the load balancer code changes settle
down so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
