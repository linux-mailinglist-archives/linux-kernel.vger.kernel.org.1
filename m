Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960DD263DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgIJHDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgIJHAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:00:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13AC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so4606216wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce/xQKtB6h18AIsA1S/vHOwsBOtcRFWUAHoCEtAF9MI=;
        b=Bykaar4y+OM56UQs41qd+HfFRBUKI2PbUH/c2CRXCxsuJjuxK9RLw25jDs+wUJM5F7
         8u3vrIp+saNA2o2D2s2c5DZd9t/EzbKpkmYlzxjiIR1WqCbZ5s5wWHMP16n9uo2wrcYe
         SzprGrr3/V2AASVdwkkcRDIA1ahj1bVbIcsGcTmmIH4Yxd8AaYeJ7BLfmzGnfraksfvE
         M1vq+5HnPLEOVO7uVST3qrq7DEb6tGkEsb3eM6z41um6rN1M3U1Ay8YwKb9cfKjnqXkR
         n3clNLb0VPr+kzO6l0O122vhJpjxqyqGsyow82Ad/XA3d+N1UEV0xm8IHCBaLqd+ZrJp
         vcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce/xQKtB6h18AIsA1S/vHOwsBOtcRFWUAHoCEtAF9MI=;
        b=ZVrqIVxCgv15omWisFo1mHzCtarZJSyhY1Dx4mB/iEBKRRl5rlaxn2BlByMa6CLAjr
         1TgWbZ2ovxG9wrjb5ZyDpJheucwbIoYvZuhgBTL+Rndb5YWMMCSesDrcV4wMmAxbVnxm
         DROfc0LLiZ/uEy58fUie35kSqXAN8QqWY8hVrn5znu/r2QOkFuvmqtgV5sWII6BVIVc1
         Be1ZtKF7cVghmQTSdRgEuA7JLINlb/8TyYezX/u39DHe6RD5idzl/KJonT7IQJNUnpk3
         0GwAbHwgH4bueS1BcaeUXjJvUmw1pZ66LKlcldkQc39k1l9V5lirW1P1E9C49u0VHL1I
         B+Tw==
X-Gm-Message-State: AOAM530Th54v0okqGt5JSFe2IZpSJ0q3NQK06J1845BXS6S5DrPxKCL5
        IsGOrj4P576aH0YLZKdfqDYP7dgCm+lrYQ==
X-Google-Smtp-Source: ABdhPJzp6kyJ7IwDRSY2ewSLac2cqEYYpDYUO1o0ix0uAfI5gaRB2tLJlDhcG1BJ2JnipSd0Vi8YBw==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr7065149wmb.25.1599720923433;
        Wed, 09 Sep 2020 23:55:23 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: [PATCH 26/29] ath9k: ar5008_initvals: Remove unused table entirely
Date:   Thu, 10 Sep 2020 07:54:28 +0100
Message-Id: <20200910065431.657636-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar5008_initvals.h:553:18: warning: ‘ar5416Bank6’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../net/wireless/ath/ath9k/ar5008_initvals.h  | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar5008_initvals.h b/drivers/net/wireless/ath/ath9k/ar5008_initvals.h
index 467ccfae2ceed..8d251600d8458 100644
--- a/drivers/net/wireless/ath/ath9k/ar5008_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar5008_initvals.h
@@ -550,43 +550,6 @@ static const u32 ar5416Bank3[][3] = {
 	{0x000098f0, 0x01400018, 0x01c00018},
 };
 
-static const u32 ar5416Bank6[][3] = {
-	/* Addr      5G          2G        */
-	{0x0000989c, 0x00000000, 0x00000000},
-	{0x0000989c, 0x00000000, 0x00000000},
-	{0x0000989c, 0x00000000, 0x00000000},
-	{0x0000989c, 0x00e00000, 0x00e00000},
-	{0x0000989c, 0x005e0000, 0x005e0000},
-	{0x0000989c, 0x00120000, 0x00120000},
-	{0x0000989c, 0x00620000, 0x00620000},
-	{0x0000989c, 0x00020000, 0x00020000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x40ff0000, 0x40ff0000},
-	{0x0000989c, 0x005f0000, 0x005f0000},
-	{0x0000989c, 0x00870000, 0x00870000},
-	{0x0000989c, 0x00f90000, 0x00f90000},
-	{0x0000989c, 0x007b0000, 0x007b0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00f50000, 0x00f50000},
-	{0x0000989c, 0x00dc0000, 0x00dc0000},
-	{0x0000989c, 0x00110000, 0x00110000},
-	{0x0000989c, 0x006100a8, 0x006100a8},
-	{0x0000989c, 0x004210a2, 0x004210a2},
-	{0x0000989c, 0x0014008f, 0x0014008f},
-	{0x0000989c, 0x00c40003, 0x00c40003},
-	{0x0000989c, 0x003000f2, 0x003000f2},
-	{0x0000989c, 0x00440016, 0x00440016},
-	{0x0000989c, 0x00410040, 0x00410040},
-	{0x0000989c, 0x0001805e, 0x0001805e},
-	{0x0000989c, 0x0000c0ab, 0x0000c0ab},
-	{0x0000989c, 0x000000f1, 0x000000f1},
-	{0x0000989c, 0x00002081, 0x00002081},
-	{0x0000989c, 0x000000d4, 0x000000d4},
-	{0x000098d0, 0x0000000f, 0x0010000f},
-};
-
 static const u32 ar5416Bank6TPC[][3] = {
 	/* Addr      5G          2G        */
 	{0x0000989c, 0x00000000, 0x00000000},
-- 
2.25.1

