Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C072CF21F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgLDQnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgLDQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:43:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17485C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:42:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so5940340wrv.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foCoiLT+slgLG3L0w47m6AcbVpAqnmRhNM9NU1juQQM=;
        b=DYbfXG/nueM424ONrCFUHd6ulpon66D0URs3nGOX/ObWhuyxam8eMl5jzNRVTSEAK3
         lWdCy6erUawbbk55ZsqDwuDDXe/HSgV5aAhRGTEEoCtRz4nPvGMjOa/5mXtpgnMvmZQY
         B4hBOHISvNLYDVA0i+2PGF42NXG68niDjaO47Q8A9eFFd0Fz1Jfy6cUFYu7fG9E5MG6F
         pWhIWwO0nV+36kUw3SIKbv2SK7mp0eh+lwx61tkp7OBAnOsdRDoJASpCEGfjvf/GQHjI
         NF851j92Grd1bcwdc4Acn6u5XbBNaUFy0X2tVrDpjd4NdqYDtnv1t0HQxNAGBbyA9wfh
         pTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foCoiLT+slgLG3L0w47m6AcbVpAqnmRhNM9NU1juQQM=;
        b=q1IfWh1wVamxjkrAmy+s2bvlfwy65I2KHtPKZIb4DHqI+xDpc0Uwlmv7p3NJcqlJb1
         LrOlKF166K7tvxelaB5iaOtGJHdojbuC/W2aPa6ykknFT6rK79e/dFORt9x65jI+ebX4
         lOjvr9rpunCIpz15pdjAnFAx7t26koKU9hLcPKjwf9f6W1/xQHiqdntQEKMd2eTpjHvl
         fQOV3uD8J7cm2h1lY7/dEXKO5D/I75WT04jcgMCYwjVtFceHGDIs91SI0jmrN7kJEp+t
         WqhxYOjY2XCzWxOZJR+ltB+pDAQQlOI0XTZNIUyNwLr5BKBrDVHBBYQqkVvgHgoUCEFs
         jZ3w==
X-Gm-Message-State: AOAM530i7mS1wxp8ahEGGu1FBp2ng5sZZqKI4F9ApsGWSfZUz8loGve/
        Gl8eE5WpUAxQ1Epc3ADqNhMeuqAF2t/2/7wu
X-Google-Smtp-Source: ABdhPJxAYhVN/ft3fnkyFb8bYQ65F6gu0a4IL7ACH8WXTdLYqnGmeUfo9ae/WbBKPLEDWaEaxJAIWw==
X-Received: by 2002:adf:8b8f:: with SMTP id o15mr5986941wra.311.1607100151872;
        Fri, 04 Dec 2020 08:42:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d15sm4488923wrx.93.2020.12.04.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:42:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: q6afe-clocks: Add missing parent clock rate
Date:   Fri,  4 Dec 2020 16:42:28 +0000
Message-Id: <20201204164228.1826-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setting clock rate on child clocks without a parent clock rate will
result in zero clk rate for child. This also means that when audio
is started dsp will attempt to access registers without enabling
clock resulting in board boot up.

Fix this by adding the missing parent clock rate.

Fixes: 520a1c396d196 ("ASoC: q6afe-clocks: add q6afe clock controller")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 87e4633afe2c..f0362f061652 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -16,6 +16,7 @@
 		.afe_clk_id	= Q6AFE_##id,		\
 		.name = #id,				\
 		.attributes = LPASS_CLK_ATTRIBUTE_COUPLE_NO, \
+		.rate = 19200000,			\
 		.hw.init = &(struct clk_init_data) {	\
 			.ops = &clk_q6afe_ops,		\
 			.name = #id,			\
-- 
2.21.0

