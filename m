Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE23D2EBE0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbhAFM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbhAFMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01DC061367
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h10so1652402pfo.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1brOZ/QkKBkYoCUBItg4EDZ/jZVAfzXyKHdM8JfODc=;
        b=rEkvBpqkBqjG/BjYtvLcvuieckDMqtYZGNrSWTBTitknOeVkFyw0GkvB7wazdWnpta
         yTOgnDBMci0OibkE3eLYWEG59HBDCFScG17169gQuCUBVn6q+E2F/3s5lTkoyt8OcC/7
         WAj/AB3HFIpU7aLI4kVyjcGvfUtZqGqQAroFzd0gddF3f/Yhg4NTD+k94UMJFY1G8Qb6
         mUPy5JIvi4kEZUMevANo3LvOJ0hBLMJ+2XJTqf4AzbR6hGKYR2nxCg1RwJH75k1mPN5J
         jUfoAYQ6nbuOc778RXFzKIuYp0USE1wtcQF+krEiwvHuRTQ1L+QF4iPSh4hJ/H2c36G7
         iQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1brOZ/QkKBkYoCUBItg4EDZ/jZVAfzXyKHdM8JfODc=;
        b=HM+yigOyFRTOghvR+FgGrQlFGcjbjXXhDkI82UZjsG8Ymr+yho+mrH8f/PmABZ69S+
         F+UZ88Ltg0BZmhPhjXJv0xyt4HICBZEiB7+vUsKos8YFyg35HGBDJRO5yr2i6x6ncHot
         Pu26zI/lGRVosZxkVCt3angxIK8X6bJUfpcYAvtQdEvDy/ZDcqf0dGcloD1uCvVM+lBe
         TNOOnv/E8AKVW+BbPcqMtVkX/pHxqMTiDdWvFb4tsdzfU2tx5FyhSrMdzxMKAB6W7NnJ
         5yesX60IuHml7MXFK67s2SGivuSq5QIAdbs78/Pe1hl8s0MODfT/a98JLzyaQhwegQui
         Rx4g==
X-Gm-Message-State: AOAM533Ljq0RHY6pyDspPjPZGq+67F9Ril2zxH5Bpg0EPwoJQn5jF8c9
        B5XC+56RZ//8MRweZXBUcWTY
X-Google-Smtp-Source: ABdhPJzhQfLC+T8VacszQjULvoQ8NJh1lU2HEZ8BV4rB9trr0SVQhxEBGu/l/7Rz/NJudZeMj4IFMw==
X-Received: by 2002:a63:8f4c:: with SMTP id r12mr4337589pgn.311.1609937652549;
        Wed, 06 Jan 2021 04:54:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 08/18] ARM: dts: qcom: sdx55: Add Shared memory manager support
Date:   Wed,  6 Jan 2021 18:23:12 +0530
Message-Id: <20210106125322.61840-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add smem node to support shared memory manager on SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index b752b150a5e7..5c091787c458 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -157,6 +157,12 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		smem {
+			compatible = "qcom,smem";
+			memory-region = <&smem_mem>;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
-- 
2.25.1

