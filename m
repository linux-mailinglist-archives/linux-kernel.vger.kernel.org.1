Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06C28B515
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgJLMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729953AbgJLMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Tp/pxwbrRyeSEcnT8YJ4hvBMIWgGbY7I+4xmVDlJL0=;
        b=KBtIotTaeIuBc1YhE4nkPhrEsxgYFoKV7BxQyI8bkM8hqTWRvMrVbyvJUW0epfPKtVv2XF
        MeS4c+hpXt+E/RkV8v6KIbLN+ZPesZbctkUsw372TBFyEByBjFGRTrVibsqtwUuFJRuifr
        fpal0n5A7OrBinIQ530pccYxBw7ufrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-P9hBt8v5OGyUYVPnu833Qw-1; Mon, 12 Oct 2020 08:54:17 -0400
X-MC-Unique: P9hBt8v5OGyUYVPnu833Qw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DCFB6415D;
        Mon, 12 Oct 2020 12:54:16 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E13160C07;
        Mon, 12 Oct 2020 12:54:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 04/29] virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
Date:   Mon, 12 Oct 2020 14:52:58 +0200
Message-Id: <20201012125323.17509-5-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can drop rc2, we don't actually need the value.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 78c2fbcddcf8..b3eebac7191f 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1072,7 +1072,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
 				      uint64_t *nb_sb)
 {
 	const int count = min_t(int, *nb_sb, vm->nb_sb_per_mb);
-	int rc, rc2;
+	int rc;
 
 	if (WARN_ON_ONCE(!count))
 		return -EINVAL;
@@ -1103,13 +1103,12 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
 
 		dev_err(&vm->vdev->dev,
 			"adding memory block %lu failed with %d\n", mb_id, rc);
-		rc2 = virtio_mem_mb_unplug_sb(vm, mb_id, 0, count);
 
 		/*
 		 * TODO: Linux MM does not properly clean up yet in all cases
 		 * where adding of memory failed - especially on -ENOMEM.
 		 */
-		if (rc2)
+		if (virtio_mem_mb_unplug_sb(vm, mb_id, 0, count))
 			new_state = VIRTIO_MEM_MB_STATE_PLUGGED;
 		virtio_mem_mb_set_state(vm, mb_id, new_state);
 		return rc;
-- 
2.26.2

