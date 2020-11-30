Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204022C869F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgK3OZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgK3OZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:25:27 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:24:47 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l1so6567384pld.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hUOAHLGzUxdK6sV4gYVVkCsQkx2wG1uqj+iBjzbcsE=;
        b=LHnyHvPFOIQYs4019+jQoRSwLda8bi2aGZE75+jc2/qV7fB+D6gEQ+/cIfA/fik/Av
         buQauHaHznIsQoTtGqX2Oc+uPYI2LKjO76utJT2e7TO5O+ZnMi2ZFV9e1L+a1zAKzO2t
         hvuvyNs3dbmrjgVi0W3cZ28bul43/gWVpLHDWqQeb5yjY8QfE36C3focoG5huGqo2qCh
         Kx59i1p60+m+11IxqulxAxuMIZxEHyLDQUckA1jLS00Ix4r2nXcyr5EECKqSNZ/m83gK
         w9zFFZPijoTm7OA8sWyx1Cdplkjn2T03KLkzsdVVoFI5PuBOMCMfS8xiiErfONxGiNGY
         aCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hUOAHLGzUxdK6sV4gYVVkCsQkx2wG1uqj+iBjzbcsE=;
        b=jfhdQ8yYjuBcxrDo71T3nFZdBBaGdBzIwFn2/H1Bvkxx0d4SYBHSUlWd58lCMbqCQn
         a60nBxWto2o78tX22DicdluOrmKJzYudEIyj1z+ycjkm/4hYX9wzp0ELTMzglRegtN4w
         jhOUVT9s64NhWHozdG4F8IjazjYgh1T9F/NxjRf66AzwRl25FeTJsqGV1qn8Kk1MMJSU
         VgvU67LsCYHZ0cE9ztsheutWxEA3UMZ2dJlEXQU2y2HnkkzQUpvNw48LYYI7Y8MSOCXA
         pxozl3sDvhHGljhH2hEwwilzTvOb8Ad1wo9I/fo6XG5Im+b8EemUjThFYsAiC5XjVkdT
         h4aQ==
X-Gm-Message-State: AOAM533pd3HA5F5P6gGoUZgZSeYbI5+lyId/JWn4j0SyzTkOaJooIRzF
        pgZhjNxVBsfPTVNLFOSpuPi3q3uOO+xwzA==
X-Google-Smtp-Source: ABdhPJwmleCHj5XhXL/YlPcmmM72w38q874vV0GVlQlGqk59AUGoA5adCr5IEK4y2j4chkjHIroOWw==
X-Received: by 2002:a17:90b:915:: with SMTP id bo21mr5073145pjb.66.1606746286328;
        Mon, 30 Nov 2020 06:24:46 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id x5sm6097486pjr.38.2020.11.30.06.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:24:45 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/mm/pti: Check unaligned address for pmd clone in pti_clone_pagetable()
Date:   Mon, 30 Nov 2020 23:25:15 +0800
Message-Id: <20201130152516.2387-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit 825d0b73cd752("x86/mm/pti: Handle unaligned address gracefully
in pti_clone_pagetable()") handles unaligned address well for unmapped
PUD/PMD etc. But unaligned address for pmd_large() or PTI_CLONE_PMD is also
needed to be aware.

For example, when pti_clone_pagetable(start, end, PTI_CLONE_PTE) is
called with @start=@pmd_aligned_addr+100*PAGE_SIZE,
@bug_addr=@pmd_aligned_addr+x*PMD_SIZE and  @end is larger than
@bug_addr+PMD_SIZE+PAGE_SIZE.

So @bug_addr is pmd aligned. If @bug_addr is mapped as large page
and @bug_addr+PMD_SIZE is not large page. It is easy to see that
[@bug_addr+PMD_SIZE, @bug_addr+PMD_SIZE+PAGE_SIZE) is not cloned.
(In the code, @addr=@bug_addr+100*PAGE_SIZE is handled as large page,
and is advanced to @bug_addr+100*PAGE_SIZE+PMD_SIZE which is not
large page mapped and 100 pages is skipped without cloned)

Similar for PTI_CLONE_PMD when @bug_addr+100*PAGE_SIZE+PMD_SIZE
is larger than @end even @bug_addr is not large page.
In the case several pages after @bug_addr+PMD_SIZE is not cloned.

We also use addr = round_up(addr+1, PAGE_SIZE) in another branch for
consistent coding without fixing anything since the addresses are
at least PAGE_ALIGNED.

No real bug is found, this patch is just for the sake of robustness.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/mm/pti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab92930569..a229320515da 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -374,7 +374,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 */
 			*target_pmd = *pmd;
 
-			addr += PMD_SIZE;
+			addr = round_up(addr + 1, PMD_SIZE);
 
 		} else if (level == PTI_CLONE_PTE) {
 
@@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			/* Clone the PTE */
 			*target_pte = *pte;
 
-			addr += PAGE_SIZE;
+			addr = round_up(addr + 1, PAGE_SIZE);
 
 		} else {
 			BUG();
-- 
2.19.1.6.gb485710b

