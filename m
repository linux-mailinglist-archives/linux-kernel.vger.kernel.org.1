Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017CA2DC17C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLPNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:45:50 -0500
Received: from magratgarlick.emantor.de ([78.46.208.201]:50994 "EHLO
        magratgarlick.emantor.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLPNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:45:50 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 08:45:49 EST
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id 4BBA2103A18; Wed, 16 Dec 2020 14:35:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:79:5902:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 11E151039D7;
        Wed, 16 Dec 2020 14:35:22 +0100 (CET)
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
Subject: [PATCH 0/3] Mainline Webasto ccbv2 board
Date:   Wed, 16 Dec 2020 14:34:58 +0100
Message-Id: <20201216133501.28135-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Webasto ccbv2 device tree.

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

