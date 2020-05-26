Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4D19CFD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 07:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbgDCFlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 01:41:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id c23so3001609pgj.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JpEWlty5iU4yVEF0VoZT8ihanR9mHkOnsExRDYdzEPo=;
        b=uZeY6GfKM9sqc/ALNFgLZqAsGBizsRSVFgMaT9dBeQ7K8xgadMzrlOeKV6fxLGANjz
         Qe4Pf4WWy5oCv45VSlJExIsVnsnbNj1vIes662v2Qet2lSesbglNInC8SzuJpVCuoUEp
         M053lmGw6KITkIdyfq/SWyO4m/S5LW2QqRdyu09psD+baqjCz331b3GeOFqNK/HX/HIX
         c2yl5/Gl8gxyfv0sTH5BKtvuawkt5pAJySStp2J8L9OWZ74evDuNq4+c7QnLD1kmYcM6
         EWq+SN/RZBcxKe/JU3OwUpYGL5OPBne8A8wyI87xwcqsUXLyoI7r51tfbgG+zIXLRK0l
         ycRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JpEWlty5iU4yVEF0VoZT8ihanR9mHkOnsExRDYdzEPo=;
        b=dOSPldAZdNYcYTIr4m6Wh2DHeg4TWKSmVysuqX7nHeNgDQsaw4gzEKn44mWgEtKeEn
         5PpTNx9GQqxA+uCKE0DdZ7dVHrbKlkx4YCIVerjVuD0GFIB4pf8gDVqM6XdITFMP8x2L
         XM5QouuXnufc64NCllJ+43CFIDjDKEKqodhKsD3ZKf4SaZBj76wXMdJue+Dd1J9OxdaB
         Kt4DhnZizVnmlfH9aWIqcaIa5KuSFPXZH+SPhCX5XI4Nv1dWGJurkn0qfzordXUqmgVp
         F/0mzkf6d8m0uUx4ly2n6Hgpxj3hC/ohzoJT775eiEbomqiWjd+bheGVBEPeeFtF08za
         8BZw==
X-Gm-Message-State: AGi0PuadOqrPTpVnRQOvhKZPbWp9Ik28GKOwT1a2P8I0Rh23zo9EM4ir
        g5wZaakg7E2/dMQF/8YEK/ZrKAAh
X-Google-Smtp-Source: APiQypLaqcFt1Bqh8gUQfOO4TRxG2T8Y2ltQCc/4pSN854NzCpSALg9eyOcE5xOOAEmIB1UpL6TqfQ==
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr6498599pgc.4.1585892465534;
        Thu, 02 Apr 2020 22:41:05 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:04 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 00/10] workingset protection/detection on the anonymous LRU list
Date:   Fri,  3 Apr 2020 14:40:38 +0900
Message-Id: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hello,

This patchset implements workingset protection and detection on
the anonymous LRU list.

* Changes on v5
- change memcg charge timing for the swapped-in page (fault -> swap-in)
- avoid readahead if previous owner of the swapped-out page isn't me
- use another lruvec to update the reclaim_stat for a new anonymous page
- add two more cases to fix up the reclaim_stat

* Changes on v4
- In the patch "mm/swapcache: support to handle the exceptional
entries in swapcache":
-- replace the word "value" with "exceptional entries"
-- add to handle the shadow entry in add_to_swap_cache()
-- support the huge page
-- remove the registration code for shadow shrinker

- remove the patch "mm/workingset: use the node counter
if memcg is the root memcg" since workingset detection for
anonymous page doesn't use shadow shrinker now
- minor style fixes

* Changes on v3
- rework the patch, "mm/vmscan: protect the workingset on anonymous LRU"
(use almost same reference tracking algorithm to the one for the file
mapped page)

* Changes on v2
- fix a critical bug that uses out of index lru list in
workingset_refault()
- fix a bug that reuses the rotate value for previous page

* SUBJECT
workingset protection

* PROBLEM
In current implementation, newly created or swap-in anonymous page is
started on the active list. Growing the active list results in rebalancing
active/inactive list so old pages on the active list are demoted to the
inactive list. Hence, hot page on the active list isn't protected at all.

Following is an example of this situation.

Assume that 50 hot pages on active list and system can contain total
100 pages. Numbers denote the number of pages on active/inactive
list (active | inactive). (h) stands for hot pages and (uo) stands for
used-once pages.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(uo) | 50(h)

3. workload: another 50 newly created (used-once) pages
50(uo) | 50(uo), swap-out 50(h)

As we can see, hot pages are swapped-out and it would cause swap-in later.

* SOLUTION
Since this is what we want to avoid, this patchset implements workingset
protection. Like as the file LRU list, newly created or swap-in anonymous
page is started on the inactive list. Also, like as the file LRU list,
if enough reference happens, the page will be promoted. This simple
modification changes the above example as following.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(h) | 50(uo)

3. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(uo)

hot pages remains in the active list. :)

* EXPERIMENT
I tested this scenario on my test bed and confirmed that this problem
happens on current implementation. I also checked that it is fixed by
this patchset.

I did another test to show the performance effect of this patchset.

- ebizzy (with modified random function)
ebizzy is the test program that main thread allocates lots of memory and
child threads access them randomly during the given times. Swap-in/out
will happen if allocated memory is larger than the system memory.

The random function that represents the zipf distribution is used to
make hot/cold memory. Hot/cold ratio is controlled by the parameter. If
the parameter is high, hot memory is accessed much larger than cold one.
If the parameter is low, the number of access on each memory would be
similar. I uses various parameters in order to show the effect of
patchset on various hot/cold ratio workload.

My test setup is a virtual machine with 8 cpus and 1024MB memory.

Result format is as following.

Parameter 0.1 ... 1.3
Allocated memory size
Throughput for base (larger is better)
Throughput for patchset (larger is better)
Improvement (larger is better)


* single thread

     0.1      0.3      0.5      0.7      0.9      1.1      1.3
<512M>
  7009.0   7372.0   7774.0   8523.0   9569.0  10724.0  11936.0
  6973.0   7342.0   7745.0   8576.0   9441.0  10730.0  12033.0
   -0.01     -0.0     -0.0     0.01    -0.01      0.0     0.01
<768M>
   915.0   1039.0   1275.0   1687.0   2328.0   3486.0   5445.0
   920.0   1037.0   1238.0   1689.0   2384.0   3638.0   5381.0
    0.01     -0.0    -0.03      0.0     0.02     0.04    -0.01
<1024M>
   425.0    471.0    539.0    753.0   1183.0   2130.0   3839.0
   414.0    468.0    553.0    770.0   1242.0   2187.0   3932.0
   -0.03    -0.01     0.03     0.02     0.05     0.03     0.02
<1280M>
   320.0    346.0    410.0    556.0    871.0   1654.0   3298.0
   316.0    346.0    411.0    550.0    892.0   1652.0   3293.0
   -0.01      0.0      0.0    -0.01     0.02     -0.0     -0.0
<1536M>
   273.0    290.0    341.0    458.0    733.0   1381.0   2925.0
   271.0    293.0    344.0    462.0    740.0   1398.0   2969.0
   -0.01     0.01     0.01     0.01     0.01     0.01     0.02
<2048M>
    77.0     79.0     95.0    147.0    276.0    690.0   1816.0
    91.0     94.0    115.0    170.0    321.0    770.0   2018.0
    0.18     0.19     0.21     0.16     0.16     0.12     0.11


* multi thread (8)

     0.1      0.3      0.5      0.7      0.9      1.1      1.3
<512M>
 29083.0  29648.0  30145.0  31668.0  33964.0  38414.0  43707.0
 29238.0  29701.0  30301.0  31328.0  33809.0  37991.0  43667.0
    0.01      0.0     0.01    -0.01     -0.0    -0.01     -0.0
<768M>
  3332.0   3699.0   4673.0   5830.0   8307.0  12969.0  17665.0
  3579.0   3992.0   4432.0   6111.0   8699.0  12604.0  18061.0
    0.07     0.08    -0.05     0.05     0.05    -0.03     0.02
<1024M>
  1921.0   2141.0   2484.0   3296.0   5391.0   8227.0  14574.0
  1989.0   2155.0   2609.0   3565.0   5463.0   8170.0  15642.0
    0.04     0.01     0.05     0.08     0.01    -0.01     0.07
<1280M>
  1524.0   1625.0   1931.0   2581.0   4155.0   6959.0  12443.0
  1560.0   1707.0   2016.0   2714.0   4262.0   7518.0  13910.0
    0.02     0.05     0.04     0.05     0.03     0.08     0.12
<1536M>
  1303.0   1399.0   1550.0   2137.0   3469.0   6712.0  12944.0
  1356.0   1465.0   1701.0   2237.0   3583.0   6830.0  13580.0
    0.04     0.05      0.1     0.05     0.03     0.02     0.05
<2048M>
   172.0    184.0    215.0    289.0    514.0   1318.0   4153.0
   175.0    190.0    225.0    329.0    606.0   1585.0   5170.0
    0.02     0.03     0.05     0.14     0.18      0.2     0.24

As we can see, as allocated memory grows, patched kernel get the better
result. Maximum improvement is 21% for the single thread test and
24% for the multi thread test.


* SUBJECT
workingset detection

* PROBLEM
Later part of the patchset implements the workingset detection for
the anonymous LRU list. There is a corner case that workingset protection
could cause thrashing. If we can avoid thrashing by workingset detection,
we can get the better performance.

Following is an example of thrashing due to the workingset protection.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (will be hot) pages
50(h) | 50(wh)

3. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(wh)

4. workload: 50 (will be hot) pages
50(h) | 50(wh), swap-in 50(wh)

5. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(wh)

6. repeat 4, 5

Without workingset detection, this kind of workload cannot be promoted
and thrashing happens forever.

* SOLUTION
Therefore, this patchset implements workingset detection.
All the infrastructure for workingset detecion is already implemented,
so there is not much work to do. First, extend workingset detection
code to deal with the anonymous LRU list. Then, make swap cache handles
the exceptional value for the shadow entry. Lastly, install/retrieve
the shadow value into/from the swap cache and check the refault distance.

* EXPERIMENT
I made a test program to imitates above scenario and confirmed that
problem exists. Then, I checked that this patchset fixes it.

My test setup is a virtual machine with 8 cpus and 6100MB memory. But,
the amount of the memory that the test program can use is about 280 MB.
This is because the system uses large ram-backed swap and large ramdisk
to capture the trace.

Test scenario is like as below.

1. allocate cold memory (512MB)
2. allocate hot-1 memory (96MB)
3. activate hot-1 memory (96MB)
4. allocate another hot-2 memory (96MB)
5. access cold memory (128MB)
6. access hot-2 memory (96MB)
7. repeat 5, 6

Since hot-1 memory (96MB) is on the active list, the inactive list can
contains roughly 190MB pages. hot-2 memory's re-access interval
(96+128 MB) is more 190MB, so it cannot be promoted without workingset
detection and swap-in/out happens repeatedly. With this patchset,
workingset detection works and promotion happens. Therefore, swap-in/out
occurs less.

Here is the result. (average of 5 runs)

type swap-in swap-out
base 863240 989945
patch 681565 809273

As we can see, patched kernel do less swap-in/out.

Patchset is based on v5.6.
Patchset can also be available at

https://github.com/JoonsooKim/linux/tree/improve-anonymous-lru-management-v5.00-v5.6

Enjoy it.

Thanks.

Joonsoo Kim (10):
  mm/vmscan: make active/inactive ratio as 1:1 for anon lru
  mm/vmscan: protect the workingset on anonymous LRU
  mm/workingset: extend the workingset detection for anon LRU
  mm/swapcache: support to handle the exceptional entries in swapcache
  mm/swap: charge the page when adding to the swap cache
  mm/swap: implement workingset detection for anonymous LRU
  mm/workingset: support to remember the previous owner of the page
  mm/swap: do not readahead if the previous owner of the swap entry
    isn't me
  mm/vmscan: restore active/inactive ratio for anonymous LRU
  mm/swap: reinforce the reclaim_stat changed by anon LRU algorithm
    change

 include/linux/mmzone.h        |  14 ++++--
 include/linux/pagevec.h       |   2 +-
 include/linux/swap.h          |  24 +++++++---
 include/linux/vmstat.h        |   2 +-
 include/trace/events/vmscan.h |   3 +-
 kernel/events/uprobes.c       |   2 +-
 mm/huge_memory.c              |   6 +--
 mm/khugepaged.c               |   2 +-
 mm/memcontrol.c               |  12 +++--
 mm/memory.c                   |  23 +++++++--
 mm/migrate.c                  |   2 +-
 mm/mlock.c                    |   2 +-
 mm/shmem.c                    |  21 +++++----
 mm/swap.c                     | 105 +++++++++++++++++++++++++++++++++++-------
 mm/swap_state.c               |  95 ++++++++++++++++++++++++++++++++------
 mm/swapfile.c                 |   2 +-
 mm/userfaultfd.c              |   2 +-
 mm/vmscan.c                   |  38 +++++++++------
 mm/vmstat.c                   |   6 ++-
 mm/workingset.c               |  90 +++++++++++++++++++++++++++---------
 mm/zswap.c                    |   2 +-
 21 files changed, 343 insertions(+), 112 deletions(-)

-- 
2.7.4

