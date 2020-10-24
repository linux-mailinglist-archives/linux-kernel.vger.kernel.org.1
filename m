Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92A6297E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764196AbgJXTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:47:32 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45668 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764172AbgJXTra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:47:30 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09OJkr0O013768;
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
Subject: [PATCH v4 3/3] random32: add a selftest for the prandom32 code
Date:   Sat, 24 Oct 2020 21:46:21 +0200
Message-Id: <20201024194621.13720-4-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20201024194621.13720-1-w@1wt.eu>
References: <20201024194621.13720-1-w@1wt.eu>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that this code is new, let's add a selftest for it as well.
It doesn't rely on fixed sets, instead it picks 1024 numbers and
verifies that they're not more correlated than desired.

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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 lib/random32.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/lib/random32.c b/lib/random32.c
index 7f047844e494..4d0e05e471d7 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -38,6 +38,7 @@
 #include <linux/jiffies.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/bitops.h>
 #include <asm/unaligned.h>
 #include <trace/events/random.h>
 
@@ -556,6 +557,61 @@ static void prandom_timer_start(struct random_ready_callback *unused)
 	mod_timer(&seed_timer, jiffies);
 }
 
+#ifdef CONFIG_RANDOM32_SELFTEST
+/* Principle: True 32-bit random numbers will all have 16 differing bits on
+ * average. For each 32-bit number, there are 601M numbers differing by 16
+ * bits, and 89% of the numbers differ by at least 12 bits. Note that more
+ * than 16 differing bits also implies a correlation with inverted bits. Thus
+ * we take 1024 random numbers and compare each of them to the other ones,
+ * counting the deviation of correlated bits to 16. Constants report 32,
+ * counters 32-log2(TEST_SIZE), and pure randoms, around 6 or lower. With the
+ * u32 total, TEST_SIZE may be as large as 4096 samples.
+ */
+#define TEST_SIZE 1024
+static int __init prandom32_state_selftest(void)
+{
+	unsigned int x, y, bits, samples;
+	u32 xor, flip;
+	u32 total;
+	u32 *data;
+
+	data = kmalloc(sizeof(*data) * TEST_SIZE, GFP_KERNEL);
+	if (!data)
+		return 0;
+
+	for (samples = 0; samples < TEST_SIZE; samples++)
+		data[samples] = prandom_u32();
+
+	flip = total = 0;
+	for (x = 0; x < samples; x++) {
+		for (y = 0; y < samples; y++) {
+			if (x == y)
+				continue;
+			xor = data[x] ^ data[y];
+			flip |= xor;
+			bits = hweight32(xor);
+			total += (bits - 16) * (bits - 16);
+		}
+	}
+
+	/* We'll return the average deviation as 2*sqrt(corr/samples), which
+	 * is also sqrt(4*corr/samples) which provides a better resolution.
+	 */
+	bits = int_sqrt(total / (samples * (samples - 1)) * 4);
+	if (bits > 6)
+		pr_warn("prandom32: self test failed (at least %u bits"
+			" correlated, fixed_mask=%#x fixed_value=%#x\n",
+			bits, ~flip, data[0] & ~flip);
+	else
+		pr_info("prandom32: self test passed (less than %u bits"
+			" correlated)\n",
+			bits+1);
+	kfree(data);
+	return 0;
+}
+core_initcall(prandom32_state_selftest);
+#endif /*  CONFIG_RANDOM32_SELFTEST */
+
 /*
  * Start periodic full reseeding as soon as strong
  * random numbers are available.
-- 
2.28.0

