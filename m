Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F82BC632
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgKVOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 09:47:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgKVOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:47:47 -0500
Date:   Sun, 22 Nov 2020 14:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606056465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mQRb8uEb5nmGdKJj+HSBTxgXUOyta3UX5B4Ep5zt300=;
        b=U6htBCJH+MU956yn1xtzKOkiWKTPCPaFxBmSzXDKD9+hAtxu4cJkZ3QyEYU/cgjIlwNplt
        lCM+zKXPAhK+wenilLrtPuzCXiIKoQJiYElt2ywQFgX6Jzsrst6OFDKhvIc2r3m4c4EuYQ
        LEN/FU8SLTTwdFgU4dyBkjGM6cJ5NDcpRkSmFsncbu5i0MLbVErsNk8CbmfZ21XXseqdeN
        sBI1ekXAhrcojRY+9X6ikIK86ifG8zQMdF6mHuhJfQXaR0/txAassgtrQlpv1/0G4403DY
        miZCxhHOIRkzhqr72I3t8qmfimeahfGpp9lyOVPKd1fht6C1fXp9paCruKxKRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606056465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mQRb8uEb5nmGdKJj+HSBTxgXUOyta3UX5B4Ep5zt300=;
        b=lPUNy6GG9pyqFumIEO9STa5UBEhQUO89pU8T6Kbn2nPIDfZypEQik1Qdg8L7yZp8uHOnwb
        vbqoS1/ORCqE0uDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.10-rc5
Message-ID: <160605644301.9003.16302947389602369819.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-22

up to:  43be4388e94b: lockdep: Put graph lock/unlock under lock_recursion protection


A single fix for lockdep which makes the recursion protection cover graph
lock/unlock.


Thanks,

	tglx

------------------>
Boqun Feng (1):
      lockdep: Put graph lock/unlock under lock_recursion protection


 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d9fb9e19d2ed..c1418b47f625 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -108,19 +108,21 @@ static inline void lockdep_lock(void)
 {
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
+	__this_cpu_inc(lockdep_recursion);
 	arch_spin_lock(&__lock);
 	__owner = current;
-	__this_cpu_inc(lockdep_recursion);
 }
 
 static inline void lockdep_unlock(void)
 {
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
 	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
 		return;
 
-	__this_cpu_dec(lockdep_recursion);
 	__owner = NULL;
 	arch_spin_unlock(&__lock);
+	__this_cpu_dec(lockdep_recursion);
 }
 
 static inline bool lockdep_assert_locked(void)

