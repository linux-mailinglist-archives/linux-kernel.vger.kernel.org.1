Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30685290DCD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgJPWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:39:20 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:55132 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731257AbgJPWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:39:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCEKmif_1602887946;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCEKmif_1602887946)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 17 Oct 2020 06:39:06 +0800
Date:   Sat, 17 Oct 2020 06:39:06 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
Message-ID: <20201016223906.GA48071@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-6-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:52:59PM +0200, David Hildenbrand wrote:
>Let's check by traversing busy system RAM resources instead, to avoid
>relying on memory block states.
>
>Don't use walk_system_ram_range(), as that works on pages and we want to
>use the bare addresses we have easily at hand.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index b3eebac7191f..6bbd1cfd10d3 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -1749,6 +1749,20 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
> 	vm->parent_resource = NULL;
> }
> 
>+static int virtio_mem_range_has_system_ram(struct resource *res, void *arg)
>+{
>+	return 1;
>+}
>+
>+static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
>+{
>+	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>+
>+	return walk_iomem_res_desc(IORES_DESC_NONE, flags, vm->addr,
>+				   vm->addr + vm->region_size, NULL,
>+				   virtio_mem_range_has_system_ram) == 1;
>+}
>+
> static int virtio_mem_probe(struct virtio_device *vdev)
> {
> 	struct virtio_mem *vm;
>@@ -1870,10 +1884,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> 	 * the system. And there is no way to stop the driver/device from going
> 	 * away. Warn at least.
> 	 */
>-	if (vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] ||
>-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
>-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
>-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL]) {
>+	if (virtio_mem_has_memory_added(vm)) {
> 		dev_warn(&vdev->dev, "device still has system memory added\n");
> 	} else {
> 		virtio_mem_delete_resource(vm);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
