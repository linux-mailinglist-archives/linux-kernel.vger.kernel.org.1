Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B204E3039EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbhAZKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbhAYTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:20:09 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C49C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:29 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id j13so1381399qvu.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rWpWL/DRiZPfCy8fAJD8ErDuDMoAsKZLcMwbx3gozjY=;
        b=NZ5XxFttV3baXG5fjW/ZpaC7LBvDpicX5uySrcQVbyy1c18h0xyqlMmWuyCRowKzIL
         3e33S4LCQP2unKI4CIWKN0KSN5UOTN71ef3uB9naUZwGHi6huRuILd95UDOOciWb/aN8
         ULr8BmGlF99/Ts9F6CX+/Hl3EWpBrY4QuAZIvNHgadEQ7LrCErmysGI0hmBvGVKLOvww
         uaYh2RRy2tdHXfkNRSNPuja7VlZtWq13bIgkwLZe/uCR9EKKqC52TRzHPnJeGklcyVz4
         aNd3+2sBb1fkTBenfwdJob3WSuHRrYk21+XJDoA0CWQJZBnq2vPRu1wy+jEOG6/FSzt0
         YQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWpWL/DRiZPfCy8fAJD8ErDuDMoAsKZLcMwbx3gozjY=;
        b=ULr5CW8oUn9hMd98npwSj/OhAOmbq0hITkEb+jxpjBCcLmvMmYRyQsD0+u4Z+g/7aU
         QA/IZPTfJA8zvWyfLyXwk/w6v8gsxsEx7nNw9Vy72blo6vLXnPTZWzQS2Mlfra7jhD1e
         SQ6bAyVeBH9AcUBUyaapNk56RubQCylWTsvp8kzdDNc8JYjPSSu6HdA4MIw+C/H2WFv+
         qsaSRZmFvPALspbkrJ7bzNAflykkfE6Z9t+poV5uB7qYKu7JjxCkzfGHetgVpQrC74+O
         YZPeUmrFW4a+inI2ZxC5rPP4j/0hOocNvyA43RJ1np9vEM6EQOaTHl8fOyvIoDMyvxPv
         Ut0w==
X-Gm-Message-State: AOAM531Vt2wW8obyiirgTPSEsl30vRgCXl3h/iJxAlOfEOjEI16RdVKI
        CYGQuy7M1BUBbjyHKaKGKJS8qQ==
X-Google-Smtp-Source: ABdhPJwtUDo/AEU+wN44OEcc7AdxoOnqTZ02B3zhpDKqDqRd5gONz17nKuvw43h6SxCW1YGZ7BgVUQ==
X-Received: by 2002:ad4:4e86:: with SMTP id dy6mr2312415qvb.4.1611602368593;
        Mon, 25 Jan 2021 11:19:28 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:28 -0800 (PST)
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
Subject: [PATCH v10 02/18] arm64: hibernate: variable pudp is used instead of pd4dp
Date:   Mon, 25 Jan 2021 14:19:07 -0500
Message-Id: <20210125191923.1060122-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be p4dp used when p4d page is allocated.
This is not a functional issue, but for the logical correctness this
should be fixed.

Fixes: e9f6376858b9 ("arm64: add support for folded p4d page tables")
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9c9f47e9f7f4..0a54d81c90f9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -190,10 +190,10 @@ static int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
 
 	pgdp = pgd_offset_pgd(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pudp)
+		p4dp = (void *)get_safe_page(GFP_ATOMIC);
+		if (!pgdp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
+		pgd_populate(&init_mm, pgdp, p4dp);
 	}
 
 	p4dp = p4d_offset(pgdp, dst_addr);
-- 
2.25.1

