Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0A2D5C04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbgLJNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389202AbgLJNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:35:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31751C061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:34:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c79so4087369pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HrlhwzfucDR5qxXO2ofJVJSibF38U2PTF5Ks906fNI=;
        b=uvRdxVVH0Jn2OFl15gJ0xy24S5BzZLKBz927cLMs9s54NYsvV/2ZBHsNfDYfl/kNOW
         wBjEqldB41IrSkHvZGag4Ic8b6R+PPEFuAcZSuWv/IP/5UwiZCzspuEm2tHWJDDUsv8/
         D6PkBwt1Qumn6cncLCU9kXYmL4nDE90KK9/Lq8YoPVJvxQHaoHYib0oy8YVga+eXEujF
         SarHxT0z7/PC5e7LtawyeZv8lkiE8/S0OiPJbzj3z+uoY4kkK15VKIe8ywYlv9qwyoxK
         9A7oCPgk/8hLXLOtYu/d4rKBANEu/mDwB79wzilPsVwhBNVkkWIw6qU6TqDf0S/fVZj/
         XoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HrlhwzfucDR5qxXO2ofJVJSibF38U2PTF5Ks906fNI=;
        b=aPhtEYuxbwGydE/KWkCxuwXzro7ZeFfTlXnd2yt1r4oWJnOWhtMDkz/E4JD12zgD+b
         Dxb3PrPh2UaBzC9acTH4twTdcEh6vGu1Ab/vIwiMb4oM5MgDLW1d5ATAWrcmIayfigGF
         Ix5m6Fj2JzWk32ZILXhPSDbWeyzE2S3VnQcSu3F8ldJxitWZQ+xjMoKXDIz8a6XAd6hK
         AaG1A8dLTCFwdx/2N/g59nEaZB8ItP0UJfaNnqVXMDM+9KYVIYw43bfJbSlFkwMzKSA3
         pjxkXjSrQrJjVS2bNrbxxlioD7pBRncSbnL32yk3jmJjl+BVve7WSSfamfCEUILpgfaq
         ptQw==
X-Gm-Message-State: AOAM530wGNzy3wtFqKRwaBj1Pk3lFfVgs/tcI/gswA5wMjvwLC++DW6n
        +C4+mobykQy6nBJnfwyHLlM5DkyqC9g=
X-Google-Smtp-Source: ABdhPJzMm+OgU3qicDGAlNqziGHS1i378IvGjqc0G7Awu9zieojHc1fftdyHhT03covgFyfDCeyuHw==
X-Received: by 2002:a17:90b:1894:: with SMTP id mn20mr7607608pjb.100.1607607293630;
        Thu, 10 Dec 2020 05:34:53 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id c6sm6548727pgl.38.2020.12.10.05.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 05:34:53 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 1/3] x86/mm/pti: handle unaligned address for pmd clone in pti_clone_pagetable()
Date:   Thu, 10 Dec 2020 22:35:24 +0800
Message-Id: <20201210143527.2398-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com>
References: <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit 825d0b73cd752("x86/mm/pti: Handle unaligned address gracefully
in pti_clone_pagetable()") handles unaligned address well for unmapped
PUD/PMD etc. But unaligned address for mapped pmd also needs to
be aware.

For mapped pmd, if @addr is not aligned to PMD_SIZE, the next pmd
(PTI_CLONE_PMD or the next pmd is large) or the last ptes (PTI_CLONE_PTE)
in the next pmd will not be cloned when @end < @addr + PMD_SIZE in the
current logic in the code.

It is not a good idea to force alignment in the caller due to one of
the cases (see the comments in the code), so it just handles the alignment
in pti_clone_pagetable().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/mm/pti.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab92930569..7ee99ef13a99 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -342,6 +342,21 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 		}
 
 		if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
+			/*
+			 * pti_clone_kernel_text() might be called with
+			 * @start not aligned to PMD_SIZE. We need to make
+			 * it aligned, otherwise the next pmd or last ptes
+			 * are not cloned when @end < @addr + PMD_SIZE.
+			 *
+			 * We can't force pti_clone_kernel_text() to align
+			 * the @addr to PMD_SIZE when level == PTI_CLONE_PTE.
+			 * But the problem can still possible exist when the
+			 * first pmd is large. And it is not a good idea to
+			 * check whether the first pmd is large or not in the
+			 * caller, so we just simply align it here.
+			 */
+			addr = round_down(addr, PMD_SIZE);
+
 			target_pmd = pti_user_pagetable_walk_pmd(addr);
 			if (WARN_ON(!target_pmd))
 				return;
-- 
2.19.1.6.gb485710b

