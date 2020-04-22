Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3481B4347
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDVL3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726978AbgDVL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635CEC03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qcNaO6TeoUuyIuTCApoGJf3icCr5QqGmR4DD4Cw2KJ0=; b=Lh3mERFPhFwQDoq0FzmDRrIyJz
        MwP+snGy3tOyi+oj0jC5FLhqkbRM+pNkeBT/pxwSapItgwypsiKYgXyDeIoN+R3+9K/ULW2/OwrFd
        BETgxJ0gfm9vp/I8MH/FJx5gDF8vX020P2mIf5mVi3jQ+v23PzCDVtwfC1QLH3DD00uv9DxqG7YoJ
        mp0C+oWnBV67y/dmqj+G5ffnH9+gJSoRlSk1N8dEF+9+JwvuTCYWqUBZ1O5a1MeEjomtB+PkPDCG2
        /CcVJpBAGjBRbrzLWlzhYSCnKs27irda3TUR1yU4H5sbi2VEQzyszKFzcmMTa1rmoK6l44vYwYYTI
        570XD0rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006r9-8c; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 506F0307971;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E4D8A22B9589B; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.988065598@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, john.stultz@linaro.org
Subject: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to take away sched_setscheduler() from modules, change
this into sched_set_normal(.nice = 19).

Cc: john.stultz@linaro.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/staging/android/ion/ion_heap.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *
 
 int ion_heap_init_deferred_free(struct ion_heap *heap)
 {
-	struct sched_param param = { .sched_priority = 0 };
-
 	INIT_LIST_HEAD(&heap->free_list);
 	init_waitqueue_head(&heap->waitqueue);
 	heap->task = kthread_run(ion_heap_deferred_free, heap,
@@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct i
 		       __func__);
 		return PTR_ERR_OR_ZERO(heap->task);
 	}
-	sched_setscheduler(heap->task, SCHED_IDLE, &param);
+	sched_set_normal(heap->task, 19);
 
 	return 0;
 }


