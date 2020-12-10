Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4490E2D5BED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbgLJNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389134AbgLJNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:35:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB5C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:35:01 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id c12so3747766pgm.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhXrinmLEXRQUYb3doNOOPr4PxGlZZX5GJxHDUGJlzU=;
        b=rD9wmPQYHU3pkYZfUPWHAsToEts6yQ+rMnVgN90FSNeLnBmM/6+L7pnZ5mlSm6qaV2
         MCJPwrBzV2Q/P7Ow7uMGFKianL4z8+BFkMygxGW/WFUQxUUQEz8Kt896RJMEw1l7qA0D
         10q/6fAsrID+RtKmF1gX+ZKMIs7S6Pj3y3egI+cnlTeKk290LDgiWUk4FdUpvskRi4BK
         gaM679bqM7lMXX7fqnU6qdvhRpwyHbycz4INKkJwjl54XRkYg5UgKzUiZ9JUmAs/JMf6
         bmwdnjdMdgaZuhf04KMbgGx+FfpKEt+BiQ9WhCvsq7ywo1JskKNwr4H8GF05GbXEwoKu
         1yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhXrinmLEXRQUYb3doNOOPr4PxGlZZX5GJxHDUGJlzU=;
        b=lJeRI13+eZ3j/5e2mTfQsFMCE/mXYmVcV9x+ZKKhyX/9FXQU14su4bKPX93/o38NpL
         zMazLgbvs9OlqBFee2ydDJ993WY7N2CNleMHgj+DQiQ3FIWfn718xQs5O+pyK1z0HkCK
         NGmZRNaZC5Iscp1YAOFguHdeINaPGIm040JDvN8KdWBam7Ql5LLIHN2HR0nQ20rR1nfo
         etwIVJsiiYDKgVLewBuSyd6jGdGK9fLUX873LaER9HrmRV4yBjcyb1NHVpk2EBqA/vP/
         2lZJSlW4fUykRkqWBX9zyHKXgEI8IZ7Q0aNwy+z4STBla3JN10P8u14jhhVCaVo7U4Zq
         hmXg==
X-Gm-Message-State: AOAM531vQSFhXPiJhaQYfhkYbN6viFAanOBLhWm/Mlkc/buRIa221szd
        4bcwu+0bKcLWrJg0SosUswJ63L7RW2U=
X-Google-Smtp-Source: ABdhPJzd7pCdj39Z+nubJ+3UAacSSsRCmi78oei3Y4/mJTJZIBFh9KVcpPQrJubRwFTt/4LftMSL1g==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr7404472pjn.27.1607607300709;
        Thu, 10 Dec 2020 05:35:00 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id s5sm6537606pfh.5.2020.12.10.05.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 05:35:00 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 3/3] x86/mm/pti: warn and stop when pti_clone_pagetable() is on 1G page
Date:   Thu, 10 Dec 2020 22:35:26 +0800
Message-Id: <20201210143527.2398-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201210143527.2398-1-jiangshanlai@gmail.com>
References: <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com>
 <20201210143527.2398-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Right now, we only clone parts of the kernel image and the cpu entry area.
The cpu entry area would be insane to map with 1G pages since it maps so
many different kinds of pages and has *small* mappings.

For the kernel image to have a 1GB area with uniform permissions seems
pretty far away to practice.  It would be en even more remote possibility
that a large swath of it would need to be cloned for PTI.  Kernel text
with a non-PCID system is probably as close as we would get.  I'm also
not even sure we have the code to create 1GB mappings for parts of the
image.

In other words, no caller calls pti_clone_pagetable() on range that
includes pud large page(1G) by now. If it were called in such case,
there would be bugs in the caller side or other places, so it worths
a warning for robustness.

We also add check for pgd_large() & p4d_large() with the same reason,
and pgd_large() & p4d_large() are constant 0 which just acts as the
self-comment in code without any overhead.

[ Many thanks to Dave Hansen for more elaborated changelog ]

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/mm/pti.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index cd6da1d42ba9..e8d2df072c5c 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -321,10 +321,10 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			break;
 
 		pgd = pgd_offset_k(addr);
-		if (WARN_ON(pgd_none(*pgd)))
+		if (WARN_ON(pgd_none(*pgd) || pgd_large(*pgd)))
 			return;
 		p4d = p4d_offset(pgd, addr);
-		if (WARN_ON(p4d_none(*p4d)))
+		if (WARN_ON(p4d_none(*p4d) || p4d_large(*p4d)))
 			return;
 
 		pud = pud_offset(p4d, addr);
@@ -333,6 +333,8 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			addr = round_up(addr + 1, PUD_SIZE);
 			continue;
 		}
+		if (WARN_ON(pud_large(*pud)))
+			return;
 
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
-- 
2.19.1.6.gb485710b

