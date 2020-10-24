Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A46297E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764179AbgJXTr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:47:26 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45662 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764171AbgJXTrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:47:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09OJkrwC013767;
        Sat, 24 Oct 2020 21:46:53 +0200
From:   Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        George Spelvin <lkml@sdf.org>,
        Amit Klein <aksecurity@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
        Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>
Subject: [PATCH v4 2/3] random32: add noise from network and scheduling activity
Date:   Sat, 24 Oct 2020 21:46:20 +0200
Message-Id: <20201024194621.13720-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20201024194621.13720-1-w@1wt.eu>
References: <20201024194621.13720-1-w@1wt.eu>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of the interrupt perturbations in previous random32
change (random32: make prandom_u32() output unpredictable), the PRNG
has become 100% deterministic again. While SipHash is expected to be
way more robust against brute force than the previous Tausworthe LFSR,
there's still the risk that whoever has even one temporary access to
the PRNG's internal state is able to predict all subsequent draws till
the next reseed (roughly every minute). This may happen through a side
channel attack or any data leak.

This patch restores the spirit of commit f227e3ec3b5c ("random32: update
the net random state on interrupt and activity") in that it will perturb
the internal PRNG's statee using externally collected noise, except that
it will not pick that noise from the random pool's bits nor upon
interrupt, but will rather combine a few elements along the Tx path
that are collectively hard to predict, such as dev, skb and txq
pointers, packet length and jiffies values. These ones are combined
using a single round of SipHash into a single long variable that is
mixed with the net_rand_state upon each invocation.

The operation was inlined because it produces very small and efficient
code, typically 3 xor, 2 add and 2 rol. The performance was measured
to be the same (even very slightly better) than before the switch to
SipHash; on a 6-core 12-thread Core i7-8700k equipped with a 40G NIC
(i40e), the connection rate dropped from 556k/s to 555k/s while the
SYN cookie rate grew from 5.38 Mpps to 5.45 Mpps.

Link: https://lore.kernel.org/netdev/20200808152628.GA27941@SDF.ORG/
Cc: George Spelvin <lkml@sdf.org>
Cc: Amit Klein <aksecurity@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: tytso@mit.edu
Cc: Florian Westphal <fw@strlen.de>
Cc: Marc Plumb <lkml.mplumb@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 include/linux/prandom.h | 19 +++++++++++++++++++
 kernel/time/timer.c     |  2 ++
 lib/random32.c          |  5 +++++
 net/core/dev.c          |  4 ++++
 4 files changed, 30 insertions(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index cc1e71334e53..bbf4b4ad61df 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -16,6 +16,12 @@ void prandom_bytes(void *buf, size_t nbytes);
 void prandom_seed(u32 seed);
 void prandom_reseed_late(void);
 
+DECLARE_PER_CPU(unsigned long, net_rand_noise);
+
+#define PRANDOM_ADD_NOISE(a, b, c, d) \
+	prandom_u32_add_noise((unsigned long)(a), (unsigned long)(b), \
+			      (unsigned long)(c), (unsigned long)(d))
+
 #if BITS_PER_LONG == 64
 /*
  * The core SipHash round function.  Each line can be executed in
@@ -50,6 +56,18 @@ void prandom_reseed_late(void);
 #error Unsupported BITS_PER_LONG
 #endif
 
+static inline void prandom_u32_add_noise(unsigned long a, unsigned long b,
+					 unsigned long c, unsigned long d)
+{
+	/*
+	 * This is not used cryptographically; it's just
+	 * a convenient 4-word hash function. (3 xor, 2 add, 2 rol)
+	 */
+	a ^= raw_cpu_read(net_rand_noise);
+	PRND_SIPROUND(a, b, c, d);
+	raw_cpu_write(net_rand_noise, d);
+}
+
 struct rnd_state {
 	__u32 s1, s2, s3, s4;
 };
@@ -99,6 +117,7 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 	state->s2 = __seed(i,   8U);
 	state->s3 = __seed(i,  16U);
 	state->s4 = __seed(i, 128U);
+	PRANDOM_ADD_NOISE(state, i, 0, 0);
 }
 
 /* Pseudo random number generator from numerical recipes. */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3e341af741b9..de37e33a868d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1706,6 +1706,8 @@ void update_process_times(int user_tick)
 {
 	struct task_struct *p = current;
 
+	PRANDOM_ADD_NOISE(jiffies, user_tick, p, 0);
+
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
 	run_local_timers();
diff --git a/lib/random32.c b/lib/random32.c
index be9f242a4207..7f047844e494 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -337,6 +337,8 @@ struct siprand_state {
 };
 
 static DEFINE_PER_CPU(struct siprand_state, net_rand_state) __latent_entropy;
+DEFINE_PER_CPU(unsigned long, net_rand_noise);
+EXPORT_PER_CPU_SYMBOL(net_rand_noise);
 
 /*
  * This is the core CPRNG function.  As "pseudorandom", this is not used
@@ -360,9 +362,12 @@ static DEFINE_PER_CPU(struct siprand_state, net_rand_state) __latent_entropy;
 static inline u32 siprand_u32(struct siprand_state *s)
 {
 	unsigned long v0 = s->v0, v1 = s->v1, v2 = s->v2, v3 = s->v3;
+	unsigned long n = raw_cpu_read(net_rand_noise);
 
+	v3 ^= n;
 	PRND_SIPROUND(v0, v1, v2, v3);
 	PRND_SIPROUND(v0, v1, v2, v3);
+	v0 ^= n;
 	s->v0 = v0;  s->v1 = v1;  s->v2 = v2;  s->v3 = v3;
 	return v1 + v3;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 9499a414d67e..82dc6b48e45f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -145,6 +145,7 @@
 #include <linux/indirect_call_wrapper.h>
 #include <net/devlink.h>
 #include <linux/pm_runtime.h>
+#include <linux/prandom.h>
 
 #include "net-sysfs.h"
 
@@ -3558,6 +3559,7 @@ static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 		dev_queue_xmit_nit(skb, dev);
 
 	len = skb->len;
+	PRANDOM_ADD_NOISE(skb, dev, txq, len + jiffies);
 	trace_net_dev_start_xmit(skb, dev);
 	rc = netdev_start_xmit(skb, dev, txq, more);
 	trace_net_dev_xmit(skb, rc, dev, len);
@@ -4130,6 +4132,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			if (!skb)
 				goto out;
 
+			PRANDOM_ADD_NOISE(skb, dev, txq, jiffies);
 			HARD_TX_LOCK(dev, txq, cpu);
 
 			if (!netif_xmit_stopped(txq)) {
@@ -4195,6 +4198,7 @@ int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 
 	skb_set_queue_mapping(skb, queue_id);
 	txq = skb_get_tx_queue(dev, skb);
+	PRANDOM_ADD_NOISE(skb, dev, txq, jiffies);
 
 	local_bh_disable();
 
-- 
2.28.0

