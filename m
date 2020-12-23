Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC972E1B55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgLWLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgLWLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:04:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE8C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:04:18 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 11so10174746pfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wr04wRtfr+9xAJATRoyW0Odw47YG07e8A4tfkmKY6o=;
        b=la+BDoB97R8Zm2+gkZTx0LdGGdRFU5HMRB8H7Q/qdsGyuyLFPsb2rf0BHO9Oa02td3
         +0FLQP0BEYMmqcaqjbConn9GwLnFpkYdlmR2xa0KcOMRTq9E8beL/mvQtC+AoHqNLtQO
         5pw3ql63taEt54JevUkXkuZnwSxy76szfH7rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wr04wRtfr+9xAJATRoyW0Odw47YG07e8A4tfkmKY6o=;
        b=sjC1bnSpH9hyzqSe61UKC2IMkKligje3vCal6NA7apETKqDWYbr7r6vYdBAWH6UuSE
         VuWSenIZUPAdbfV21EDoeJD9u1LjSVE6q2/9JCKUSg3lrAEOdrjJ7JLuv/ERps76Yg0z
         c1Tx14/jn4+vk5fm1H7NHCyn+FsrN7lqmnYW3Btt4cJQ6bEm0Cu+6qSJvJ0lSDE84XWx
         3NS2WbEqlSR4q7BnFex4HXPjQLc7/TZg6OPdSJNomnOi0f8cWlANVeriWeaoJzBshsOf
         B4kgI6n2dTCDKW2gfduKsA/aD2JLscqBlHNXax8lWcysi3wH6D/1tXS3vxT/wwSVuQct
         q7yg==
X-Gm-Message-State: AOAM532aIwRYRhuYIrL/1r4Sxf86ekIfRFPndwZJzLXj6Mkxu8OxD4dv
        qKTZHAvDKCQAfi1zjkC8EZ4NgA==
X-Google-Smtp-Source: ABdhPJy11noMdaqdZLEFb6GtB8b60kIlaNhnZT03fFHUBdVURtMnO5Z2Ij68gj6AlDw3ZSquz7Pbvw==
X-Received: by 2002:aa7:9501:0:b029:155:3b11:d5c4 with SMTP id b1-20020aa795010000b02901553b11d5c4mr4555036pfp.76.1608721457374;
        Wed, 23 Dec 2020 03:04:17 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:eca4:40c1:8784:571c])
        by smtp.gmail.com with ESMTPSA id 3sm23275909pfv.92.2020.12.23.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:04:16 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 0/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
Date:   Wed, 23 Dec 2020 16:33:37 +0530
Message-Id: <20201223110343.126638-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial series to support Engicam i.Core MX8M Mini SOM
and it's associated carrier board dts(i) support.

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

i.Core MX8M Mini needs to mount on top of Engicam baseboards for
creating complete platform boards.

Possible baseboards are,
- EDIMM2.2
- C.TOUCH 2.0

Changes for v3:
- don't maintain common nodes and include it, if no feature diff
- keep min/max regulator hoping
- collect Krzysztof r-b
- fix dt-bindings

Any inputs?
Jagan.

Jagan Teki (6):
  arm64: defconfig: Enable REGULATOR_PF8X00
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SoM
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   8 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8mm-engicam-ctouch2.dtsi |  82 +++++++
 .../freescale/imx8mm-engicam-edimm2.2.dtsi    |  82 +++++++
 .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  |  21 ++
 .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts |  21 ++
 .../dts/freescale/imx8mm-icore-mx8mm.dtsi     | 232 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 449 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi

-- 
2.25.1

