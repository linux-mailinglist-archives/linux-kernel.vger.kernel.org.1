Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64EA2EBE06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAFMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbhAFMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:46 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41572C061358
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w6so1671874pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2go+ls/qPoPwnzq44cqWZBr5hhnTFbprnBw3lgRSl8=;
        b=vF3OlZRzA4kGsPen1lQL9psMPxJg/oKs6EmpqMmye8NvtlALKGIZGitD3+ZCouhPfA
         3AXoznmcevlGmCxtm0NZWMRG6SO+GQmG4cr6kSTye6Pn4AgA1oue8cysmsE56zSEkz00
         +1Xf4hkfPL/EDMEQeDpNOefGxRPdc6vVEXQOqq9uVwyX+PgcXfhJwzDQJ7Ud9plqGIre
         k461m3NDoS0cIUfjUxxl06iL1up/ThyZ0pqKukMbKdGgIDVW4BhAPr5hmV7RYnfQy7/T
         gWfa58l6bqlGjIXr5fpzdWE0nz0Z2z/j3d1J7Y24tfrese5RBf0K0cQGh/cVZ6LZieQn
         IpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2go+ls/qPoPwnzq44cqWZBr5hhnTFbprnBw3lgRSl8=;
        b=A/D7OuwXNK2HhPGNkQc7+CP7HWY+lypYTclWjm0CfmBOpzr8+H9IM9vDiAsnMYftVJ
         BsyIelnI/C2kcwbvmFekueNNkvxAlF5sqQVnFHnoLXNVBKx/l5DbOJStVD2a5YvEHJgC
         x4xLfSoWy2oYTXWGKAKwjWyclirvg21yoqIdyTddG3bXDVMh9C5hR7NQo0KHQ38BQApv
         iK02QCbRITJMEA3aeUuvko2PEUBH7UXXITvWSU0sqWyFG8XLlYy9HxcLtaXvF+NMDdTY
         0pJlEV1UHSFx6nQr4LBkbC62vUJBLzmdE3AuQESFsxjALtLNRvbbcQQY6jVrwcaRq1Eh
         3+EA==
X-Gm-Message-State: AOAM531oNAzn9zcRY9i1+b7QpWm8WRdHjQni7G5RCCciwxP4P0SdsZBG
        0KrzWZmBx233BR2SVYx+LlnO
X-Google-Smtp-Source: ABdhPJyN+mEYRq82CnFpAJfddmgar5O3RVZmVmyjlUK00DMdBe1BBF8MMRcTMvS7tVh/WatS/ksdpg==
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr4403419pgb.421.1609937668761;
        Wed, 06 Jan 2021 04:54:28 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 12/18] ARM: dts: qcom: sdx55-mtp: Enable QPIC NAND
Date:   Wed,  6 Jan 2021 18:23:16 +0530
Message-Id: <20210106125322.61840-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QPIC NAND on SDX55-MTP board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 177886e168aa..83b9d784423e 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -50,3 +50,15 @@ &blsp1_uart3 {
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

