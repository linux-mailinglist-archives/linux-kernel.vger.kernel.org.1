Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651E329002A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404816AbgJPIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:50:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47681 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404253AbgJPIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:50:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBSTQi_1602838193;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBSTQi_1602838193)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:49:53 +0800
Date:   Fri, 16 Oct 2020 16:49:53 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 19/29] virito-mem: existing (un)plug functions are
 specific to Sub Block Mode (SBM)
Message-ID: <20201016084953.GB44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-20-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-20-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:13PM +0200, David Hildenbrand wrote:
>Let's rename them accordingly. virtio_mem_plug_request() and
>virtio_mem_unplug_request() will be handled separately.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

The code is correct, while the naming is a bit long to understand...

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 90 ++++++++++++++++++-------------------
> 1 file changed, 43 insertions(+), 47 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 73ff6e9ba839..fc2b1ff3beed 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -1075,8 +1075,8 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
>  * Plug selected subblocks. Updates the plugged state, but not the state
>  * of the memory block.
>  */
>-static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
>-				 int sb_id, int count)
>+static int virtio_mem_sbm_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
>+				  int sb_id, int count)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
> 			      sb_id * vm->subblock_size;
>@@ -1096,8 +1096,8 @@ static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
>  * Unplug selected subblocks. Updates the plugged state, but not the state
>  * of the memory block.
>  */
>-static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
>-				   int sb_id, int count)
>+static int virtio_mem_sbm_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
>+				    int sb_id, int count)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
> 			      sb_id * vm->subblock_size;
>@@ -1122,8 +1122,8 @@ static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
>  *
>  * Note: can fail after some subblocks were unplugged.
>  */
>-static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
>-				       unsigned long mb_id, uint64_t *nb_sb)
>+static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
>+					unsigned long mb_id, uint64_t *nb_sb)
> {
> 	int sb_id, count;
> 	int rc;
>@@ -1144,7 +1144,7 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
> 			sb_id--;
> 		}
> 
>-		rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
>+		rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
> 		if (rc)
> 			return rc;
> 		*nb_sb -= count;
>@@ -1161,18 +1161,18 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
>  *
>  * Note: can fail after some subblocks were unplugged.
>  */
>-static int virtio_mem_mb_unplug(struct virtio_mem *vm, unsigned long mb_id)
>+static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
> {
> 	uint64_t nb_sb = vm->nb_sb_per_mb;
> 
>-	return virtio_mem_mb_unplug_any_sb(vm, mb_id, &nb_sb);
>+	return virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
> }
> 
> /*
>  * Prepare tracking data for the next memory block.
>  */
>-static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
>-				      unsigned long *mb_id)
>+static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
>+					  unsigned long *mb_id)
> {
> 	int rc;
> 
>@@ -1200,9 +1200,8 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
>  *
>  * Will modify the state of the memory block.
>  */
>-static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
>-				      unsigned long mb_id,
>-				      uint64_t *nb_sb)
>+static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
>+					  unsigned long mb_id, uint64_t *nb_sb)
> {
> 	const int count = min_t(int, *nb_sb, vm->nb_sb_per_mb);
> 	int rc;
>@@ -1214,7 +1213,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
> 	 * Plug the requested number of subblocks before adding it to linux,
> 	 * so that onlining will directly online all plugged subblocks.
> 	 */
>-	rc = virtio_mem_mb_plug_sb(vm, mb_id, 0, count);
>+	rc = virtio_mem_sbm_plug_sb(vm, mb_id, 0, count);
> 	if (rc)
> 		return rc;
> 
>@@ -1241,7 +1240,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
> 		 * TODO: Linux MM does not properly clean up yet in all cases
> 		 * where adding of memory failed - especially on -ENOMEM.
> 		 */
>-		if (virtio_mem_mb_unplug_sb(vm, mb_id, 0, count))
>+		if (virtio_mem_sbm_unplug_sb(vm, mb_id, 0, count))
> 			new_state = VIRTIO_MEM_SBM_MB_PLUGGED;
> 		virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
> 		return rc;
>@@ -1259,8 +1258,9 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
>  *
>  * Note: Can fail after some subblocks were successfully plugged.
>  */
>-static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
>-				     uint64_t *nb_sb, bool online)
>+static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
>+				      unsigned long mb_id, uint64_t *nb_sb,
>+				      bool online)
> {
> 	unsigned long pfn, nr_pages;
> 	int sb_id, count;
>@@ -1279,7 +1279,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
> 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id + count, 1))
> 			count++;
> 
>-		rc = virtio_mem_mb_plug_sb(vm, mb_id, sb_id, count);
>+		rc = virtio_mem_sbm_plug_sb(vm, mb_id, sb_id, count);
> 		if (rc)
> 			return rc;
> 		*nb_sb -= count;
>@@ -1323,7 +1323,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 	/* Try to plug subblocks of partially plugged online blocks. */
> 	virtio_mem_sbm_for_each_mb(vm, mb_id,
> 				   VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
>-		rc = virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, true);
>+		rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb, true);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
> 		cond_resched();
>@@ -1332,7 +1332,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 	/* Try to plug subblocks of partially plugged offline blocks. */
> 	virtio_mem_sbm_for_each_mb(vm, mb_id,
> 				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
>-		rc = virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, false);
>+		rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb, false);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
> 		cond_resched();
>@@ -1349,7 +1349,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
> 			return -ENOSPC;
> 
>-		rc = virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
>+		rc = virtio_mem_sbm_plug_and_add_mb(vm, mb_id, &nb_sb);
> 		if (rc || !nb_sb)
> 			return rc;
> 		cond_resched();
>@@ -1360,10 +1360,10 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
> 			return -ENOSPC;
> 
>-		rc = virtio_mem_prepare_next_mb(vm, &mb_id);
>+		rc = virtio_mem_sbm_prepare_next_mb(vm, &mb_id);
> 		if (rc)
> 			return rc;
>-		rc = virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
>+		rc = virtio_mem_sbm_plug_and_add_mb(vm, mb_id, &nb_sb);
> 		if (rc)
> 			return rc;
> 		cond_resched();
>@@ -1384,13 +1384,13 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
>  *
>  * Note: Can fail after some subblocks were successfully unplugged.
>  */
>-static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
>-					       unsigned long mb_id,
>-					       uint64_t *nb_sb)
>+static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
>+						unsigned long mb_id,
>+						uint64_t *nb_sb)
> {
> 	int rc;
> 
>-	rc = virtio_mem_mb_unplug_any_sb(vm, mb_id, nb_sb);
>+	rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, nb_sb);
> 
> 	/* some subblocks might have been unplugged even on failure */
> 	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
>@@ -1422,9 +1422,9 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
>  *
>  * Will modify the state of the memory block.
>  */
>-static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
>-					  unsigned long mb_id, int sb_id,
>-					  int count)
>+static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
>+					   unsigned long mb_id, int sb_id,
>+					   int count)
> {
> 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size) * count;
> 	unsigned long start_pfn;
>@@ -1438,7 +1438,7 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
> 		return rc;
> 
> 	/* Try to unplug the allocated memory */
>-	rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
>+	rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
> 	if (rc) {
> 		/* Return the memory to the buddy. */
> 		virtio_mem_fake_online(start_pfn, nr_pages);
>@@ -1460,17 +1460,17 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
>  * Note: Can fail after some subblocks were successfully unplugged. Can
>  *       return 0 even if subblocks were busy and could not get unplugged.
>  */
>-static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
>-					      unsigned long mb_id,
>-					      uint64_t *nb_sb)
>+static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
>+					       unsigned long mb_id,
>+					       uint64_t *nb_sb)
> {
> 	int rc, sb_id;
> 
> 	/* If possible, try to unplug the complete block in one shot. */
> 	if (*nb_sb >= vm->nb_sb_per_mb &&
> 	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>-		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, 0,
>-						    vm->nb_sb_per_mb);
>+		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, 0,
>+						     vm->nb_sb_per_mb);
> 		if (!rc) {
> 			*nb_sb -= vm->nb_sb_per_mb;
> 			goto unplugged;
>@@ -1487,7 +1487,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
> 		if (sb_id < 0)
> 			break;
> 
>-		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, sb_id, 1);
>+		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, sb_id, 1);
> 		if (rc == -EBUSY)
> 			continue;
> 		else if (rc)
>@@ -1535,8 +1535,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	/* Try to unplug subblocks of partially plugged offline blocks. */
> 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
> 				       VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
>-		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
>-							 &nb_sb);
>+		rc = virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, &nb_sb);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
> 		cond_resched();
>@@ -1544,8 +1543,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 
> 	/* Try to unplug subblocks of plugged offline blocks. */
> 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_OFFLINE) {
>-		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
>-							 &nb_sb);
>+		rc = virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, &nb_sb);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
> 		cond_resched();
>@@ -1559,8 +1557,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	/* Try to unplug subblocks of partially plugged online blocks. */
> 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
> 				       VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
>-		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
>-							&nb_sb);
>+		rc = virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, &nb_sb);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
> 		mutex_unlock(&vm->hotplug_mutex);
>@@ -1570,8 +1567,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 
> 	/* Try to unplug subblocks of plugged online blocks. */
> 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_ONLINE) {
>-		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
>-							&nb_sb);
>+		rc = virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, &nb_sb);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
> 		mutex_unlock(&vm->hotplug_mutex);
>@@ -1596,7 +1592,7 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
> 	int rc;
> 
> 	virtio_mem_sbm_for_each_mb(vm, mb_id, VIRTIO_MEM_SBM_MB_PLUGGED) {
>-		rc = virtio_mem_mb_unplug(vm, mb_id);
>+		rc = virtio_mem_sbm_unplug_mb(vm, mb_id);
> 		if (rc)
> 			return rc;
> 		virtio_mem_sbm_set_mb_state(vm, mb_id,
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
