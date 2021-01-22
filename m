Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D92FFD43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhAVHUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbhAVHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:20:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBCC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:19:35 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so2682888plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7lBR1mHhZ3G4t7qjjOaFVjXbCVtxGkQJSA5/5KPakg=;
        b=TzUPAiRx99clP3du9v9fy8wRLPLpZ7tLJxBjBDeC5JmBY3PDbpDo3jMInRw8ccRm5x
         evrasNPzG3FrbsKnXDK9S5QeK/ks5ypu/Ml/FoUnH3H7tNtPdct7btWwZL0d2jFV2RpW
         3oKU6ahYWrVv6PH5g4k1dnC0GrwQhPL+dDPoy/g/knF81RkD5uV1WYDZ3G72h5HQFkMl
         xhYzxHS2j94b2Ofjv7zygJ2NXRUM28T4BSz9vEiH2MBr1/CxC8rVrmtYHCTNfQCqVuxt
         5xmZstGYVpSEOcQjgR1kWsdrXVrwm8bFNPNEnPS686Pc7YMmFVa8PCFhakxpeM49UeQz
         A6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7lBR1mHhZ3G4t7qjjOaFVjXbCVtxGkQJSA5/5KPakg=;
        b=NSuN4cWufl7ffRbAvhD2DXVnWaDsoSRYUjm3ymKnaFqJHCbbI6mTruaurc+oUTMXOg
         7DSJZ+DysLPgk/FwIjovCG5vO83d0gQ7fOIpdQcArsCIhwmEanqG8QD8zc5GBer4GiWJ
         vgefjTFoI9nrWHok7Ro5r3G0vBIJgqHyy29jMPLrwjcvVR80LlwZoh+pAe0KExJ6+tpg
         BCUTHvPqxYwZE5L9xmusPBA4Zpbp/eBukB3FECicWWeqcPJJ/lrSAiuAwgZBXwhzC7cP
         lnoOWtktPkY+bZTV3ouBBweGnfZ9w7PJdXH/+dOFS8KFnGrkgcqXKHSoSd1ncmBnWxIX
         IRHg==
X-Gm-Message-State: AOAM533lC01sHbO37+FJ3EJnxxlttfFtE0G8L4vrDtGqfYE8xK6iMRQz
        wzArXyZs5DzWkS8fzLcZ62W73SsgXPRDT0UP
X-Google-Smtp-Source: ABdhPJw2k7eX11odeDz1QhYWgaaFfE7rkcePqQdAumc9xnCPr3ba8G71bxTLBWuNiqiXKZqQXoXx9Q==
X-Received: by 2002:a17:90b:d92:: with SMTP id bg18mr3758919pjb.66.1611299975278;
        Thu, 21 Jan 2021 23:19:35 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id 11sm7852260pgz.22.2021.01.21.23.19.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 23:19:34 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, yu-cheng.yu@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com,
        kan.liang@linux.intel.com, viro@zeniv.linux.org.uk,
        kevinb@redhat.com
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] x86/fpu/xstate: Use sizeof() instead of a constant
Date:   Fri, 22 Jan 2021 15:19:25 +0800
Message-Id: <20210122071925.41285-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fpstate_sanitize_xstate(), use sizeof() instead of a constant,
at the same time, remove & and [0].

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5d8047441a0a..683749b80ae2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -167,14 +167,14 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 		fx->fop = 0;
 		fx->rip = 0;
 		fx->rdp = 0;
-		memset(&fx->st_space[0], 0, 128);
+		memset(fx->st_space, 0, sizeof(fx->st_space));
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

