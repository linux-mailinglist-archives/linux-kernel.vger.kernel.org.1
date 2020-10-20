Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8B2936F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392106AbgJTIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJTIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:44:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D10C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:44:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v22so441296ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npY3XpZ1WJkzBlC4QeIItPlhppwYJDvN6wAnSiJqkk4=;
        b=d5KRK+lAAduNlPfivlmVntV0dRiwGVstNHD1SoFQZHyAOFWdms/0ESHmFRguL1oZUm
         r+6bsMs2s4+1J5By+h70CKYpgUOxZjJ7Sut+HyUehkBqzQ28jeVk44gTMPvxWONy+Bdy
         xLah6x21WHRc3sYeE2hXGEmHGfMwZurhJuz6fpoeWY7t+1JZ2eg8K8fVU2ugcYlNyS/D
         gHCNKqnmSvcK7Tm38y4xjmy6EX4Ouv1L8LfkcF/OFoxSYIMkkYemAxLeXUrjX4r/VGbp
         LeRdyoSoCWGPi4w8coabO6F1a9Am6Ul6rdMd4VKa8YRwzh+oOBPYf/eyb6nsgAfkMDBT
         6Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npY3XpZ1WJkzBlC4QeIItPlhppwYJDvN6wAnSiJqkk4=;
        b=d8MkS5icow1brvHq1xrmFlTFupmtRyGTqr86fn/7S2fsh9/0SUyrwSHiCb/dq814SY
         1aKEUUxQpcOvMGdy02gozGUipKCLiQPQyf2KfsfjgPzsxT17Pvmog7FwHoomxBOv1bGI
         IwUJxPAHSZDv6kJErSq3Uj63EY5b2vUWobMjPjKH1nSPqcvJdL/7IQEy2EjKqnppaR26
         oxc9t7mChfnvrWcsVlVfWHfvKEhsD7K+wMWb+J6PsBMhw/0l2nuZLw2cK25BxJgHcjQV
         n99bmH7S+RZwIGHV5Ys+jclEeC0e0PGMeMXyytqOhcsXRV5Yo4LGcOuW/L/TsRCyz0pk
         WW9g==
X-Gm-Message-State: AOAM532QimLcD3uhIn/Tgp4m3/Mmr+zKUouzGG28YC3Oz2Qfp36mrgMb
        Ik8UlUmpIbnMM/jfPbIuTa4=
X-Google-Smtp-Source: ABdhPJy0KshjnIva7Meea2Ko5m0iAPPCsedajlu8jwqMHPL+ziWAx64CDJM9j0yWa1K0yNDQIx/SDw==
X-Received: by 2002:a17:90a:678a:: with SMTP id o10mr1902383pjj.180.1603183482568;
        Tue, 20 Oct 2020 01:44:42 -0700 (PDT)
Received: from localhost.localdomain ([117.246.150.152])
        by smtp.googlemail.com with ESMTPSA id y15sm1241581pjt.41.2020.10.20.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 01:44:41 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     dmugil2000@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH] x86/mm/kmmio: correctly handle kzalloc return
Date:   Tue, 20 Oct 2020 14:13:44 +0530
Message-Id: <20201020084345.96823-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing return value -1 to error code

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 arch/x86/mm/kmmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index be020a7bc414..15430520c232 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -386,7 +386,7 @@ static int add_kmmio_fault_page(unsigned long addr)
 
 	f = kzalloc(sizeof(*f), GFP_ATOMIC);
 	if (!f)
-		return -1;
+		return -ENOMEN;
 
 	f->count = 1;
 	f->addr = addr;
-- 
2.25.1

