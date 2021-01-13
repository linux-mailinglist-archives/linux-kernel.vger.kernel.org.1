Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42512F4DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbhAMOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbhAMOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D5C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k10so1838441wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZEx6Psm5kmVFzQRuV4hKShFUTuX59E1ZZSqS64lTO4=;
        b=qCaU5/PwjTYjtfnriB60Z9oLOr+vFl/C6eE9S2SqWRzje404GBkmpQhafug/AkVxOy
         cQQpoF2TPpvHLZ2G0WwI0m9I3+iSy5mECHxCRPxdVQEqbEaiQAKEQ21H2Puw7RerAiVE
         wFP15HZbbxQs2PH85CQiCco+76nv2mFTwq9YLxfrDpX1dbHfhcDj5xFdWbHJisbQiGp9
         gXFKfd2QUbQryXwNq3Wq2jJyOgsjiru7oncOJDfA+X11+HkluVlV1zwafJGTb/u8E2G8
         MRaYmLZI/XB7G9OUxyfbsMCiS30QwhZAVeTDBJWC+SfdIRLhSlZ+MEl7DCFddFc+gJo3
         s87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZEx6Psm5kmVFzQRuV4hKShFUTuX59E1ZZSqS64lTO4=;
        b=H0YFMbXJ/R88AhYGuRAFgaUWRDCQqz2ldy6O37Rfl6DO33RnATnBruBdOLLb1UV2Au
         epaY47FVzFxUI5vnPxkYSeWV84udZGvTXS/j2SOFqBPFUHQPW9u5cUtnaH9SLJqL/Uoi
         4NRCAqLl34t1oBdbJGFuBsfw3hD/oJh2eCngMnxcCTGggwXEC4KZGz/98hffTgUuPyYi
         /xGPcm9vNUPaE3vPo0mjAFVYvdLaGkFUr/mipUXl2mjX4J39N6Bhi9r/B+a4nOMMYtAf
         +FqPtgbKhT0r9dr3wWdD/QvnTIOkwl+UYkG5i1pPKSwxxuce/FnpPrDHNGWaEAo4yy1/
         L0Hw==
X-Gm-Message-State: AOAM533H3T5ax0yu6EZqEXSloBDealP2lINtxqjRNrk6GQYD9yMRfe6y
        5WMYMnlKgcwEruZojRorVmLBSA==
X-Google-Smtp-Source: ABdhPJzXGlHjQWCGWlwH0MsHBEeXn1e8tUGwLxoT/K65Pbdak+HaHN+93bMx8dcQNJlERhqlDPiH6w==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr2609520wma.0.1610549437515;
        Wed, 13 Jan 2021 06:50:37 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/31] video: fbdev: via: lcd: Remove unused variable 'mode_crt_table'
Date:   Wed, 13 Jan 2021 14:49:53 +0000
Message-Id: <20210113145009.1272040-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/via/lcd.c: In function ‘viafb_lcd_set_mode’:
 drivers/video/fbdev/via/lcd.c:540:29: warning: variable ‘mode_crt_table’ set but not used [-Wunused-but-set-variable]

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/via/lcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd.c
index 4a869402d120d..088b962076b51 100644
--- a/drivers/video/fbdev/via/lcd.c
+++ b/drivers/video/fbdev/via/lcd.c
@@ -537,11 +537,9 @@ void viafb_lcd_set_mode(const struct fb_var_screeninfo *var, u16 cxres,
 	u32 clock;
 	struct via_display_timing timing;
 	struct fb_var_screeninfo panel_var;
-	const struct fb_videomode *mode_crt_table, *panel_crt_table;
+	const struct fb_videomode *panel_crt_table;
 
 	DEBUG_MSG(KERN_INFO "viafb_lcd_set_mode!!\n");
-	/* Get mode table */
-	mode_crt_table = viafb_get_best_mode(set_hres, set_vres, 60);
 	/* Get panel table Pointer */
 	panel_crt_table = viafb_get_best_mode(panel_hres, panel_vres, 60);
 	viafb_fill_var_timing_info(&panel_var, panel_crt_table);
-- 
2.25.1

