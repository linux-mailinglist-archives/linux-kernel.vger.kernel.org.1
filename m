Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397E31A85F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502457AbgDNQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440386AbgDNQtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:19 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8D222202;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=jd11BH+E0kQ4lfNrsHgxWhZfvWguP7UNkigN6xgvlsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3BRPSdhXr2NWHwbVytJt888whMqL4XdRsAPxAnw06Ccp/8/5WpOzD2ZM96n5x6dZ
         cdVFapXprQxXuhCY/n2SNcnDoE8RDnuGzMLof2XGViItjgjBVO4NGLCrzRjnihl0PE
         bjuwdVqcxt0zVMi/Lyj0l7/uWN5m/+uaMpeCJYas=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068nY-JQ; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 33/33] lib: bitmap.c: get rid of some doc warnings
Date:   Tue, 14 Apr 2020 18:48:59 +0200
Message-Id: <1e2568fdfa838c1a0d8cc2a1d70dd4b6de99bfb1.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ascii art drawings there. Use a block markup tag there
in order to get rid of those warnings:

	./lib/bitmap.c:189: WARNING: Unexpected indentation.
	./lib/bitmap.c:190: WARNING: Block quote ends without a blank line; unexpected unindent.
	./lib/bitmap.c:190: WARNING: Unexpected indentation.
	./lib/bitmap.c:191: WARNING: Line block ends without a blank line.

It should be noticed that there's actually a syntax violation
right now, as something like:

	/**
	 ...
	 @src:

will be handled as a definition for @src parameter, and not as
part of a diagram. So, we need to add something before it, in
order for this to be processed the way it should.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 lib/bitmap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa342d6..21a7640c5eed 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -182,21 +182,22 @@ EXPORT_SYMBOL(__bitmap_shift_left);
  *
  * In pictures, example for a big-endian 32-bit architecture:
  *
- * @src:
- * 31                                   63
- * |                                    |
- * 10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
- *                 |  |              |                                    |
- *                16  14             0                                   32
+ * The @src bitmap is::
  *
- * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is:
+ *   31                                   63
+ *   |                                    |
+ *   10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
+ *                   |  |              |                                    |
+ *                  16  14             0                                   32
  *
- * 31                                   63
- * |                                    |
- * 10110000 00011000 00110010 00010101  00010000 00011000 00101110 01000010
- *                    |              |                                    |
- *                    14 (bit 17     0                                   32
- *                        from @src)
+ * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is::
+ *
+ *   31                                   63
+ *   |                                    |
+ *   10110000 00011000 00110010 00010101  00010000 00011000 00101110 01000010
+ *                      |              |                                    |
+ *                      14 (bit 17     0                                   32
+ *                          from @src)
  *
  * Note that @dst and @src might overlap partially or entirely.
  *
-- 
2.25.2

