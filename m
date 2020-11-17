Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB202B6CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgKQSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKQSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:24 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:23 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id 67so13498641wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wfMub1Dq2/zzWvEJdcb9YkOg3Kk4cyIQtTysz5FPZ9k=;
        b=i29eJtch8pt4MddWICqOePgkq/MwJTbTc/hOyGFj3909KVEBPm5n0cRj+EplVnonKY
         WbI373E5+4cYXjRgWXgB7yoEj51rISpjpUCCpNubJ4wb3DMp/jUm/ja856YXPM1roevU
         DCSoS5kmz/1ross0mm9LO5aO5Df0pZvR0PhjdaR8ldJFyvyqiVcNi/BAVeb15byHXn9C
         8IMifCCt418cG8UX7UZpo+rA5552KYu5sl1fjIkWTaOGhboJk+EaVtU77VEJh1fdvKKP
         1csKvBXdENtZrlIOODJUyxJZCWUu3IhGdceC5DZsOslbPK2hFkR/d4psXG8fA7BWlsm1
         lmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wfMub1Dq2/zzWvEJdcb9YkOg3Kk4cyIQtTysz5FPZ9k=;
        b=hueFcI6KqUZi+dbIdcX79bYhY2a+SrbvRPLWBJkDVn6Q6qkYhi64yIqhWyXJyLaCUI
         ISTCsMIY4wItKznGp0Onbho64Kcqqc1S6Ey2ORGnbgbJUN9OAGb4C4xpXrdgTc33Y3/X
         my8V/qo8vxpJ4qEcdL/3ko7m2MpYd9MFaz2BiM49Y3nryeNcw/1bOYA7aIqERHG4Bkm4
         jGxrTk44TantIOhzU9mYUGfkXxwIZjVaggN/ElA7PtEYgCyRfUYMkdgl4h4IavZcUYMB
         JO5+BzecbFNc5b+XJUxP0Q+kFoClZ9evqKbpD9alOJppPYYaSGelOpQBGyujBF37Z6Zo
         BCfA==
X-Gm-Message-State: AOAM533OGEbnkOKLhTmqlVKblS2Gx/KgapBy2Kyy+RRvOp2i2xvmN6GY
        jj9/8680bopUoxwVLgium7X+oW46Ozkf
X-Google-Smtp-Source: ABdhPJwLzQmM3f+/yXxfkHBpPHMIy89xImU6xwZzUPy415BoTaClg6AeXK5YHYslpqgilPliowk09nC1PT5L
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a1c:3d54:: with SMTP id
 k81mr389168wma.144.1605636981668; Tue, 17 Nov 2020 10:16:21 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:41 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-2-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 01/27] arm64: lib: Annotate {clear,copy}_page() as position-independent
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

clear_page() and copy_page() are suitable for use outside of the kernel
address space, so annotate them as position-independent code.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/clear_page.S | 4 ++--
 arch/arm64/lib/copy_page.S  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index 073acbf02a7c..b84b179edba3 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -14,7 +14,7 @@
  * Parameters:
  *	x0 - dest
  */
-SYM_FUNC_START(clear_page)
+SYM_FUNC_START_PI(clear_page)
 	mrs	x1, dczid_el0
 	and	w1, w1, #0xf
 	mov	x2, #4
@@ -25,5 +25,5 @@ SYM_FUNC_START(clear_page)
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	1b
 	ret
-SYM_FUNC_END(clear_page)
+SYM_FUNC_END_PI(clear_page)
 EXPORT_SYMBOL(clear_page)
diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index e7a793961408..29144f4cd449 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -17,7 +17,7 @@
  *	x0 - dest
  *	x1 - src
  */
-SYM_FUNC_START(copy_page)
+SYM_FUNC_START_PI(copy_page)
 alternative_if ARM64_HAS_NO_HW_PREFETCH
 	// Prefetch three cache lines ahead.
 	prfm	pldl1strm, [x1, #128]
@@ -75,5 +75,5 @@ alternative_else_nop_endif
 	stnp	x16, x17, [x0, #112 - 256]
 
 	ret
-SYM_FUNC_END(copy_page)
+SYM_FUNC_END_PI(copy_page)
 EXPORT_SYMBOL(copy_page)
-- 
2.29.2.299.gdc1121823c-goog

