Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5B290020
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394776AbgJPIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:46:28 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41762 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394758AbgJPIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:46:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBIdn9_1602837979;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBIdn9_1602837979)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:46:19 +0800
Date:   Fri, 16 Oct 2020 16:46:19 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 18/29] virtio-mem: factor out calculation of the bit
 number within the sb_states bitmap
Message-ID: <20201016084619.GA44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-19-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-19-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:12PM +0200, David Hildenbrand wrote:
>The calculation is already complicated enough, let's limit it to one
>location.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 2cc497ad8298..73ff6e9ba839 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -327,6 +327,16 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
> 	     _mb_id--) \
> 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
> 
>+/*
>+ * Calculate the bit number in the sb_states bitmap for the given subblock
>+ * inside the given memory block.
>+ */
>+static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
>+					  unsigned long mb_id, int sb_id)
>+{
>+	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>+}
>+
> /*
>  * Mark all selected subblocks plugged.
>  *
>@@ -336,7 +346,7 @@ static void virtio_mem_sbm_set_sb_plugged(struct virtio_mem *vm,
> 					  unsigned long mb_id, int sb_id,
> 					  int count)
> {
>-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
> 
> 	__bitmap_set(vm->sbm.sb_states, bit, count);
> }
>@@ -350,7 +360,7 @@ static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
> 					    unsigned long mb_id, int sb_id,
> 					    int count)
> {
>-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
> 
> 	__bitmap_clear(vm->sbm.sb_states, bit, count);
> }
>@@ -362,7 +372,7 @@ static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
> 					   unsigned long mb_id, int sb_id,
> 					   int count)
> {
>-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
> 
> 	if (count == 1)
> 		return test_bit(bit, vm->sbm.sb_states);
>@@ -379,7 +389,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
> 					     unsigned long mb_id, int sb_id,
> 					     int count)
> {
>-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
> 
> 	/* TODO: Helper similar to bitmap_set() */
> 	return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
>@@ -393,7 +403,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
> static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
> 					    unsigned long mb_id)
> {
>-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
>+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
> 
> 	return find_next_zero_bit(vm->sbm.sb_states,
> 				  bit + vm->nb_sb_per_mb, bit) - bit;
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
