Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981612AABDF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgKHPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:24:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgKHPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:24:53 -0500
Date:   Sun, 08 Nov 2020 15:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604849092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FUC9sAEC0HmOuQbl/4cnd8dcwUziOKWuk74EIgKBMjc=;
        b=ZAIf7EZLoCnIgzmnqaJBnvhLQUy3RUx7SMzrZFyccKsUm8J9SbtNWZNl8obpJuS4Z0nFu5
        3F5PS5SOg5cwAhamBS6xOYN8D1XOvwGe6dYjHi32NQLdQkp+vdSOzRmoWZJtARTK2BuJ56
        SYCwwFt8LFLcFUgfnkkPO0fROkBxLFPuerAMrmIX5Te9efxNRl7LVu58tdQW6CuCu94nFx
        dQDs+X1JW9YUMItLKkwqWYbt0X3B5ZCccCAV/zrKJtv91iX383gw+giF2aZvVFtZrLZNXk
        nxsfnmCgu68TTDTOUy6vo7KMXM8RuJoRLdwA2Lh+Bsi6z/HYG7ojEWuliMLb8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604849092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FUC9sAEC0HmOuQbl/4cnd8dcwUziOKWuk74EIgKBMjc=;
        b=4lm6ZJlDfjWe2JBvfNu22FGPXjXSZJn7AuIx134tQjEq1R0r+wWcacIYHQa5Z5qzRaEI4p
        iWg7X3Zf36nsk7Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for 5.10-rc3
Message-ID: <160484899473.4262.9790266201913163807.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-11-08

up to:  9d820f68b2bd: entry: Fix the incorrect ordering of lockdep and RCU check

A single fix for the generic entry code to correct the wrong assumption
that the lockdep interrupt state needs not to be established before calling
the RCU check.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      entry: Fix the incorrect ordering of lockdep and RCU check


 kernel/entry/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2b8366693d5c..e9e2df3f3f9e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -337,10 +337,10 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * already contains a warning when RCU is not watching, so no point
 	 * in having another one here.
 	 */
+	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
 	rcu_irq_enter_check_tick();
-	/* Use the combo lockdep/tracing function */
-	trace_hardirqs_off();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 
 	return ret;

