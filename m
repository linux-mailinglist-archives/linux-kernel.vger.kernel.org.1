Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E432A8232
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgKEP3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730854AbgKEP3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:29:52 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F26C20735;
        Thu,  5 Nov 2020 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604590191;
        bh=foAW702CtoshU7IWzq9HQprEHlBZdWORtipJNquMtSg=;
        h=From:To:Cc:Subject:Date:From;
        b=JmQYjF0wJyxik3FaSbBrfOi0nchfZ72/zrm698mZ2ACRgDx7F8YjPuIOTM6BKKROq
         HJSC3WY9WXF9Ted7N2lTSD9H25Bs3GbCBD+z5IZ8g59XWSNyjtQ2S0uZafhI7xYIM3
         8AJ9zslO5tojU1NEBQhFSAJ5soBSaeeEt4JncNfM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        andre.przywara@arm.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] random: avoid arch_get_random_seed_long() when collecting IRQ randomness
Date:   Thu,  5 Nov 2020 16:29:44 +0100
Message-Id: <20201105152944.16953-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reseeding the CRNG periodically, arch_get_random_seed_long() is
called to obtain entropy from an architecture specific source if one
is implemented. In most cases, these are special instructions, but in
some cases, such as on ARM, we may want to back this using firmware
calls, which are considerably more expensive.

Another call to arch_get_random_seed_long() exists in the CRNG driver,
in add_interrupt_randomness(), which collects entropy by capturing
inter-interrupt timing and relying on interrupt jitter to provide
random bits. This is done by keeping a per-CPU state, and mixing in
the IRQ number, the cycle counter and the return address every time an
interrupt is taken, and mixing this per-CPU state into the entropy pool
every 64 invocations, or at least once per second. The entropy that is
gathered this way is credited as 1 bit of entropy. Every time this
happens, arch_get_random_seed_long() is invoked, and the result is
mixed in as well, and also credited with 1 bit of entropy.

This means that arch_get_random_seed_long() is called at least once
per second on every CPU, which seems excessive, and doesn't really
scale, especially in a virtualization scenario where CPUs may be
oversubscribed: in cases where arch_get_random_seed_long() is backed
by an instruction that actually goes back to a shared hardware entropy
source (such as RNDRRS on ARM), we will end up hitting it hundreds of
times per second.

So let's drop the call to arch_get_random_seed_long() from
add_interrupt_randomness(), and instead, rely on crng_reseed() to call
the arch hook to get random seed material from the platform.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/random.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2a41b21623ae..a9c393c1466d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1261,8 +1261,6 @@ void add_interrupt_randomness(int irq, int irq_flags)
 	cycles_t		cycles = random_get_entropy();
 	__u32			c_high, j_high;
 	__u64			ip;
-	unsigned long		seed;
-	int			credit = 0;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
@@ -1298,23 +1296,12 @@ void add_interrupt_randomness(int irq, int irq_flags)
 
 	fast_pool->last = now;
 	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
-
-	/*
-	 * If we have architectural seed generator, produce a seed and
-	 * add it to the pool.  For the sake of paranoia don't let the
-	 * architectural seed generator dominate the input from the
-	 * interrupt noise.
-	 */
-	if (arch_get_random_seed_long(&seed)) {
-		__mix_pool_bytes(r, &seed, sizeof(seed));
-		credit = 1;
-	}
 	spin_unlock(&r->lock);
 
 	fast_pool->count = 0;
 
 	/* award one bit for the contents of the fast pool */
-	credit_entropy_bits(r, credit + 1);
+	credit_entropy_bits(r, 1);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
-- 
2.17.1

