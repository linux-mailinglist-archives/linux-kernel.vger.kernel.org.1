Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0433039F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbhAZKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbhAYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE8C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:43 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z9so10532281qtv.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fYtwEkSD1g4zgc3mwZlXud5vJEM5wBsBl27BfuiCCGo=;
        b=U2AIVAJVNsrZwMQGm3jBTprnYlMZE2r0f07KZ/zh8a2HtVegm5Vrw9+CSVp/lI7Olr
         b3BHv9VX9zYpOGGmLuvOmzIVhSJR0S+/r/mkSAONsXUZHdQBInsFN0VBlaumZAGrgg/F
         s4k2BJaAFHTTlqUf+cDOFIXSAPXmQj1K0VWS9M4Dhs8r6V23ddNJ1CPgIA5l3dp1IaPX
         9gBIB7dFsc7RCkiDRTBhE9rOUkOsra1PlaC4eXs98zEiGF268+JK7j0dEP/u53Tvk+FU
         fIy+tzeA6q2grkIIzOJ3NToRGJ3bHoTlX+Ix/f+DR7XKJX/ZM7gvINzw0/dtPHUm1kYk
         PTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYtwEkSD1g4zgc3mwZlXud5vJEM5wBsBl27BfuiCCGo=;
        b=qd0oHrXBsVw75SQlXvMdfiybX5iW/xgfsi2mcHt/UDa1XXRu/IP26rNU1ZIIxb+tw9
         NK0GKmHu+og4/BcaBqBKwzXBj/LgSVFwKQ83MTN1OE2Nr75LzedRk6iEUMEsnvA0/ZYf
         ErVTIF0do+kiaT0rthGwtlt0nTaCBO/0TWTLRE6y4ID1TVxA6QnZKS50PCOUneCGosBS
         yf32pd/mYbVCq2sT5rKzxcfZa3ArVczjf15QkH8tAD00zCJjuuS2/ZKb68Dgdv+Y3EeC
         6f0hApru5xDy40ygJg8xD1VR4MjT39zSJvkPROarOrYAMv8pdyTnf7H3aNKAlRwW4ykg
         zhpw==
X-Gm-Message-State: AOAM533MTbMIG+dfD4BoknmWS+lJFWx0kDnpVmjfAWn9OBRqSdarBqj8
        YLy2sD9lJcCfQ5t7bklFe2PNDg==
X-Google-Smtp-Source: ABdhPJyI8k+86XaV/8c2jn/BKReyE9eDvlppb7XnDOdVY2z1s16lwW29T78nGb4fSsM7KDSok6C8eQ==
X-Received: by 2002:ac8:a82:: with SMTP id d2mr1908195qti.343.1611602382398;
        Mon, 25 Jan 2021 11:19:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:41 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 11/18] arm64: kexec: arm64_relocate_new_kernel clean-ups and optimizations
Date:   Mon, 25 Jan 2021 14:19:16 -0500
Message-Id: <20210125191923.1060122-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to bigger changes to arm64_relocate_new_kernel that would
enable this function to do MMU backed memory copy, do few clean-ups and
optimizations. These include:

1. Call raw_dcache_line_size()  only when relocation is actually going to
   happen. i.e. kdump type kexec, does not need it.

2.  copy_page(dest, src, tmps...) increments dest and src by PAGE_SIZE, so
    no need to store dest prior to calling copy_page and increment it
    after. Also, src is not used after a copy, not need to copy either.

3. For consistency use comment on the same line with instruction when it
   describes the instruction itself.

4. Some comment corrections

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/relocate_kernel.S | 36 +++++++----------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 84eec95ec06c..462ffbc37071 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -17,28 +17,24 @@
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
- * The memory that the old kernel occupies may be overwritten when coping the
+ * The memory that the old kernel occupies may be overwritten when copying the
  * new image to its final location.  To assure that the
  * arm64_relocate_new_kernel routine which does that copy is not overwritten,
  * all code and data needed by arm64_relocate_new_kernel must be between the
  * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
  * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
- * control_code_page, a special page which has been set up to be preserved
- * during the copy operation.
+ * safe memory that has been set up to be preserved during the copy operation.
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
-
 	/* Setup the list loop variables. */
 	mov	x18, x2				/* x18 = dtb address */
 	mov	x17, x1				/* x17 = kimage_start */
 	mov	x16, x0				/* x16 = kimage_head */
-	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
-
 	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
-
+	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
 .Lloop:
 	and	x12, x16, PAGE_MASK		/* x12 = addr */
 
@@ -57,34 +53,18 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	b.lo    2b
 	dsb     sy
 
-	mov x20, x13
-	mov x21, x12
-	copy_page x20, x21, x0, x1, x2, x3, x4, x5, x6, x7
-
-	/* dest += PAGE_SIZE */
-	add	x13, x13, PAGE_SIZE
+	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
 	b	.Lnext
-
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-
-	/* ptr = addr */
-	mov	x14, x12
+	mov	x14, x12			/* ptr = addr */
 	b	.Lnext
-
 .Ltest_destination:
 	tbz	x16, IND_DESTINATION_BIT, .Lnext
-
-	/* dest = addr */
-	mov	x13, x12
-
+	mov	x13, x12			/* dest = addr */
 .Lnext:
-	/* entry = *ptr++ */
-	ldr	x16, [x14], #8
-
-	/* while (!(entry & DONE)) */
-	tbz	x16, IND_DONE_BIT, .Lloop
-
+	ldr	x16, [x14], #8			/* entry = *ptr++ */
+	tbz	x16, IND_DONE_BIT, .Lloop	/* while (!(entry & DONE)) */
 .Ldone:
 	/* wait for writes from copy_page to finish */
 	dsb	nsh
-- 
2.25.1

