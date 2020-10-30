Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29A92A046C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgJ3LiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgJ3LgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA11EC0613D2;
        Fri, 30 Oct 2020 04:36:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg9so6223488edb.12;
        Fri, 30 Oct 2020 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tlEzE6C1VQeXr9jc1VNNdwhwwH8y0PAFW8m/un2sGo=;
        b=aEoHRuhrti1m79g1tsGn5C4ugVzGICJc3E4OLNx0A8xvhNmO4YKcHsc0RUKt2Z7V/4
         1wtfae8OrR0AAkD1xLWVjVqgzsH8PXvbjLdHbWkaTWAM8s9Ynbw3gITkgwpS74r1NnCC
         UYBmZ8fx6m750rPGJ/W7Tc+ZsqFLJBBfTQ9BY2s3+5XsHzKxsvPP45WKISoqa5Ohyk/h
         RzQcxWrIvxM1/Z7b7xI51dpNaSTtkYzX5ZbtX4YaNxGpS5qmFH1ZcL94w3qCiz1iN+2O
         rjvZlkD+EU5sbnUifDytwHf2fgWg1Cxyx7z71c9K2JaCdwVecIGQZoJ2/kdvj1mjaPj8
         FLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tlEzE6C1VQeXr9jc1VNNdwhwwH8y0PAFW8m/un2sGo=;
        b=gcu6cl2yJzoN8x40MhvfYfNzOqdSvUWsVn2Tj86HKR5TYlC0fYbk1NCk/UViWeSOMB
         XCXoWin9ugt3i4uUTRsY+b7tU7LviMS4lo/fY8T4RXyljvdr8zykZR0yLI74rhwf6iD+
         bRrZxReE/tUJv/zt0fm7ccQ2NolK6EkO8cbQy1daQYwDysfCPNZePlcA01OE7td97Sj0
         lj+mC+OBMM9mmlMDRYVke3RUDTJZOJy9x4Tdm1eWVgbcnZnDk/4XWlta40t2rHKfcDHw
         87+GGDBWPolG2n1jDo1o0HYF7LL/pwbP8TeqcN4jhMCiiNggKTfMWponOiGF/5NDRkRf
         JgKg==
X-Gm-Message-State: AOAM5328C5VDps5I/owf2GhCd23Hhc2t+HnlJQ9uEgDHejDW012sspBP
        vDL0CNGlht0CA07Mn97NCAI=
X-Google-Smtp-Source: ABdhPJyleycFGkXFkZqQwWGk1TDEoyRSvGyEEGGSD3qNibcCy6+sTHI6Ur+scVo2PaWC+/f2YXL3Pg==
X-Received: by 2002:a50:c38e:: with SMTP id h14mr1877675edf.174.1604057783596;
        Fri, 30 Oct 2020 04:36:23 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:23 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 06/11] arm64: dts: ls208xa: add the external MDIO nodes
Date:   Fri, 30 Oct 2020 13:35:50 +0200
Message-Id: <20201030113555.726487-7-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add the external MDIO device nodes found in the WRIOP global memory
region. This is needed for management of external PHYs.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - removed the 0x from the unit addresses
Changes in v3:
 - none
Changes in v4:
 - none
Changes in v5:
 - used only lowercase letters for the address

 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index bf72918fe545..4f59937793ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -458,6 +458,24 @@ ptp-timer@8b95000 {
 			fsl,extts-fifo;
 		};
 
+		emdio1: mdio@8b96000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8b96000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		emdio2: mdio@8b97000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8b97000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
-- 
2.28.0

