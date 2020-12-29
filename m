Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96B2E7018
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgL2Ls3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2Ls3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:29 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A78C0613D6;
        Tue, 29 Dec 2020 03:47:48 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5CDD722EE4;
        Tue, 29 Dec 2020 12:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VrXbXLZtCoumKFxMp1+LesYeK4uPvY4I2rBFNv+DLVw=;
        b=fN3wAdzqZxlMqIoLQDqHH46ENIluyavZ/Hezwr0Yf0c9v9B09V7DpfEUuwE5O7+BS0NboT
        UmSHdpHtE36Gd4hEPZ/B3wWttudTdBKjp4Ke4mIhqiO/9AXPHK3W67OGFkHlqJuFfal30q
        cOqxKWPTtfQr6Pl1YaHz9jTil1UM8Jw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/7] arm64: dts: fsl: use the new clockgen constants
Date:   Tue, 29 Dec 2020 12:47:33 +0100
Message-Id: <20201229114740.7936-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4cb15934ba05 ("clk: qoriq: provide constants for the type")
there are constants for better readabilty. This series will use them for
all arm64 device trees.

This is just a mechanical change. The change was done with the following
script:

$ sed -e 's/<&clockgen 0 \([0-9]\)>/<\&clockgen QORIQ_CLK_SYSCLK \1>/g' \
      -e 's/<&clockgen 1 \([0-9]\)>/<\&clockgen QORIQ_CLK_CMUX \1>/g' \
      -e 's/<&clockgen 2 \([0-9]\)>/<\&clockgen QORIQ_CLK_HWACCEL \1>/g' \
      -e 's/<&clockgen 3 \([0-9]\)>/<\&clockgen QORIQ_CLK_FMAN \1>/g' \
      -e 's/<&clockgen 4 0>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>/g' \
      -e 's/<&clockgen 4 1>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>/g' \
      -e 's/<&clockgen 4 3>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4)>/g' \
      -e 's/<&clockgen 4 7>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(8)>/g' \
      -e 's/<&clockgen 4 15>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(16)>/g' \
      -i \
         arm64/boot/dts/freescale/fsl-ls1012a.dtsi \
         arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts \
         arm64/boot/dts/freescale/fsl-ls1028a.dtsi \
         arm64/boot/dts/freescale/fsl-ls1043a.dtsi \
         arm64/boot/dts/freescale/fsl-ls1046a.dtsi \
         arm64/boot/dts/freescale/fsl-ls1088a.dtsi \
         arm64/boot/dts/freescale/fsl-ls2080a.dtsi \
         arm64/boot/dts/freescale/fsl-ls2088a.dtsi \
         arm64/boot/dts/freescale/fsl-ls208xa.dtsi \
         arm64/boot/dts/freescale/fsl-lx2160a.dtsi \
         boot/dts/freescale/qoriq-fman3-0.dtsi

Afterwards the changes were manually clean-up for proper indendation, the
include file was added and split into individual commits per SoC.

Michael Walle (7):
  arm64: dts: ls1012a: use constants in the clockgen phandle
  arm64: dts: ls1028a: use constants in the clockgen phandle
  arm64: dts: ls1043a: use constants in the clockgen phandle
  arm64: dts: ls1046a: use constants in the clockgen phandle
  arm64: dts: ls1088a: use constants in the clockgen phandle
  arm64: dts: ls208xa: use constants in the clockgen phandle
  arm64: dts: lx2160a: use constants in the clockgen phandle

 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  60 +++++--
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    |   5 +-
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 162 +++++++++++++-----
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  73 +++++---
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  73 +++++---
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  91 +++++++---
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  17 +-
 .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  17 +-
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  85 ++++++---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  92 ++++++----
 .../boot/dts/freescale/qoriq-fman3-0.dtsi     |   6 +-
 11 files changed, 465 insertions(+), 216 deletions(-)

-- 
2.20.1

