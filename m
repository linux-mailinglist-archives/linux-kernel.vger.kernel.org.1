Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7628EE94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgJOIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:35:24 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45889 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbgJOIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:35:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC5QO15_1602750919;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UC5QO15_1602750919)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 16:35:20 +0800
Date:   Thu, 15 Oct 2020 16:35:19 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 08/29] virtio-mem: drop last_mb_id
Message-ID: <20201015083519.GG86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-9-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:02PM +0200, David Hildenbrand wrote:
>No longer used, let's drop it.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

If above two patches are merged.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 37a0e338ae4a..5c93f8a65eba 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -84,8 +84,6 @@ struct virtio_mem {
> 
> 	/* Id of the first memory block of this device. */
> 	unsigned long first_mb_id;
>-	/* Id of the last memory block of this device. */
>-	unsigned long last_mb_id;
> 	/* Id of the last usable memory block of this device. */
> 	unsigned long last_usable_mb_id;
> 	/* Id of the next memory bock to prepare when needed. */
>@@ -1689,8 +1687,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
> 	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
> 						   memory_block_size_bytes());
> 	vm->next_mb_id = vm->first_mb_id;
>-	vm->last_mb_id = virtio_mem_phys_to_mb_id(vm->addr +
>-			 vm->region_size) - 1;
> 
> 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
> 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
