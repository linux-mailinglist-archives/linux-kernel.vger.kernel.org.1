Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE352A92D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKFJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:35:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:35:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so696369wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xbe1zafvLzFk0NBuZKfqZ6Cyl3GP1S5ka0zb2rUwC3Y=;
        b=aCr5QBrqgXrzRg0NR6myvS6xEIITsQ2Bccqq53y4TRpcpC39vVuVatUdShlYuUwtjz
         5Dbe7SGEKcnUlpSR9ydb3ABkuToji9XJqkUBWgJISIaFSb2kK8zYVmJYqURepQefiObs
         jhkI1moTACYZ5HCIiWDuY5ABopOEVIrbfTucIXS6h8eaL9+TzBaGAWYAFY90FmOE6Qb8
         eFWlQmt8UQtszRvVQaZIPAvz0ju/x9bzDCYWKDf6oMfelTQan8wfb7u0B9Bfa09u0Dd0
         qUc5mvdxeeE2xn9MhAYIAs/F0vPF5eTucCp5oxXLN9n5Mr12obbmemNcEDGj+lw6LsX0
         8hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xbe1zafvLzFk0NBuZKfqZ6Cyl3GP1S5ka0zb2rUwC3Y=;
        b=V+CWk17kZZMeBpqSha8jQvKkIZvRoaeUI7C7YGldisLLc5Z20I5XRYIV93COzt9Rrq
         SfFbU+z4pGNYDktar87kQxdvesjUI2TMNty4TFvX6//E6Ydmy+dKKHbGJd+etJaz6q2j
         0O1GsLmuEUKyT6N/CVZVDhlRmk0yCZGXspAHlSk4PD6BImF9P4F0+0Epj91CwFYwfjMW
         BJtpslULxImJYa99lK2zPXdTO6jEBfGKTSxGAcg8GPK3xpC9B8sWmN0mQACwesj5/CSh
         lqL0xN2U796ZBxQRUl0suIVbUDygZ3e7NXPUR7Oi/wTTTVnB3n3Q6rlBF6GHQR/ld56z
         1Lxg==
X-Gm-Message-State: AOAM530GMXBIMRmi/yzALN43B/FM22VMWUne1vceynPoYTAtnpQSRP3b
        RieoW4CM4aybVo+l3HTK4mE3Lw==
X-Google-Smtp-Source: ABdhPJwylk79+X8Z8POef/KGObpESqQTg/XvVd3YRpXcCW/8KEFz9wAe1qHhm9PuoC916iB7pnocrQ==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr1210948wmk.131.1604655302864;
        Fri, 06 Nov 2020 01:35:02 -0800 (PST)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id y185sm1395980wmb.29.2020.11.06.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:35:01 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:34:56 +0100
From:   Marco Elver <elver@google.com>
To:     paulmck@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, andreyknvl@google.com,
        glider@google.com, dvyukov@google.com, cai@lca.pw
Subject: [PATCH v2] kcsan: Fix encoding masks and regain address bit
Message-ID: <20201106093456.GB2851373@elver.google.com>
References: <20201105220302.GA15733@paulmck-ThinkPad-P72>
 <20201105220324.15808-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105220324.15808-3-paulmck@kernel.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
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
v2:
* Use WATCHPOINT_ADDR_BITS to avoid duplicating "BITS_PER_LONG-1 -
  WATCHPOINT_SIZE_BITS" per Boqun's suggestion.
---
 kernel/kcsan/encoding.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 4f73db6d1407..7ee405524904 100644
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
+#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)
+#define WATCHPOINT_ADDR_MASK	GENMASK(WATCHPOINT_ADDR_BITS-1, 0)
+static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
+static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-- 
2.29.2.222.g5d2a92d10f8-goog

