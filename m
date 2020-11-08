Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B882AABE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgKHPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:24:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgKHPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:24:56 -0500
Date:   Sun, 08 Nov 2020 15:23:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604849094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Z6eZe+w54zkzRzP8y1K3y0Sq4EGYJtRS2V8GPfT5YxU=;
        b=E+RRT2SNiqfoQvuehIFISz7FHzwhrzQLw9rN9MbGl1Oyf0F5UEl0HyWkQ+zh2h4xZDwXcn
        wj1lG9GtzdYC4HH7qG7VXYarlYR65EAezY8C3H1JP6bwwmptOmOGz/ntJPudw50XazLEOM
        JQV+B14XEypGYmu9O6uKeKT6evALn1Y42oIWrHyJPfzFVptxIxPPgCEUteBTjiQikGl/IM
        IbzTimOgouLY7haZ23xBMzeV0MobziixA0SdwDB/PBYu+k0HEcynXby3Em+6FMUChWdx4u
        Zq+E28ZU8xqWRsRwx4bD617MZzysNTZVthWp2kWQI1AM/VuMpkA9L5QuV/5rWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604849094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Z6eZe+w54zkzRzP8y1K3y0Sq4EGYJtRS2V8GPfT5YxU=;
        b=YNaTSNPGmQ+VikUSacu+klS8+LWjxc6I+4h9D7nnHucnq5ZWhaBtqPE2mnubpeSdbOyBMq
        0e7CXDxDMOzVScAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for 5.10-rc3
References: <160484899473.4262.9790266201913163807.tglx@nanos>
Message-ID: <160484899714.4262.9283526258177769567.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-08

up to:  9f5d1c336a10: futex: Handle transient "ownerless" rtmutex state correctly


A single fix for the futex code where an intermediate state in the
underlying RT mutex was not handled correctly and triggering a BUG()
instead of treating it as another variant of retry condition.

Thanks,

	tglx

------------------>
Mike Galbraith (1):
      futex: Handle transient "ownerless" rtmutex state correctly


 kernel/futex.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index f8614ef4ff31..ac328874f6e5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2380,10 +2380,22 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		}
 
 		/*
-		 * Since we just failed the trylock; there must be an owner.
+		 * The trylock just failed, so either there is an owner or
+		 * there is a higher priority waiter than this one.
 		 */
 		newowner = rt_mutex_owner(&pi_state->pi_mutex);
-		BUG_ON(!newowner);
+		/*
+		 * If the higher priority waiter has not yet taken over the
+		 * rtmutex then newowner is NULL. We can't return here with
+		 * that state because it's inconsistent vs. the user space
+		 * state. So drop the locks and try again. It's a valid
+		 * situation and not any different from the other retry
+		 * conditions.
+		 */
+		if (unlikely(!newowner)) {
+			err = -EAGAIN;
+			goto handle_err;
+		}
 	} else {
 		WARN_ON_ONCE(argowner != current);
 		if (oldowner == current) {

