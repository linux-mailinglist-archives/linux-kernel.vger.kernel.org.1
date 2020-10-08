Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2079287702
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgJHPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgJHPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:19:46 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4838DC061755;
        Thu,  8 Oct 2020 08:19:45 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g7so6479712iov.13;
        Thu, 08 Oct 2020 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OadWliMkKsOGtnfiZb5kyGf0zP5P3Ecr/Kuunrt0F6s=;
        b=mTZuT1H1PlfrlHcAhSp3oC3GdYDRhwWX+qpevfSkSWvFxLIDr4EyeR+WjQI5VcFKJy
         RIBmGwQOl6ZTAihIVlBgf8+TuepD0elpkYopZJZzfe4GNZRan6NMrOeJqL89XaHSDU4j
         O3YEJPE2QqGNmUjdecmyF+aAo9y4jrwIplP8U/Omfjipzo6oXhzId3xZkCnlSP0kTPQe
         ak3ZGqaqsyfU8SOKL8r4jCBYJs9RSk6wxwQXsEOKbrX2TdqqFv/XK6Nhwrw6j5O2fSyP
         6cdPb6isZ23eF8iBxqRYuimg4VLZii3ZARC+swE05P4GZL18XuZfqMn4coHOONYffjWB
         FtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OadWliMkKsOGtnfiZb5kyGf0zP5P3Ecr/Kuunrt0F6s=;
        b=cfnO3AZSkucvceSQkUC4OQBlwXheenOeoA+5WoETIkzvyJ4PtIlrCbXue1QNZIvHUV
         OKVMonvny8bQOOR/0IvPGrwTm9Gguvc8jVqMSZFL+lsZjL1bJxNGy1yIux77m0ilUZf7
         jfPrh7cuDZoBZCNUCGdd7ZfPa4zNFsmdm8gxzx+tSPitrwuYf7CDyxWB0XxuH9UACRoG
         dgLHOluiEBHYVkFhrXqfaLJECpWSq/a9c8ct5a3c2iFMBoOrNCnAbkZ5MC9pCI8HgnzB
         mUGf1sod1ZR4PsGwz4VAtT+jpaWOSyW6eGCUIis1XqgkhkuveH5Z0bRxH+PSwWLaceUA
         SFlA==
X-Gm-Message-State: AOAM5330pE//PPdNUab76dk45ZboaS6lCo6FUQDHe3HpWAz5bKhAJ9Qh
        2WMyBmrAg/ifwu24pnduLMs=
X-Google-Smtp-Source: ABdhPJykn44k7sBEiZTov9IAqd9gIEG+a5joQb+wOztH6kQ2UZh/wTpdFidqRM3i5usLgK2isDrOiw==
X-Received: by 2002:a05:6602:5ca:: with SMTP id w10mr6453076iox.60.1602170384485;
        Thu, 08 Oct 2020 08:19:44 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id x14sm2774342ilg.21.2020.10.08.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:19:43 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts imx8mn: Remove non-existent USB OTG2
Date:   Thu,  8 Oct 2020 10:19:33 -0500
Message-Id: <20201008151933.716363-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the i.MX8MN TRM, there is only one OTG port.  The
address for OTG2 is reserved on Nano.

This patch removes the non-existent OTG2.

Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 746faf1cf2fb..ac206e1f2dad 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -791,21 +791,6 @@ usbmisc1: usbmisc@32e40200 {
 				reg = <0x32e40200 0x200>;
 			};
 
-			usbotg2: usb@32e50000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
-				reg = <0x32e50000 0x200>;
-				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
-				assigned-clocks = <&clk IMX8MN_CLK_USB_BUS>,
-						  <&clk IMX8MN_CLK_USB_CORE_REF>;
-				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>,
-							 <&clk IMX8MN_SYS_PLL1_100M>;
-				fsl,usbphy = <&usbphynop2>;
-				fsl,usbmisc = <&usbmisc2 0>;
-				status = "disabled";
-			};
-
 			usbmisc2: usbmisc@32e50200 {
 				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
 				#index-cells = <1>;
-- 
2.25.1

