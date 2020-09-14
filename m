Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2E2691F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgINQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:39648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgINPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C8B15A2;
        Mon, 14 Sep 2020 08:10:51 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABC983F718;
        Mon, 14 Sep 2020 08:10:50 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/14] arm64: usercopy: Reduce overhead in fixup
Date:   Mon, 14 Sep 2020 15:09:58 +0000
Message-Id: <20200914150958.2200-15-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914150958.2200-1-oli.swede@arm.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the usercopy fixups the intermediate in-order copy step could
create an overhead for a fault that occurs a large number of
bytes ahead in the buffer. On inspection of the copy routine,
it appears possible to leverage the property where all bytes lower
than the fault address minus N bytes (128 for this algorithm) have
already been copied at the point of a fault .

This adds a preprocessor directive for defining the value that should
be subtracted from the intermediate fault address by the first-stage
fixup routine. This is the only dependency on the copy routine and
this change should be re-evaluated when importing new optimized copy
routines to determine if the property still holds, or e.g. if N needs
to be increased, to ensure the fixup remains precise.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_user_fixup.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 4858edd55994..970370b5b0a5 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#define FIXUP_GRANULE 128
+
 addr	.req	x15
 .section .fixup,"ax"
 .align	2
@@ -36,6 +38,13 @@ L(src_fault):
 	mov	x4, x0 // x4: initial target store address
 	add	x5, x1, x2 // x5: srcend
 
+	subs	x3, x15, FIXUP_GRANULE
+	ccmp	x3, x1, #0, pl
+	csel	x3, x3, x1, ge // x3: initial target (user) load address
+	sub	x4, x3, x1
+	add	x4, x0, x4 // x4: initial target store address
+	add	x5, x1, x2 // x5: srcend
+
 L(src_buf_scan):
 	ldrb2_post	w6, x3, #1
 	strb2_post	w6, x4, #1
@@ -52,6 +61,13 @@ L(dst_fault):
 	mov	x4, x1 // x4: initial target load address
 	add	x5, x0, x2 // x5: dstend
 
+	subs	x3, x15, FIXUP_GRANULE
+	ccmp	x3, x0, #0, pl
+	csel	x3, x3, x0, ge // x3: initial target (user) store address
+	sub	x4, x3, x0
+	add	x4, x1, x4 // x4: initial target load address
+	add	x5, x0, x2 // x5: dstend
+
 L(dst_buf_scan):
 	ldrb2_post	w6, x4, #1
 	strb2_post	w6, x3, #1
-- 
2.17.1

