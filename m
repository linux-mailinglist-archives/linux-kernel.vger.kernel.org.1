Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E720C2A7D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgKELlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgKELlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:41:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:41:10 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so938716wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NT4L8anxXm4wXPLVLxmm3DEteISuGR3FP/KLGJpviU=;
        b=x0u6INKsJMHOufY/7/lCh0VyNCFWbYUaHN7ctfYL+qRWXrEuAZumb1autNdeoQlnrV
         k1g3HVrRhdTNG+/Z/co8PwrnifK2W2rH8k9MeUM9i8KAuQ3MzWrUkTPmgthz2rR4YAwQ
         posQdFV148EG+os9lAobSB1P9ka4rxkuxeDc+mBbO2q2hKxTlCEtw1KbrBApiw3OUCyW
         HAKyKjpEw+VCGeiRmbSLQ3FxEtocBrYIirVV87VbPv3UQO4sfgNJWHPYydlUb73SO2Z9
         AOXDP/pjEyLWtkl4+xYcWAV+C2mShsY/EY3nyNz1JF0qQjQSKWeXZvUYVTSugBTRd59d
         aTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NT4L8anxXm4wXPLVLxmm3DEteISuGR3FP/KLGJpviU=;
        b=NxNzxm6i2OwRDcIEJNqg4MBsXf9JvUvuDQbtQL88gg33yleUxE4hcZnDauvQQtc6d1
         9lLa/4loo1LUkVPSIrTdP3j3TvFLjV8lRBGrWqW1p8eQApVj/OtTm89XMAK67HMzInY0
         VDx7yo54/AULKl31630O2M4wXZXkU1Uy8EnyDFCbs2uGiJb19DbENsyRTof15jzbB8Qw
         NNyFw66Of4toRXjY+vQakNtKlu7vBRlFHdAEwA+Y5mpTluQnuN63ePLRu81vXIaUryrK
         IgDWJWjPgOl2QdmqU1pYkGHa/iyAHAQo9g1skFVWKw+RngjYCqMZzP49nZaFxDQNvxT/
         kjdA==
X-Gm-Message-State: AOAM532xWFsQ0M9uKPYBurr2dNUZRrdBAU9Xw7okB0nZTYcBZk0gqj4q
        twEwV9iOPaWxJW3OBWL+pYx8AA==
X-Google-Smtp-Source: ABdhPJyyPzkxO4wkBPYj9UA0OxF6Y7OTNGnkUAcf2gff0pcr11t6FZpC3LD9ZIv71Hlwcujx/5IFXg==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr2319563wmj.162.1604576469577;
        Thu, 05 Nov 2020 03:41:09 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z19sm2154352wmk.12.2020.11.05.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:41:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoc: qcom: lpass-cpu: fix warning on symbol scope
Date:   Thu,  5 Nov 2020 11:41:00 +0000
Message-Id: <20201105114100.18647-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning when module is compiled with W=1 C=1

lpass-cpu.c:677:22: warning: symbol 'lpass_hdmi_regmap_config'
was not declared. Should it be static?

Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 9d17c87445a9..1fd862e3fd8a 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -674,7 +674,7 @@ static bool lpass_hdmi_regmap_volatile(struct device *dev, unsigned int reg)
 	return false;
 }
 
-struct regmap_config lpass_hdmi_regmap_config = {
+static struct regmap_config lpass_hdmi_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-- 
2.21.0

