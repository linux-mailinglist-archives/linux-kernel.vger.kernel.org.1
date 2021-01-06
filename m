Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17562EBDE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhAFMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAFMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:54:24 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130EC061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:53:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so2163627pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxgWqwKwqFym7GE4OKnS1/iwRMLr+x+z7Qj6uMJA0Lc=;
        b=ILkpyGb9ndDGS/VxgIBYFV+JKMiqVIUJkG0k41KFgfRFSgEz10sd9spVbft0zaSx+3
         HgDpL2LVPpx79sf3uMXoS1xrJSsG8+yWoZDBpOfN3KT9FtlW9C7gESQ3JB+leI5b9QVs
         Yk7GQnjdkGYBn2N90/EX/54JZFli6GRWTCMU6bS4mwB+4PWH3OODb/a7J1N9dO6oJ8eL
         ftmXubWk/WXPpYosKP8t99slfiHzzQ2cejYk5Zk8clWESJTCPR1ntHgcFpEa4dJ2OiVX
         ttBLZYE1FHPKI337LLoJiLtbJJFpEkJdHzrslx6zK48rCgmxk/O2jLAzWOcZ8liVQreZ
         9J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxgWqwKwqFym7GE4OKnS1/iwRMLr+x+z7Qj6uMJA0Lc=;
        b=fKhAWHPWp3gJXVs/SY9tADCEMElvmJkPKPL5HLUL61oUYfbQXTRRkY/snTyswEpjoI
         njrSiVtI+uE2j+UxiJ0xieErFSYAP8vb3sL4Po1pcMfGFzS7A9k9jGXTZDjhknNnJKG+
         zwr7aTZw4oIkQvjFBEgjVXUwXo3K61M0i2hhN/NLxOeCYIhVwWzv4IwmOWOpbnP2kSo+
         UTS2P602V9loDoCy4KIEltC52SrV7GOFbSszFJbrCAr9LySnMnqqbcfpYv7XofCpVtcN
         l7DcJNY+zjIjXQ9QXDXVlVKB3rLeXygcFbfNAGt9+pQlvMeyue1Upj00wJaPwTFxOMkU
         4hgQ==
X-Gm-Message-State: AOAM530ifQXPr9jI56u8O5xIa0dXdLuPLpKfQbkylFjxHAEnYTjKdxe2
        JvXfNLEWphvVdyRsQiNcyOpn
X-Google-Smtp-Source: ABdhPJwIiSX1nJKSXMYhZWUeNbdUl+4Z9bp/U0R33TfL3oylGuIpCzC7vmqPGjIjCFpWNmdS7KUyWA==
X-Received: by 2002:a63:fd01:: with SMTP id d1mr4257682pgh.319.1609937623229;
        Wed, 06 Jan 2021 04:53:43 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:53:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 01/18] ARM: dts: qcom: sdx55: Add pincontrol node
Date:   Wed,  6 Jan 2021 18:23:05 +0530
Message-Id: <20210106125322.61840-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds pincontrol node to SDX55 dts.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index ca7d4e4f5d11..08b4a40338fa 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -96,6 +96,16 @@ pdc: interrupt-controller@b210000 {
 			interrupt-controller;
 		};
 
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,sdx55-pinctrl";
+			reg = <0xf100000 0x300000>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		intc: interrupt-controller@17800000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.25.1

