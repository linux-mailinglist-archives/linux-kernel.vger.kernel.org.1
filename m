Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98501ECEB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgFCLmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 07:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=T+DOFpWbn6w2E0hTbTLLAKKN4dYF4a47Ffrg1miQE+s=; b=WlkGKt1MX6Ir6JuHJV5OpZweyS
        MjraldTCdcyiEopcdiGXvxRoglByC4CqhMbJnj1HkRYU4NPzGzErWACKZcLI3a5M3nOo6PENzpfcK
        QwMmaGxL92K/4TvairrSNyzJ9Ez7rcVH25DZkkP9ZY15KmGd/HawPoXZhmVzB8iqrjfqRHOyILY9J
        M7awHbG2TIpF/rFNePIr20Y9ZdaJ3l9+XTnWg+LZgVGrd6LLfqa2YzJ1QQL8XDr+y5cFQbTBnGat5
        NDS4+evAHMc1h7JStbaqELxqpDbgWnkfstWHeL48qp1rlF99laCQrZvI1ChwvNn145BAFywX60Oy6
        KQpm1bWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRmr-0005oU-FK; Wed, 03 Jun 2020 11:42:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B673230008D;
        Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A62B0209C23E0; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114051.838509047@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, Qian Cai <cai@lca.pw>
Subject: [PATCH 1/9] x86/entry: Fix irq_exit()
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because if you rename a function, you should also rename the users.

Fixes: b614345f52bc ("x86/entry: Clarify irq_{enter,exit}_rcu()")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lkml.kernel.org/r/20200602150511.GH706478@hirez.programming.kicks-ass.net
---
 kernel/softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -438,7 +438,7 @@ void irq_exit_rcu(void)
  */
 void irq_exit(void)
 {
-	irq_exit_rcu();
+	__irq_exit_rcu();
 	rcu_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();


