Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AA2EA7EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbhAEJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbhAEJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8BC0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q22so18056941pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATxPuvgrya5B/FyBJYrUahFVKKPVYhe/pH6/5ZIOhtU=;
        b=yF+TpclryjnTudKWHmOw5ksb8YAaigz8auYp8L8NwLf7QbfKpcE8O+++8cmp2Y8w0t
         dqjSm4Q3x3VC7ZFXOZsAVUrM1fvkX0tk1wICc576CZ6trs9wwcW5vtAPRB6dj9k2QAqO
         ZbiCcZ+wbWQSiFDxPb4xiFolrPF0i1LnOlby9fYCegEIYfUwgX0+Z1DK/OPlcQQ+fgQH
         7Xzwp0TSNY5e4PmzKjLlo6XiP3/VvPQvnT+wE1cz7I7b8hrerYbZzBgAUtX7zgcQZPT+
         VyAD1eg5jbTlf0VZb8zcq4wmmqXZoZfs4bVXZC3loePvxqe3ArBayN6EJU0/6GTFf8Ry
         8lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATxPuvgrya5B/FyBJYrUahFVKKPVYhe/pH6/5ZIOhtU=;
        b=acj3e6DRnujN4GSuAXvELPlAqSuCqdVx2JEsZdUURkR5Oe5WeTlUyzMiSzn6yZ6DBy
         hkKQkNaFUNQ+g2tLnwmd8H36QhnAfgXgfukQdKcWfDkp60mtZpZf5PRq9tFgt4iSdB7v
         gOWtqNUaPoQGIwR4GWqIb/0pQWPQmUFr/xl9NG7yr5v+M8RxJmf424zhmS/P15+Zrlo4
         5GZ6R441hv5zE5QQNV6FxP9HZ2VNypGuHE3+EAU33gSHY9F6kBqSV4YTvphG1gtI3t5w
         wdv7f4J8zJ6v+wCd8Rl13zKOVnvuizmlclBeiEwJ9fKBYx0HkFwsc0dXkZpUOYoFSly7
         6nog==
X-Gm-Message-State: AOAM532be9frdQftMhSEDhka/EQVeiKMVi5QRtHAbagBsX4g2ywMSlPd
        oqD1VJBzMuX+Axd/DUr3wH76nWFI1Oqq
X-Google-Smtp-Source: ABdhPJx2Ys8NN3Y6xjU35ij5aXME0P/12yOrukdOS/Zp++voxL7+vuyVsUTWhtxyW82O88OOzN7Azw==
X-Received: by 2002:a65:6405:: with SMTP id a5mr74536513pgv.389.1609840027454;
        Tue, 05 Jan 2021 01:47:07 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/18] ARM: dts: qcom: sdx55: Add support for TCSR Mutex
Date:   Tue,  5 Jan 2021 15:16:25 +0530
Message-Id: <20210105094636.10301-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR Mutex node to support Qualcomm Hardware Mutex block on SDX55
SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 927f43a7414c..e48ec7a1971b 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -166,6 +166,17 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		tcsr_mutex_block: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x1f40000 0x20000>;
+		};
+
+		tcsr_mutex: hwlock {
+			compatible = "qcom,tcsr-mutex";
+			syscon = <&tcsr_mutex_block 0 0x1000>;
+			#hwlock-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
-- 
2.25.1

