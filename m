Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B172226A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbgGTQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbgGTP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D85C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:56:30 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0jTHQoxks+qBbNy0dT5aGqcUc2Cr1SJenmjgFYt3N0=;
        b=0V3xPZ56wRb+H5VAtw5/esSrIemWiTtPVerHzmVIRkbqNZekvK39uzuKMK83c4f+cuKGym
        Buhxl2KFhnVrbgoG9zh/lpE8dRAScv2FGBq4e1HDPyowYLZ4KG+/JJq7Al2IdengKkKtfJ
        ifK0DkB1e7kztu8OPKu91/qqOgnPh3ugvfde8UzT6bc+ULLp+DhSDXNOcDfRo4ZV0/QbtR
        NFaVLXoafOBFrDsNVlSQtjTM/MIkUPhFIhsZOlPQyxpE7D3+JiwM1C0RgbITCXOo9xfqOU
        7Py9RCOyskuCchl1oQwF3SydvCqVKSUMOIQU03AZla+mIMGbGpZqH387MfD8BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0jTHQoxks+qBbNy0dT5aGqcUc2Cr1SJenmjgFYt3N0=;
        b=ayC+KzQjmD0ubcD81RJySYrEE79d3RhlKoUEEt5NmmIvAde1zjFsoKlntqjey7faOWL5Mc
        43/TMAfJZJIIL/AA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4 12/24] dma-buf: Use sequence counter with associated wound/wait mutex
Date:   Mon, 20 Jul 2020 17:55:18 +0200
Message-Id: <20200720155530.1173732-13-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. If the serialization primitive is
not disabling preemption implicitly, preemption has to be explicitly
disabled before entering the sequence counter write side critical
section.

The dma-buf reservation subsystem uses plain sequence counters to manage
updates to reservations. Writer serialization is accomplished through a
wound/wait mutex.

Acquiring a wound/wait mutex does not disable preemption, so this needs
to be done manually before and after the write side critical section.

Use the newly-added seqcount_ww_mutex_t instead:

  - It associates the ww_mutex with the sequence count, which enables
    lockdep to validate that the write side critical section is properly
    serialized.

  - It removes the need to explicitly add preempt_disable/enable()
    around the write side critical section because the write_begin/end()
    functions for this new data type automatically do this.

If lockdep is disabled this ww_mutex lock association is compiled out
and has neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/dma-buf/dma-resv.c                       | 8 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 --
 include/linux/dma-resv.h                         | 2 +-
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 15efa0c2dacb..a7631352a486 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -129,7 +129,7 @@ subsys_initcall(dma_resv_lockdep);
 void dma_resv_init(struct dma_resv *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
-	seqcount_init(&obj->seq);
+	seqcount_ww_mutex_init(&obj->seq, &obj->lock);
 
 	RCU_INIT_POINTER(obj->fence, NULL);
 	RCU_INIT_POINTER(obj->fence_excl, NULL);
@@ -260,7 +260,6 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 	fobj = dma_resv_get_list(obj);
 	count = fobj->shared_count;
 
-	preempt_disable();
 	write_seqcount_begin(&obj->seq);
 
 	for (i = 0; i < count; ++i) {
@@ -282,7 +281,6 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 	smp_store_mb(fobj->shared_count, count);
 
 	write_seqcount_end(&obj->seq);
-	preempt_enable();
 	dma_fence_put(old);
 }
 EXPORT_SYMBOL(dma_resv_add_shared_fence);
@@ -309,14 +307,12 @@ void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence)
 	if (fence)
 		dma_fence_get(fence);
 
-	preempt_disable();
 	write_seqcount_begin(&obj->seq);
 	/* write_seqcount_begin provides the necessary memory barrier */
 	RCU_INIT_POINTER(obj->fence_excl, fence);
 	if (old)
 		old->shared_count = 0;
 	write_seqcount_end(&obj->seq);
-	preempt_enable();
 
 	/* inplace update, no shared fences */
 	while (i--)
@@ -394,13 +390,11 @@ int dma_resv_copy_fences(struct dma_resv *dst, struct dma_resv *src)
 	src_list = dma_resv_get_list(dst);
 	old = dma_resv_get_excl(dst);
 
-	preempt_disable();
 	write_seqcount_begin(&dst->seq);
 	/* write_seqcount_begin provides the necessary memory barrier */
 	RCU_INIT_POINTER(dst->fence_excl, new);
 	RCU_INIT_POINTER(dst->fence, dst_list);
 	write_seqcount_end(&dst->seq);
-	preempt_enable();
 
 	dma_resv_list_free(src_list);
 	dma_fence_put(old);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b91b5171270f..ff4b583cb96a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -258,11 +258,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	new->shared_count = k;
 
 	/* Install the new fence list, seqcount provides the barriers */
-	preempt_disable();
 	write_seqcount_begin(&resv->seq);
 	RCU_INIT_POINTER(resv->fence, new);
 	write_seqcount_end(&resv->seq);
-	preempt_enable();
 
 	/* Drop the references to the removed fences or move them to ef_list */
 	for (i = j, k = 0; i < old->shared_count; ++i) {
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index a6538ae7d93f..d44a77e8a7e3 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -69,7 +69,7 @@ struct dma_resv_list {
  */
 struct dma_resv {
 	struct ww_mutex lock;
-	seqcount_t seq;
+	seqcount_ww_mutex_t seq;
 
 	struct dma_fence __rcu *fence_excl;
 	struct dma_resv_list __rcu *fence;
-- 
2.20.1

