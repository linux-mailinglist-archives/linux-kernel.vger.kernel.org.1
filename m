Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B52691DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgINPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:14:13 -0400
Received: from foss.arm.com ([217.140.110.172]:39646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgINPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FE41597;
        Mon, 14 Sep 2020 08:10:50 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA8F3F718;
        Mon, 14 Sep 2020 08:10:49 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/14] arm64: usercopy: Add conclusive fixup routine
Date:   Mon, 14 Sep 2020 15:09:57 +0000
Message-Id: <20200914150958.2200-14-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914150958.2200-1-oli.swede@arm.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a second-stage routine to the usercopy functions that
contains the final calculation for the return value, which
represents the number of bytes not copied and is returned to the
faulting syscall. This is only reached in the code path where a
fault occurs during the second in-order copy; otherwise, the
intermediate fixup will fall back to returning zero if it reaches
the end of the buffer.

As the intermediate fixup has already placed either srcend or dstend
in x5 depending on the instruction that faulted, the sub operation is
the same and the final fixup can be re-used for both cases.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_user_fixup.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 6a7b2406d948..4858edd55994 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -62,8 +62,17 @@ L(all_copied):
 	mov	x0, #0 // reached the end of buffer
 	ret
 
-9998:
-// TODO: add accurate fixup
 L(none_copied):
 	mov	x0, x2 // count (x2)
 	ret
+
+/*
+ * Faults during a scan of the user buffer while running an
+ * in-order copy.
+ *
+ * Calculate the number of bytes not copied, using the fault
+ * address as a precise indicator.
+ */
+9998:
+    sub x0, x5, addr // x0: srcend-faddr or dstend-faddr
+    ret
-- 
2.17.1

