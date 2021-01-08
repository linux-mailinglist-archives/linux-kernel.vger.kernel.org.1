Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799102EF15E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbhAHLeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAHLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:34:06 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942CC061282
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:32:55 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 15so7495971pgx.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFCn4DrN5tcytFqIGARwmeCierFc1Kb78mBSzO9W+eo=;
        b=b5bZ2NhkOjV7VellrHdmvW8UPCU1cxaZG8XswMDojv7DVRq7RuTaIazHWcVzuUOGNe
         4xsVcKd90dTRaLlV6wkeGs9lmhysuRKMK6D4oHC9DwgNVD3FaJ8gQFBN+wQwHZPFEE9P
         2cqmqxqeRWsp+5FqQXencD9HfxkTCn9Bd3i2on7FGFGJD8/M8JjWtRg7yP/bw5ArGeVL
         ksVymKZi+nLUPiU4qkK3z7k93Szgd8FsPvbVWOQ/PMZfACwLfqwNgxq3nezxo95Rfcaf
         peQlOpn6AOyLlLZSJwX/gFyC4JlVTMc8aTZMCWjYtLVl7YEb0yg3uJqzSY4e1gLdQfzp
         07Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFCn4DrN5tcytFqIGARwmeCierFc1Kb78mBSzO9W+eo=;
        b=NKDCUQ6CX2HGjfnmjEW2ebjDq1HKl/ffrq1xDV9spDq5wsYtIQmvGAEOYT24QMUg2/
         14fiLsVnXQ5pmlB1x58I9RF4THv8RvFuKcKE0p1Z302B/XKJNrYhLtBos4TeOK6qs3TA
         4Uv2weID+JF4HLIzKwAVXcZxvKjZm+xzznAN+MQZn3H9bD/311/lIzmFLMYjPOvaPf1f
         9pQ8XEf8f6kxd+lnKfwuKExfMMtJyh7jq1tKp6DNeNdsmAWFrkeM8MHrw/nDBdqTVt7I
         ECAL5Na9TC1+73Z2/5xkYfoKD7wHB0XB9yx+fCxHXBm9P2U16w2Jw3oMowPn5Fo7zDTX
         RFdQ==
X-Gm-Message-State: AOAM530JfxOOP2OcBvlF7Wr7orsW+S8GXzNHrYrV8LY08zwy3m7ffOa+
        ed/hu9uTizQKoNpLriOcDlrz
X-Google-Smtp-Source: ABdhPJwyt0lKR1eZ3+pay1gSvPHa300MNibDSeSAAHd4WmKUexHWuW37nVr3tNnBI3vHbxvd74LQDw==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id g134-20020a62528c0000b029019e4a39d9eamr3424004pfb.20.1610105575033;
        Fri, 08 Jan 2021 03:32:55 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.188])
        by smtp.gmail.com with ESMTPSA id i25sm9261573pgb.33.2021.01.08.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 03:32:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com
Cc:     viresh.kumar@linaro.org, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/5] mailbox: qcom: Add support for SDX55 APCS IPC
Date:   Fri,  8 Jan 2021 17:02:30 +0530
Message-Id: <20210108113233.75418-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108113233.75418-1-manivannan.sadhasivam@linaro.org>
References: <20210108113233.75418-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SDX55, the IPC bits are located in the APCS GCC block. Also, this block
can provide clock functionality. Hence, add support for IPC with correct
offset and name of the clock provider.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 077e5c6a9ef7..1c205832a1cc 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -61,11 +61,15 @@ static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
 	.offset = 12, .clk_name = NULL
 };
 
+static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
+	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
+};
+
 static const struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = 0xFFC,
+	.max_register = 0x1008,
 	.fast_io = true,
 };
 
@@ -162,6 +166,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &sdm660_apcs_data },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
2.25.1

