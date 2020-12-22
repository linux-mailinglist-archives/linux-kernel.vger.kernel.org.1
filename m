Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C942E0349
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLVALD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLVALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:11:02 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:10:22 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id k7so2608150ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkeUuRBSMYupYeqs3Fxfe8LsOkubv80hcNOts5V5138=;
        b=wgzgkG6AhM1e2Ul0DpLAewBrwAlTmaXBEYZ+gZExTiD8OwqTsiWnvD0+p02e0Zu/LU
         xA4JixDrlt/T8Dpv6l/Aoc0QdNQQnj+6ju0qvBDIbJbB9HHrreFIihMhDtRqlYNmgtkW
         PVRAebnY/pdj5HHP7ml2vXsWmGA+jSevIHbO4QfbkrGLO+i9w4HpkTibM+rzesdXbpLV
         t9gGejJDr33juy2WA4fWeORmGuqDsuO3rE9TsCmJTMtv3p40X9D6iPFmdEWwVhZg5Mer
         sQbwGKbu6Bix6GSRagImADIq4T4zZwUPUnd15wfS4wUDxboPoX97Er2gRSYN/bEbJIvq
         ZqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkeUuRBSMYupYeqs3Fxfe8LsOkubv80hcNOts5V5138=;
        b=rVbd8WSQuX/VjQ/FE93SF5aLL/0Ev+uyoz9LTiWF+16eY96SfSCy5DRWK+t1aP4g+2
         PcDWa/J0pa1P1pos0ZX595Fm93s4E4B3aruReCuug2hLFqaJ7zaxDcXBNPvBHeKPh4XA
         j3tLUFpq2FXXbt+yobai17F5NGLnsknVb2dngRTE9lpiZu034JtmgJf8qBkQhgL6uzEY
         gMEFV3giR0Cu66MEJc0yssAqqlTGTJ76YlTRYhTUZ3WizVlUhRvFbVF6Rqnpf+WRFr7K
         BsY39t32yIwG1sIHKS1H5I2SnnfY83ltGb8NxXhWvEggw5mzxKOgUolzR+V2cX0eqq/d
         Qbow==
X-Gm-Message-State: AOAM532TDdUrWO7Pwa15EdGvosvhCLwoEf12CLSNSczjoooCM87JI2wI
        GQEV0Bbp8RXRvzLEgg28BgsQsg==
X-Google-Smtp-Source: ABdhPJz3lSFUkmACZL9GfaZlGA7JuhqWjNMRj0w2yYSCcHavfnN0W6pig+ORUGr8NpUzuHIgFm0M3g==
X-Received: by 2002:a4a:3001:: with SMTP id q1mr13229599oof.88.1608595821650;
        Mon, 21 Dec 2020 16:10:21 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u3sm4143813otk.31.2020.12.21.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:10:20 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Reserve LPASS clocks in gcc
Date:   Mon, 21 Dec 2020 16:11:03 -0800
Message-Id: <20201222001103.3112306-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC_LPASS_Q6_AXI_CLK and GCC_LPASS_SWAY_CLK clocks may not be
touched on a typical UEFI based SDM845 device, but when the kernel is
built with CONFIG_SDM_LPASSCC_845 this happens, unless they are marked
as protected-clocks in the DT.

This was done for the MTP and the Pocophone, but not for DB845c and the
Lenovo Yoga C630 - causing these to fail to boot if the LPASS clock
controller is enabled (which it typically isn't).

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 4 +++-
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 7cc236575ee2..c0b93813ea9a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -415,7 +415,9 @@ &dsi0_phy {
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
-			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_LPASS_Q6_AXI_CLK>,
+			   <GCC_LPASS_SWAY_CLK>;
 };
 
 &gpu {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 13fdd02cffe6..87ffbb89fbc7 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -302,7 +302,9 @@ &dsi0_phy {
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
-			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_LPASS_Q6_AXI_CLK>,
+			   <GCC_LPASS_SWAY_CLK>;
 };
 
 &gpu {
-- 
2.29.2

