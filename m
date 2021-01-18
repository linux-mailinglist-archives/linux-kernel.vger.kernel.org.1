Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC012FA991
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407946AbhARTDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436953AbhARTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:02:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:02:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g10so14666082wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Kty1SsDZGYmfUaFdIQI7Zq2VlU05k1IiFmWYlmVzbE=;
        b=pyMAcrMRbEe6TGaFQnMhvLyPC81ZH5fVLbGbHmSJ8iJT/EvtGysU0MlhGwYCaM6Go3
         AwLNWS2HzdTR2aIebufDjsAplNBGkKRK4JuZ7OOruuQiwEOZ0di3yoTEbjA70eYrYBFQ
         iqc1L43A4SgXovb4nwEem3jVmwSbHm0Nu7arZQjfb7jtH5pSqi/JRRw2C7y+WXeLOU8n
         g8GYlReg8EuRnt0NyADBdx02d7o4kR9xFntpWHIaWC9N+jYoa6NDSycS5WVZky453IcP
         fhBHtlw1tc6f2sx6ub6xw1B78uNMXIHfgzbVmUCjblR5ZFSYMofPgEzFxT12cpA2sLTQ
         pzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Kty1SsDZGYmfUaFdIQI7Zq2VlU05k1IiFmWYlmVzbE=;
        b=ZRyaJTqXKxIGt0ESZIFiayItuTdjC2mOXcKjDekQ6r6PLqd/NaEV+lIr/aNVThdrgY
         9nGmoRioCB0zI5jTxHGzut33EmWORm7pZpFw4vLEGAa5S0ojGIW+mEJjVxhss74It78S
         sqH5MFShMzHdiNToBcBhWGnIxgOFtEXdkffBIVJTVEe2y70zH4vZPbcDbI+AbQT4F1eq
         Nfuwn92ePoYeV74hF+DdxjzBqiLyH0Rs9Pzj4ePygeTFccwAUpAm1dzC6UwbRTh45AlA
         mRRmRPsVJNu+TQLnwtkDCPS7tjmZWVTETblA77HHEHxyFDZDZ2lJZo41jy50g5xQZz1v
         aSBA==
X-Gm-Message-State: AOAM532dnqaZ9lKHmij60Oei9UmyAEmw2gqCtoGva8rd6C599Eg/T6L8
        IZBFHtDefm2eik0vVlHaE+ycmQ==
X-Google-Smtp-Source: ABdhPJwZXKJ6wE68hu01F+Ly4OeBx+mI7taJbTpIRlW2jzdqbB7t/UaAtQXMLC4knrxqueTOlw8nkA==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr700875wme.11.1610996526322;
        Mon, 18 Jan 2021 11:02:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:399d:974c:1ebc:7134])
        by smtp.gmail.com with ESMTPSA id z63sm519244wme.8.2021.01.18.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:02:05 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     dongchun.zhu@mediatek.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongchun Zhu <Dongchun.Zhu@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@linux.intel.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@google.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4] media: ov8856: Configure sensor for GRBG Bayer for all modes
Date:   Mon, 18 Jan 2021 20:01:32 +0100
Message-Id: <20210118190132.1045913-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previously added modes 3264x2448 & 1632x1224 are actually
configuring the sensor for BGGR mode, this is an issue since
the mode that is exposed through V4L incorrectly is set as GRBG.

This patch fixes the issue by moving the output crop window of
internal sensor ISP uses by one row, which means that the Bayer
pattern of the output is changed.

From:
row 1: B G B G B G ...
row 2: G R G R G R ...
raw 3: B G B G B G ...
...

To:
raw 2: G R G R G R ...
raw 3: B G B G B G ...
...

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Suggested-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---

Changes since v1:
 - Sakari: Added mode information to ov8856_mode struct
 - Sakari: enum_mbus_code updated

Changes since v2:
 - Andrey: Switched approach to changing the sensor configuration
   to yield identical Bayer modes for all modes

Changes since v3:
 - Andrey: Improve commit msg to explain Bayer shift better

 drivers/media/i2c/ov8856.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 2f4ceaa80593..8a355135c7db 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -428,7 +428,7 @@ static const struct ov8856_reg mode_3264x2448_regs[] = {
 	{0x3810, 0x00},
 	{0x3811, 0x04},
 	{0x3812, 0x00},
-	{0x3813, 0x02},
+	{0x3813, 0x01},
 	{0x3814, 0x01},
 	{0x3815, 0x01},
 	{0x3816, 0x00},
@@ -821,7 +821,7 @@ static const struct ov8856_reg mode_1632x1224_regs[] = {
 	{0x3810, 0x00},
 	{0x3811, 0x02},
 	{0x3812, 0x00},
-	{0x3813, 0x02},
+	{0x3813, 0x01},
 	{0x3814, 0x03},
 	{0x3815, 0x01},
 	{0x3816, 0x00},
-- 
2.27.0

