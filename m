Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8F2A0460
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJ3Lg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgJ3LgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFBC0613D5;
        Fri, 30 Oct 2020 04:36:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g25so5448628edm.6;
        Fri, 30 Oct 2020 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBz8lpV3BEz5nI41EelA8kr8OaTMOshWjzZxTJgUigo=;
        b=Hf4GZux6GbsdsZS95/lNPfUIBdFl7ZnLnBNMdTDStOPmBk3aZt9JFooPnW8uaqQKVZ
         v+5tIur8rTBSGdohdPD4LxroQF5EDi3sTL/APv5M2YYusFfe+sFYq9hhEx4iOIFpzfc5
         Vn8hpCeVVHNXnJ1AqV7og0SPnKNPdw9qtyVPfhzywHUZA1wmBqBuP2RzxvUBSR1/tSv4
         4KPcn6GLjDJxv4jHFcDBiiaQfAli2z0oZLF8nxpv+7L3Ru0jcyRhkatB+9HV/Srs6Ldx
         IvJ32934LwT6qOUUYeJ9dZ1KvZA53m+TYhExiH8W/7ls+Bb/2eQvJBGTMpcP54/Aqs1E
         eRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBz8lpV3BEz5nI41EelA8kr8OaTMOshWjzZxTJgUigo=;
        b=iuL67zqGg+u130HcFKMs+TV3Beq2OHxSt/HK+apA99sJVZduQCndBFF2hWvZyuHOoK
         3fPI88z7zbHYN1ilTZaM7Qhmmw1YiD8ijyndF6VGSZUNhg7cQD+ttXH9AftMSWr75RNV
         JJLEaAR7VSkyfIXFVp2NelibJWBzcnmS1p2MdApLMvrvyN6aOfsGDQhRbG27kwg0+nkE
         clo3eRZMYcOAbfP6r40biFTU0vrqY/FE94WZeCbG4kaoa6yOE8PjoAdhTehBcFNqwZdX
         wzUnFhpe+6l3k7ZoAPeQddaEFkNEbVPiCJy9gk77ElQ+A8umKA5He6ScGB4v8AwsdUJj
         hEdQ==
X-Gm-Message-State: AOAM530sbWl3vce74YRGEcDqc//Fg5nrJSFv8PY6SNCpNBmiTKEnn1kA
        KLC32E0PAN3UV7gXqHWUlEo=
X-Google-Smtp-Source: ABdhPJyLWN5+FkmjEe3yDdE6H23aMerOkRptmfO5N+mQYRmLrx2okTC2/hgaUmBuJOFF2Mze+DbKDQ==
X-Received: by 2002:a05:6402:74f:: with SMTP id p15mr1849925edy.69.1604057779508;
        Fri, 30 Oct 2020 04:36:19 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:18 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 03/11] arm64: dts: ls1088a: add external MDIO device nodes
Date:   Fri, 30 Oct 2020 13:35:47 +0200
Message-Id: <20201030113555.726487-4-ciorneiioana@gmail.com>
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
 - used only lowercase letters for the hex address

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index ff5805206a28..58b6a5aa8df2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -672,6 +672,24 @@ ptp-timer@8b95000 {
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
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-- 
2.28.0

