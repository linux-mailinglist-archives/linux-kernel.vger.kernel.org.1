Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1373C27F22E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgI3TBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgI3TBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:01:52 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B705120708;
        Wed, 30 Sep 2020 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492511;
        bh=sOXQXh8knxv1AF9xNNR8yw3Dd9cyJ6Qbl/YyFiJMgl4=;
        h=From:To:Subject:Date:From;
        b=g9gP4ZdPP5ydl5PIzqYuXaghjmilQAsIWz3/WQmHGEKLRbk2gT97p3WKnBEfVI9h6
         dMc6syNFKeBZgWNpCuaQncIktcQI6ufVkwl7pDumawkDnib4HRwkpRlNRHGvrYES5i
         FkQ14/XPzPo7AZq3q7urL+tWvyPDnjU2Pql1SQmA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/12] ARM: dts: imx: Board compatibles cleanup
Date:   Wed, 30 Sep 2020 21:01:31 +0200
Message-Id: <20200930190143.27032-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Drop applied vendor-prefix patches.
2. Add Reviews from Rob.
3. Use ABB prefix for Aristainetos boards.
4. Add missed compatibles for i.MX51, i.MX53 and i.MX6DL.
5. Fix typo (VF600 -> VF610) in VF boards.
6. New vendor prefixes (patches): #1 and #2.

Best regards,
Krzysztof


Krzysztof Kozlowski (12):
  dt-bindings: vendor-prefixes: add MicroSys
  dt-bindings: vendor-prefixes: add Revotics
  dt-bindings: arm: fsl: document i.MX25 and i.MX27 boards
  dt-bindings: arm: fsl: document i.MX51 boards
  dt-bindings: arm: fsl: document i.MX53 boards
  dt-bindings: arm: fsl: document VF boards
  dt-bindings: arm: fsl: document i.MX6DL boards
  ARM: dts: imx6dl-pico: fix board compatibles
  dt-bindings: vendor-prefixes: add ABB
  dt-bindings: arm: fsl: document i.MX6DL Aristainetos boards
  ARM: dts: imx6dl: add compatibles for Aristainetos boards
  dt-bindings: arm: fsl: document i.MX6Q boards

 .../devicetree/bindings/arm/fsl.yaml          | 223 ++++++++++++++++--
 .../devicetree/bindings/vendor-prefixes.yaml  |   6 +
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts  |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts  |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts   |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts   |   2 +-
 arch/arm/boot/dts/imx6dl-pico-dwarf.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-pico-hobbit.dts      |   2 +-
 arch/arm/boot/dts/imx6dl-pico-nymph.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-pico-pi.dts          |   2 +-
 10 files changed, 216 insertions(+), 29 deletions(-)

-- 
2.17.1

