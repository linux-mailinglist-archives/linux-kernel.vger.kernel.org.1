Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A42F1207
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbhAKMBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbhAKMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:00:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE23C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:00:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw4so24233805ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OW8w9+OK+kpGhqgXSAht9uVN2nF9YMGSL1tUgT2Bs9Q=;
        b=EsRDrUhPpM9Is+P0DCnamaarnKSYq4o/vGbyGa2dwsoNGwSuZQv+XKTDZG4dMbpNB4
         037pSOoUXYDTFHieNWTc5SA+PnkRZSgzQNjC86cOdGvWWFQVQBPKNd9rn76m8UjnVM5k
         45nJNTd2h52DJShEnava1+XA+8GCGkdhI2NfjtAx+F8xxEMJR7r4ieiIU1hY6dowbo+m
         FjE2stb5DY8wAUTk5o2GIxTE5/6z6k6I42efmjz3QD0DWS36+1w/Ut4ejRlRM2KDNCU1
         SGP5oQSeJmT94MqKq9sGjaGGJZIKTYaGO6ESRhVUenOvRdqpXhebaCFktULZpX4W0FXV
         R3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OW8w9+OK+kpGhqgXSAht9uVN2nF9YMGSL1tUgT2Bs9Q=;
        b=PcV3LoOW7uboiQG8iLTzzdkcrK3MxY+IzS9W8BnjmdzzEkuItRBiGOKMmBVyaj8unl
         U49eE94LVYuqxSQJjWpUj/WFL5BTFLs/qKzB1iUtSbKmTCPOwS0AG1DqyLA2Wslg8rK6
         MTzOAwQQ/iUUcwYqAtL+ktstZ8YtNxSRUmh8jgbzsGek0j6P/TztjxMY9Suu5Uzg+9RI
         t3PVg7imLu4bRMNa0NLebTmffAL8KvpDMVv3KnTTmTNhSo5ohKm1u/dLzB9KM2fkw0c0
         7QEiXhAOLlMXfF94xutT07FU/2h1r1Uiy5/XuUq303WF7U8/iH1q9VWXF+yLOE6Wi211
         su7Q==
X-Gm-Message-State: AOAM5300kERuXHL3pDPZve8/zEZVJm2n09cYy8kkJo6DPPhmnyXgyXOO
        EtUOZWcyc+0Z9iLTKNd++0boNQ==
X-Google-Smtp-Source: ABdhPJw8sahUMcOxodYfKP6KQePGGZK0sOT4LELPBVUvL0IWKI6ubgbWuu7t0cSieKXrj3kUtPrfXw==
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr10475752ejd.160.1610366417997;
        Mon, 11 Jan 2021 04:00:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:fe7e:1742:34f2:8721])
        by smtp.gmail.com with ESMTPSA id t15sm7680427eds.38.2021.01.11.04.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 04:00:17 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     dongchun.zhu@mediatek.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongchun Zhu <Dongchun.Zhu@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@linux.intel.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@google.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v2] media: ov8856: Configure sensor for GRBG Bayer for all modes
Date:   Mon, 11 Jan 2021 12:59:30 +0100
Message-Id: <20210111115930.117393-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previously added modes 3264x2448 & 1632x1224 are actually
configuring the sensor for BGGR mode, this is an issue since
the mode that is exposed through V4L incorrectly is set as GRBG.

This patch fixes the issue by configuring the sensor to always
output GRBG Bayer formatted frames.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Suggested-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v1:
 - Sakari: Added mode information to ov8856_mode struct
 - Sakari: enum_mbus_code updated

Changes since v2:
 - Andrey: Switched approach to changing the sensor configuration
   to yield identical Bayer modes for all modes


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

