Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22629231F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgJSHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:54:10 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34255 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727420AbgJSHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:54:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UCTl6m-_1603094046;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCTl6m-_1603094046)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Oct 2020 15:54:06 +0800
Date:   Mon, 19 Oct 2020 15:54:06 +0800
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
Subject: Re: [PATCH v1 29/29] virtio-mem: Big Block Mode (BBM) - safe memory
 hotunplug
Message-ID: <20201019075406.GE54484@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-30-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-30-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:23PM +0200, David Hildenbrand wrote:
>Let's add a safe mechanism to unplug memory, avoiding long/endless loops
>when trying to offline memory - similar to in SBM.
>
>Fake-offline all memory (via alloc_contig_range()) before trying to
>offline+remove it. Use this mode as default, but allow to enable the other
>mode explicitly (which could give better memory hotunplug guarantees in

I don't get the point how unsafe mode would have a better guarantees?

>some environments).
>
>The "unsafe" mode can be enabled e.g., via virtio_mem.bbm_safe_unplug=0
>on the cmdline.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/virtio/virtio_mem.c | 97 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 95 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 6bcd0acbff32..09f11489be6f 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -37,6 +37,11 @@ module_param(bbm_block_size, ulong, 0444);
> MODULE_PARM_DESC(bbm_block_size,
> 		 "Big Block size in bytes. Default is 0 (auto-detection).");
> 
>+static bool bbm_safe_unplug = true;
>+module_param(bbm_safe_unplug, bool, 0444);
>+MODULE_PARM_DESC(bbm_safe_unplug,
>+	     "Use a safe unplug mechanism in BBM, avoiding long/endless loops");
>+
> /*
>  * virtio-mem currently supports the following modes of operation:
>  *
>@@ -87,6 +92,8 @@ enum virtio_mem_bbm_bb_state {
> 	VIRTIO_MEM_BBM_BB_PLUGGED,
> 	/* Plugged and added to Linux. */
> 	VIRTIO_MEM_BBM_BB_ADDED,
>+	/* All online parts are fake-offline, ready to remove. */
>+	VIRTIO_MEM_BBM_BB_FAKE_OFFLINE,
> 	VIRTIO_MEM_BBM_BB_COUNT
> };
> 
>@@ -889,6 +896,32 @@ static void virtio_mem_sbm_notify_cancel_offline(struct virtio_mem *vm,
> 	}
> }
> 
>+static void virtio_mem_bbm_notify_going_offline(struct virtio_mem *vm,
>+						unsigned long bb_id,
>+						unsigned long pfn,
>+						unsigned long nr_pages)
>+{
>+	/*
>+	 * When marked as "fake-offline", all online memory of this device block
>+	 * is allocated by us. Otherwise, we don't have any memory allocated.
>+	 */
>+	if (virtio_mem_bbm_get_bb_state(vm, bb_id) !=
>+	    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
>+		return;
>+	virtio_mem_fake_offline_going_offline(pfn, nr_pages);
>+}
>+
>+static void virtio_mem_bbm_notify_cancel_offline(struct virtio_mem *vm,
>+						 unsigned long bb_id,
>+						 unsigned long pfn,
>+						 unsigned long nr_pages)
>+{
>+	if (virtio_mem_bbm_get_bb_state(vm, bb_id) !=
>+	    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
>+		return;
>+	virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
>+}
>+
> /*
>  * This callback will either be called synchronously from add_memory() or
>  * asynchronously (e.g., triggered via user space). We have to be careful
>@@ -949,6 +982,10 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
> 		vm->hotplug_active = true;
> 		if (vm->in_sbm)
> 			virtio_mem_sbm_notify_going_offline(vm, id);
>+		else
>+			virtio_mem_bbm_notify_going_offline(vm, id,
>+							    mhp->start_pfn,
>+							    mhp->nr_pages);
> 		break;
> 	case MEM_GOING_ONLINE:
> 		mutex_lock(&vm->hotplug_mutex);
>@@ -999,6 +1036,10 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
> 			break;
> 		if (vm->in_sbm)
> 			virtio_mem_sbm_notify_cancel_offline(vm, id);
>+		else
>+			virtio_mem_bbm_notify_cancel_offline(vm, id,
>+							     mhp->start_pfn,
>+							     mhp->nr_pages);
> 		vm->hotplug_active = false;
> 		mutex_unlock(&vm->hotplug_mutex);
> 		break;
>@@ -1189,7 +1230,13 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
> 			do_online = virtio_mem_sbm_test_sb_plugged(vm, id,
> 								   sb_id, 1);
> 		} else {
>-			do_online = true;
>+			/*
>+			 * If the whole block is marked fake offline, keep
>+			 * everything that way.
>+			 */
>+			id = virtio_mem_phys_to_bb_id(vm, addr);
>+			do_online = virtio_mem_bbm_get_bb_state(vm, id) !=
>+				    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE;
> 		}
> 		if (do_online)
> 			generic_online_page(page, order);
>@@ -1969,15 +2016,50 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
> static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
> 						       unsigned long bb_id)
> {
>+	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
>+	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
>+	unsigned long end_pfn = start_pfn + nr_pages;
>+	unsigned long pfn;
>+	struct page *page;
> 	int rc;
> 
> 	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
> 			 VIRTIO_MEM_BBM_BB_ADDED))
> 		return -EINVAL;
> 
>+	if (bbm_safe_unplug) {
>+		/*
>+		 * Start by fake-offlining all memory. Once we marked the device
>+		 * block as fake-offline, all newly onlined memory will
>+		 * automatically be kept fake-offline. Protect from concurrent
>+		 * onlining/offlining until we have a consistent state.
>+		 */
>+		mutex_lock(&vm->hotplug_mutex);
>+		virtio_mem_bbm_set_bb_state(vm, bb_id,
>+					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
>+

State is set here.

>+		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>+			page = pfn_to_online_page(pfn);
>+			if (!page)
>+				continue;
>+
>+			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
>+			if (rc) {
>+				end_pfn = pfn;
>+				goto rollback_safe_unplug;
>+			}
>+		}
>+		mutex_unlock(&vm->hotplug_mutex);
>+	}
>+
> 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
>-	if (rc)
>+	if (rc) {
>+		if (bbm_safe_unplug) {
>+			mutex_lock(&vm->hotplug_mutex);
>+			goto rollback_safe_unplug;
>+		}
> 		return rc;
>+	}
> 
> 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
> 	if (rc)

And changed to PLUGGED or UNUSED based on rc.

>@@ -1987,6 +2069,17 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
> 		virtio_mem_bbm_set_bb_state(vm, bb_id,
> 					    VIRTIO_MEM_BBM_BB_UNUSED);
> 	return rc;
>+
>+rollback_safe_unplug:
>+	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>+		page = pfn_to_online_page(pfn);
>+		if (!page)
>+			continue;
>+		virtio_mem_fake_online(pfn, PAGES_PER_SECTION);
>+	}
>+	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED);

And changed to ADDED if failed.

>+	mutex_unlock(&vm->hotplug_mutex);
>+	return rc;
> }

So in which case, the bbm state is FAKE_OFFLINE during
virtio_mem_bbm_notify_going_offline() and
virtio_mem_bbm_notify_cancel_offline() ?

> 
> /*
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
