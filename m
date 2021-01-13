Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6D2F4DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhAMOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbhAMOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66240C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d26so2384665wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvE9T1Sdi1RAuyfyFAKYPhv+PIZJRg/gdw+xAA12HNM=;
        b=U7XZpCynbw9Y5AThFO42Dm2JoFqWJsr9KG6TgiBESTQlNc3fAWqvrv/vV8/bWuW37L
         5Fjmhghbx5eL6EY4Moqeeu/yko+J0D69QRMZW6dhXQ+Nm9vDb4yEtKNNPUG+swW/GUbD
         nAaRi2O/qE3tCVsaODzksTZRhF5TfWSJtIznTgVmbKSYSnmBQqobEUxuFMK2YTYRo0L7
         5w6ysuaaYARhRutz78Bmdnh6Kc8gc9Z/V8eH/apGCKxMK7Ke/jwJuBK4NTtqahNEJg7W
         TA2E0XY8ZoQAjFera38Ev01dBrJEDrnnCeyVsmeOs34OMOGtHvVAEe9zC9dc+VdMb3Ui
         iGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvE9T1Sdi1RAuyfyFAKYPhv+PIZJRg/gdw+xAA12HNM=;
        b=QGCkYVj4vxVeNPrLGyx92AZl91kN7YebpPFn7J88zngl3aDMkDekYPNBMBt/hbzaNQ
         XH2/tKGHyDXcAi68u0V9+MmbfY48q20c3I43sOLMToOkfqt7exrkTe8P4w3voj5WHEb7
         oWO7j0ljiO7KoxcdVDh4TOI7VVwT9Ul0DncUKuR0K3L5yWHf4YqnTPtEZ/X2CJgpx1sM
         dErNjdmnaz5vMu66MRXu0YSP9JHc82OwHWDIdmqq18emspw2UijVJkzsTR8MldFECQdV
         h7YXkH4TpR1PFDDgF2eEwrKEoZQe60GRHb+6Q6QEh7Y744dGwYSOZ+A5TEqb0w1Obeem
         bnRQ==
X-Gm-Message-State: AOAM530JhRhPhSM5WSQdGmc6ScL4f00QEZp/MOjLSSCxpLPAYBnnbojN
        qOvlds+o9Iiq42zUKN/7YrT2WQ==
X-Google-Smtp-Source: ABdhPJw8rEyi0DM19K9SdWt8OAokANJ3aIc/AvHlDFnh4GZL9+DaYT3IWFB1YtzXdbd84j6vPII+bw==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr3187110wro.244.1610549419211;
        Wed, 13 Jan 2021 06:50:19 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Alex Kern <alex.kern@gmx.de>, "Eddie C. Dost" <ecd@skynet.be>,
        Anthony Tong <atong@uiuc.edu>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 04/31] video: fbdev: aty: atyfb_base: Mark 'dac_type' as __maybe_unused
Date:   Wed, 13 Jan 2021 14:49:42 +0000
Message-Id: <20210113145009.1272040-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dac_type' is only used in the '#ifdef CONFIG_ATARI' clause.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/aty/atyfb_base.c: In function ‘aty_init’:
 drivers/video/fbdev/aty/atyfb_base.c:2363:6: warning: variable ‘dac_type’ set but not used [-Wunused-but-set-variable]

Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Alex Kern <alex.kern@gmx.de>
Cc: "Eddie C. Dost" <ecd@skynet.be>
Cc: Anthony Tong <atong@uiuc.edu>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 11c328f0585ce..9b056b49f2807 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2360,7 +2360,7 @@ static int aty_init(struct fb_info *info)
 #ifdef CONFIG_FB_ATY_GX
 	if (!M64_HAS(INTEGRATED)) {
 		u32 stat0;
-		u8 dac_type, dac_subtype, clk_type;
+		u8 __maybe_unused dac_type, dac_subtype, clk_type;
 		stat0 = aty_ld_le32(CNFG_STAT0, par);
 		par->bus_type = (stat0 >> 0) & 0x07;
 		par->ram_type = (stat0 >> 3) & 0x07;
-- 
2.25.1

