Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194192A8765
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgKETfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbgKETfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:35:20 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529CC0613CF;
        Thu,  5 Nov 2020 11:35:20 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 52D3C22F99;
        Thu,  5 Nov 2020 20:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=neMeSekzaAOM6uqf+1gwm202RIk2AZiqN2dpHLhDA9s=;
        b=A8Df9VDwQZ24vyDkWrR/M783tkkWZoZs+RaiwlVXP9THuoeRBT1ZcqBdAUHVcY1SeNtsmR
        oPNaJ9z7zUK2voNcjSrDvYZXVdnaliZaNmHvhjD2jsnY27wlJxiUc8FpyGmpL1LqotRmxX
        HpjDoj9ZTFD4NSKC43h0yIZPmy+suoY=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/5] clk: add fsl-flexspi driver
Date:   Thu,  5 Nov 2020 20:35:07 +0100
Message-Id: <20201105193512.22388-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Layerscape SoCs which feature the FlexSPI controller there is
a single register which can control the divider value. The base
frequency is the platform PLL.

Right now the LS1028A and the LX2160A aren't able to switch the
SCK frequency on the FlexSPI interface. Add a new clock driver
which operate on said register.

Michael Walle (5):
  clk: divider: add devm_clk_hw_register_divider_table()
  dt-bindings: clock: document the fsl-flexspi-clk driver
  clk: fsl-flexspi: new driver
  arm64: dts: ls1028a: fix FlexSPI clock
  arm64: dts: lx2160a: fix FlexSPI clock

 .../bindings/clock/fsl,flexspi-clock.yaml     |  55 +++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  15 ++-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  15 ++-
 drivers/clk/Kconfig                           |   8 ++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-divider.c                     |  34 ++++++
 drivers/clk/clk-fsl-flexspi.c                 | 106 ++++++++++++++++++
 include/linux/clk-provider.h                  |  27 +++++
 8 files changed, 257 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,flexspi-clock.yaml
 create mode 100644 drivers/clk/clk-fsl-flexspi.c

-- 
2.20.1

