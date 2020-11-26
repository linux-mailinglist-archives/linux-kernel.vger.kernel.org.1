Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6072C4CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbgKZBzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgKZBzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:55:03 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F73C061A52
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:55:02 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o8so322445ioh.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kC4cX8QlAj/mV9DiPMHXGpd2mMsXbrJC4NkhdR19Ci0=;
        b=U+/IrjHhDbN9b7zOOiWg7syuPWyzv4Q9/VPwxiNYSmG9XnrACcIrE3il1XsUw5kFI5
         PvmlgGvPFD0e1F/g/XqFPt3G77M4O/39tlGxnLHn2FaOJAvh8tDoNxe20m7iresby8Y1
         wjecL5BWJyisI8Yv4LU/Ozcmsurb75/Aa8xWrAGX38FgG4nmf3zcB/GlQOc9YllVGqEe
         mPGsZ5T+1nbVCAcqehLo7hTXPPjHEzhywQv7OfSFJEuLqNtTQuiFGZqfe9o5U0kF8T5t
         rgJC4xoNxtj1aJkvmymJywmT9tOYFU9aXihZw/rpia1sc6Xx4hItG/+jOQ5uB8TmI+6f
         3dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kC4cX8QlAj/mV9DiPMHXGpd2mMsXbrJC4NkhdR19Ci0=;
        b=eRjlcb5r9uiQSGyEpA0uhTgFuhqlagoQIk7+LMk7GDrbCplvXOnEZDVvVNFLRknmGQ
         aIXiaxxwJX8Y84e/MQeiP1mh1qFAlKk12lKm6MCzHUS4BVbrA8gjVZ7zW5MDNUmu219k
         gOpkb8Sg+4nLo9iUiOoDCMEAA4tD+K/XAYXSRxKv5EKqOgCpK841kRBYahGwYjy6vW9Q
         Ti36cQuamhULyHSBLIIRYcul39Hs9rB6Gyy2Xf1k+tTpUYvceJN+98+XxiNCeB0D/C6P
         VpE1FdlrA6Q9HFOSsO8EymKIpzIPerx3WBhJcU8cHWi7mcwYTaFZvSsOJEnv7gpZkxml
         vb1w==
X-Gm-Message-State: AOAM53111FUZpLrsUdp04Z6Osjbvt3Am2jFy6+pr8c5v1iRk41a9iIdB
        i9UiNIwm5x1pKSosxoSlqmiJTQ==
X-Google-Smtp-Source: ABdhPJycJ9c96dJI6sXobyQCW68aVZ++Ik9ZB+47DDelnTs+VZ1jCSjbxi81/XSCQ1gz4ISkgmho/w==
X-Received: by 2002:a02:290e:: with SMTP id p14mr1135688jap.105.1606355702321;
        Wed, 25 Nov 2020 17:55:02 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id r17sm1714907ioj.5.2020.11.25.17.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:55:01 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sc7180: use GIC_SPI for IPA interrupts
Date:   Wed, 25 Nov 2020 19:54:56 -0600
Message-Id: <20201126015457.6557-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201126015457.6557-1-elder@linaro.org>
References: <20201126015457.6557-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GIC_SPI rather than 0 in the specifiers for the two ARM GIC
interrupts used by IPA.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index eb66aadf360d7..fa379bfaa443a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1405,8 +1405,8 @@
 				    "ipa-shared",
 				    "gsi";
 
-			interrupts-extended = <&intc 0 311 IRQ_TYPE_EDGE_RISING>,
-					      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
 					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "ipa",
-- 
2.20.1

