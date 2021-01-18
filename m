Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEC2F990A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbhARFMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731543AbhARFLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:11:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85064C061799
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cq1so8701289pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfy5xQphKmuo7mjXEpIQjuE+vSJRcxz4P/4YQuZy1ok=;
        b=Ea4Pnex2/cshJh+NybehwAVtubTldQzN3nYvh4t8NvYZEk8E0N8/zACUhMzHYOc9D5
         RSs1GrQX7Ww19BHkcQSkm0bzUHLp8ceYKnqlHTyfJ55n3AUmdZHZjwLzGgX5joC+EskE
         Q2KOvI4Y48SvW3DuVDLIuZHYItTjCoScN3iFv3KNuX4WtY+thl7LcwFoPDWUHo7wCa8X
         V8rWa87l0YIWg4sk93F13OkbOTKLmXXiQpV6hCZ16vK1AhMe/qnG6MMA1t4GVlS9lely
         J3ahAaNqht3s+iKvH/YHB8dbqqVBaX5TTuUu6AcUrXS10VJEk/Ij4NPz8zYXv1o4dRDl
         oG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfy5xQphKmuo7mjXEpIQjuE+vSJRcxz4P/4YQuZy1ok=;
        b=P1GICvvKyPw9bRElyiFgQ2wzienw8FNyAqHZOXNR/BPOpBT3MbKC1RDKm0tqXGntbs
         DUIJVjITaoenxw60xqH4Q+hNuxVCP3nv5Nj6Pm3jiGE4KVbJw+pdesmln8hlEjzUp/9W
         3qgP4XGMkOiq96AQ1DZAMnEd3pSVUrR89UrqsO6jlROmGMZvHcwV1BejUWfkdzg+2pVj
         12T+F/ccIX2ztGeNKDpsvkVCHVCjXmgDRSevfNbwDKVjB7Kd/oOXdGRajOy1/cHnvSdC
         lr1GiF1Eai15Vae5215WHK6LNqFcUan7H2OsZJwuAlKDjq+pwKueFdUrZZjUeEgvcJIb
         /U3g==
X-Gm-Message-State: AOAM5317bVEBdWGALX847akpTgIuXrmVNYN+nribpuWe2XXG6Cbwii7W
        ys26QiFidkn2BPeIJw6U4EgB
X-Google-Smtp-Source: ABdhPJyvcvrmbsPjdVx5GFb1pReWtqG7hBSFGUnjQLRYK0mcu5pHLEhZcqn5Y7MZ+/jMOST7Ap3P4A==
X-Received: by 2002:a17:90b:46d2:: with SMTP id jx18mr1616434pjb.44.1610946630033;
        Sun, 17 Jan 2021 21:10:30 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id j3sm14703571pjs.50.2021.01.17.21.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:10:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/7] ARM: dts: qcom: sdx55: Add Watchdog support
Date:   Mon, 18 Jan 2021 10:40:03 +0530
Message-Id: <20210118051005.55958-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
References: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Watchdog support for Application Processor Subsystem (APSS) block
on SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 98945900baa9..606244fbb91c 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -354,6 +354,12 @@ intc: interrupt-controller@17800000 {
 			      <0x17802000 0x1000>;
 		};
 
+		watchdog@17817000 {
+			compatible = "qcom,apss-wdt-sdx55", "qcom,kpss-wdt";
+			reg = <0x17817000 0x1000>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@17820000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

