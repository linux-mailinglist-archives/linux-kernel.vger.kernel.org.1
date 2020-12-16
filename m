Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D32DC411
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgLPQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLPQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:25:21 -0500
X-Greylist: delayed 10153 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Dec 2020 08:24:41 PST
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D531C061794;
        Wed, 16 Dec 2020 08:24:41 -0800 (PST)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id AD637103AE3; Wed, 16 Dec 2020 17:24:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:79:5902:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 7AA12103AD0;
        Wed, 16 Dec 2020 17:24:37 +0100 (CET)
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     kernel@pengutronix.de,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM AND ARM64 SoC
        SUB-ARCHITECTURES (COMMON PARTS)),
        linux-kernel@vger.kernel.org (open list),
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 0/3] Mainline Webasto ccbv2 board
Date:   Wed, 16 Dec 2020 17:24:29 +0100
Message-Id: <20201216162433.9138-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Webasto ccbv2 device tree.

v2:
- add correct mailing lists to cc
- add commit message for vendor-prefix and dt-bindings

Rouven Czerwinski (3):
  dt-bindings: vendor-prefixes: add Webasto SE
  ARM: dts: add Webasto ccbv2
  dt-bindings: arm: fsl: add Webasto ccbv2

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6ul-webasto-ccbv2.dts    | 472 ++++++++++++++++++
 4 files changed, 476 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-webasto-ccbv2.dts


base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.29.2

