Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861412EA7E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbhAEJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbhAEJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D00C061798
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:46:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so16088890plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYJjVEdJXcwBJxA+GXTjlWCuGOgAc5YnZyOc1A9H7aI=;
        b=GoaLO67/vwONiRlFCErFYmsnindE6FNNEkPpRQ2CSMHWdo1BSQWLIfVvVORnvqnEuL
         rIJXn37iE5TYl+rY92j1o2VXffhdHda50TTwh1AeYwe5QrXeTTD+TFqCzYjJP7GrcbyU
         V4OBhgHfq+zotzfPb4yGqurQZ1td3HcjxaTJE4WmiV7HiLayKDw1+TIxIW2Ew5OLrvys
         dZ7Vg1vCaUndKPmbwrMvomm2nA31ug/V+NfvmAgJVnoUxT++nSxs9VbyZY1ibSkFDoQJ
         +Z+rMHEyj3YI802OUXZ9U51lbMv9QRNkFIFUqRslpKtCJdOnfimSKFbSGJzvNPzNXGaG
         Nc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYJjVEdJXcwBJxA+GXTjlWCuGOgAc5YnZyOc1A9H7aI=;
        b=Fp6Opzf/jxoeHKECpWYhge1zaBeN5Y37rQ+oPVQE23danY9DMlRbf3mvZGEqBjRSH5
         0DtK4w3X6YxgbXADWwvW+aubQyXSzwtS6af8EUksdR1TCFna2nSmw5LJjtwHQ2AMxo+d
         SnmLDlgueIADlerb/8tx4Y2oXqfAq3w9rvHMstaSb5fnJBjZCOfzpuIoNcfpR8ix64k0
         nW/brcIT5XyNzkfptu7zpqzTvrMq309PFWjY+gxazAtwuwc9W6wtgVs5U+DkyNSk+4+9
         Q3HZswmHA5Sq2fj5eVCQ0UTpQep4Xw2LbhR7Ecmfd4Rx6qcejsm7NRWAvtWKKiWT7z9k
         r5Zg==
X-Gm-Message-State: AOAM5325EvtAtLSZtRFL+hL6B6cAXeON80lpUv7JBJ4NdhlaITW9bomj
        +v6J3/7mYai5R+hJyqTMv5np
X-Google-Smtp-Source: ABdhPJwPuLwdos8O4BPJKvXBGevqLxltX9yQMQN8g5ML0AAVZq+r6mlbdLcBngqdIzZy1qLt38qJ+g==
X-Received: by 2002:a17:902:7e85:b029:da:72a2:de1 with SMTP id z5-20020a1709027e85b02900da72a20de1mr75418943pla.57.1609840011268;
        Tue, 05 Jan 2021 01:46:51 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:46:50 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/18] ARM: dts: qcom: sdx55: Add reserved memory nodes
Date:   Tue,  5 Jan 2021 15:16:20 +0530
Message-Id: <20210105094636.10301-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds reserved memory nodes to the SDX55 dtsi as defined by v8 of
the memory map

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 08b4a40338fa..eeb6bf392f93 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -60,6 +60,73 @@ psci {
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mpss_debug_mem: memory@8ef00000 {
+			no-map;
+			reg = <0x8ef00000 0x800000>;
+		};
+
+		hyp_mem: memory@8fc00000 {
+			no-map;
+			reg = <0x8fc00000 0x80000>;
+		};
+
+		ac_db_mem: memory@8fc80000 {
+			no-map;
+			reg = <0x8fc80000 0x40000>;
+		};
+
+		secdata_mem: memory@8fcfd000 {
+			no-map;
+			reg = <0x8fcfd000 0x1000>;
+		};
+
+		ipa_fw_mem: memory@8fced000 {
+			no-map;
+			reg = <0x8fced000 0x10000>;
+		};
+
+		sbl_mem: memory@8fd00000 {
+			no-map;
+			reg = <0x8fd00000 0x100000>;
+		};
+
+		aop_image: memory@8fe00000 {
+			no-map;
+			reg = <0x8fe00000 0x20000>;
+		};
+
+		aop_cmd_db: memory@8fe20000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x8fe20000 0x20000>;
+			no-map;
+		};
+
+		smem_mem: memory@8fe40000 {
+			no-map;
+			reg = <0x8fe40000 0xc0000>;
+		};
+
+		tz_mem: memory@8ff00000 {
+			no-map;
+			reg = <0x8ff00000 0x100000>;
+		};
+
+		tz_apps_mem: memory@0x90000000 {
+			no-map;
+			reg = <0x90000000 0x500000>;
+		};
+
+		mpss_adsp_mem: memory@90800000 {
+			no-map;
+			reg = <0x90800000 0xf800000>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.25.1

