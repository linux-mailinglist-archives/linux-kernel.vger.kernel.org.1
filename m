Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF042DF639
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgLTRAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 12:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgLTRAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 12:00:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A488C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 08:59:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h22so8540103lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 08:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ACQLhZ/DjpUcMSHfzCdjeEO3CADfnxSX7nisOAf+8Q=;
        b=f1/S2sTpGE9/fYtha/WIr/3vCQN3IQxnl/mvseRqKym0ugFOUyzxA3tRVf7uJBxreo
         zFcuekdLmGBV4KyjOt6btzaQqDc6egCNQTJ0eRvysZcEmYqoLZQmkvek7TT7FShFIl0F
         dAcoFuHN5SxLzePJa7u81EOjoK6PDyAOW14uEdeEFMqabHd2W83hPxfkXAhV7iUdCDRh
         QnGL9B7bsMf3NzJQYj32ZvF+Xye4VLw44Jm3UBbTUiOKcx01iY90JSHRtB8Ql77TW+30
         siTDMTnUSYCeIyM7niGNiPGXU/xP3py3zywKtx5/wOw7MHbGbazQNAO01LioB0Xjxjsj
         aK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ACQLhZ/DjpUcMSHfzCdjeEO3CADfnxSX7nisOAf+8Q=;
        b=E/aBpAlLadnw3am7LGb4CbdsPDj38HoukQg709omzJeXeI2InsoDdGNkW0tt90aKm8
         cN1xcINTd/DRxAKQbZk4KnibE57vEUE+OuWlQSiBSC0yMzf7Oi+AvEjKLbac6tKDreQG
         TKOJtfMYl2tA6hUQArCPXIiAtn6D5tk2qXwlmX43G7aixHmMCNFkIVtZ10p+8CW+8JzR
         uP1KzzVSXzreMlhjbEgOEJH1y1tdXtx/9F+uy1ac6X9Mm1mgCwF/XwfWaapWImw7nYXK
         MejUzSEGdA8hr02oB6H1jNjjwfkGZMIL7IuOKXxKPzBfOJk/y3vJtqmkPJBsg2v4xU/c
         0DZQ==
X-Gm-Message-State: AOAM531xALD3Il1gDX9GnfTX/CtbF/lAiGxOqgGdDZwNi+d5HewD8BCT
        9GmjqLdBpxOPuHByTJ6rBSf3Ng==
X-Google-Smtp-Source: ABdhPJyomwhvZ8n02afXuxM0EgqV2KwweS7Ki1b1xSd1dZQ7LcO8fa5dYyNZFvPPOh6v3hagydZaUQ==
X-Received: by 2002:a2e:2284:: with SMTP id i126mr5868907lji.93.1608483540121;
        Sun, 20 Dec 2020 08:59:00 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.15])
        by smtp.gmail.com with ESMTPSA id t30sm1696638lft.266.2020.12.20.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 08:58:59 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dtb: qcom: qrb5165-rb5: add power domain to pcie0 phy
Date:   Sun, 20 Dec 2020 19:58:45 +0300
Message-Id: <20201220165845.3712599-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201220165845.3712599-1-dmitry.baryshkov@linaro.org>
References: <20201220165845.3712599-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If QCA6391 chip (connected to PCIe0) is not powered at the PCIe probe
time, PCIe0 bus probe will timeout and the device will not be detected.
To ease device power up support, use qca639x as pcie0 phy power-domain.
This allows us to make sure that QCA6391 chip is powered on before PCIe0
probe happens.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index e6bab9960cea..9aa7793cd7c0 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -457,6 +457,9 @@ &pcie0_phy {
 	status = "okay";
 	vdda-phy-supply = <&vreg_l5a_0p88>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
+
+	/* Power on QCA639x chip, otherwise PCIe bus timeouts */
+	power-domains = <&qca639x>;
 };
 
 &pcie1 {
-- 
2.29.2

