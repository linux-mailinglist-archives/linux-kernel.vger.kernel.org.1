Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA39E1B433A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDVL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726988AbgDVL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A50C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1O++Jmz4O/aJ9je06qlQH2dQKA6f/U+DxpFpDR7/BDU=; b=3IZLmhcdUBEl0uXxPoHTw5Z9P9
        BzHoR6Wq1KQRT3qPf5uZZ7OiuqhNj385kEKr0BFveyvZVhC2ae0spFb8uIBP8t3q6pbb/nQVaotUx
        ezcWnc5Nh9QmdyGOA9+hf5DKuymDF414utZXdDhbPWLaCIoapVzwfC1Yhnfc1JaJeC5QC8VHf2BbR
        r7LZvM+NydlbmTn0mK2BUg0XbpHwpPlT2FfUNK8PuPgteaiIKasaj3sL+6dEHf5rzPoFxxN0oRR9o
        lMBTn0Q0Cckwys9RUQHxZw1+CofeuuAkpD56PlQWV+NKoyd0s2xTuI9NXxYitdU6IEHPJ1yheuaQC
        cUrVpQrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rC-CN; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B054307987;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2430F22B99F02; Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Message-Id: <20200422112832.530383182@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org
Subject: [PATCH 22/23] sched: Remove sched_setscheduler*() EXPORTs
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that nothing (modular) still uses sched_setscheduler(), remove the
exports.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5066,13 +5066,11 @@ int sched_setscheduler(struct task_struc
 {
 	return _sched_setscheduler(p, policy, param, true);
 }
-EXPORT_SYMBOL_GPL(sched_setscheduler);
 
 int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, true, true);
 }
-EXPORT_SYMBOL_GPL(sched_setattr);
 
 int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
@@ -5097,7 +5095,6 @@ int sched_setscheduler_nocheck(struct ta
 {
 	return _sched_setscheduler(p, policy, param, false);
 }
-EXPORT_SYMBOL_GPL(sched_setscheduler_nocheck);
 
 /*
  * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally


