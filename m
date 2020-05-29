Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E51E71EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 03:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438278AbgE2BIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 21:08:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:11994 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438237AbgE2BIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:08:53 -0400
IronPort-SDR: JLT4EGk674GEYEz5VOdPCpcxwuYs1c0LD7cOe1w0QDwc9/IM/9ubMnRpgo9OYyUclY78c08LqE
 IEtS1UmFYmMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 18:08:52 -0700
IronPort-SDR: ixD3qR6BbywtK7dqWsF46ggwXAXbDpkCiFtwthZcjbofXam14AOdu9Z92nPN8dxehT0/PeeGJw
 O69/Xjgk7U/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="311093660"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 18:08:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH -V4] swap: Reduce lock contention on swap cache from swap slots allocation
Date:   Fri, 29 May 2020 09:08:40 +0800
Message-Id: <20200529010840.928819-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In some swap scalability test, it is found that there are heavy lock
contention on swap cache even if we have split one swap cache radix
tree per swap device to one swap cache radix tree every 64 MB trunk in
commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").

The reason is as follow.  After the swap device becomes fragmented so
that there's no free swap cluster, the swap device will be scanned
linearly to find the free swap slots.  swap_info_struct->cluster_next
is the next scanning base that is shared by all CPUs.  So nearby free
swap slots will be allocated for different CPUs.  The probability for
multiple CPUs to operate on the same 64 MB trunk is high.  This causes
the lock contention on the swap cache.

To solve the issue, in this patch, for SSD swap device, a percpu
version next scanning base (cluster_next_cpu) is added.  Every CPU
will use its own per-cpu next scanning base.  And after finishing
scanning a 64MB trunk, the per-cpu scanning base will be changed to
the beginning of another randomly selected 64MB trunk.  In this way,
the probability for multiple CPUs to operate on the same 64 MB trunk
is reduced greatly.  Thus the lock contention is reduced too.  For
HDD, because sequential access is more important for IO performance,
the original shared next scanning base is used.

To test the patch, we have run 16-process pmbench memory benchmark on
a 2-socket server machine with 48 cores.  One ram disk is configured
as the swap device per socket.  The pmbench working-set size is much
larger than the available memory so that swapping is triggered.  The
memory read/write ratio is 80/20 and the accessing pattern is random.
In the original implementation, the lock contention on the swap cache
is heavy.  The perf profiling data of the lock contention code path is
as following,

_raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      7.91
_raw_spin_lock_irqsave.__remove_mapping.shrink_page_list:               7.11
_raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 2.51
_raw_spin_lock_irqsave.swap_cgroup_record.mem_cgroup_uncharge_swap:     1.66
_raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      1.29
_raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:         1.03
_raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:        0.93

After applying this patch, it becomes,

_raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 3.58
_raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      2.3
_raw_spin_lock_irqsave.swap_cgroup_record.mem_cgroup_uncharge_swap:     2.26
_raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:        1.8
_raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:         1.19

The lock contention on the swap cache is almost eliminated.

And the pmbench score increases 18.5%.  The swapin throughput
increases 18.7% from 2.96 GB/s to 3.51 GB/s.  While the swapout
throughput increases 18.5% from 2.99 GB/s to 3.54 GB/s.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
---

Changelog:

v4:

- Fix wrong ALIGN() usage with ALIGN_DOWN().  Thanks Daniel's comments!

- Add some comments.  Thanks Daniel's comments!

v3:

- Fix cluster_next_cpu allocation and freeing.  Thanks Daniel's comments!

v2:

- Rebased on latest mmotm tree (v5.7-rc5-mmots-2020-05-15-16-36), the
  mem cgroup change has influence on performance data.

- Fix cluster_next_cpu initialization per Andrew and Daniel's comments.

- Change per-cpu scan base every 64MB per Andrew's comments.

---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 61 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b42fb47d8cbe..e96820fb7472 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -252,6 +252,7 @@ struct swap_info_struct {
 	unsigned int inuse_pages;	/* number of those currently in use */
 	unsigned int cluster_next;	/* likely index for next allocation */
 	unsigned int cluster_nr;	/* countdown to next cluster search */
+	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 423c234aca15..c12e1fe6b067 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -612,10 +612,12 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 		} else if (!cluster_list_empty(&si->discard_clusters)) {
 			/*
 			 * we don't have free cluster but have some clusters in
-			 * discarding, do discard now and reclaim them
+			 * discarding, do discard now and reclaim them, then
+			 * reread cluster_next_cpu since we dropped si->lock
 			 */
 			swap_do_scheduled_discard(si);
-			*scan_base = *offset = si->cluster_next;
+			*scan_base = this_cpu_read(*si->cluster_next_cpu);
+			*offset = *scan_base;
 			goto new_cluster;
 		} else
 			return false;
@@ -721,6 +723,34 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	}
 }
 
+static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
+{
+	unsigned long prev;
+
+	if (!(si->flags & SWP_SOLIDSTATE)) {
+		si->cluster_next = next;
+		return;
+	}
+
+	prev = this_cpu_read(*si->cluster_next_cpu);
+	/*
+	 * Cross the swap address space size aligned trunk, choose
+	 * another trunk randomly to avoid lock contention on swap
+	 * address space if possible.
+	 */
+	if ((prev >> SWAP_ADDRESS_SPACE_SHIFT) !=
+	    (next >> SWAP_ADDRESS_SPACE_SHIFT)) {
+		/* No free swap slots available */
+		if (si->highest_bit <= si->lowest_bit)
+			return;
+		next = si->lowest_bit +
+			prandom_u32_max(si->highest_bit - si->lowest_bit + 1);
+		next = ALIGN_DOWN(next, SWAP_ADDRESS_SPACE_PAGES);
+		next = max_t(unsigned int, next, si->lowest_bit);
+	}
+	this_cpu_write(*si->cluster_next_cpu, next);
+}
+
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
 			       swp_entry_t slots[])
@@ -745,7 +775,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	 */
 
 	si->flags += SWP_SCANNING;
-	scan_base = offset = si->cluster_next;
+	/*
+	 * Use percpu scan base for SSD to reduce lock contention on
+	 * cluster and swap cache.  For HDD, sequential access is more
+	 * important.
+	 */
+	if (si->flags & SWP_SOLIDSTATE)
+		scan_base = this_cpu_read(*si->cluster_next_cpu);
+	else
+		scan_base = si->cluster_next;
+	offset = scan_base;
 
 	/* SSD algorithm */
 	if (si->cluster_info) {
@@ -834,7 +873,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	unlock_cluster(ci);
 
 	swap_range_alloc(si, offset, 1);
-	si->cluster_next = offset + 1;
 	slots[n_ret++] = swp_entry(si->type, offset);
 
 	/* got enough slots or reach max slots? */
@@ -883,6 +921,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	}
 
 done:
+	set_cluster_next(si, offset + 1);
 	si->flags -= SWP_SCANNING;
 	return n_ret;
 
@@ -2646,6 +2685,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	free_percpu(p->percpu_cluster);
 	p->percpu_cluster = NULL;
+	free_percpu(p->cluster_next_cpu);
+	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
 	kvfree(cluster_info);
 	kvfree(frontswap_map);
@@ -3198,11 +3239,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		unsigned long ci, nr_cluster;
 
 		p->flags |= SWP_SOLIDSTATE;
+		p->cluster_next_cpu = alloc_percpu(unsigned int);
+		if (!p->cluster_next_cpu) {
+			error = -ENOMEM;
+			goto bad_swap_unlock_inode;
+		}
 		/*
 		 * select a random position to start with to help wear leveling
 		 * SSD
 		 */
-		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
+		for_each_possible_cpu(cpu) {
+			per_cpu(*p->cluster_next_cpu, cpu) =
+				1 + prandom_u32_max(p->highest_bit);
+		}
 		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
 		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
@@ -3318,6 +3367,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap:
 	free_percpu(p->percpu_cluster);
 	p->percpu_cluster = NULL;
+	free_percpu(p->cluster_next_cpu);
+	p->cluster_next_cpu = NULL;
 	if (inode && S_ISBLK(inode->i_mode) && p->bdev) {
 		set_blocksize(p->bdev, p->old_block_size);
 		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-- 
2.25.0

