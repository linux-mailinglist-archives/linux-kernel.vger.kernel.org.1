Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E962C86A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgK3OZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3OZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:25:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD0C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:24:56 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x24so10495319pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4y0SgFg0JafOcbviW2ZmbiP/K/Rj5Utx/rAGeZ6TRw=;
        b=P5uCkdcbYLEcOB8p+BUm7TKLx0CWqs2V7Up8qa61b5RDf2AXOuWOd4DzX5/evqDntV
         VvpBWCGYR1EKCJBl2HL1SXcyLXs86dBVPa3GXKcM/9hMxQcq60hsEVwWxOre5YxCzkoA
         t7Tru5VR7Zxk0ysKJWSbo+3W0JmoGUHy0C1oNIENlr7gcg2Rrz8iKaZNBR2LjbFPycD0
         t4HJHTD4zHe5/QEfGGcwVyTEPL+B5OAaCAu3u0cihEoBkLfBzmB41wCexyhU0S/6sl6h
         8mtJekY7Hm/zS1PiM14NBw1ZdfujIMzbLj2kQq/l2DJbtH2vRu1HqUNEP6/N0ezVGdbT
         6t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4y0SgFg0JafOcbviW2ZmbiP/K/Rj5Utx/rAGeZ6TRw=;
        b=JiCelXCaFlecb0MSKtJmcnnR+OK5brf3LEVM1IjIGSC3a+zDpEZ6dEu37COUBAGI8d
         jPnDkLSWT8EptV2vuSnn/UG39NxzCtg2NQr5cz7g/3i4EXNJc9WKAELFqwajF2FF1n6M
         I4n8dK5+cOZ5uLi58wyVGMEwkOyWcgGWofdFmtE31qGds/nxXE6Z0Rl2i/WYMeLY+7pz
         rIdQHICy3TEgcEAb5Vg7h9OdgJy0PVBtvKIkhGf8VLlEeAOk8b7tQMi8g8DNOd8uQuLZ
         2jB6LdZhCvVMuHZ4q3juUh4Z3pIaQjKpjZTWFjYDNM3W7uj13Wsda7uWTexqbz6tMwzF
         tMyQ==
X-Gm-Message-State: AOAM532NdP6BG37dxKQXhG1cEL+K7dhoV/GzEiWUkx5D8TKFYNsQ76eq
        du/2TIcjXGEQFm1ItWFxFoS0p0pHBEWSng==
X-Google-Smtp-Source: ABdhPJztfeF2aky5zM9n8XLYO3OnMIYEBK0eYQoirWuz9cnJMB4BxRvSdea6H9yjQgLF8HDyEUA1Og==
X-Received: by 2002:a62:8685:0:b029:197:f766:b135 with SMTP id x127-20020a6286850000b0290197f766b135mr19508522pfd.0.1606746295378;
        Mon, 30 Nov 2020 06:24:55 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id r11sm1884672pgn.26.2020.11.30.06.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:24:54 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/mm/pti: warn and stop when pti_clone_pagetable() is on 1G page
Date:   Mon, 30 Nov 2020 23:25:16 +0800
Message-Id: <20201130152516.2387-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201130152516.2387-1-jiangshanlai@gmail.com>
References: <20201130152516.2387-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

All callers don't call pti_clone_pagetable() on range that
includes pud large page(1G). If it were called in such
case, there would be bugs in the caller size, so it worth
a warning for robustness.

Also add check for pgd_large() & p4d_large() with the same
reason, and pgd_large() & p4d_large() are constant 0 which
just acts as self-comment in code without overhead.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/mm/pti.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a229320515da..89366fec956b 100644
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

