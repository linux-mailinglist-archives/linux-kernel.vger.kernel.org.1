Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E191B280494
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbgJARIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:08:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8668E208B6;
        Thu,  1 Oct 2020 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572099;
        bh=hramfqj1yiPhhN1ZXKTQ84cPqv1i/iJ0owaU6jF6kKA=;
        h=From:To:Subject:Date:From;
        b=Qyi5JnW5nJple0OdCmBVVV4JhVs25P+v5lLnrtykRx7kzzR34j5ikNpEXVgeU4vmT
         5wPlWDS0EvJsMdnufG3hlv84JIlsBAtWKqANz3+Wn2TZg5713hKCzcWLy7/JiLXPta
         0V+GLkgrT25sUn8wPFaZoMCAeGqe3nliomGW7P0g=
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
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/12] dt-bindings: arm: fsl: fix and document compatibles
Date:   Thu,  1 Oct 2020 19:07:47 +0200
Message-Id: <20201001170759.9592-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a continuation of my series:
https://lore.kernel.org/linux-arm-kernel/20200930190143.27032-1-krzk@kernel.org/

It is rebased on top of it and finally fixes remaining i.MX2 - i.MX8
boards compatibles.

There is ongoing discussion in my previous patchset about imx6q-pico
(Technexion) board compatibles so the DTS is marked as RFC.

Best regards,
Krzysztof


Krzysztof Kozlowski (12):
  dt-bindings: vendor-prefixes: add Element14
  dt-bindings: arm: fsl: document i.MX6Q boards
  dt-bindings: arm: fsl: document i.MX6QP boards
  dt-bindings: arm: fsl: document i.MX6SL boards
  dt-bindings: arm: fsl: document i.MX6SX boards
  dt-bindings: arm: fsl: document i.MX6UL boards
  dt-bindings: arm: fsl: document i.MX6ULL boards
  dt-bindings: arm: fsl: document i.MX7S boards
  dt-bindings: arm: fsl: document i.MX7D boards
  ARM: dts: imx6q-pico: fix board compatibles
  ARM: dts: imx6sl-warp: correct vendor in compatible to Revotics
  ARM: dts: imx7s-warp: correct vendor in compatible to Element14

 .../devicetree/bindings/arm/fsl.yaml          | 157 ++++++++++++++++--
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/imx6q-pico-dwarf.dts        |   2 +-
 arch/arm/boot/dts/imx6q-pico-hobbit.dts       |   2 +-
 arch/arm/boot/dts/imx6q-pico-nymph.dts        |   2 +-
 arch/arm/boot/dts/imx6q-pico-pi.dts           |   2 +-
 arch/arm/boot/dts/imx6sl-warp.dts             |   4 +-
 arch/arm/boot/dts/imx7s-warp.dts              |   4 +-
 8 files changed, 154 insertions(+), 21 deletions(-)

-- 
2.17.1

