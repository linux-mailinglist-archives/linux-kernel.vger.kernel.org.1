Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585B328FD12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgJPEDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:03:06 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44199 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbgJPEDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:03:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC9wxDT_1602820981;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UC9wxDT_1602820981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 12:03:02 +0800
Date:   Fri, 16 Oct 2020 12:03:01 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue
 when offlining memory
Message-ID: <20201016040301.GJ86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-10-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>Let's trigger from offlining code when we're not allowed to touch online
>memory.

This describes the change in virtio_mem_memory_notifier_cb()?

>
>Handle the other case (memmap possibly freeing up another memory block)
>when actually removing memory. When removing via virtio_mem_remove(),
>virtio_mem_retry() is a NOP and safe to use.
>
>While at it, move retry handling when offlining out of
>virtio_mem_notify_offline(), to share it with Device Block Mode (DBM)
>soon.

I may not understand the logic fully. Here is my understanding of current
logic:


  virtio_mem_run_wq()
      virtio_mem_unplug_request()
          virtio_mem_mb_unplug_any_sb_offline()
	      virtio_mem_mb_remove()             --- 1
	  virtio_mem_mb_unplug_any_sb_online()
	      virtio_mem_mb_offline_and_remove() --- 2

This patch tries to trigger the wq at 1 and 2. And these two functions are
only valid during this code flow.

These two functions actually remove some memory from the system. So I am not
sure where extra unplug-able memory comes from. I guess those memory is from
memory block device and mem_sectioin, memmap? While those memory is still
marked as online, right?

In case we can gather extra memory at 1 and form a whole memory block. So that
we can unplug an online memory block (by moving data to a new place), this
just affect the process at 2. This means there is no need to trigger the wq at
1, and we can leave it at 2.

>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/virtio/virtio_mem.c | 40 ++++++++++++++++++++++++++-----------
> 1 file changed, 28 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 5c93f8a65eba..8ea00f0b2ecd 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -158,6 +158,7 @@ static DEFINE_MUTEX(virtio_mem_mutex);
> static LIST_HEAD(virtio_mem_devices);
> 
> static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
>+static void virtio_mem_retry(struct virtio_mem *vm);
> 
> /*
>  * Register a virtio-mem device so it will be considered for the online_page
>@@ -435,9 +436,17 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
> static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>+	int rc;
> 
> 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
>-	return remove_memory(vm->nid, addr, memory_block_size_bytes());
>+	rc = remove_memory(vm->nid, addr, memory_block_size_bytes());
>+	if (!rc)
>+		/*
>+		 * We might have freed up memory we can now unplug, retry
>+		 * immediately instead of waiting.
>+		 */
>+		virtio_mem_retry(vm);
>+	return rc;
> }
> 
> /*
>@@ -452,11 +461,19 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
> 					    unsigned long mb_id)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>+	int rc;
> 
> 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
> 		mb_id);
>-	return offline_and_remove_memory(vm->nid, addr,
>-					 memory_block_size_bytes());
>+	rc = offline_and_remove_memory(vm->nid, addr,
>+				       memory_block_size_bytes());
>+	if (!rc)
>+		/*
>+		 * We might have freed up memory we can now unplug, retry
>+		 * immediately instead of waiting.
>+		 */
>+		virtio_mem_retry(vm);
>+	return rc;
> }
> 
> /*
>@@ -534,15 +551,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
> 		BUG();
> 		break;
> 	}
>-
>-	/*
>-	 * Trigger the workqueue, maybe we can now unplug memory. Also,
>-	 * when we offline and remove a memory block, this will re-trigger
>-	 * us immediately - which is often nice because the removal of
>-	 * the memory block (e.g., memmap) might have freed up memory
>-	 * on other memory blocks we manage.
>-	 */
>-	virtio_mem_retry(vm);
> }
> 
> static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
>@@ -679,6 +687,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
> 		break;
> 	case MEM_OFFLINE:
> 		virtio_mem_notify_offline(vm, mb_id);
>+
>+		/*
>+		 * Trigger the workqueue. Now that we have some offline memory,
>+		 * maybe we can handle pending unplug requests.
>+		 */
>+		if (!unplug_online)
>+			virtio_mem_retry(vm);
>+
> 		vm->hotplug_active = false;
> 		mutex_unlock(&vm->hotplug_mutex);
> 		break;
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
