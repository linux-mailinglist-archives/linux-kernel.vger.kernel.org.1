Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9F2900C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390727AbgJPJIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:08:49 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60341 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405419AbgJPJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:07:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCB9zIn_1602839249;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCB9zIn_1602839249)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 17:07:29 +0800
Date:   Fri, 16 Oct 2020 17:07:29 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 24/29] virtio-mem: print debug messages from
 virtio_mem_send_*_request()
Message-ID: <20201016090729.GG44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-25-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-25-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:18PM +0200, David Hildenbrand wrote:
>Let's move the existing dev_dbg() into the functions, print if something
>went wrong, and also print for virtio_mem_send_unplug_all_request().
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 50 ++++++++++++++++++++++++++-----------
> 1 file changed, 35 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index eb2ad31a8d8a..e68d0d99590c 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -1053,23 +1053,33 @@ static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
> 		.u.plug.addr = cpu_to_virtio64(vm->vdev, addr),
> 		.u.plug.nb_blocks = cpu_to_virtio16(vm->vdev, nb_vm_blocks),
> 	};
>+	int rc = -ENOMEM;
> 
> 	if (atomic_read(&vm->config_changed))
> 		return -EAGAIN;
> 
>+	dev_dbg(&vm->vdev->dev, "plugging memory: 0x%llx - 0x%llx\n", addr,
>+		addr + size - 1);
>+
> 	switch (virtio_mem_send_request(vm, &req)) {
> 	case VIRTIO_MEM_RESP_ACK:
> 		vm->plugged_size += size;
> 		return 0;
> 	case VIRTIO_MEM_RESP_NACK:
>-		return -EAGAIN;
>+		rc = -EAGAIN;
>+		break;
> 	case VIRTIO_MEM_RESP_BUSY:
>-		return -ETXTBSY;
>+		rc = -ETXTBSY;
>+		break;
> 	case VIRTIO_MEM_RESP_ERROR:
>-		return -EINVAL;
>+		rc = -EINVAL;
>+		break;
> 	default:
>-		return -ENOMEM;
>+		break;
> 	}
>+
>+	dev_dbg(&vm->vdev->dev, "plugging memory failed: %d\n", rc);
>+	return rc;
> }
> 
> static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
>@@ -1081,21 +1091,30 @@ static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
> 		.u.unplug.addr = cpu_to_virtio64(vm->vdev, addr),
> 		.u.unplug.nb_blocks = cpu_to_virtio16(vm->vdev, nb_vm_blocks),
> 	};
>+	int rc = -ENOMEM;
> 
> 	if (atomic_read(&vm->config_changed))
> 		return -EAGAIN;
> 
>+	dev_dbg(&vm->vdev->dev, "unplugging memory: 0x%llx - 0x%llx\n", addr,
>+		addr + size - 1);
>+
> 	switch (virtio_mem_send_request(vm, &req)) {
> 	case VIRTIO_MEM_RESP_ACK:
> 		vm->plugged_size -= size;
> 		return 0;
> 	case VIRTIO_MEM_RESP_BUSY:
>-		return -ETXTBSY;
>+		rc = -ETXTBSY;
>+		break;
> 	case VIRTIO_MEM_RESP_ERROR:
>-		return -EINVAL;
>+		rc = -EINVAL;
>+		break;
> 	default:
>-		return -ENOMEM;
>+		break;
> 	}
>+
>+	dev_dbg(&vm->vdev->dev, "unplugging memory failed: %d\n", rc);
>+	return rc;
> }
> 
> static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
>@@ -1103,6 +1122,9 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
> 	const struct virtio_mem_req req = {
> 		.type = cpu_to_virtio16(vm->vdev, VIRTIO_MEM_REQ_UNPLUG_ALL),
> 	};
>+	int rc = -ENOMEM;
>+
>+	dev_dbg(&vm->vdev->dev, "unplugging all memory");
> 
> 	switch (virtio_mem_send_request(vm, &req)) {
> 	case VIRTIO_MEM_RESP_ACK:
>@@ -1112,10 +1134,14 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
> 		atomic_set(&vm->config_changed, 1);
> 		return 0;
> 	case VIRTIO_MEM_RESP_BUSY:
>-		return -ETXTBSY;
>+		rc = -ETXTBSY;
>+		break;
> 	default:
>-		return -ENOMEM;
>+		break;
> 	}
>+
>+	dev_dbg(&vm->vdev->dev, "unplugging all memory failed: %d\n", rc);
>+	return rc;
> }
> 
> /*
>@@ -1130,9 +1156,6 @@ static int virtio_mem_sbm_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
> 	const uint64_t size = count * vm->sbm.sb_size;
> 	int rc;
> 
>-	dev_dbg(&vm->vdev->dev, "plugging memory block: %lu : %i - %i\n", mb_id,
>-		sb_id, sb_id + count - 1);
>-
> 	rc = virtio_mem_send_plug_request(vm, addr, size);
> 	if (!rc)
> 		virtio_mem_sbm_set_sb_plugged(vm, mb_id, sb_id, count);
>@@ -1151,9 +1174,6 @@ static int virtio_mem_sbm_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
> 	const uint64_t size = count * vm->sbm.sb_size;
> 	int rc;
> 
>-	dev_dbg(&vm->vdev->dev, "unplugging memory block: %lu : %i - %i\n",
>-		mb_id, sb_id, sb_id + count - 1);
>-
> 	rc = virtio_mem_send_unplug_request(vm, addr, size);
> 	if (!rc)
> 		virtio_mem_sbm_set_sb_unplugged(vm, mb_id, sb_id, count);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
