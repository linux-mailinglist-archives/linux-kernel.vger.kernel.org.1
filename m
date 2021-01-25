Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02593039F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403877AbhAZKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbhAYTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:20:35 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3BC06178B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so10531956qtv.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3FwrG1DRKa930mcqv1CQX/Ow19T+ppBoJGHaLYA3Zn4=;
        b=OMM+n/NgLxxolTPSpQfFupxi8pL7prIM8KcL0yuUt6nWfKRTlR6APYpr/V8F9WNvA1
         ikIhnojbMioMSri7RLzroDZGFYn/E6gh220XP8IJyVS3exiStf/6gCaet1KfKtTGtzSB
         hUwZY6sdDa4bLX25PetOw90C87Q6MClcrvHBbWn37ai8bBgV5A9XsgIe+309KgWBm0o4
         PM5Hgbdxd/Z4Wf3Z9Uy9rmMFm46l1p1ggWGl3Glxu55yQPOxsT+XaTwTkEaSpvjMbD6M
         6rT7T58457HNNABrDb3FqPJjaoGnar+ESiEAa6nYAAfBmFI+ipXzsBU1dI23SbYeBsye
         z4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FwrG1DRKa930mcqv1CQX/Ow19T+ppBoJGHaLYA3Zn4=;
        b=sCwpImR1wojzzOQzzwuLTBhl+o8bouvWE7/e8YQtSLjsglEsKP0Ky3aV+rutO+ow75
         yrpyNr3ygQD1+1/EVwklSMqnZjL7nj6Ln3/IOfkrkMtust/+UN2Si3Q8rJ65DseLoja2
         IGB9ohbdkKzvlnfkhmRFhBMm6xWzxW+Ja0Emoo0l53snM6RfQjwNxQo1aas2qjrbrjSY
         jCxJwJpNMetRimszCSj5bRSRnVTucJo0+X+dgfFRyukcLeX7U7P00mPD3HTyCGLxBDk0
         1id41Dta8reGqozKCm2NfyJ6pbUW2xrFv1Wg3xo/XhSHo5E8CmxDAfBvoJ0yEwjSKiOy
         QrKg==
X-Gm-Message-State: AOAM533TJAIybKw2MZJ4METwXB/1ykVyZ3b4aPUfd+wt+i3DOxYobEYQ
        jVDNQZMBjBQPHMuOxk7MYQ/zyQ==
X-Google-Smtp-Source: ABdhPJzYpijMw9x6eiYnJkfIhvZXHqaaGkTUev606A5PQKAYeMNfq2YM+YhFDIUaCji9oVYPnb8lLA==
X-Received: by 2002:ac8:3571:: with SMTP id z46mr2020689qtb.83.1611602374721;
        Mon, 25 Jan 2021 11:19:34 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:34 -0800 (PST)
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
Subject: [PATCH v10 06/18] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
Date:   Mon, 25 Jan 2021 14:19:11 -0500
Message-Id: <20210125191923.1060122-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_pgd_* should be independent from mm context because the tables that
are created by this code are used when there are no mm context around, as
it is between kernels. Simply replace mm_init's with NULL.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/trans_pgd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 47b6b7029907..ded8e2ba0308 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -67,7 +67,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
+	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
 	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
@@ -90,7 +90,7 @@ static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
 		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, dst_pudp, dst_pmdp);
+		pud_populate(NULL, dst_pudp, dst_pmdp);
 	}
 	dst_pmdp = pmd_offset(dst_pudp, start);
 
@@ -126,7 +126,7 @@ static int copy_pud(struct trans_pgd_info *info, p4d_t *dst_p4dp,
 		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
-		p4d_populate(&init_mm, dst_p4dp, dst_pudp);
+		p4d_populate(NULL, dst_p4dp, dst_pudp);
 	}
 	dst_pudp = pud_offset(dst_p4dp, start);
 
@@ -241,7 +241,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		p4dp = trans_alloc(info);
 		if (!pgdp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, p4dp);
+		pgd_populate(NULL, pgdp, p4dp);
 	}
 
 	p4dp = p4d_offset(pgdp, dst_addr);
@@ -249,7 +249,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
-		p4d_populate(&init_mm, p4dp, pudp);
+		p4d_populate(NULL, p4dp, pudp);
 	}
 
 	pudp = pud_offset(p4dp, dst_addr);
@@ -257,7 +257,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
+		pud_populate(NULL, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
@@ -265,7 +265,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
+		pmd_populate_kernel(NULL, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-- 
2.25.1

