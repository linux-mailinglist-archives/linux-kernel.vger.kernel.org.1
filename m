Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3392F3535
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbhALQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392647AbhALQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9niD141992;
        Tue, 12 Jan 2021 16:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=6n2AgFBEPspAmukd40iAPqkglyEzQK/Jo3RJOqdke6A=;
 b=CNo+FF0Cqs6La++CeIJ6e6lYZ00myHMKNHMq+hDjk04PYBxhkqSgkFkXTfVEXXIB+YVq
 wOt0vPQBLvU6e7lm2o+ZAozW0kQ3Gml0l00YxizUV9Ijlf6+tTvSuE8bTTsx1r+E+pch
 TzzwMN1/WyeaHrqdcCV9IIZ3jdZ8mJl/kBQSEwhysV7xCwFhBQjuxxxpG7CB8ClKEq/m
 jah94Uu4ioJ/fK+kfh5vallCUOlSvVaj5hjlCZcilaaYiPWmSclz2uJhDNQ5QCcsl77D
 GgbiBF2cpHgJSMKsayJnvU5P+gO3wMFWiHQvUlXH9QXnBvbWedqM+UKBABaCgwtbNncV SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kcyq5aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAbun100491;
        Tue, 12 Jan 2021 16:12:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 360keh7hh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:55 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGCqBw003962;
        Tue, 12 Jan 2021 16:12:52 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:12:51 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 00/70] RFC mm: Introducing the Maple Tree
Date:   Tue, 12 Jan 2021 11:11:30 -0500
Message-Id: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

***NOTE: the majority of this patch is the tests (35855 lines).***

Thanks to Vlastimil Babka for helping with perf on the full kernel
build and looking at the cache numbers.

Changes since last RFC:
 - rebased against 5.10 and updated benchmarks
 - Transitioned more internal mm operations to using maple states
 - Removed the mm_struct linked list as well as the maximum address
 - Replaced external linked list operations by maple tree iterators or
   searches
 
The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel that a
non-overlapping range-based tree would be beneficial, especially one with a
simple interface.  The first user that is covered in this patch set is the
vm_area_struct rbtree in the mm_struct with the long term goal of reducing the
contention of the mmap_sem.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf nodes.
With the increased branching factor, it is significantly short than the rbtree
so it has fewer cache misses.  As you can see below, the performance is getting
very close even without the vmacache.  I am looking for ways to optimize the
vma code to make this even faster and would like input.  As this tree requires
allocations to provide RCU functionality, it is worth avoiding expanding the
tree only to contract it in the next step.

This patch set is based on 5.10.

It is important to note that this is an RFC and there are limitations around
what is currently supported.

The current status of this release is:
 - **No support for 32 bit or nommu builds**  There will be test robot emails
 - Removal of the vmacache
 - Removal of the mm_struct linked list and highest VMA end.

 - Increase in performance in the following micro-benchmarks in Hmean:
  - will-it-scale signal1-processes -5 to +10%
  - will-it-scale page_fault1-threads increase upper limit by 20%
  - will-it-scale page_fault2-threads -5 to +45% (disregarding dip in rbtree at
    30-48 threads)
  - will-it-scale malloc1-threads 24.5 to 1168%, tests with 30, 48, 79, 110,
    and 141 are all over 100% better.
  - will-it-scale brk1-threads **This test doesn't make sense, disregard**
  - will-it-scale pthread_mutex1-threads -4.6 to +17%
  - will-it-scale signal1-processes -6 to +10.7%
  - will-it-scale signal1-threads -0.7 to +11%

 - Decrease in performance in the following micro-benchmarks:
  - will-it-scale page_fault3-processes -3.5 to -7%
  - will-it-scale brk1 which tests insert speed of a vma as it is written of
    -40 to -48%.
  - will-it-scale malloc1-processes -0.7 to -13%

 - page_fault3-threads is worth noting as a bumpy graph with a higher base
   value but a lower upper value.

 - kernbench elapse time is relatively flat.  Please see performance
   details for more information.

 - Converted the following to use the advanced maple tree interface:
   mm/mmap.c
   - brk()
   - mmap_region()
   - do_munmap()
   - dup_mmap()
   - do_munmap()
   mm/memory.c
   - free_pgtables()
   - unmap_vmas()

 - Currently operating in non-RCU mode.  Once turned on, RCU mode will
   automatically enable when more than one thread is active on a task.

The long term goal of the maple tree is to reduce mmap_sem contention by
removing users that cause contention one by one.  This may lead to the lock
being completely removed at some point.

The secondary goals is to add a fast RCU tree with a simple interface to
the kernel and to clean up the mm code by removing the integration of
the tree within the code and structures themselves.


Link: https://github.com/oracle/linux-uek/releases/tag/howlett%2Fmaple%2F20210105


============================================================================
Implementation details:

Each node is 256 Bytes and has multiple node types.  The current implementation
uses two node types and has a branching factor of 16 for leaf/non-alloc nodes
and 10 for internal alloc nodes.  The advantage of the internal alloc nodes is
the ability to track the largest sub-tree gap for each entry.

With the removal of the vmacache and the linked list, most benchmarks are close
to achieving parity and some are now above what the rbtree achieves.  I'd still
like some help with figuring out how to make building kernels faster.

The tree is at a disadvantage of needing to allocate storage space for internal
use where as the rbtree stored the data within the vm_area_struct.  This is a
necessary trade off to move to RCU mode in the future.  


performance details and raw data:

kernbench system time is up by ~4%, but elapsed time is pretty much the
same.

Perf analysis of a 140 thread kernel build cache shows the follow:

With v2 RFC of the maple tree:
     14,692,670.92 msec task-clock                #   68.720 CPUs utilized
43,983,754,174,774      cycles                    #    2.994 GHz
35,221,280,320,157      instructions              #    0.80  insn per cycle
   548,066,089,628      cache-references          #   37.302 M/sec
    39,632,749,650      cache-misses              #    7.231 % of all cache refs

     213.804939614 seconds time elapsed

   12822.727778000 seconds user
    1768.516799000 seconds sys

Vanilla 5.10:
     14,535,940.58 msec task-clock                #   67.025 CPUs utilized
43,541,026,636,749      cycles                    #    2.995 GHz
35,025,757,470,518      instructions              #    0.80  insn per cycle
   535,675,044,717      cache-references          #   36.852 M/sec
    38,837,910,214      cache-misses              #    7.250 % of all cache refs

     216.872446418 seconds time elapsed

   12785.056085000 seconds user
    1653.652012000 seconds sys


0.555% more instructions were executed (195522849639 more)
0.019% more cache hits occurred

I *think* the system is able to keep the CPUs busy more often due to the
increased cache hit rate.  However, the added instructions reduce or remove the
advantage at this point.

I had thought that there is more CPU used in-kernel but the bottleneck
of the mmap_sem lock is still the runtime speed limiting factor.  This
doesn't make sense as pointed out by Vlastimil 'because kernel build
should be lots of separate single-threaded processes (gcc) so where
would that contention come from'.

I would appreciate any insightful comments on the results.


Benchmark numbers from mmtests on a 144 core system:

wis-signal                               5.10                          maple tree
Hmean     signal1-processes-2        1786040.86 (   0.00%)      1810613.96 *   1.38%*
Hmean     signal1-processes-5        4495852.24 (   0.00%)      4456978.23 *  -0.86%*
Hmean     signal1-processes-8        6962785.32 (   0.00%)      6928809.21 *  -0.49%*
Hmean     signal1-processes-12       9996679.72 (   0.00%)      9960859.26 *  -0.36%*
Hmean     signal1-processes-21       5800266.56 (   0.00%)      6424291.55 *  10.76%*
Hmean     signal1-processes-30       5461129.81 (   0.00%)      5965843.00 *   9.24%*
Hmean     signal1-processes-48       5402662.10 (   0.00%)      5373518.13 *  -0.54%*
Hmean     signal1-processes-79       6324458.64 (   0.00%)      6373855.01 *   0.78%*
Hmean     signal1-processes-110      7888582.74 (   0.00%)      7715943.65 *  -2.19%*
Hmean     signal1-processes-141      9708237.79 (   0.00%)      9144247.40 *  -5.81%*


wis-pf                                      5.10                          maple tree
Hmean     page_fault3-processes-2        1528339.53 (   0.00%)      1418181.17 *  -7.21%*
Hmean     page_fault3-processes-5        3844682.44 (   0.00%)      3568964.13 *  -7.17%*
Hmean     page_fault3-processes-8        5962218.35 (   0.00%)      5582064.77 *  -6.38%*
Hmean     page_fault3-processes-12       8627107.79 (   0.00%)      8161496.35 *  -5.40%*
Hmean     page_fault3-processes-21      13714558.07 (   0.00%)     13137400.10 *  -4.21%*
Hmean     page_fault3-processes-30      19982269.52 (   0.00%)     18935995.56 *  -5.24%*
Hmean     page_fault3-processes-48      31128230.35 (   0.00%)     29117987.37 *  -6.46%*
Hmean     page_fault3-processes-79      46534013.37 (   0.00%)     43858063.38 *  -5.75%*
Hmean     page_fault3-processes-110     51560408.08 (   0.00%)     49113317.22 *  -4.75%*
Hmean     page_fault3-processes-141     56715596.66 (   0.00%)     54704417.46 *  -3.55%*

Hmean     page_fault1-threads-2          1845141.09 (   0.00%)      1845041.57 *  -0.01%*
Hmean     page_fault1-threads-5          4170927.21 (   0.00%)      4174427.49 *   0.08%*
Hmean     page_fault1-threads-8          5808980.21 (   0.00%)      5887126.65 *   1.35%*
Hmean     page_fault1-threads-12         5925792.38 (   0.00%)      5905272.94 *  -0.35%*
Hmean     page_fault1-threads-21         5871532.58 (   0.00%)      6440880.05 *   9.70%*
Hmean     page_fault1-threads-30         6832271.78 (   0.00%)      6861522.91 *   0.43%*
Hmean     page_fault1-threads-48         8614245.56 (   0.00%)      8922534.13 *   3.58%*
Hmean     page_fault1-threads-79        11609583.54 (   0.00%)     11257758.66 *  -3.03%*
Hmean     page_fault1-threads-110       11594428.36 (   0.00%)     12005585.11 *   3.55%*
Hmean     page_fault1-threads-141       11314690.18 (   0.00%)     13623989.67 *  20.41%*

Hmean     page_fault2-threads-2           806638.35 (   0.00%)       790103.29 *  -2.05%*
Hmean     page_fault2-threads-5          1689522.43 (   0.00%)      1705998.81 *   0.98%*
Hmean     page_fault2-threads-8          2117462.47 (   0.00%)      2002244.16 *  -5.44%*
Hmean     page_fault2-threads-12         2130151.22 (   0.00%)      2181799.70 *   2.42%*
Hmean     page_fault2-threads-21         1428004.62 (   0.00%)      2076765.86 *  45.43%*
Hmean     page_fault2-threads-30         1163606.91 (   0.00%)      2090400.49 *  79.65%*
Hmean     page_fault2-threads-48          605893.29 (   0.00%)      1712174.51 * 182.59%*
Hmean     page_fault2-threads-79         1401105.11 (   0.00%)      1948016.56 *  39.03%*
Hmean     page_fault2-threads-110        2107269.70 (   0.00%)      2063247.07 *  -2.09%*
Hmean     page_fault2-threads-141        1148808.86 (   0.00%)      1643422.67 *  43.05%*

Hmean     page_fault3-threads-2          1370710.48 (   0.00%)      1359083.92 *  -0.85%*
Hmean     page_fault3-threads-5          3010390.55 (   0.00%)      2488127.21 * -17.35%*
Hmean     page_fault3-threads-8          3214674.74 (   0.00%)      2502612.56 * -22.15%*
Hmean     page_fault3-threads-12         3443935.69 (   0.00%)      2788050.49 * -19.04%*
Hmean     page_fault3-threads-21         1500648.03 (   0.00%)      1748934.69 *  16.55%*
Hmean     page_fault3-threads-30         1633922.78 (   0.00%)      1644905.78 *   0.67%*
Hmean     page_fault3-threads-48         1357568.84 (   0.00%)      1501556.63 *  10.61%*
Hmean     page_fault3-threads-79         1731774.85 (   0.00%)      1527178.31 * -11.81%*
Hmean     page_fault3-threads-110        1867416.16 (   0.00%)      1918662.69 *   2.74%*
Hmean     page_fault3-threads-141        1901439.58 (   0.00%)      1960142.22 *   3.09%*


wis-malloc                                  5.10                          maple tree
Hmean     brk1-processes-2           4547264.11 (   0.00%)      2711590.85 * -40.37%*
Hmean     brk1-processes-5          11396047.63 (   0.00%)      6723760.18 * -41.00%*
Hmean     brk1-processes-8          17684347.79 (   0.00%)      9850073.01 * -44.30%*
Hmean     brk1-processes-12         25803477.74 (   0.00%)     13551301.45 * -47.48%*
Hmean     brk1-processes-21         42083608.45 (   0.00%)     22484839.92 * -46.57%*
Hmean     brk1-processes-30         61095769.10 (   0.00%)     31853867.49 * -47.86%*
Hmean     brk1-processes-48         95924485.69 (   0.00%)     50239694.48 * -47.63%*
Hmean     brk1-processes-79        144415437.49 (   0.00%)     75287655.57 * -47.87%*
Hmean     brk1-processes-110       161729976.95 (   0.00%)     83624072.84 * -48.29%*
Hmean     brk1-processes-141       178985545.93 (   0.00%)     92036828.36 * -48.58%*
 *Note: This isn't testing brk, it's testing insert of a VMA

Hmean     malloc1-processes-2         513481.82 (   0.00%)       447458.20 * -12.86%*
Hmean     malloc1-processes-5        1192865.83 (   0.00%)      1052137.79 * -11.80%*
Hmean     malloc1-processes-8        1290698.38 (   0.00%)      1202802.10 *  -6.81%*
Hmean     malloc1-processes-12       1357323.31 (   0.00%)      1300602.17 *  -4.18%*
Hmean     malloc1-processes-21       2052572.96 (   0.00%)      1975328.24 *  -3.76%*
Hmean     malloc1-processes-30       2793186.04 (   0.00%)      2700345.64 *  -3.32%*
Hmean     malloc1-processes-48       4087424.14 (   0.00%)      4059035.58 *  -0.69%*
Hmean     malloc1-processes-79       5185320.24 (   0.00%)      5120912.56 *  -1.24%*
Hmean     malloc1-processes-110      5231498.33 (   0.00%)      4991315.64 *  -4.59%*
Hmean     malloc1-processes-141      5096423.47 (   0.00%)      4847749.27 *  -4.88%*

Hmean     malloc1-threads-2            14119.77 (   0.00%)       179149.22 *1168.78%*
Hmean     malloc1-threads-5           120466.20 (   0.00%)       158994.30 *  31.98%*
Hmean     malloc1-threads-8           103323.01 (   0.00%)       128684.83 *  24.55%*
Hmean     malloc1-threads-12          102365.88 (   0.00%)       127458.10 *  24.51%*
Hmean     malloc1-threads-21           55230.52 (   0.00%)        97276.98 *  76.13%*
Hmean     malloc1-threads-30           40144.81 (   0.00%)        87899.80 * 118.96%*
Hmean     malloc1-threads-48           18651.63 (   0.00%)        57501.70 * 208.29%*
Hmean     malloc1-threads-79            5987.82 (   0.00%)        36411.66 * 508.10%*
Hmean     malloc1-threads-110           9425.14 (   0.00%)        19021.17 * 101.81%*
Hmean     malloc1-threads-141           6176.71 (   0.00%)        22104.21 * 257.86%*

wis-pthreadmutex                            5.10                          maple tree
Hmean     pthread_mutex1-threads-2         18757795.65 (   0.00%)     18234843.22 *  -2.79%*
Hmean     pthread_mutex1-threads-5         10875114.75 (   0.00%)     12748240.14 *  17.22%*
Hmean     pthread_mutex1-threads-8         13474657.37 (   0.00%)     14906619.63 *  10.63%*
Hmean     pthread_mutex1-threads-12        14686773.11 (   0.00%)     14096530.35 *  -4.02%*
Hmean     pthread_mutex1-threads-21        14253992.75 (   0.00%)     13893250.09 *  -2.53%*
Hmean     pthread_mutex1-threads-30        15327949.47 (   0.00%)     14613516.32 *  -4.66%*
Hmean     pthread_mutex1-threads-48        14892473.83 (   0.00%)     15177204.93 *   1.91%*
Hmean     pthread_mutex1-threads-79        14333125.23 (   0.00%)     14254569.45 *  -0.55%*
Hmean     pthread_mutex1-threads-110       13623757.15 (   0.00%)     14067267.02 *   3.26%*
Hmean     pthread_mutex1-threads-141       13097069.36 (   0.00%)     13320433.23 *   1.71%*

wis-signal                                  5.10                          maple tree
Hmean     signal1-processes-2        1786040.86 (   0.00%)      1810613.96 *   1.38%*
Hmean     signal1-processes-5        4495852.24 (   0.00%)      4456978.23 *  -0.86%*
Hmean     signal1-processes-8        6962785.32 (   0.00%)      6928809.21 *  -0.49%*
Hmean     signal1-processes-12       9996679.72 (   0.00%)      9960859.26 *  -0.36%*
Hmean     signal1-processes-21       5800266.56 (   0.00%)      6424291.55 *  10.76%*
Hmean     signal1-processes-30       5461129.81 (   0.00%)      5965843.00 *   9.24%*
Hmean     signal1-processes-48       5402662.10 (   0.00%)      5373518.13 *  -0.54%*
Hmean     signal1-processes-79       6324458.64 (   0.00%)      6373855.01 *   0.78%*
Hmean     signal1-processes-110      7888582.74 (   0.00%)      7715943.65 *  -2.19%*
Hmean     signal1-processes-141      9708237.79 (   0.00%)      9144247.40 *  -5.81%*

Hmean     signal1-threads-2          1253290.69 (   0.00%)      1304356.96 *   4.07%*
Hmean     signal1-threads-5          1105142.15 (   0.00%)      1219370.11 *  10.34%*
Hmean     signal1-threads-8          1085584.56 (   0.00%)      1206909.95 *  11.18%*
Hmean     signal1-threads-12         1113346.88 (   0.00%)      1218394.23 *   9.44%*
Hmean     signal1-threads-21          817087.31 (   0.00%)       852237.46 *   4.30%*
Hmean     signal1-threads-30          657827.07 (   0.00%)       695077.88 *   5.66%*
Hmean     signal1-threads-48          523114.49 (   0.00%)       562605.91 *   7.55%*
Hmean     signal1-threads-79          500027.91 (   0.00%)       527026.99 *   5.40%*
Hmean     signal1-threads-110         480231.16 (   0.00%)       498458.54 *   3.80%*
Hmean     signal1-threads-141         468149.75 (   0.00%)       464573.98 *  -0.76%*


kernbench               5.10-rc1                maple tree
Amean     user-2        887.32 (   0.00%)      882.62 *   0.53%*
Amean     syst-2        145.77 (   0.00%)      152.04 *  -4.30%*
Amean     elsp-2        522.10 (   0.00%)      522.97 *  -0.17%*
Amean     user-4        902.24 (   0.00%)      898.12 *   0.46%*
Amean     syst-4        149.70 (   0.00%)      156.35 *  -4.44%*
Amean     elsp-4        269.58 (   0.00%)      271.99 *  -0.90%*
Amean     user-8        920.12 (   0.00%)      913.07 *   0.77%*
Amean     syst-8        149.97 (   0.00%)      155.61 *  -3.76%*
Amean     elsp-8        141.55 (   0.00%)      141.58 *  -0.03%*
Amean     user-16       935.31 (   0.00%)      926.23 *   0.97%*
Amean     syst-16       151.97 (   0.00%)      157.41 *  -3.58%*
Amean     elsp-16        77.37 (   0.00%)       77.35 *   0.04%*
Amean     user-32       982.76 (   0.00%)      977.36 *   0.55%*
Amean     syst-32       162.56 (   0.00%)      167.90 *  -3.29%*
Amean     elsp-32        46.17 (   0.00%)       46.08 *   0.19%*
Amean     user-64      1093.08 (   0.00%)     1081.16 *   1.09%*
Amean     syst-64       177.43 (   0.00%)      183.63 *  -3.49%*
Amean     elsp-64        30.80 (   0.00%)       30.28 *   1.68%*
Amean     user-128     1611.20 (   0.00%)     1610.98 *   0.01%*
Amean     syst-128      234.32 (   0.00%)      244.25 *  -4.24%*
Amean     elsp-128       25.76 (   0.00%)       25.73 *   0.12%*
Amean     user-256     1733.42 (   0.00%)     1739.23 *  -0.34%*
Amean     syst-256      248.58 (   0.00%)      259.16 *  -4.26%*
Amean     elsp-256       25.17 (   0.00%)       25.44 *  -1.07%*
Amean     user-288     1734.83 (   0.00%)     1737.28 *  -0.14%*
Amean     syst-288      249.63 (   0.00%)      259.55 *  -3.97%*
Amean     elsp-288       25.43 (   0.00%)       25.45 *  -0.09%*


gitcheckout

Amean     User           0.00 (   0.00%)        0.00 *   0.00%*
Amean     System         8.07 (   0.00%)        7.92 *   1.83%*
Amean     Elapsed       23.46 (   0.00%)       22.91 *   2.35%*
Amean     CPU           91.87 (   0.00%)       92.33 *  -0.51%*

Liam R. Howlett (70):
  radix tree test suite: Enhancements for Maple Tree
  radix tree test suite: Add support for fallthrough attribute
  radix tree test suite: Add support for kmem_cache_free_bulk
  radix tree test suite: Add keme_cache_alloc_bulk() support
  Maple Tree: Add new data structure
  mm: Start tracking VMAs with maple tree
  mm/mmap: Introduce unlock_range() for code cleanup
  mm/mmap: Change find_vma() to use the maple tree
  mm/mmap: Change find_vma_prev() to use maple tree
  mm/mmap: Change unmapped_area and unmapped_area_topdown to use maple
    tree
  kernel/fork: Convert dup_mmap to use maple tree
  mm: Remove rb tree.
  mm/gup: Add mm_populate_vma() for use when the vma is known
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm/mmap: Change vm_brk_flags() to use mm_populate_vma()
  mm: Move find_vma_intersection to mmap.c and change implementation to
    maple tree.
  mm/mmap: Change mmap_region to use maple tree state
  mm/mmap: Drop munmap_vma_range()
  mm: Remove vmacache
  mm/mmap: Change __do_munmap() to avoid unnecessary lookups.
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Add do_mas_munmap() and wraper for __do_munmap()
  mmap: Use find_vma_intersection in do_mmap() for overlap
  mmap: Remove __do_munmap() in favour of do_mas_munmap()
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
  mmap: make remove_vma_list() inline
  mm: Introduce vma_next() and vma_prev()
  arch/arm64: Remove mmap linked list from vdso.
  arch/parsic: Remove mmap linked list from kernel/cache
  arch/powerpc: Remove mmap linked list from mm/book2s32/tlb
  arch/powerpc: Remove mmap linked list from mm/book2s32/subpage_prot
  arch/powerpc: Optimize cell spu task sync.
  arch/s390: Use maple tree iterators instead of linked list.
  arch/um: Use maple tree iterators instead of linked list
  arch/x86: Use maple tree iterators for vdso/vma
  arch/xtensa: Use maple tree iterators for unmapped area
  drivers/misc/cxl: Use maple tree iterators for cxl_prefault_vma()
  drivers/oprofile: Lookup address in tree instead of linked list.
  drivers/tee/optee: Use maple tree iterators for __check_mem_type()
  fs/binfmt_elf: Use maple tree iterators for fill_files_note()
  fs/coredump: Use maple tree iterators in place of linked list
  fs/exec: Use vma_next() instead of linked list
  fs/proc/base: Use maple tree iterators in place of linked list
  fs/proc/task_mmu: Stop using linked list and highest_vm_end
  fs/userfaultfd: Stop using vma linked list.
  ipc/shm: Stop using the vma linked list
  kernel/acct: Use maple tree iterators instead of linked list
  kernel/events/core: Use maple tree iterators instead of linked list
  kernel/events/uprobes: Use maple tree iterators instead of linked list
  kernel/sched/fair: Use maple tree iterators instead of linked list
  kernel/sys: Use maple tree iterators instead of linked list
  mm/gup: Use maple tree navigation instead of linked list
  mm/huge_memory: Use vma_next() instead of vma linked list
  mm/khugepaged: Use maple tree iterators instead of vma linked list
  mm/ksm: Use maple tree iterators instead of vma linked list
  mm/madvise: Use vma_next instead of vma linked list
  mm/memcontrol: Stop using mm->highest_vm_end
  mm/mempolicy: Use maple tree iterators instead of vma linked list
  mm/mlock: Use maple tree iterators instead of vma linked list
  mm/mprotect: Use maple tree navigation instead of vma linked list
  mm/mremap: Use vma_next() instead of vma linked list
  mm/msync: Use vma_next() instead of vma linked list
  mm/nommu: Use maple tree iterators instead of vma linked list
  mm/oom_kill: Use maple tree iterators instead of vma linked list
  mm/pagewalk: Use vma_next() instead of vma linked list
  mm/swapfile: Use maple tree iterator instead of vma linked list
  mm/nommu: Stop inserting into the vma linked list
  mm/util: Remove __vma_link_list() and __vma_unlink_list()
  mm: Remove vma linked list.
  mm/mmap: Convert __insert_vm_struct to use mas, convert vma_link to
    use vma_mas_link()

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple-tree.rst         |    36 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/vdso.c                      |     5 +-
 arch/parisc/kernel/cache.c                    |     8 +-
 arch/powerpc/mm/book3s32/tlb.c                |     3 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/powerpc/oprofile/cell/spu_task_sync.c    |    22 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     7 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |     3 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/misc/cxl/fault.c                      |     3 +-
 drivers/oprofile/buffer_sync.c                |    14 +-
 drivers/tee/optee/call.c                      |    13 +-
 fs/binfmt_elf.c                               |     3 +-
 fs/coredump.c                                 |    13 +-
 fs/exec.c                                     |     7 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/task_mmu.c                            |    43 +-
 fs/userfaultfd.c                              |    24 +-
 include/linux/maple_tree.h                    |   439 +
 include/linux/mm.h                            |    49 +-
 include/linux/mm_types.h                      |    34 +-
 include/linux/mm_types_task.h                 |     5 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |     3 +
 include/linux/vmacache.h                      |    28 -
 include/trace/events/maple_tree.h             |   227 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    13 +-
 kernel/acct.c                                 |     6 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    48 +-
 kernel/sched/fair.c                           |    10 +-
 kernel/sys.c                                  |     3 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  5700 +++
 lib/test_maple_tree.c                         | 35855 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/debug.c                                    |    12 +-
 mm/gup.c                                      |    27 +-
 mm/huge_memory.c                              |     6 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |     4 +-
 mm/khugepaged.c                               |     7 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    39 +-
 mm/mempolicy.c                                |    33 +-
 mm/mlock.c                                    |    20 +-
 mm/mmap.c                                     |  2022 +-
 mm/mprotect.c                                 |     8 +-
 mm/mremap.c                                   |    13 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |    14 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     3 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |    13 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |    78 +-
 tools/testing/radix-tree/linux/kernel.h       |     8 +
 tools/testing/radix-tree/linux/maple_tree.h   |     3 +
 tools/testing/radix-tree/linux/slab.h         |     2 +
 tools/testing/radix-tree/maple.c              |    59 +
 tools/testing/radix-tree/test.h               |     1 +
 .../radix-tree/trace/events/maple_tree.h      |     8 +
 77 files changed, 43844 insertions(+), 1507 deletions(-)
 create mode 100644 Documentation/core-api/maple-tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

-- 
2.28.0

