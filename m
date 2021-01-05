Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D392EA7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbhAEJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbhAEJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D943BC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t6so16094758plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99rzKTlTSe9qUr5y9f4oV2o3y4JbKLKmKgTDd+AN/bw=;
        b=ysjZYIunuHnaKobYqtb2SzBWEzwAJNrB6H7dVFLyKLjCRpxMecpAhLYxXyuL6P2rZX
         XCP2P+llhVTGe/GqJPy/7uVIUa0eS5XhyRii0TsZRmnCgiH+Jo2E+BuCXH+tNGSkyyn9
         DLuwx9V2Xp9O1b3ANNWvyigvov1++qfeslA2N+wZi/Ysl9OGV/9VXdvvQ2zgXsJbXSWb
         k0zECQMVoRyxvsIrEGHFtjFmDQNlNaxHfgYvH10yBw4lY85bx1+BT7BJxny3AH2xMrLW
         CkkicZs+zysxm/0Kl1ktPPyigeSDnHKQz1GTmPZVaKZO1oobgUnq2BRhgYGpfySgccaF
         KfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99rzKTlTSe9qUr5y9f4oV2o3y4JbKLKmKgTDd+AN/bw=;
        b=fBd/UjmJ0tm2L6K7SLNyaIOYVrMpb8vvHbE4All1PdmHyVJAlgDdFbtXFxvIJT9z9c
         ZenQhEd7AlEOWZ8ZyYisKITQOq42JOMu274to7163GSfQI+Gm6IyYzXY7TFra+VLq5X4
         r/UyCnJAEbRjNadn25npbJ8UGPIAmmMOJKFbEqWobAToLJ0xEk2h4DPksIsjHZT3MK8i
         bqkgY5cWXMpkykRo+9g3uLQS5mbnArd+w2/IxIYEzf/EF8+4XdXJy0oKoeKVES285V1q
         YIfyJELgHR34Vq8Df3D3eTUXyashjqSYqC6bLQE6usodxSJ0T2M5aDztLcMAe7e7Pqeg
         V/aQ==
X-Gm-Message-State: AOAM530obzHgjy8V55VgcKxgXBuB/7sJwYY2WR2fd/lKbbFZ7wGv/tmM
        Va6Oi/OdSH5fZTMH1PdvoRuM4x8dmFFy
X-Google-Smtp-Source: ABdhPJyF1qvCxX0ZW9eBrh/hCjzFVl5Mu+wJ81mZ9TeRXi/j4Zry/Yx+IdGd8+tyU96ff9FPcgIJyA==
X-Received: by 2002:a17:902:7086:b029:dc:8d:feab with SMTP id z6-20020a1709027086b02900dc008dfeabmr76123157plk.22.1609840052421;
        Tue, 05 Jan 2021 01:47:32 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 15/18] ARM: dts: qcom: sdx55-mtp: Add pmx55 pmic
Date:   Tue,  5 Jan 2021 15:16:33 +0530
Message-Id: <20210105094636.10301-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

SDX55-mtp features PMX55 pmic, so include the dts as well

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 09aeeb14be37..825cc7d0ba18 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -8,6 +8,7 @@
 
 #include "qcom-sdx55.dtsi"
 #include <arm64/qcom/pm8150b.dtsi>
+#include "qcom-pmx55.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX55 MTP";
-- 
2.25.1

