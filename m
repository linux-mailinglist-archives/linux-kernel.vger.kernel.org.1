Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82C2F4DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbhAMOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbhAMOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574CC06135A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g25so3770270wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvwJoM6XPaTXW+swhyuXIxTf/L820o0O05r3Nn2BahU=;
        b=nid9QSSJw0nnYpdBxWNfeDxySbsTdIoMqZnUcmEnH52+LjrzqEPdVxtuCSQU+wNDQp
         62FqX/weiPQySDiuQC9amofCPbG5004lDcrdnsnbkZYpzAuZJWvH09KtuoWBDRa2aWSO
         AocjLmQI+CLfzX2ZsW6YPb2EJJtPlz/GlBtg1LtWbQlVwwHB11QS8Mte86K91VCLTbrK
         fFJLvGRnloBApapS2VcH6Q1I7KdGDGhrjWmsEMB+WKoFpwYMTT3bIWKLWXdKJxr7Xn8w
         cAkIudEJcSr3GiCxwMMFUlqXuSrqw8ck0D0hkmDyZxfdnSB9sa3sIlBp8zjyERLJw0nR
         orsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvwJoM6XPaTXW+swhyuXIxTf/L820o0O05r3Nn2BahU=;
        b=mVOlT1DM+WtN7ctxbUn8Y3qAralnDZDuhNG2+jDL8OYMHFxEbNblZXj0Wm+a/0rqX/
         AX7OqTvJsPptb81hW6wjrwy7jrXlfn4A3PdC/BPIk8fQUrtgOq8V9u7Rce+RSoMxkxaM
         HlYQz06BPxPMw47/nY1N/aQk0qWGkbvoHrYP47dgSuhkVWTgbP0dzmvOTyiIquh/x5yg
         8c/GDTQBb70fDVYXBPcOcNNL7+sQfdLRpWywjGK12BxQO6pjfpBl4zXdLF+OZFUzggRz
         2P+iwSVa4AmwNjrlG+znp5qUbHjgyc/WSCUYTpUFMZSqbSZZf6JJT45ikF7weWlsICNZ
         KOzg==
X-Gm-Message-State: AOAM533QIoPUqyX4cYAnz3odU11gkGEBydmIb2jlHtCRrIxEvLhHpExI
        kBGt5x3Y7uGdcB6wdHvI/qdwFQ==
X-Google-Smtp-Source: ABdhPJxfLq1AkB7CSlngKBkLh9QrvLjSYsWJajt2KPoiRKEuRYNd2u3c5lDCPhIKbXF1gj4rQNYUUA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr2464833wml.160.1610549452072;
        Wed, 13 Jan 2021 06:50:52 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 27/31] video: fbdev: sis: init: Remove unused variables 'cr_data2', 'VT' and 'HT'
Date:   Wed, 13 Jan 2021 14:50:05 +0000
Message-Id: <20210113145009.1272040-28-lee.jones@linaro.org>
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

 drivers/video/fbdev/sis/init.c: In function ‘SiS_Generic_ConvertCRData’:
 drivers/video/fbdev/sis/init.c:3543:37: warning: variable ‘cr_data2’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sis/init.c:3542:39: warning: variable ‘VT’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sis/init.c:3541:39: warning: variable ‘HT’ set but not used [-Wunused-but-set-variable]

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/init.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index 4510272ad297a..b77ea1a8825a5 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -3538,16 +3538,13 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 			struct fb_var_screeninfo *var, bool writeres
 )
 {
-   unsigned short HRE, HBE, HRS, HDE, HT;
-   unsigned short VRE, VBE, VRS, VDE, VT;
-   unsigned char  sr_data, cr_data, cr_data2;
+   unsigned short HRE, HBE, HRS, HDE;
+   unsigned short VRE, VBE, VRS, VDE;
+   unsigned char  sr_data, cr_data;
    int            B, C, D, E, F, temp;
 
    sr_data = crdata[14];
 
-   /* Horizontal total */
-   HT =  crdata[0] | ((unsigned short)(sr_data & 0x03) << 8);
-
    /* Horizontal display enable end */
    HDE = crdata[1] | ((unsigned short)(sr_data & 0x0C) << 6);
    E = HDE + 1;
@@ -3584,12 +3581,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
    sr_data = crdata[13];
    cr_data = crdata[7];
 
-   /* Vertical total */
-   VT  = crdata[6] |
-	 ((unsigned short)(cr_data & 0x01) << 8) |
-	 ((unsigned short)(cr_data & 0x20) << 4) |
-	 ((unsigned short)(sr_data & 0x01) << 10);
-
    /* Vertical display enable end */
    VDE = crdata[10] |
 	 ((unsigned short)(cr_data & 0x02) << 7) |
@@ -3604,8 +3595,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 	 ((unsigned short)(sr_data & 0x08) << 7);
    F = VRS + 1 - E;
 
-   cr_data2 = (crdata[16] & 0x01) << 5;
-
    /* Vertical blank end */
    VBE = crdata[12] | ((unsigned short)(sr_data & 0x10) << 4);
    temp = VBE - ((E - 1) & 511);
-- 
2.25.1

