Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21172A8983
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgKEWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732603AbgKEWD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:03:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F4D21D46;
        Thu,  5 Nov 2020 22:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613806;
        bh=Ncz9nvwlkZVwG51mnGlyWz6j4Z0NH0pqXpw92eRR6Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcVqjhH5UTHOv4DhRyOS3e1KDRBnEUH/YNdLOu5kdiyHCbwCYyrx3D1MlDey1M/ky
         uv3ePmyMzQ4dCI6oM3/SdztsxdYQD9LUE52LVi+8Ejr9j52VTgDg3oLdk9enErnDxa
         l+5Mq52pef8/+zD05sMRr6wUAlHksNNCehuoKX4E=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/3] kcsan: Fix encoding masks and regain address bit
Date:   Thu,  5 Nov 2020 14:03:24 -0800
Message-Id: <20201105220324.15808-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105220302.GA15733@paulmck-ThinkPad-P72>
References: <20201105220302.GA15733@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

The watchpoint encoding masks for size and address were off-by-one bit
each, with the size mask using 1 unnecessary bit and the address mask
missing 1 bit. However, due to the way the size is shifted into the
encoded watchpoint, we were effectively wasting and never using the
extra bit.

For example, on x86 with PAGE_SIZE==4K, we have 1 bit for the is-write
bit, 14 bits for the size bits, and then 49 bits left for the address.
Prior to this fix we would end up with this usage:

	[ write<1> | size<14> | wasted<1> | address<48> ]

Fix it by subtracting 1 bit from the GENMASK() end and start ranges of
size and address respectively. The added static_assert()s verify that
the masks are as expected. With the fixed version, we get the expected
usage:

	[ write<1> | size<14> |             address<49> ]

Functionally no change is expected, since that extra address bit is
insignificant for enabled architectures.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/encoding.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 4f73db6..b50bda9 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -37,14 +37,12 @@
  */
 #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
 
-/*
- * Masks to set/retrieve the encoded data.
- */
-#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
-#define WATCHPOINT_SIZE_MASK                                                   \
-	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
-#define WATCHPOINT_ADDR_MASK                                                   \
-	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
+/* Bitmasks for the encoded watchpoint access information. */
+#define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
+#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
+#define WATCHPOINT_ADDR_MASK	GENMASK(BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS, 0)
+static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
+static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-- 
2.9.5

