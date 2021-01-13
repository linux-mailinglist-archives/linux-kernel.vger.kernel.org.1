Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81792F4DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbhAMOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbhAMOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F250EC061348
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y17so2387835wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoUfRt23bqbKPl1TGglCjWozG44qym29OpcwnZGK6kU=;
        b=DVx9RGOhwl5u8ldZy5VrfBB5nqUBSa6oCbOAtc/naAE4if9nM+qG1VzCKee+LVG+3B
         pYMHjLmmVhejEEkmBIU3VqOIbS0QbervpRSbvt8RbrJ65WI6sdAQJIFHQBuqYquGY9sm
         C0BoNNBF1vlcU19yuj0aroZuKk5XVtUWIzVX0dv3Fl5+wU5eXqndsETD1SuasAlFPapO
         Ndex26m6UwPr44hJ1bIN/A68qcXyyjbFTxYEWrG/wLv+f8ePNT5PGN0tbNcfIJ6tyYVQ
         66n2l1NmCju3l+XV3FxP/N8a/cWJvm9uSD3UZcReTj1OIqHd9zRtoKkjQOixv9hbaPDF
         TjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoUfRt23bqbKPl1TGglCjWozG44qym29OpcwnZGK6kU=;
        b=rbrkYrfOfHsqG9bwMxzeFWzOdmYbeGXS6viA5NlUXNwn7YmWV422lkI2SwKiYLoTTy
         9UlI5/cuWCbJBDtFNn7BUlAU0oxYSIpQUpQyjzLBZEHVYtlsjwF7uCYquHTABoP6WJhu
         zFgmLWTynU3wKLEBWO8TFzFnXGMSZ1zaeEJ5E1kkDPi7vxXRs2xNYim3HFgQ+PfDbo5w
         AZIVGpvMu4OeKzr1GqhOP3EBI7+senX+YVPEy8zwBMC9oESOJoKse/I9+wfMLSB/c7BZ
         47LB8b2oC6ljzl5YK9L2Aa2l0GXKZcWdAVEZoCP0kyxC20axNqPux9k5VgxdbovA1vO9
         6uSw==
X-Gm-Message-State: AOAM5329vgOVHopU93nfiG5yHQMR2I3FZ0EFHk+c8997AIosWPXLVTaR
        rVFi870mBtdW6MwDKjs2Ycuv+mnHt1jaGgDy
X-Google-Smtp-Source: ABdhPJzAZpIkSU3ZuxYWodWKq2E4apdvM/gowpmYALF9g0lHHwu0yWyxlERCrNd/IkX0NEsPk4cbEg==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr2897319wrw.371.1610549445789;
        Wed, 13 Jan 2021 06:50:45 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 22/31] video: fbdev: cirrusfb: Remove unused variable 'dummy' from 'WHDR()'
Date:   Wed, 13 Jan 2021 14:50:00 +0000
Message-Id: <20210113145009.1272040-23-lee.jones@linaro.org>
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

 drivers/video/fbdev/cirrusfb.c: In function ‘WHDR’:
 drivers/video/fbdev/cirrusfb.c:2466:16: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/cirrusfb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index e9027172c0f55..f05160fa34da9 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2463,8 +2463,6 @@ static void AttrOn(const struct cirrusfb_info *cinfo)
  */
 static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 {
-	unsigned char dummy;
-
 	if (is_laguna(cinfo))
 		return;
 	if (cinfo->btype == BT_PICASSO) {
@@ -2473,18 +2471,18 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 		WGen(cinfo, VGA_PEL_MSK, 0x00);
 		udelay(200);
 		/* next read dummy from pixel address (3c8) */
-		dummy = RGen(cinfo, VGA_PEL_IW);
+		RGen(cinfo, VGA_PEL_IW);
 		udelay(200);
 	}
 	/* now do the usual stuff to access the HDR */
 
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
 
 	WGen(cinfo, VGA_PEL_MSK, val);
@@ -2492,7 +2490,7 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 
 	if (cinfo->btype == BT_PICASSO) {
 		/* now first reset HDR access counter */
-		dummy = RGen(cinfo, VGA_PEL_IW);
+		RGen(cinfo, VGA_PEL_IW);
 		udelay(200);
 
 		/* and at the end, restore the mask value */
-- 
2.25.1

