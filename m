Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3729003F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405222AbgJPIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:54:51 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36784 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405019AbgJPIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:54:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBgXd3_1602838487;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBgXd3_1602838487)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:54:47 +0800
Date:   Fri, 16 Oct 2020 16:54:47 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 22/29] virtio-mem: memory block ids are specific to
 Sub Block Mode (SBM)
Message-ID: <20201016085447.GE44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-23-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-23-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:16PM +0200, David Hildenbrand wrote:
>Let's move first_mb_id/next_mb_id/last_usable_mb_id accordingly.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 44 ++++++++++++++++++-------------------
> 1 file changed, 22 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index d06c8760b337..d3ab04f655ee 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -96,13 +96,6 @@ struct virtio_mem {
> 	/* Maximum region size in bytes. */
> 	uint64_t region_size;
> 
>-	/* Id of the first memory block of this device. */
>-	unsigned long first_mb_id;
>-	/* Id of the last usable memory block of this device. */
>-	unsigned long last_usable_mb_id;
>-	/* Id of the next memory bock to prepare when needed. */
>-	unsigned long next_mb_id;
>-
> 	/* The parent resource for all memory added via this device. */
> 	struct resource *parent_resource;
> 	/*
>@@ -121,6 +114,13 @@ struct virtio_mem {
> 	uint64_t offline_threshold;
> 
> 	struct {
>+		/* Id of the first memory block of this device. */
>+		unsigned long first_mb_id;
>+		/* Id of the last usable memory block of this device. */
>+		unsigned long last_usable_mb_id;
>+		/* Id of the next memory bock to prepare when needed. */
>+		unsigned long next_mb_id;
>+
> 		/* The subblock size. */
> 		uint64_t sb_size;
> 		/* The number of subblocks per Linux memory block. */
>@@ -265,7 +265,7 @@ static unsigned long virtio_mem_phys_to_sb_id(struct virtio_mem *vm,
> static void virtio_mem_sbm_set_mb_state(struct virtio_mem *vm,
> 					unsigned long mb_id, uint8_t state)
> {
>-	const unsigned long idx = mb_id - vm->first_mb_id;
>+	const unsigned long idx = mb_id - vm->sbm.first_mb_id;
> 	uint8_t old_state;
> 
> 	old_state = vm->sbm.mb_states[idx];
>@@ -282,7 +282,7 @@ static void virtio_mem_sbm_set_mb_state(struct virtio_mem *vm,
> static uint8_t virtio_mem_sbm_get_mb_state(struct virtio_mem *vm,
> 					   unsigned long mb_id)
> {
>-	const unsigned long idx = mb_id - vm->first_mb_id;
>+	const unsigned long idx = mb_id - vm->sbm.first_mb_id;
> 
> 	return vm->sbm.mb_states[idx];
> }
>@@ -292,7 +292,7 @@ static uint8_t virtio_mem_sbm_get_mb_state(struct virtio_mem *vm,
>  */
> static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
> {
>-	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
>+	unsigned long old_bytes = vm->sbm.next_mb_id - vm->sbm.first_mb_id;
> 	unsigned long new_bytes = old_bytes + 1;
> 	int old_pages = PFN_UP(old_bytes);
> 	int new_pages = PFN_UP(new_bytes);
>@@ -316,14 +316,14 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
> }
> 
> #define virtio_mem_sbm_for_each_mb(_vm, _mb_id, _state) \
>-	for (_mb_id = _vm->first_mb_id; \
>-	     _mb_id < _vm->next_mb_id && _vm->sbm.mb_count[_state]; \
>+	for (_mb_id = _vm->sbm.first_mb_id; \
>+	     _mb_id < _vm->sbm.next_mb_id && _vm->sbm.mb_count[_state]; \
> 	     _mb_id++) \
> 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
> 
> #define virtio_mem_sbm_for_each_mb_rev(_vm, _mb_id, _state) \
>-	for (_mb_id = _vm->next_mb_id - 1; \
>-	     _mb_id >= _vm->first_mb_id && _vm->sbm.mb_count[_state]; \
>+	for (_mb_id = _vm->sbm.next_mb_id - 1; \
>+	     _mb_id >= _vm->sbm.first_mb_id && _vm->sbm.mb_count[_state]; \
> 	     _mb_id--) \
> 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
> 
>@@ -334,7 +334,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
> static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
> 					  unsigned long mb_id, int sb_id)
> {
>-	return (mb_id - vm->first_mb_id) * vm->sbm.sbs_per_mb + sb_id;
>+	return (mb_id - vm->sbm.first_mb_id) * vm->sbm.sbs_per_mb + sb_id;
> }
> 
> /*
>@@ -414,7 +414,7 @@ static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
>  */
> static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
> {
>-	const unsigned long old_nb_mb = vm->next_mb_id - vm->first_mb_id;
>+	const unsigned long old_nb_mb = vm->sbm.next_mb_id - vm->sbm.first_mb_id;
> 	const unsigned long old_nb_bits = old_nb_mb * vm->sbm.sbs_per_mb;
> 	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->sbm.sbs_per_mb;
> 	int old_pages = PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
>@@ -1177,7 +1177,7 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
> {
> 	int rc;
> 
>-	if (vm->next_mb_id > vm->last_usable_mb_id)
>+	if (vm->sbm.next_mb_id > vm->sbm.last_usable_mb_id)
> 		return -ENOSPC;
> 
> 	/* Resize the state array if required. */
>@@ -1191,7 +1191,7 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
> 		return rc;
> 
> 	vm->sbm.mb_count[VIRTIO_MEM_SBM_MB_UNUSED]++;
>-	*mb_id = vm->next_mb_id++;
>+	*mb_id = vm->sbm.next_mb_id++;
> 	return 0;
> }
> 
>@@ -1622,7 +1622,7 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
> 			usable_region_size, &usable_region_size);
> 	end_addr = vm->addr + usable_region_size;
> 	end_addr = min(end_addr, phys_limit);
>-	vm->last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr) - 1;
>+	vm->sbm.last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr) - 1;
> 
> 	/* see if there is a request to change the size */
> 	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
>@@ -1813,9 +1813,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
> 	vm->sbm.sbs_per_mb = memory_block_size_bytes() / vm->sbm.sb_size;
> 
> 	/* Round up to the next full memory block */
>-	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
>-						   memory_block_size_bytes());
>-	vm->next_mb_id = vm->first_mb_id;
>+	vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
>+						       memory_block_size_bytes());
>+	vm->sbm.next_mb_id = vm->sbm.first_mb_id;
> 
> 	/* Prepare the offline threshold - make sure we can add two blocks. */
> 	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
