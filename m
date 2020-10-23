Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA2296E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463470AbgJWMMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463462AbgJWMMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:12:32 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089BBC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:12:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id es11so797705qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ouYH/AbpkMNV6tkRrDvFrzxeHdaKqWEGX7QPqZMtewo=;
        b=aI9i0Aa5WCjKA07HTuWW8FUp7wx+YFaPdUHZTbNXkORhjoo+4gY9P+Njn7vXtPjd98
         Lo4GQHkNsI83ZvsDocGxx560+bjwXIg5lJP/eqt4ox7W+is0xIo7AcUoCFHnTxDw8GGo
         V09Hj183zNECQ1i+9bzz4kZcWGY4HiYvi1R0UbYxs3pvArHYjby//i1nVk1HPl7Q+DEp
         0NfxpdizNvMUFMWcwPDb2LNCe6OBJhKDTTx0ifsSafqdTrRUJPn6tUyl1ZiTVWZbPIei
         8b2A43tsOgsg7G12PUAlBIhn1qNGsKtUIijLphPQ02Kj4cUUDqiKj45bOINXypsAgExY
         rL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ouYH/AbpkMNV6tkRrDvFrzxeHdaKqWEGX7QPqZMtewo=;
        b=UkisWMd7JOcq/nPKk1TwtvisLz9Rtg6zza1ErSmfINHR/2C+33jSJoVAY3gQfbBRxu
         EEGkCmTEPp+e6Zk96lO/WArJ4y+N/DxSUp5ZVjSJ9oB0vqKU0L/QvaYcVtc1lSJm7Xds
         0U0gsZsZJwiR+bVTHmiWtrCk4IQ9yWGkdREZtLym6cqih3vy71Dwv2Bv5jaS6GSflL8Z
         thZeKnIFtm1c53p+/H5p+clSOPkiDPFUuonweJHH2q4egLbJ1xy/SgEdGlfG5nUNOzkC
         THrQQWrpH83LDIhY8Nf1EkvCqom9RCt6I/j28BA+WtI8SB8VuejM0p4lVAyHRkxTP4Sg
         H07A==
X-Gm-Message-State: AOAM533X9F3lN7VfodS3GhzPz3ZujRfD45+JEduCPa+OfM/DYvW5X/0A
        TCbArb8Z1QsHHKR6vYv1l3f3v8lkZQ==
X-Google-Smtp-Source: ABdhPJxW3pz7jE4MX7asN2BGLqaI1oG3AfmWxPt0T37nonMLsH1u+4rSLQYKcMuRA/L272ajQdGkE+LC+A==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:8285:: with SMTP id i5mr1932002qva.54.1603455150074;
 Fri, 23 Oct 2020 05:12:30 -0700 (PDT)
Date:   Fri, 23 Oct 2020 14:12:24 +0200
Message-Id: <20201023121224.3630272-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kcsan: Fix encoding masks and regain address bit
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/kcsan/encoding.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 64b3c0f2a685..fc5154dd2475 100644
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
2.29.0.rc1.297.gfa9743e501-goog

