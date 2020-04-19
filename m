Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CCA1AF633
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDSB6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDSB6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2F8221EA;
        Sun, 19 Apr 2020 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261483;
        bh=HGY9EZSq5eQ+gq4BcOvqMa3Xzze7z+HiEycaWwdZI5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08avI91IDpE3saAPRaxPOOvZBxObQJzCFDEY091qOD2wgmZcSq/adftI9cNszXUeY
         aBCTT9Vh3lw5158X6udzsVLMGBDfTna5Z4orAYG/3ZxEnLMLRgQ0CR+szIkS9PBtpr
         Ipv6y5T6cjDIPHMZ4hkmmAxOxdxggdXygetHRpkU=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 04/12] tools bitmap: add bitmap_andnot definition
Date:   Sat, 18 Apr 2020 21:57:46 -0400
Message-Id: <20200419015754.24456-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition of bitmap_andnot() and wire tools/lib/bitmap.c into
liblockdep.

This is needed as a result of de4643a77356 ("locking/lockdep: Reuse lock
chains that have been freed").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/bitmap.h | 10 ++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 tools/lib/lockdep/Build      |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f2..ab5df035f8eda 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
+int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 
@@ -178,4 +180,12 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+                        const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_andnot(dst, src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 5043747ef6c5f..b6bc037623fc1 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -86,3 +86,18 @@ int __bitmap_equal(const unsigned long *bitmap1,
 
 	return 1;
 }
+
+int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+                                const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int lim = bits/BITS_PER_LONG;
+	unsigned long result = 0;
+
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
+	if (bits % BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
+			BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
diff --git a/tools/lib/lockdep/Build b/tools/lib/lockdep/Build
index 6f667355b0687..219a9e2d9e0ba 100644
--- a/tools/lib/lockdep/Build
+++ b/tools/lib/lockdep/Build
@@ -1 +1 @@
-liblockdep-y += common.o lockdep.o preload.o rbtree.o
+liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o
-- 
2.20.1

