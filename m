Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10E728FE45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394172AbgJPGYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:24:49 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40919 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393958AbgJPGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:24:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCAvHH1_1602829484;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCAvHH1_1602829484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 14:24:44 +0800
Date:   Fri, 16 Oct 2020 14:24:44 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 12/29] virtio-mem: factor out fake-offlining into
 virtio_mem_fake_offline()
Message-ID: <20201016062444.GL86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-13-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:06PM +0200, David Hildenbrand wrote:
>... which now matches virtio_mem_fake_online(). We'll reuse this
>functionality soon.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 34 ++++++++++++++++++++++++----------
> 1 file changed, 24 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 00d1cfca4713..d132bc54ef57 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -832,6 +832,27 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
> 	}
> }
> 
>+/*
>+ * Try to allocate a range, marking pages fake-offline, effectively
>+ * fake-offlining them.
>+ */
>+static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
>+{
>+	int rc;
>+
>+	rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
>+				GFP_KERNEL);
>+	if (rc == -ENOMEM)
>+		/* whoops, out of memory */
>+		return rc;
>+	if (rc)
>+		return -EBUSY;
>+
>+	virtio_mem_set_fake_offline(pfn, nr_pages, true);
>+	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
>+	return 0;
>+}
>+
> static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
> {
> 	const unsigned long addr = page_to_phys(page);
>@@ -1335,17 +1356,10 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
> 
> 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
> 			     sb_id * vm->subblock_size);
>-	rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
>-				MIGRATE_MOVABLE, GFP_KERNEL);
>-	if (rc == -ENOMEM)
>-		/* whoops, out of memory */
>-		return rc;
>-	if (rc)
>-		return -EBUSY;
> 
>-	/* Mark it as fake-offline before unplugging it */
>-	virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
>-	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
>+	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
>+	if (rc)
>+		return rc;
> 
> 	/* Try to unplug the allocated memory */
> 	rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
