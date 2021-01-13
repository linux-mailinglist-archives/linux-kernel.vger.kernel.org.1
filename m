Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9E2F4DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbhAMOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbhAMOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1802C061347
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d26so2386288wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdRuSJvii4mKY/Efrp+W2ecV3k/kYMixGrJ5X2aYPPE=;
        b=h7CCOaMRu/KwDp4FkMru0iAXzhcqDT8Zgx3TFkmqeQ+lFmQabkd31QQ+lufeDRUy3X
         LtVPTgu8/Zqp1FSR8BAvO7dZtJzfFJCxlVtW1Nocwnb68P37FSE+be5cVVaNK5Tt8JCU
         9w0Ph8RfNh92LMTOPQay3rdqNK2k+J9YHe1s4Pc7Cfwul+RTcoi4Ud5EHifbnQv/CgAl
         HXLZdEt7o50147fxcADWLOPX90H4PF4f7epdHBvT72f7b/PpYAha9w6yexNN/IIcz2uN
         fnQb+ZapvvgV5yFNpXtWjyjgqG+ixxGtM9qn4DjB5lbBlmDCcef1Kbvt5M9KefOQMbJJ
         FfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdRuSJvii4mKY/Efrp+W2ecV3k/kYMixGrJ5X2aYPPE=;
        b=XJ4JqHMM8fDy4QB8hyostRpd0Cb1+ZVs70x1D5/4RejvHaRfIrRQROeA/DbzopoJOs
         XfXG3n5O2w0vaZLagWN5grBEddJLctmIKKJhV3wbasVEAR4zFft1V5GxenGEY6uyaRh4
         FBm7qFudZhbyGIXOPx8Kyk0bZPouJLkNDH0x1GP1aD8rKsxwdRFJm232ObDJ7tU6iCEv
         1E7ULc/uZNINvTVji+75BV0ycf20qpwxMsS6yNwRZIt3oZBFaWiD5WK/XhaEOWK2d96N
         RgZ4NpaPMOB7jJIqw+U8BzfgZBmysLhvNrjFgn5ixw8Y6otGVewAk0NWE6YMHWQ0fHIU
         85LA==
X-Gm-Message-State: AOAM531sv2OC4AS8yDCpsjjvoAHaJwndcDnZrUBMpCAA8xuUFgaCX9RP
        LDt4dFS7GuN70lbVIi9O3tP+9A==
X-Google-Smtp-Source: ABdhPJyuIlFTIENDUMPlw5lomJPJtWMdNwJG+DPzaqlFIAPWPUczY5LQd4LCs7FSNVgCvZWujNH+Hw==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr2937092wrw.379.1610549444578;
        Wed, 13 Jan 2021 06:50:44 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar90@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        James Simmons <jsimmons@infradead.org>,
        Paul Mundt <lethal@chaoticdreams.org>, Urs Ganse <ursg@uni.de>,
        Helge Deller <deller@gmx.de>, Alan Cox <alan@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 21/31] video: fbdev: sstfb: Mark 3 debug variables as __maybe_unused
Date:   Wed, 13 Jan 2021 14:49:59 +0000
Message-Id: <20210113145009.1272040-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only used if SST_DEBUG_FUNC is set.

Declare them under the same clause as their use.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/sstfb.c: In function ‘sst_detect_ics’:
 drivers/video/fbdev/sstfb.c:934:26: warning: variable ‘n_clk1_b’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sstfb.c:934:16: warning: variable ‘n_clk0_7’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sstfb.c:934:6: warning: variable ‘n_clk0_1’ set but not used [-Wunused-but-set-variable]

Cc: Alex Dewar <alex.dewar90@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ghozlane Toumi <gtoumi@laposte.net>
Cc: James Simmons <jsimmons@infradead.org>
Cc: Paul Mundt <lethal@chaoticdreams.org>
Cc: Urs Ganse <ursg@uni.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Alan Cox <alan@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index c05cdabeb11c2..b8813a0b63b1d 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -931,7 +931,7 @@ static int sst_detect_ics(struct fb_info *info)
 {
 	struct sstfb_par *par = info->par;
 	int m_clk0_1, m_clk0_7, m_clk1_b;
-	int n_clk0_1, n_clk0_7, n_clk1_b;
+	int __maybe_unused n_clk0_1, __maybe_unused n_clk0_7, __maybe_unused n_clk1_b;
 	int i;
 
 	for (i = 0; i<5; i++ ) {
-- 
2.25.1

