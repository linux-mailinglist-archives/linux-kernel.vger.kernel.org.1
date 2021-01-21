Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9232FDF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393043AbhAUB7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbhAUBr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:47:27 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BFFC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:46:00 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id q6so122032ooo.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KQrJpxzoEOP183dwS54dhdJ00ZQkcSYlNAckMrfyS4=;
        b=pWN+Q8SFX0/VoEi62+5ReF1K5LVJ8inQdlJsatRbtoMa9Or+sx8ejT9jJ7YkPOvzlU
         mKLchPlYnhLgHBRTt90Kln+V0lXx0QutBR5YeXqVCkxuZ8I4nLHsj2nE9NgOqIqlCCOJ
         NMNvqyJihw6wqTUCccLQXOAoHPRhHzegPzrg5qqetLwqCxBumeiaqBqZNEiuALRgD9qx
         OGpTwXSF5PgxONbhZPcT/qm67ZhKr4yObFx5PoRcJNt4Ger4FMuHf48qWG8m+3+aK9PF
         xRW52FzedpD6N7xXriTG8t2lngDRnNnqBz8eaITE62Jf8+z8DljEU2NSqRRZCmR0ON06
         Q8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KQrJpxzoEOP183dwS54dhdJ00ZQkcSYlNAckMrfyS4=;
        b=qRq+b/cZyGuvEwo43WyRBWmZmM3C/5Vuuy2BH5nvQPE4e1qwNwIP7MwTs8OUR9BQgY
         6Mp/q9CnoWa/2QxdATpPj1TmpZfqsZKXkVA2z1Em8XWuTgjuke/LLoPLHGsj6Iqd7h3E
         1IkMP+ypOgJxdo5SF5nITdgj/n0K7a2jTC1UYacinXeiVp+IdKUpI+KUa3BfOrL+sLGY
         paaf4JPnYywGU3wos24A3VtlJ8g79cuj9lIt9DWd0KlJHBL63Q/P8AjoxaAwHjNmaaVv
         yDcO7RGsg0yFM6WB7ZnxSfwAOBkhkx9q3oTxhWmnf2+U7wTq4xJmUaYN33uhzoFsbXfl
         MQTg==
X-Gm-Message-State: AOAM533/Wf/7vC4cZxBmn3fO0hY9myUJlqglm51HCZSLX5b7hznsRyTO
        EouibBVQkYAuSX6qxfXc5VyTsQ==
X-Google-Smtp-Source: ABdhPJw7hcw3C3V4C4SQV3doWhAKFFrJsBA2zpYFqPvJYlRSPdw9RtlatXpFYUcp9cqtI/6r1ZGBTQ==
X-Received: by 2002:a4a:9608:: with SMTP id q8mr3051298ooi.79.1611193559419;
        Wed, 20 Jan 2021 17:45:59 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j17sm784398otj.52.2021.01.20.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:45:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom: aoss: Add SC8180X compatible
Date:   Wed, 20 Jan 2021 17:46:06 -0800
Message-Id: <20210121014606.1612668-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121014606.1612668-1-bjorn.andersson@linaro.org>
References: <20210121014606.1612668-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8180X platform has an AOSS that needs to be communicated
with, add a compatible for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/qcom_aoss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index b5840d624bc6..bc01ff7c5d3f 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -597,6 +597,7 @@ static int qmp_remove(struct platform_device *pdev)
 
 static const struct of_device_id qmp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-aoss-qmp", },
+	{ .compatible = "qcom,sc8180x-aoss-qmp", },
 	{ .compatible = "qcom,sdm845-aoss-qmp", },
 	{ .compatible = "qcom,sm8150-aoss-qmp", },
 	{ .compatible = "qcom,sm8250-aoss-qmp", },
-- 
2.29.2

