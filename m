Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AA29216E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 05:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgJSDWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 23:22:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44773 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729093AbgJSDWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 23:22:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UCQ-x4t_1603077730;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCQ-x4t_1603077730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Oct 2020 11:22:11 +0800
Date:   Mon, 19 Oct 2020 11:22:10 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-ID: <20201019032210.GC54484@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-28-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-28-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:21PM +0200, David Hildenbrand wrote:
>virtio-mem soon wants to use offline_and_remove_memory() memory that
>exceeds a single Linux memory block (memory_block_size_bytes()). Let's
>remove that restriction.
>
>Let's remember the old state and try to restore that if anything goes
>wrong. While re-onlining can, in general, fail, it's highly unlikely to
>happen (usually only when a notifier fails to allocate memory, and these
>are rather rare).
>
>This will be used by virtio-mem to offline+remove memory ranges that are
>bigger than a single memory block - for example, with a device block
>size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
>block size of 128MB.
>
>While we could compress the state into 2 bit, using 8 bit is much
>easier.
>
>This handling is similar, but different to acpi_scan_try_to_offline():
>
>a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
>optimization is still relevant - it should only apply to ZONE_NORMAL
>(where we have no guarantees). If relevant, we can always add it.
>
>b) acpi_scan_try_to_offline() simply onlines all memory in case
>something goes wrong. It doesn't restore previous online type. Let's do
>that, so we won't overwrite what e.g., user space configured.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Looks good to me.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 89 insertions(+), 16 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index b44d4c7ba73b..217080ca93e5 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1806,39 +1806,112 @@ int remove_memory(int nid, u64 start, u64 size)
> }
> EXPORT_SYMBOL_GPL(remove_memory);
> 
>+static int try_offline_memory_block(struct memory_block *mem, void *arg)
>+{
>+	uint8_t online_type = MMOP_ONLINE_KERNEL;
>+	uint8_t **online_types = arg;
>+	struct page *page;
>+	int rc;
>+
>+	/*
>+	 * Sense the online_type via the zone of the memory block. Offlining
>+	 * with multiple zones within one memory block will be rejected
>+	 * by offlining code ... so we don't care about that.
>+	 */
>+	page = pfn_to_online_page(section_nr_to_pfn(mem->start_section_nr));
>+	if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
>+		online_type = MMOP_ONLINE_MOVABLE;
>+
>+	rc = device_offline(&mem->dev);
>+	/*
>+	 * Default is MMOP_OFFLINE - change it only if offlining succeeded,
>+	 * so try_reonline_memory_block() can do the right thing.
>+	 */
>+	if (!rc)
>+		**online_types = online_type;
>+
>+	(*online_types)++;
>+	/* Ignore if already offline. */
>+	return rc < 0 ? rc : 0;
>+}
>+
>+static int try_reonline_memory_block(struct memory_block *mem, void *arg)
>+{
>+	uint8_t **online_types = arg;
>+	int rc;
>+
>+	if (**online_types != MMOP_OFFLINE) {
>+		mem->online_type = **online_types;
>+		rc = device_online(&mem->dev);
>+		if (rc < 0)
>+			pr_warn("%s: Failed to re-online memory: %d",
>+				__func__, rc);
>+	}
>+
>+	/* Continue processing all remaining memory blocks. */
>+	(*online_types)++;
>+	return 0;
>+}
>+
> /*
>- * Try to offline and remove a memory block. Might take a long time to
>- * finish in case memory is still in use. Primarily useful for memory devices
>- * that logically unplugged all memory (so it's no longer in use) and want to
>- * offline + remove the memory block.
>+ * Try to offline and remove memory. Might take a long time to finish in case
>+ * memory is still in use. Primarily useful for memory devices that logically
>+ * unplugged all memory (so it's no longer in use) and want to offline + remove
>+ * that memory.
>  */
> int offline_and_remove_memory(int nid, u64 start, u64 size)
> {
>-	struct memory_block *mem;
>-	int rc = -EINVAL;
>+	const unsigned long mb_count = size / memory_block_size_bytes();
>+	uint8_t *online_types, *tmp;
>+	int rc;
> 
> 	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
>-	    size != memory_block_size_bytes())
>-		return rc;
>+	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
>+		return -EINVAL;
>+
>+	/*
>+	 * We'll remember the old online type of each memory block, so we can
>+	 * try to revert whatever we did when offlining one memory block fails
>+	 * after offlining some others succeeded.
>+	 */
>+	online_types = kmalloc_array(mb_count, sizeof(*online_types),
>+				     GFP_KERNEL);
>+	if (!online_types)
>+		return -ENOMEM;
>+	/*
>+	 * Initialize all states to MMOP_OFFLINE, so when we abort processing in
>+	 * try_offline_memory_block(), we'll skip all unprocessed blocks in
>+	 * try_reonline_memory_block().
>+	 */
>+	memset(online_types, MMOP_OFFLINE, mb_count);
> 
> 	lock_device_hotplug();
>-	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
>-	if (mem)
>-		rc = device_offline(&mem->dev);
>-	/* Ignore if the device is already offline. */
>-	if (rc > 0)
>-		rc = 0;
>+
>+	tmp = online_types;
>+	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
> 
> 	/*
>-	 * In case we succeeded to offline the memory block, remove it.
>+	 * In case we succeeded to offline all memory, remove it.
> 	 * This cannot fail as it cannot get onlined in the meantime.
> 	 */
> 	if (!rc) {
> 		rc = try_remove_memory(nid, start, size);
>-		WARN_ON_ONCE(rc);
>+		if (rc)
>+			pr_err("%s: Failed to remove memory: %d", __func__, rc);
>+	}
>+
>+	/*
>+	 * Rollback what we did. While memory onlining might theoretically fail
>+	 * (nacked by a notifier), it barely ever happens.
>+	 */
>+	if (rc) {
>+		tmp = online_types;
>+		walk_memory_blocks(start, size, &tmp,
>+				   try_reonline_memory_block);
> 	}
> 	unlock_device_hotplug();
> 
>+	kfree(online_types);
> 	return rc;
> }
> EXPORT_SYMBOL_GPL(offline_and_remove_memory);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
