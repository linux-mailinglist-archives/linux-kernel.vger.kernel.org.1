Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14D32D6488
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbgLJRIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:08:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392421AbgLJRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGo16d119806;
        Thu, 10 Dec 2020 17:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=4jW2jSXM/emfK76xnkn9sL90OjL7XKuF3dKJAYXIECI=;
 b=Gjp0Kixi7fpK6Vfv39FZgQLri2//qnrGxiXnHYnf6pNFURmTirmScd0TS+A5r6uhNf7r
 EH0SlMPP2sl5Ga8q4oZXJ1DIk35yKk6lQP9dFgMWJXWEGrrQ2wK4lRYkteuJV/98a4Jf
 q/5tGNqPLw9S6oVY2OVlSDViQiqirbjQjuPXqSUXjccTE6BOXzGCP5ag1FKG0RIfy3cQ
 tdLgHaV20CC9mvGmaFC+9P50ZsY5z25ufosO1ZA2QEUVErKDxIOLIxLy+TaLjHJQt957
 ZpRnCv4Z3d/2/eQjugJRbIWFafFvEQXjEMv/ZdajwScQ024WUP+wQAJ6UO7y1pSBW8BE Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3581mr6fu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwj3o046029;
        Thu, 10 Dec 2020 17:04:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 358m41xatk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4TVu012633;
        Thu, 10 Dec 2020 17:04:29 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:29 -0800
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 00/28] RFC mm: Introducing the Maple Tree
Date:   Thu, 10 Dec 2020 12:03:34 -0500
Message-Id: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patch set is based on 5.10-rc1.

Please note that 35821 lines of this patch is the test code.

It is important to note that this is an RFC and there are limitations around
what is currently supported.

The current status of this release is:
 - **No support for 32 bit or nommu builds**
 - There is a performance regression with regards to kernel builds from -3% to
   -5% of system time.  Elapsed time is within 1 second of 5.10-rc1.
 - Removal of the vmacache
 - The mm struct uses the maple tree to store and retrieve all VMAs

 - Decrease in performance in the following micro-benchmarks:
  - will-it-scale brk1 which tests insert speed of a vma as it is written of
    -25 to -33%.  The test does not seem to test what it is meant to test.
  - kernbuild (~-4 to -5% system, less that -1% elapsed Amean)


 - Increase in performance in the following micro-benchmarks in Hmean:
  - will-it-scale malloc1-processes (~1-9%)
  - will-it-scale malloc1-threads (~29-71%)
  - will-it-scale pthread_mutex1-threads (~0-16%)
  - will-it-scale signal1-processes (2-17%)
  - will-it-scale brk1-threads **This test doesn't make sense, disregard**

 - Converted the following to use the advanced maple tree interface:
   - brk()
   - mmap_region()
   - do_munmap()
   - dup_mmap()

 - Currently operating in non-RCU mode.  Once enabled, RCU mode will be enabled
   only when more than one thread is active on a task.  At that point the maple
   tree will enable RCU lookup of VMAs.

The long term goal of the maple tree is to reduce mmap_sem contention by
removing users that cause contention one by one.  This may lead to the lock
being completely removed at some point.

The secondary goals is to provide the kernel with a fast RCU tree with a simple
interface and to clean up the mm code by removing the integration of the tree
within the code and structures themselves.

This patch set is based on 5.10-rc1.

Link: https://github.com/oracle/linux-uek/releases/tag/howlett%2Fmaple%2F20201204


Implementation details:
Each node is 256 Bytes and has multiple node types.  The current implementation
uses two node types and has a branching factor of 16 for leaf/non-alloc nodes
and 10 for internal alloc nodes.  The advantage of the internal alloc nodes is
the ability to track the largest sub-tree gap for each entry.

Even with the removal of the vmacache, the benchmarks are getting close to the
rbtree, but I'd like some help in regards to making things faster.  The tree
is at a disadvantage of needing to allocate storage space for internal use
where as the rbtree stored the data within the vm_area_struct.  This is a
necessary trade off to move to RCU mode in the future.  


Benchmark numbers from mmtests on a 144 core system:

wis-pthreadmutex                                5.10-rc1                maple tree
Hmean     pthread_mutex1-threads-2         19006635.84 (   0.00%)     21036173.96 *  10.68%*
Hmean     pthread_mutex1-threads-5         10228467.75 (   0.00%)     11890622.20 *  16.25%*
Hmean     pthread_mutex1-threads-8         13933097.01 (   0.00%)     13856905.46 *  -0.55%*
Hmean     pthread_mutex1-threads-12        11431792.97 (   0.00%)     13082725.10 *  14.44%*
Hmean     pthread_mutex1-threads-21        14536655.83 (   0.00%)     14318050.44 *  -1.50%*
Hmean     pthread_mutex1-threads-30        14025017.40 (   0.00%)     15451267.09 *  10.17%*
Hmean     pthread_mutex1-threads-48        15452188.47 (   0.00%)     14355672.94 *  -7.10%*
Hmean     pthread_mutex1-threads-79        13680017.69 (   0.00%)     13664026.29 *  -0.12%*
Hmean     pthread_mutex1-threads-110       14131595.92 (   0.00%)     13659743.96 *  -3.34%*
Hmean     pthread_mutex1-threads-141       13493999.70 (   0.00%)     12951941.54 *  -4.02%*

wis-signal                               5.10-rc1                       maple tree
Hmean     signal1-processes-2        1804422.41 (   0.00%)      1827311.56 *   1.27%*
Hmean     signal1-processes-5        4460172.84 (   0.00%)      4476128.55 *   0.36%*
Hmean     signal1-processes-8        6900853.35 (   0.00%)      6973210.80 *   1.05%*
Hmean     signal1-processes-12       9929132.51 (   0.00%)     10055390.13 *   1.27%*
Hmean     signal1-processes-21       5864723.57 (   0.00%)      6745451.58 *  15.02%*
Hmean     signal1-processes-30       6183688.25 (   0.00%)      6405037.68 *   3.58%*
Hmean     signal1-processes-48       5439087.23 (   0.00%)      5631558.18 *   3.54%*
Hmean     signal1-processes-79       6512401.34 (   0.00%)      6706141.64 *   2.97%*
Hmean     signal1-processes-110      8056779.10 (   0.00%)      8494438.86 *   5.43%*
Hmean     signal1-processes-141      9320516.16 (   0.00%)     10571140.16 *  13.42%*


wis-malloc                              5.10-rc1                maple tree
Hmean     brk1-processes-2           4665394.67 (   0.00%)      3531806.58 * -24.30%*
Hmean     brk1-processes-5          11772601.71 (   0.00%)      8829092.61 * -25.00%*
Hmean     brk1-processes-8          18257028.74 (   0.00%)     13720140.11 * -24.85%*
Hmean     brk1-processes-12         26611276.11 (   0.00%)     20040283.01 * -24.69%*
Hmean     brk1-processes-21         43293789.47 (   0.00%)     32553619.66 * -24.81%*
Hmean     brk1-processes-30         62819136.48 (   0.00%)     47206392.92 * -24.85%*
Hmean     brk1-processes-48         99084516.67 (   0.00%)     74442789.08 * -24.87%*
Hmean     brk1-processes-79        149256917.87 (   0.00%)    110957538.42 * -25.66%*
Hmean     brk1-processes-110       167784473.57 (   0.00%)    119664465.82 * -28.68%*
Hmean     brk1-processes-141       186425159.76 (   0.00%)    128345206.83 * -31.15%*

Hmean     malloc1-processes-2         551028.28 (   0.00%)       493969.15 * -10.36%*
Hmean     malloc1-processes-5        1351566.71 (   0.00%)      1113801.87 * -17.59%*
Hmean     malloc1-processes-8        1277080.35 (   0.00%)      1252745.65 *  -1.91%*
Hmean     malloc1-processes-12       1318056.55 (   0.00%)      1309786.94 *  -0.63%*
Hmean     malloc1-processes-21       2154975.49 (   0.00%)      2068093.55 *  -4.03%*
Hmean     malloc1-processes-30       2741084.95 (   0.00%)      2809368.92 *   2.49%*
Hmean     malloc1-processes-48       4143258.89 (   0.00%)      4069176.07 *  -1.79%*
Hmean     malloc1-processes-79       5138031.43 (   0.00%)      5162196.46 *   0.47%*
Hmean     malloc1-processes-110      5022505.12 (   0.00%)      5439233.18 *   8.30%*
Hmean     malloc1-processes-141      4956600.59 (   0.00%)      5393879.66 *   8.82%*

Hmean     malloc1-threads-2            13228.04 (   0.00%)       184582.23 *1295.39%*
Hmean     malloc1-threads-5           100002.88 (   0.00%)       169561.76 *  69.56%*
Hmean     malloc1-threads-8            91218.91 (   0.00%)       154958.11 *  69.87%*
Hmean     malloc1-threads-12           97814.95 (   0.00%)       123943.65 *  26.71%*
Hmean     malloc1-threads-21           45995.46 (   0.00%)        43358.07 *  -5.73%*
Hmean     malloc1-threads-30           23986.53 (   0.00%)        47083.82 *  96.29%*
Hmean     malloc1-threads-48           15167.31 (   0.00%)        30307.31 *  99.82%*
Hmean     malloc1-threads-79            8976.45 (   0.00%)         8374.31 *  -6.71%*
Hmean     malloc1-threads-110           5355.38 (   0.00%)         1970.16 * -63.21%*
Hmean     malloc1-threads-141           8452.32 (   0.00%)        12303.51 *  45.56%*

kernbench               5.10-rc1                maple tree
Amean     user-2        884.80 (   0.00%)      884.09 *   0.08%*
Amean     syst-2        141.84 (   0.00%)      147.07 *  -3.68%*
Amean     elsp-2        518.70 (   0.00%)      520.85 *  -0.41%*
Amean     user-4        900.83 (   0.00%)      899.11 *   0.19%*
Amean     syst-4        145.76 (   0.00%)      151.17 *  -3.71%*
Amean     elsp-4        268.92 (   0.00%)      268.97 *  -0.02%*
Amean     user-8        916.07 (   0.00%)      916.70 *  -0.07%*
Amean     syst-8        145.34 (   0.00%)      151.73 *  -4.40%*
Amean     elsp-8        140.55 (   0.00%)      141.88 *  -0.94%*
Amean     user-16       930.43 (   0.00%)      931.27 *  -0.09%*
Amean     syst-16       147.23 (   0.00%)      153.34 *  -4.15%*
Amean     elsp-16        76.12 (   0.00%)       76.25 *  -0.17%*
Amean     user-32       980.03 (   0.00%)      979.52 *   0.05%*
Amean     syst-32       158.15 (   0.00%)      164.38 *  -3.94%*
Amean     elsp-32        46.13 (   0.00%)       45.98 *   0.31%*
Amean     user-64      1087.31 (   0.00%)     1092.55 *  -0.48%*
Amean     syst-64       173.28 (   0.00%)      181.08 *  -4.50%*
Amean     elsp-64        29.51 (   0.00%)       30.06 *  -1.88%*
Amean     user-128     1610.27 (   0.00%)     1612.96 *  -0.17%*
Amean     syst-128      228.93 (   0.00%)      240.80 *  -5.19%*
Amean     elsp-128       25.25 (   0.00%)       25.42 *  -0.70%*
Amean     user-256     1742.43 (   0.00%)     1738.54 *   0.22%*
Amean     syst-256      241.50 (   0.00%)      256.13 *  -6.06%*
Amean     elsp-256       25.08 (   0.00%)       25.42 *  -1.35%*
Amean     user-288     1742.33 (   0.00%)     1739.64 *   0.15%*
Amean     syst-288      241.16 (   0.00%)      256.44 *  -6.34%*
Amean     elsp-288       25.10 (   0.00%)       25.44 *  -1.35%*

Liam R. Howlett (28):
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
  mm/gup: Expose mm_populate_vma() for use when the vma is known
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm/mmap: Change vm_brk_flags() to use mm_populate_vma()
  mm: Move find_vma_intersection to mmap.c and change implementation to
    maple tree.
  mm/mmap: Change mmap_region to use maple tree state
  mm/mmap: Drop munmap_vma_range()
  mm: Remove vmacache
  mm/mmap: Change __do_munmap() to avoid unnecessary lookups.
  mm/mmap: Change __do_munmap() to use a ma_state
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Add do_mas_munmap() and wraper for __do_munmap()
  mmap: Use find_vma_intersection in do_mmap() for overlap
  mmap: Remove __do_munmap() in favour of do_mas_munmap()
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
  mmap: Update count_vma_pages_range() to only use one ma_state
  mmap: make remove_vma_list() inline

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple-tree.rst         |    36 +
 MAINTAINERS                                   |    12 +
 arch/x86/kernel/tboot.c                       |     2 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 fs/exec.c                                     |     3 -
 fs/proc/task_mmu.c                            |     1 -
 include/linux/maple_tree.h                    |   439 +
 include/linux/mm.h                            |    20 +-
 include/linux/mm_types.h                      |    30 +-
 include/linux/mm_types_task.h                 |     5 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |     3 +
 include/linux/vmacache.h                      |    28 -
 include/trace/events/maple_tree.h             |   227 +
 include/trace/events/mmap.h                   |    97 +
 init/main.c                                   |     2 +
 kernel/debug/debug_core.c                     |    12 -
 kernel/fork.c                                 |    35 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  5694 +++
 lib/test_maple_tree.c                         | 35821 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/debug.c                                    |     4 +-
 mm/gup.c                                      |    20 +
 mm/init-mm.c                                  |     4 +-
 mm/mmap.c                                     |  1904 +-
 mm/mremap.c                                   |     7 +-
 mm/util.c                                     |     8 +
 mm/vmacache.c                                 |   117 -
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |    13 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |    78 +-
 tools/testing/radix-tree/linux/kernel.h       |     8 +
 tools/testing/radix-tree/linux/maple_tree.h   |     3 +
 tools/testing/radix-tree/linux/slab.h         |     2 +
 tools/testing/radix-tree/maple.c              |    58 +
 tools/testing/radix-tree/test.h               |     1 +
 .../radix-tree/trace/events/maple_tree.h      |     8 +
 40 files changed, 43554 insertions(+), 1160 deletions(-)
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

