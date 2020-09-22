Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2274273D59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIVIdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgIVIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:33:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:33:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so11758434pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=flgzfKyTcrJRrSnxciVz6vxo2TGF774YujpE4tgYeJw=;
        b=juO0C0kAsBah7Hme7SMZ+bxAI4v2xYs2ekw/vaQejxgfFZcC2cHaWrTQUjR+6ad/W5
         u1Q8hYK5UHcXLz8fitkfyic8sAs5sCX5tbP3c+KlTcOnCcppo04NNLKqIn2tR5H9HANg
         8obLjThO5iETkXPy6xgtZJrWnXVOu13uGY00vfnHBNuI7RRHOHB/61LqOgqwliWGJGpp
         NUpe8pousZSouA8mXIZrsmsae0gzVoogb50ia9E8HA31PYagddY9+CypR3TTV7qIuksN
         De+aRgf6OtDby7zO5fJw3gWoEb0DJ2Nl1McBCxdegNgpMIeRvgowLJlA7FMFo91thfV+
         scRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=flgzfKyTcrJRrSnxciVz6vxo2TGF774YujpE4tgYeJw=;
        b=TOBcb85+7oxBTjVUEU3NhTXkIuwBK6bkL6nt7DcQEue868aEJ13qXjT/pXktlPAz4c
         ynMxaHFMba2Wdsb0yf52oFNnrwuVG/aqPCR0No9vgl8FjWptEPhEhsqg+SqgJ7DUP50a
         2Fp+z92vwMWTLvh2j5jmWQvHEBQoigHZzeske4O7xwu2/oZ1FrxL0Lx1YE65zWPlZIpC
         GreWhZWtPcjl9ZB+rNDglS9sEVuXPnPYB2YaonmqwCZDB8FwYdwFAda85viRI6FnVAdh
         uTrGlcKUqdDuS0LucFxWuTQjQlyi2XMR58y6pPER/62zcQPGxiXqgZuslZpI0fMiWVZv
         7bMw==
X-Gm-Message-State: AOAM530f5ZtQF/jEOV8NBE5xq2RBUJ7+vXZRr/+wrEFu+MbK5askCo4z
        y3LZV6Y077mc27h3hdr452k=
X-Google-Smtp-Source: ABdhPJzk89smF3UcQ8ZS8r7TNzAYXrcr86Si6mAkhGwKClWWc+d53s8nsHiYFqU1FCwaXBfOstzTnQ==
X-Received: by 2002:a17:902:8e83:b029:d2:41d3:94e9 with SMTP id bg3-20020a1709028e83b02900d241d394e9mr1417884plb.75.1600763615757;
        Tue, 22 Sep 2020 01:33:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.63])
        by smtp.gmail.com with ESMTPSA id q15sm4503086pgr.27.2020.09.22.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 01:33:35 -0700 (PDT)
From:   yuleixzhang <yulei.kernel@gmail.com>
X-Google-Original-From: yuleixzhang <yuleixzhang@tencent.com>
To:     akpm@linux-foundation.org, willy@infradead.org, ziy@nvidia.com
Cc:     linux-kernel@vger.kernel.org, kernellwp@gmail.com,
        yuleixzhang <yuleixzhang@tencent.com>
Subject: [PATCH] mm:cleanup mincore_huge_pmd
Date:   Tue, 22 Sep 2020 16:34:23 +0800
Message-Id: <20200922083423.15074-1-yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mincore_huge_pmd() was dropped, remove the declaration from
the head file huge_mm.h.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/huge_mm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 8a8bc46a2432..0365aa97f8e7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -38,9 +38,6 @@ extern int zap_huge_pmd(struct mmu_gather *tlb,
 extern int zap_huge_pud(struct mmu_gather *tlb,
 			struct vm_area_struct *vma,
 			pud_t *pud, unsigned long addr);
-extern int mincore_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-			unsigned long addr, unsigned long end,
-			unsigned char *vec);
 extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			 unsigned long new_addr,
 			 pmd_t *old_pmd, pmd_t *new_pmd);
-- 
2.17.1

