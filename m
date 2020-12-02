Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE22CBEE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgLBOAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLBOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:00:49 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE113C0613CF;
        Wed,  2 Dec 2020 06:00:08 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id p5so1597654iln.8;
        Wed, 02 Dec 2020 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pfHsg9e+X34bhemFp+mjjumsO+YWi6aCD6ygR2azqNE=;
        b=CH17/dsR0AOfrENBkIF7C+kVbcOiFobmt9ZjHdNiJKVQITe2VudIcgjXVlWgqn1vGE
         yCtAwBL7nwynGcb7Sc6Fa/6JgxfCrY2rZWHuFTUm+uM0jh8W1oiEk3BXm3kszJvsPSuT
         1CvwXYEVcsdnS8BIB+qNm07mnyJe2jl0wrE01qNeJjAOsIwN0Yaj2gStOPmyJUZRWxI8
         jUCrRAgRDqFzPolUspl9OdYqhGXdSD6agBvpLRZE1cUJdqMc9TQK5gzyFUzL7xcVjQvX
         T2tS8zfF48SARhqUOX8uv9HlN9sCFkf4tj+Tcn2yLTgDAVd8se07YYWG0m52xHLFatwY
         HWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pfHsg9e+X34bhemFp+mjjumsO+YWi6aCD6ygR2azqNE=;
        b=azum0sLxpjhkhKuw1wWv9Z/Vk7Sd5/C148Sxy7o/z5DAdmeUCW5atLnNhjlFYKHnjL
         hHbyiPosHUN+9DCeAnWGwMvdEK1MhdzOae6jBgnMUu/qlT7Qs5b4hxb/ZtXP1XUVTVao
         uUXK4sHhT+f4BkKPZ5oZwoCWRyiucL2RNXsNF6UWIKCTTCNPA2F5XtGH3kn6MM6A4TVk
         +LA0tAyaE9D2e7hU/BylSzLQv3rgnW3CO+8Gu1wju6oAtffJKa+3yN0B0KAcUwKglqUr
         lEXAcY+h3/t8XyaQwAwkB+jyT9vwpBFBlVTxu0G5HLRb5pyTb6qgQpgJgCEU0d3P3jZ4
         Y9Bw==
X-Gm-Message-State: AOAM530cxBe06XDaUBQh3vJ0DM7cMHcmDk1qcH7ofNxEBzvq5cVupIxB
        H8NqB1fKzW846UTWV0TvbDd7pvpwtQw=
X-Google-Smtp-Source: ABdhPJyGikIswzOlSp9HcsiUcCcatf6bbswTc/TEswQDEvN56gnzEJUAzr9j6dw3KJ6mkZEfOGAYdw==
X-Received: by 2002:a92:98db:: with SMTP id a88mr2474401ill.106.1606917607502;
        Wed, 02 Dec 2020 06:00:07 -0800 (PST)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id y3sm1189750ilc.2.2020.12.02.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:00:06 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: Fix WiFi Pinmuxing
Date:   Wed,  2 Dec 2020 07:59:50 -0600
Message-Id: <20201202135950.22164-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi chip is capable of communication at SDR104 speeds, and
the pinmux was configured to support this, but the sdhc1 controller
didn't properly reference the pinmux.  Enable 100Mhz and 200MHz pinmux
as was originally intended.

Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 6de86a4f0ec4..90fd15e95798 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -217,8 +217,10 @@
 &usdhc1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
-- 
2.17.1

