Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5D2CBC9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgLBMNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgLBMNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:13:46 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:06 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so947454pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gp7OBeckObEgqLXot5tReJPINojYUVXrHZXsw2+DdVs=;
        b=S+x+hrvSq8+FsG0N0ZpBBOp/+ZOEcsOAd4JxmnltPmidpae39le5gXRSI6ii1msQx+
         irfnV8HBTNsjin69TVgL4F3t+HkCJoSpbjh858itEbjZl4b+7G1HwvqoJ9Ml4+gQI/44
         JIHwNAcXKSB19C1XVqn6VD54RFJYuCsZNlGcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gp7OBeckObEgqLXot5tReJPINojYUVXrHZXsw2+DdVs=;
        b=Q8wlKkT2hZO3nZr3Qe5koT2ATXMvDI/OtBzz59Hy6pC8RF8urj2jFgbxkPRm9lhFrO
         pkD1/YmxYlFyT+mvIbOXptH+JlYZnLtRcq89rGq2hPLLYI3eMgSeGfAz5dbVdtIOwDI1
         4/3XMUOvmNiKlTIMfnwwMl11dKOnEl6cKpiawWojWswvnTNclmwux0u5Bwv1nNuKjrI9
         6VbcJ5/MmasC9t2+pt21R4FXkz1Tev4MhljM3NDql52lXny94QTPDUvy2rayOHVWrxZg
         qagzcIWx1vgHYP4Pi392M5oUu/H+lemBmdSUS7QmuhdTo05lvcZ/66MX6QpziRllNLri
         YTVw==
X-Gm-Message-State: AOAM532xK4ngbgdJYr0zIi9Le6Hc7+LwWDQd5jjjrkBLpKIlDGcD3UG3
        WzR5BTWJBl83RwU4YzwUn3D+Gg==
X-Google-Smtp-Source: ABdhPJynZGzpV+BlMkL+sP9mtfxTqMKDKQbHTbkuZpxMBVz5mW+Z+7W6LHvV5fbvSa03YyF6aTCRKA==
X-Received: by 2002:a63:5417:: with SMTP id i23mr2344870pgb.433.1606911185632;
        Wed, 02 Dec 2020 04:13:05 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 00/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
Date:   Wed,  2 Dec 2020 17:42:31 +0530
Message-Id: <20201202121241.109952-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial series to support Engicam i.Core MX8M Mini SOM
and it's associated carrier board dts(i) support.

Add minimal changes to access and boot SD, eMMC, and the rest of 
the changes added in the coming days.

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

i.Core MX8M Mini needs to mount on top of Engicam baseboards for
creating complete platform boards.

Possible baseboards are,
- EDIMM2.2
- C.TOUCH 2.0
- C.TOUCH 2.0 10.1" Open Frame

Engicam i.Core MX8MM has PF8X00 PMIC and which is merged in linux-next,
https://lore.kernel.org/linux-devicetree/20201130112329.104614-2-jagan@amarulasolutions.com

Any inputs?
Jagan.

Jagan Teki (10):
  arm64: defconfig: Enable REGULATOR_PF8X00
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
  arm64: dts: imx: Add Engicam EDIMM2.2 Starter Kit
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SOM
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
  arm64: dts: imx: Add Engicam C.TOUCH 2.0
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1" OF
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1" OF

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   3 +
 .../dts/freescale/imx8mm-engicam-common.dtsi  |  24 ++
 .../dts/freescale/imx8mm-engicam-ctouch2.dtsi |   7 +
 .../freescale/imx8mm-engicam-edimm2.2.dtsi    |   7 +
 ...mx8mm-engicam-icore-mx8mm-ctouch2-of10.dts |  21 ++
 .../imx8mm-engicam-icore-mx8mm-ctouch2.dts    |  21 ++
 .../imx8mm-engicam-icore-mx8mm-edimm2.2.dts   |  21 ++
 .../freescale/imx8mm-engicam-icore-mx8mm.dtsi | 209 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 10 files changed, 318 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi

-- 
2.25.1

