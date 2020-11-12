Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2352B06A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgKLNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbgKLNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0WfQnw15Vm9t+Uqndhh69vgkO1/7kUW5WBgUBhjrGY=;
        b=A1pnE5UnPbLnMIPzC0eldpXkfh9I605Kg0+WErRnqQvOlZHhoRHwckccs7lTQ/oItXRJIJ
        eD/v7kUC8eYKuj82fJeZvzVOFUFDEMoTI/4bLXksCnpsQmHWTi/hQhXrlC4hrlXzx4FyZj
        6iuWoEQCLAHZE75A6ZP8jBlFMFBhUgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-k-FLLVhEMsmObHVn5xkdtw-1; Thu, 12 Nov 2020 08:38:46 -0500
X-MC-Unique: k-FLLVhEMsmObHVn5xkdtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 215E01030986;
        Thu, 12 Nov 2020 13:38:45 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2EB955765;
        Thu, 12 Nov 2020 13:38:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 06/29] virtio-mem: factor out calculation of the bit number within the subblock bitmap
Date:   Thu, 12 Nov 2020 14:37:52 +0100
Message-Id: <20201112133815.13332-7-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation is already complicated enough, let's limit it to one
location.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 94451b401fba..30b4d07f5263 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -290,6 +290,16 @@ static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
 	     _mb_id--) \
 		if (virtio_mem_mb_get_state(_vm, _mb_id) == _state)
 
+/*
+ * Calculate the bit number in the subblock bitmap for the given subblock
+ * inside the given memory block.
+ */
+static int virtio_mem_sb_bitmap_bit_nr(struct virtio_mem *vm,
+				       unsigned long mb_id, int sb_id)
+{
+	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+}
+
 /*
  * Mark all selected subblocks plugged.
  *
@@ -299,7 +309,7 @@ static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
 					 unsigned long mb_id, int sb_id,
 					 int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_set(vm->sb_bitmap, bit, count);
 }
@@ -313,7 +323,7 @@ static void virtio_mem_mb_set_sb_unplugged(struct virtio_mem *vm,
 					   unsigned long mb_id, int sb_id,
 					   int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_clear(vm->sb_bitmap, bit, count);
 }
@@ -325,7 +335,7 @@ static bool virtio_mem_mb_test_sb_plugged(struct virtio_mem *vm,
 					  unsigned long mb_id, int sb_id,
 					  int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	if (count == 1)
 		return test_bit(bit, vm->sb_bitmap);
@@ -342,7 +352,7 @@ static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
 					    unsigned long mb_id, int sb_id,
 					    int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	/* TODO: Helper similar to bitmap_set() */
 	return find_next_bit(vm->sb_bitmap, bit + count, bit) >= bit + count;
@@ -355,7 +365,7 @@ static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
 static int virtio_mem_mb_first_unplugged_sb(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, 0);
 
 	return find_next_zero_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) -
 	       bit;
-- 
2.26.2

