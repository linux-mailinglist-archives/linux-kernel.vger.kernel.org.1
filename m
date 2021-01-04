Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8812E9180
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhADINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbhADINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:13:00 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EFC06179F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 00:11:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be12so14150052plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 00:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6K/LbU0XVZ+HxnpwCy+UchOVctXMQ6ehwHVLCHIYOAk=;
        b=AJVyxZqPY8oCUIhavLRxLVaeY/nKST4WwvW9m0zupZ8MN/jpsbqN7h9xR3nLQPzpgQ
         0LqiqdHsG4QGyDgoSlR9UDHybEgUSqAHSiLDCDamcg9m9ftmt0JacydO3qoF9fqZSgCv
         +S9yXQIJO+I37jM3O8f9dBWxMcNKhT7UR4u7nNRkbqqP9JgSbgt+MQyohLGBzXgGqJv9
         wexF8LPSezG975+OhcEB2t/rNAuNv1HFJp5uYI7tMCAyG891Rn3RzZXuiROrzI1pRd2j
         vciTnTYcm9phQVnQekJn+Ub0YZv3cJ1ldD2i7d2x7rQ65JaKjMzYOC+Sf/6FKHIPXnzT
         CDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6K/LbU0XVZ+HxnpwCy+UchOVctXMQ6ehwHVLCHIYOAk=;
        b=p2ACLGiIt4/SWTP+l68NIVHjKHT2ng1Oth7ifsoGNjh01zb9p+0NStGXqdP9LGIwai
         oXTnW8+PwahniMgcqn3VCxeYNjwymh/hVz2xXHeZJLBmE9tnFZr35vtqqrZqF8eEUzRe
         mFi3mtJ3Hy6M6mWvgC/3UK+MRE/jzmrZpX/rns3iOAExhv/gi65HMJGIVAhFjpm10CB0
         X3HlEMkEGJaZAzFdoGyKsjBTPNIelLZmV4Rps4zMSSIG3yf6fz1pgDIePazNu7cqoFLA
         ewOWN5Zx/3t8+a19NIWTtJUOuh1v3jALAJ8RQCOh3FFSQBqkqs9W5VnJXcJgTc2UNwsU
         VhBw==
X-Gm-Message-State: AOAM533xpujPdXC5c4FpCynVYRMgtwyc7V09aOpo2NFoZMYfv0FO4vtG
        1yxo+btb8BmA3wQRk8sYGEJC
X-Google-Smtp-Source: ABdhPJzhYZtn8bzfciFcE8dO9hSHVBO+5cC563MR9QrELztidEms03zF5whuSnELFVkoJnVXW+fJUA==
X-Received: by 2002:a17:90b:1218:: with SMTP id gl24mr27686229pjb.130.1609747907702;
        Mon, 04 Jan 2021 00:11:47 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.160])
        by smtp.gmail.com with ESMTPSA id n7sm55051339pfn.141.2021.01.04.00.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 00:11:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com
Cc:     viresh.kumar@linaro.org, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] mailbox: qcom: Add support for SDX55 APCS IPC
Date:   Mon,  4 Jan 2021 13:41:22 +0530
Message-Id: <20210104081125.147300-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104081125.147300-1-manivannan.sadhasivam@linaro.org>
References: <20210104081125.147300-1-manivannan.sadhasivam@linaro.org>
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
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 077e5c6a9ef7..b00556450335 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -61,6 +61,10 @@ static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
 	.offset = 12, .clk_name = NULL
 };
 
+static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
+	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
+};
+
 static const struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
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

