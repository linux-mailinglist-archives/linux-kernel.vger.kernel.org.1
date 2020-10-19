Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD92920FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgJSB52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 21:57:28 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49221 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbgJSB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 21:57:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCPIkpE_1603072645;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCPIkpE_1603072645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Oct 2020 09:57:25 +0800
Date:   Mon, 19 Oct 2020 09:57:24 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 21/29] virtio-mem: memory notifier callbacks are
 specific to Sub Block Mode (SBM)
Message-ID: <20201019015724.GA54484@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-22-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-22-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:15PM +0200, David Hildenbrand wrote:
>Let's rename accordingly.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/virtio/virtio_mem.c | 29 +++++++++++++++--------------
> 1 file changed, 15 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 3a772714fec9..d06c8760b337 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -589,8 +589,8 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
> 	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
> }
> 
>-static int virtio_mem_notify_going_online(struct virtio_mem *vm,
>-					  unsigned long mb_id)
>+static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
>+					      unsigned long mb_id)

Look into this patch with "virtio-mem: Big Block Mode (BBM) memory hotplug"
together, I thought the code is a little "complex".

The final logic of virtio_mem_memory_notifier_cb() looks like this:

    virtio_mem_memory_notifier_cb()
        if (vm->in_sbm)
	    notify_xxx()
        if (vm->in_sbm)
	    notify_xxx()

Can we adjust this like

    virtio_mem_memory_notifier_cb()
	notify_xxx()
            if (vm->in_sbm)
                return
	notify_xxx()
            if (vm->in_sbm)
                return

This style looks a little better to me.


-- 
Wei Yang
Help you, Help me
