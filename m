Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4328B533
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgJLM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgJLM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7P2vBNnGvTj7ryjZqgBDKBivuPaDY4fI99105fL53IE=;
        b=iha3NUocjIstH/s/P2w9AXO3G+rmtnxSPyZuCNro1hV4+49+Op6lUBCVYuti4OCl7cVJTK
        iHAJjqFUfIgUp4x7dtdhfmU7yQNJrMv9KDwvDrZ5gBtVqpaDKUj+IMRO+GEy2sB5wMpJTm
        IettSAzmnUJY8/+eRRqQzNmLyF8yV2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-5FQdEEU9MSCnx-uOaL-vSw-1; Mon, 12 Oct 2020 08:55:58 -0400
X-MC-Unique: 5FQdEEU9MSCnx-uOaL-vSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 692ED801FD4;
        Mon, 12 Oct 2020 12:55:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1B1460C07;
        Mon, 12 Oct 2020 12:55:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 18/29] virtio-mem: factor out calculation of the bit number within the sb_states bitmap
Date:   Mon, 12 Oct 2020 14:53:12 +0200
Message-Id: <20201012125323.17509-19-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation is already complicated enough, let's limit it to one
location.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 2cc497ad8298..73ff6e9ba839 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -327,6 +327,16 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 	     _mb_id--) \
 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
 
+/*
+ * Calculate the bit number in the sb_states bitmap for the given subblock
+ * inside the given memory block.
+ */
+static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
+					  unsigned long mb_id, int sb_id)
+{
+	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+}
+
 /*
  * Mark all selected subblocks plugged.
  *
@@ -336,7 +346,7 @@ static void virtio_mem_sbm_set_sb_plugged(struct virtio_mem *vm,
 					  unsigned long mb_id, int sb_id,
 					  int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_set(vm->sbm.sb_states, bit, count);
 }
@@ -350,7 +360,7 @@ static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
 					    unsigned long mb_id, int sb_id,
 					    int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_clear(vm->sbm.sb_states, bit, count);
 }
@@ -362,7 +372,7 @@ static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
 					   unsigned long mb_id, int sb_id,
 					   int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	if (count == 1)
 		return test_bit(bit, vm->sbm.sb_states);
@@ -379,7 +389,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 					     unsigned long mb_id, int sb_id,
 					     int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	/* TODO: Helper similar to bitmap_set() */
 	return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
@@ -393,7 +403,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
 
 	return find_next_zero_bit(vm->sbm.sb_states,
 				  bit + vm->nb_sb_per_mb, bit) - bit;
-- 
2.26.2

