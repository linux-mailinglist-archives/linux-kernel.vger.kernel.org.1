Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4252EAACB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbhAEM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbhAEM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28599C061385
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:36 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t8so18287024pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ4Xyw+lomP5U3AJy8SgFcN3M+pTYg7eIxIz6Xs0pzE=;
        b=WFHYQQItdpm7MoI00KU+wczGRD8zZMrET2a085XOPoebkPBarWQjwa9b8h39b7wGAx
         ds2UXCzlfij2QnB8aSLP6iWEcq6Z0l2xl50UeKjRTKzNi+5R+IoVR2AVmCUnbDeaGJQp
         anB2xo790mHU5uDPAMPjDDEo/eGNZkAOsNs/nZVkS9MFC0Q46ZpOx1+0YK0VKkRcyjED
         yYaeDJYdglEpWvAh+h3V2zC0UT3BG14V3jucJIF5P0Ab2mfzWhkD67abmXn/liGKaePa
         ylk2O1Mud9l92PIqZTqbdJzRrbQ1o7a/k1w9kvjZQo71l2w3pWoRnl2+AAKfBYzXuQ37
         pGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ4Xyw+lomP5U3AJy8SgFcN3M+pTYg7eIxIz6Xs0pzE=;
        b=WM5klwM3+ZZWPdCD0MTbMbl35tKnZqaRFekxSsAPRNXjLMF4zcpgHEs/74LJWCN8nD
         W/V1l2V2NyWWY0+Ko5lxuYCiJ+S0NWSDlSvF8k/zlEt2101910HOJ4ZHIc0biNB853gL
         UHGeKXRhJC3OK/5Y9NH8ZSqGP7KfPyDPmuePQrU/GJQERDWQRmr4jaMsN+8T+NXEztnR
         80SdanvO6CUiqTnPto2BZXBSAQorqDkiUSkiuyKpLtS6COSzMhMK7u376bbOOiyeNKiB
         89elwvKlGiPGVHT6/DFiF9iP6VmFoxObYnLsz2CJ6tw9NXYspjEQf5//SPnXNAKXJZHq
         TiMw==
X-Gm-Message-State: AOAM530nnhwlXSa2YWazKphlSiyBMpEVFlc5vUn1twxuGJLlcUmE4ZSc
        foN4lNDwt5tvOBrkH61wBzaU
X-Google-Smtp-Source: ABdhPJy8VUmLbmwmFPq5SJqORw6Qrp2btQhmyblwiBeTf0+vMyMjaenPVfYCVhTg3yMqIqmGwZXtOQ==
X-Received: by 2002:a63:1602:: with SMTP id w2mr36955617pgl.128.1609849655746;
        Tue, 05 Jan 2021 04:27:35 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 12/18] ARM: dts: qcom: sdx55-mtp: Enable QPIC NAND
Date:   Tue,  5 Jan 2021 17:56:43 +0530
Message-Id: <20210105122649.13581-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QPIC NAND on SDX55-MTP board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 74ea6f425c77..b8d432a4324c 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -29,3 +29,15 @@ &blsp1_uart3 {
 &qpic_bam {
 	status = "ok";
 };
+
+&qpic_nand {
+	status = "ok";
+
+	nand@0 {
+		reg = <0>;
+
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <8>;
+	};
+};
-- 
2.25.1

