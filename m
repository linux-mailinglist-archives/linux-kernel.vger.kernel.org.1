Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A882FCB27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 07:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbhATGqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 01:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhATGpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:45:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF24C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 22:44:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so11996482plx.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 22:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TWepc0qUUHBH1P2vQBx4UfaAJ7xNlVte82F15tRR8Y=;
        b=GG37x5kbDGXnFyKzXLWASG8zpmQBzFfbtugNZdDzp7KSpFXF7toqZ+HJuBr3OlvWi2
         8OcD8krdl42T3gFOHcR4kJYf2csnzNYT0gDqYoMaEWmripGsI3W3vjVoMaVekIZWdvDy
         Zmjzl4b5HoviySaUXahFMA9ictwF0fA4k4ZqFtI+EDgiz+u5MiTVRWxsMLJIG24c9pvP
         FlbOSTy8fGIKD8wZvMZYrO+d767VGQHy4LLavxlNuolLGTXWfDZunB4RYwtbzM10t4eW
         V4qIuVeZ7VnImVXH1e5S8sDr88NsrCEKgqKkybn6XtvLDvurVmpDGazzqBR6Zu+hY91g
         Qcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TWepc0qUUHBH1P2vQBx4UfaAJ7xNlVte82F15tRR8Y=;
        b=NUA0tPfj6ReXhYUVD8LuCdbaUcHLDrUqyRtuCrFsOzypWrMN76xvVN8AKPW5XhPX6O
         uO2hCM0Qt0QOrP9pnHzoxjGriyXVO2pM0QIenILkeL4GY/FV8ctnAOO3M+VCkD8DVSFl
         /ZBlZfea2OfxF0nMn6EIEKMTCxzdECGZ2eRe3p+n5n4kTPgNVgDA6In50EuRv0VMRRFm
         PHJ1sT5ZXtBFyqTppsbJuSNVyW3ZTzlHDWMlHGHsDrvJU7aF7iuG1yOfEvJs7pBOkPR2
         95PSWyzXUS5eXoBjHUbmZej3Zgp5LHcGzsUMZLzJADYax2ZUVaP7v+QxDpRgJGM+OxbV
         naBQ==
X-Gm-Message-State: AOAM530kqlWv5ZWzQb/1RirYxabXHW1w88ful/s3JweJ5NSu0VllyxLT
        6/W2SXCKXPnWz84EQSr6414=
X-Google-Smtp-Source: ABdhPJyveqK5pZTUfXIVCa645cZeCsxZZGet4IghKKzdg3U47ybBZwCh8YCX5PyTWo4rZozFyyp6mg==
X-Received: by 2002:a17:902:9a03:b029:dc:31af:8dc2 with SMTP id v3-20020a1709029a03b02900dc31af8dc2mr8612512plp.39.1611125065489;
        Tue, 19 Jan 2021 22:44:25 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id s23sm1021177pgj.29.2021.01.19.22.44.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 22:44:24 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, yu-cheng.yu@intel.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        kan.liang@linux.intel.com, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] x86/fpu/xstate: calculate the number by sizeof and offsetof
Date:   Wed, 20 Jan 2021 14:44:15 +0800
Message-Id: <20210120064415.16977-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fpstate_sanitize_xstate(), use memset and offsetof instead of '= 0',
and use sizeof instead of a constant.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 arch/x86/kernel/fpu/xstate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5d8047441a0a..2e75630c86e9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -161,20 +161,16 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * FP is in init state
 	 */
 	if (!(xfeatures & XFEATURE_MASK_FP)) {
+		memset(fx, 0, offsetof(struct fxregs_state, mxcsr));
+		memset(fx->st_space, 0, sizeof(fx->st_space));
 		fx->cwd = 0x37f;
-		fx->swd = 0;
-		fx->twd = 0;
-		fx->fop = 0;
-		fx->rip = 0;
-		fx->rdp = 0;
-		memset(&fx->st_space[0], 0, 128);
 	}
 
 	/*
 	 * SSE is in init state
 	 */
 	if (!(xfeatures & XFEATURE_MASK_SSE))
-		memset(&fx->xmm_space[0], 0, 256);
+		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
 
 	/*
 	 * First two features are FPU and SSE, which above we handled
-- 
2.29.0

