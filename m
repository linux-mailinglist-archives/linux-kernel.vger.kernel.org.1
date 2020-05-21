Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB41DC434
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 02:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEUAuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 20:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgEUAt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:49:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB242C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:49:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so5009057wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6KiBFrklNFDtd7Hjtt5HuZ2kC5pUp1U1wrXq0Utuf4=;
        b=SeQfB26SC7fEFLPZyf1wTJC3WJ/vo9u9XJ/iu+jXyEWp73AYgiCa/9bx0/fttc7k6J
         jY7ijhqlpFkMZykbho83INFv2az4dPTBipvWbqLaUrEN2ums3lCMsO+0wJv8h3+/Nb1g
         1ydpBVRq4jxoM0AkU1/bkPsoqxOelsvu8zIZKvJHjcBjLX3YlTfrUcnOmUaB7JmFUF9I
         nozbyaiQZ/37+JV37VkMjTrc1LyPWr3+jqXOKHcycbS80QsZsBjEfRWQLtvEv9b9Xvbe
         Z/PTSW7Ft2WNIjX15ehsVNYAFx1fdn09eEAzgd82fpRnTOQA+/SH2pmCXf3/078Nrv8g
         ZZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6KiBFrklNFDtd7Hjtt5HuZ2kC5pUp1U1wrXq0Utuf4=;
        b=AL9Sg7VVM+hY+pzYFzrxrcZGi6Mv+ssGjclz14T2Y9um1rKmzrpwd8Dx4V8cBHo/AT
         KOIudSlaPZYttoXpOoC4LPfzo5KfKdZE5vV9WzCZ1jAqCb8VJxUe6A4y4NAUCwtMijz1
         7TljSUkMxJrFgy+8MXw6xjb8xivC4ail5G61/XJIYSCMaL5HFQspRqAlVDBqPAQqrztK
         jHNXpSWKX9YaosWRLLE3soV05RLV88Dac01bSdhk6QqsuNF21Ny3PQqe3dvaIPRsTed2
         mPyrYTmu8DtfOuY24QjljpRQ1I4u3xYvRpAKj209zNuu6v+Q09VDdsxuejfVFT87OoEK
         +xjQ==
X-Gm-Message-State: AOAM531qyFUvlwErLNUsMuLEvaG5F9F5yEmtguWD8xG7PU2CuKFMSdpS
        rxCUPQcCZb78rA4ZZJ0y9hAliA==
X-Google-Smtp-Source: ABdhPJw9f6aqi3+o81frESGZXUeNPWrqgx/DU+W1LN1KdORszG8GYl97k5eJzrk2BLMcfDAb9Z6How==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr6045967wrm.72.1590022195552;
        Wed, 20 May 2020 17:49:55 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s15sm4536798wro.80.2020.05.20.17.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:49:55 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, bryan.odonoghue@linaro.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/2] dt-bindings: phy-qcom-usb-hs-phy: Add qcom,enable-vbus-pullup
Date:   Thu, 21 May 2020 01:50:30 +0100
Message-Id: <20200521005031.747162-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521005031.747162-1-bryan.odonoghue@linaro.org>
References: <20200521005031.747162-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a dt-binding for qcom,enable-vbus-pullup. The binding
qcom,enable-vbus-pullup tells the HS USB PHY driver whether it should set
and unset the internal VBUS pullup bits when starting/stopping the USB PHY.

Setting the pullup bits is something you want to do if you have not routed
VBUS to a GPIO on the SoC and thus cannot use extcon with the current
switching logic in the PHY.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
index b3b75c1e6285..77e9bf1f8ba2 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
@@ -64,6 +64,12 @@ PROPERTIES
                 from the ULPI_EXT_VENDOR_SPECIFIC address, for example,
                 <0x1 0x53> would mean "write the value 0x53 to address 0x81".
 
+- qcom,enable-vbus-pullup:
+   Usage: optional
+   Value type: <bool>
+   Definition: Flag to indicate if the USB PHY driver should toggle internal
+               VBUS line pullup bits when powering the PHY on or off.
+
 EXAMPLE
 
 otg: usb-controller {
-- 
2.25.1

