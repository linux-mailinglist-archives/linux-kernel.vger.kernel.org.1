Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA51302BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbhAYToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbhAYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95959C0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:44 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l23so8040070qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tiSMngDA2ABiEtmeVcai+dAKxWkYAh1htex3hJFUjpk=;
        b=ViZk57Ck4HUJG00kgKhICCWv1eeMV2KNwvtWbX+xyUO32m6U7YnxxkY3kd7tyt7Ng+
         XrR64IVqIQXWuSCO/zvWvsnc220koQtIQ6BeCpcN3m5qJtxE8hQd+lqOk1SSUws39mJ5
         2UU0xjoEra/u8cu7+zZxLeSEhnlev+FK43G7b4wigJE0ZW7Fxmwc4f+5WKP6PGVvLDKD
         CevQSfsHTtUhlePppvfpl/vrZuOFENi0k/k70Vz6s/LnbGLcFohCKRaCw+y6dHHnaupf
         dxxTdXFgaF41aR4eCDsfpBOzusaAodDscncPCsGYESYFYQ62GgZzY2GbN4qZLZDAgGys
         GB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tiSMngDA2ABiEtmeVcai+dAKxWkYAh1htex3hJFUjpk=;
        b=p4SeljS/GTcqZnSx317yxzjpng5bjukNMWtEx1mtyGCSeYDgwPwvYM5X6uhhp0V8fo
         6jA2nQx5Q7QjJ0H/Fk4sIU52AIucH9eDqCjgH8f8WSy2Zwpr6TNzhAQq+ISvYhzJxkWb
         Wuej1NuKpwJCIap5RjwTRqbivfCXUcdr03Oa9qMmrWZliXNvQMWow+eS3Pm/IJCc/3N5
         nsGOKfyuQLcVg0vNJB0bPlLsBJknsox+8S/jvfjsgjAFAeO3R2RHDy/wjND3MygcFFv7
         YipIbgmAsjWqBZ1WJSNONU11qjR1zcV3Z/rk25m/FbGsqva2ESu8TFIdSznNaGrdfFeG
         tP+w==
X-Gm-Message-State: AOAM530+qDumfm+JFZvXVApgyM7z5yxjyC1V13SOWE0E+XYKAo0IVR0b
        Y1/8UPbPa+yR+/KoSxqaSO08+Q==
X-Google-Smtp-Source: ABdhPJzn7ahPtOGX/KTR0Kc/e2td2Abo5VWVmrRWEDIeC/ylKNtmaaW0TcaryJ7Q6EPO8SaSfFQgTQ==
X-Received: by 2002:ac8:4d93:: with SMTP id a19mr1928434qtw.356.1611602383884;
        Mon, 25 Jan 2021 11:19:43 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:43 -0800 (PST)
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
Subject: [PATCH v10 12/18] arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
Date:   Mon, 25 Jan 2021 14:19:17 -0500
Message-Id: <20210125191923.1060122-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x0 will contain the only argument to arm64_relocate_new_kernel; don't
use it as a temp. Reassigned registers to free-up x0 so we won't need
to copy argument, and can use it at the beginning and at the end of the
function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/relocate_kernel.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 462ffbc37071..b78ea5de97a4 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -34,7 +34,7 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x13, xzr			/* x13 = copy dest */
 	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
-	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
+	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
 .Lloop:
 	and	x12, x16, PAGE_MASK		/* x12 = addr */
 
@@ -43,17 +43,17 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
 
 	/* Invalidate dest page to PoC. */
-	mov     x0, x13
-	add     x20, x0, #PAGE_SIZE
+	mov     x2, x13
+	add     x20, x2, #PAGE_SIZE
 	sub     x1, x15, #1
-	bic     x0, x0, x1
-2:	dc      ivac, x0
-	add     x0, x0, x15
-	cmp     x0, x20
+	bic     x2, x2, x1
+2:	dc      ivac, x2
+	add     x2, x2, x15
+	cmp     x2, x20
 	b.lo    2b
 	dsb     sy
 
-	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
+	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-- 
2.25.1

