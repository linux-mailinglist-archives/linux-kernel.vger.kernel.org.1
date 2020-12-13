Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3032D8EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405402AbgLMRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 12:18:03 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59732 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404443AbgLMRR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 12:17:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E77E0FB07;
        Sun, 13 Dec 2020 18:17:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W9cTa25Cdr9d; Sun, 13 Dec 2020 18:17:15 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 278B743FDC; Sun, 13 Dec 2020 18:17:14 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH 0/4] Config and device tree updates for the Librem5 Devkit
Date:   Sun, 13 Dec 2020 18:17:10 +0100
Message-Id: <cover.1607879709.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This enables more components to get a working display, panel, audio and
sensors. It also updates some device tree bits to make mainline boot.

I've skipped wifi (which needs some more driver work) and devfreq (since Martin
is working on that).

The config changes don't depend on the DT parts so could be applied
independently.  The series was tested against next-20201209 and i made sure the
defconfig changes also apply on top of shawnguo/imx/defconfig.

Guido Günther (4):
  arm64: defconfig: Enable Librem5 Devkit components
  arm64: dts: imx8mq-librem5-devkit: Disable snvs_rtc
  arm64: dts: imx8mq-librem5-devkit: Mark more regulators as always-on
  arm64: dts: imx8mq-librem5-devkit: Drop custom clock settings

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 28 +++++++++----------
 arch/arm64/configs/defconfig                  |  8 ++++++
 2 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.29.2

