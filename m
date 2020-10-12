Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC74028B550
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgJLM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgJLM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asIQsS+oC8Mh53hgYBA1tcFGDTsXY+ZpGUk2qX42/rw=;
        b=YzmdmnGjunSjsN2wPIbj8YBzTs2EMzm9rND+CMsdPhwaDfUfuKErM7xHylOFuPx2ZNVerC
        4jItV3Gb1VTsM1RNW7wPCnNu0gaUmmibG5HKjm72nR7ljwZkk7zQsdCr9pcUCZtANNyI69
        rHmDTAJECiUepu0bl2yqnUbMXQiAfgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-LEt0s25AMBaPT6YEHVoaUw-1; Mon, 12 Oct 2020 08:57:06 -0400
X-MC-Unique: LEt0s25AMBaPT6YEHVoaUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05422107464C;
        Mon, 12 Oct 2020 12:57:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C44F960C07;
        Mon, 12 Oct 2020 12:56:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 26/29] virtio-mem: allow to force Big Block Mode (BBM) and set the big block size
Date:   Mon, 12 Oct 2020 14:53:20 +0200
Message-Id: <20201012125323.17509-27-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allow to force BBM, even if subblocks would be possible. Take care
of properly calculating the first big block id, because the start
address might no longer be aligned to the big block size.

Also, allow to manually configure the size of Big Blocks.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 4d396ef98a92..94cf44b15cbf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -27,6 +27,16 @@ static bool unplug_online = true;
 module_param(unplug_online, bool, 0644);
 MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
 
+static bool force_bbm;
+module_param(force_bbm, bool, 0444);
+MODULE_PARM_DESC(force_bbm,
+		"Force Big Block Mode. Default is 0 (auto-selection)");
+
+static unsigned long bbm_block_size;
+module_param(bbm_block_size, ulong, 0444);
+MODULE_PARM_DESC(bbm_block_size,
+		 "Big Block size in bytes. Default is 0 (auto-detection).");
+
 /*
  * virtio-mem currently supports the following modes of operation:
  *
@@ -2164,7 +2174,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			pageblock_nr_pages) * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
-	if (sb_size < memory_block_size_bytes()) {
+	if (sb_size < memory_block_size_bytes() && !force_bbm) {
 		/* SBM: At least two subblocks per Linux memory block. */
 		vm->in_sbm = true;
 		vm->sbm.sb_size = sb_size;
@@ -2177,9 +2187,24 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
 	} else {
 		/* BBM: At least one Linux memory block. */
-		vm->bbm.bb_size = vm->device_block_size;
+		vm->bbm.bb_size = max_t(uint64_t, vm->device_block_size,
+					memory_block_size_bytes());
+
+		if (bbm_block_size) {
+			if (!is_power_of_2(bbm_block_size)) {
+				dev_warn(&vm->vdev->dev,
+					 "bbm_block_size is not a power of 2");
+			} else if (bbm_block_size < vm->bbm.bb_size) {
+				dev_warn(&vm->vdev->dev,
+					 "bbm_block_size is too small");
+			} else {
+				vm->bbm.bb_size = bbm_block_size;
+			}
+		}
 
-		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, vm->addr);
+		/* Round up to the next aligned big block */
+		addr = vm->addr + vm->bbm.bb_size - 1;
+		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, addr);
 		vm->bbm.next_bb_id = vm->bbm.first_bb_id;
 	}
 
-- 
2.26.2

