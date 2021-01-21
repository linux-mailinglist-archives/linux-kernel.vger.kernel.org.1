Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166792FDF95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbhAUCUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbhAUBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:42:14 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41CC061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:41:24 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id e70so150102ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6SA6gdnUjtyY5Zv0yL6Xt+78Naajel2rVhAxGjJuuo=;
        b=WgCejbGRwJ1n8zON3pWi5icc7olJ8a8OxlnTpHba/FXshGGN4/Vxr7SXfmMaAMAJdo
         +dcap0newUCjuYaHOx/UUarPqNXqcycenKdEDBrPQZz9ZluY3xCFn1Wq06plq9r4HokL
         0OKWh+qe70P0vEB3+vv/KNDKMC2iC0CULXo7xYlU6VA6PcTbNf1mmTPo/ElAZCiCA/OF
         Icv/8buPj0wZAIqEEnMrCUGT0R9gSlw2PL4lGsiyScp21LIUpDB+/LZKhw0xPMkKw2VB
         RnJmKZrxsbY9lr0LmkS9dcnzWTdW/J/qVRGB2EYhnFAbzSNBRm4ovY6IA6F0Kr7xk82j
         ZjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6SA6gdnUjtyY5Zv0yL6Xt+78Naajel2rVhAxGjJuuo=;
        b=hXHrXGd+hBJcAG0tsBx27Ve5XGt6g8CaIQHz4A0NHdB5wu2p7N6D/9s1nNKDzThTvH
         7rofJ1MDTx/EvE0VD8WSvHM9ULWSXEeYuZg3ycIdwlPexvCHYTQnuEWupNBiAUfm+5nJ
         fKQv8unUMiti4QIIO8X36PcrNvHNrQcFZmAneB8W1TbZGH9Y9QqwoMS8SYvxUp8DCcOl
         o74yXVZSiujQrk+usLz+phEjErJaeAc2LD1syxe8sF1qTmaDtO+ULoF4INVf6GP3mgXV
         IRxajziNoNN80z18zkz7U+gyQ6UvQwwnUiZIiXlKN/GrjyZAsYAC2Oli8Tjj+Mb/qM2V
         b7TA==
X-Gm-Message-State: AOAM531kW/SUfahXqXqYMS7R6/SYkqbtnmE1G5d7hRg7WGmChF/KR3Zt
        JV3J6Q/jgWKHvRrpvCu+Fq7QZg==
X-Google-Smtp-Source: ABdhPJzLlveQKXJeQ/6OsYkptr2HAdOcJdSXQaePas35ZQiVIZcTNrzgI9zTWmB9637MyL8w2zmiNg==
X-Received: by 2002:a9d:2c43:: with SMTP id f61mr8618446otb.329.1611193284132;
        Wed, 20 Jan 2021 17:41:24 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j1sm766978oiw.50.2021.01.20.17.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:41:23 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mailbox: qcom: Add SC8180X apcs compatible
Date:   Wed, 20 Jan 2021 17:41:30 -0800
Message-Id: <20210121014130.1612454-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121014130.1612454-1-bjorn.andersson@linaro.org>
References: <20210121014130.1612454-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8180X platform has a APSS block exposing the usual IPC
bits, add a compatible for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 077e5c6a9ef7..0fb0ab028b62 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -159,6 +159,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8998_apcs_data },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &sdm660_apcs_data },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
-- 
2.29.2

