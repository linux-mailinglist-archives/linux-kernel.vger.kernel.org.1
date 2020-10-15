Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B337528EE87
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgJOIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:32:36 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44903 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728436AbgJOIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:32:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC5T.KF_1602750754;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UC5T.KF_1602750754)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 16:32:34 +0800
Date:   Thu, 15 Oct 2020 16:32:34 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 06/29] virtio-mem: generalize virtio_mem_owned_mb()
Message-ID: <20201015083234.GF86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-7-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:00PM +0200, David Hildenbrand wrote:
>Avoid using memory block ids. Rename it to virtio_mem_contains_range().
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/virtio/virtio_mem.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 6bbd1cfd10d3..821143db14fe 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -500,12 +500,13 @@ static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
> }
> 
> /*
>- * Test if a virtio-mem device owns a memory block. Can be called from
>+ * Test if a virtio-mem device contains a given range. Can be called from
>  * (notifier) callbacks lockless.
>  */
>-static bool virtio_mem_owned_mb(struct virtio_mem *vm, unsigned long mb_id)
>+static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
>+				      uint64_t size)
> {
>-	return mb_id >= vm->first_mb_id && mb_id <= vm->last_mb_id;
>+	return start >= vm->addr && start + size <= vm->addr + vm->region_size;

Do we have some reason to do this change?

> }
> 
> static int virtio_mem_notify_going_online(struct virtio_mem *vm,
>@@ -800,7 +801,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
> 	 */
> 	rcu_read_lock();
> 	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
>-		if (!virtio_mem_owned_mb(vm, mb_id))
>+		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
> 			continue;
> 
> 		sb_id = virtio_mem_phys_to_sb_id(vm, addr);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
