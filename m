Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41352FDFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 04:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391428AbhAUB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbhAUBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:44:31 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F583C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:43:33 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d203so546429oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35YOuN4RoCdV/aCbpWrFTknzRYidSYBqsWYqor+LJ3s=;
        b=dZFoUf5G3RQMVXyG+vD0SRCEqlRhwLQZeEQ77RS4EBjqLeUFlMoE/1a4bZtzJP9jRF
         E2TsrWJtve5xHd7+GIItkFhcoD/qH67nPKMucZ2Q3DN3v54R/JRcLndmLmo+ioji5kFL
         x8mfLYTsnuLCBdx0/R1C1UfVMww2HG7FbDDZjxJwUOrljDcdi09GKkiQXej1aFGX+u50
         JU1OP4CsUS7mYNOrT933CMExhtReK+WdYq+SVZe8CZBf0ikMzYMNv6XSNfzBMwbAKoTJ
         lApAM/dgHOiOvFe5TpZz+cVTZcKduJfZzhu/wt0dZsJRjdV9PpNzfB+UIsndROV6OjKb
         Xcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35YOuN4RoCdV/aCbpWrFTknzRYidSYBqsWYqor+LJ3s=;
        b=lcwcsmQiMBJsj0tQpypTq/Ikrj+f1sIXXuKGmkR3T12p4UsOAIvXQn8JlCGptCLEuL
         YbC2s4DGcwAB8PC+N0N8WsrqA+8pE+pj8LlFqK0jR3kLypkMJOvM/FMuQ+xFYKAt/mD7
         4PCqcj1yr9vXiwkcI2CSVeKRPhVl1Q38i56Ex3pKXpUwGMP1B9F/4SBt9hnMkoILFbtB
         aN44yRG0Qo1euZYuL39DYCHjtuV5vOYPUos0hMydkbl3u1p9KLaLSra3ngbqBY23tnwK
         C3zSjuBdvUqUaBKFQ28/bkupXxCFaDwB3x/w55RqjM18uqtNQmDEuo7ucnVDZSVcU+ar
         l4Tg==
X-Gm-Message-State: AOAM530jOUPaukSpDt9BJskIfTVZKcR8kbLXIa8JoRH2IN5aAwwAW6JT
        rCR8wTIkFrTiJP9E8wFwKr6JTw==
X-Google-Smtp-Source: ABdhPJxI8cfCPFjZAnqYCflbPb1t26VJ8O/yV+uMDRe6QnktW+qu7OjHwM91bsFKWtU9taxYV2UvnA==
X-Received: by 2002:aca:58d6:: with SMTP id m205mr4584837oib.121.1611193412495;
        Wed, 20 Jan 2021 17:43:32 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s69sm779032oih.38.2021.01.20.17.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:43:31 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] phy: qcom-qmp: Add SC8180X USB phy
Date:   Wed, 20 Jan 2021 17:43:39 -0800
Message-Id: <20210121014339.1612525-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121014339.1612525-1-bjorn.andersson@linaro.org>
References: <20210121014339.1612525-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8180X has two QMP phys used for SuperSpeed USB, which are
either the same or very similar to the same found in SM8150. Add a
compatible for this, reusing the existing SM8150 USB phy config.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a1ea911856fb..8a63148a6df6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -4211,6 +4211,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sc8180x-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc8180x-qmp-usb3-phy",
+		.data = &sm8150_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qhp-pcie-phy",
 		.data = &sdm845_qhp_pciephy_cfg,
-- 
2.29.2

