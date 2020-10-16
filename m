Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846FA28FFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404991AbgJPIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:03:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41098 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404920AbgJPIDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:03:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCAvZnG_1602835424;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCAvZnG_1602835424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:03:45 +0800
Date:   Fri, 16 Oct 2020 16:03:44 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 15/29] virito-mem: document Sub Block Mode (SBM)
Message-ID: <20201016080344.GN86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-16-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-16-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:09PM +0200, David Hildenbrand wrote:
>Let's add some documentation for the current mode - Sub Block Mode (SBM) -
>to prepare for a new mode - Big Block Mode (BBM).
>
>Follow-up patches will properly factor out the existing Sub Block Mode
>(SBM) and implement Device Block Mode (DBM).
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index faeb759687fe..fd8685673fe4 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -27,6 +27,21 @@ static bool unplug_online = true;
> module_param(unplug_online, bool, 0644);
> MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
> 
>+/*
>+ * virtio-mem currently supports the following modes of operation:
>+ *
>+ * * Sub Block Mode (SBM): A Linux memory block spans 1..X subblocks (SB). The
>+ *   size of a Sub Block (SB) is determined based on the device block size, the
>+ *   pageblock size, and the maximum allocation granularity of the buddy.
>+ *   Subblocks within a Linux memory block might either be plugged or unplugged.
>+ *   Memory is added/removed to Linux MM in Linux memory block granularity.
>+ *
>+ * User space / core MM (auto onlining) is responsible for onlining added
>+ * Linux memory blocks - and for selecting a zone. Linux Memory Blocks are
>+ * always onlined separately, and all memory within a Linux memory block is
>+ * onlined to the same zone - virtio-mem relies on this behavior.
>+ */
>+
> enum virtio_mem_mb_state {
> 	/* Unplugged, not added to Linux. Can be reused later. */
> 	VIRTIO_MEM_MB_STATE_UNUSED = 0,
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
