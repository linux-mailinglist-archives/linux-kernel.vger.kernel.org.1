Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE762EF2BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAHM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:57:57 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44914 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbhAHM54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:57:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 73AE8FB07;
        Fri,  8 Jan 2021 13:57:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h7VCpUe-W-dd; Fri,  8 Jan 2021 13:57:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8C0B640885; Fri,  8 Jan 2021 13:57:10 +0100 (CET)
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
Subject: [PATCH v3 0/4] Config and device tree updates for the Librem 5 development kit
Date:   Fri,  8 Jan 2021 13:57:06 +0100
Message-Id: <cover.1610110514.git.agx@sigxcpu.org>
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
independently. The series was tested against next-20200108 and i made sure the
defconfig changes also apply on top of Shawn's /imx/defconfig and the DT
changes to Shawn's imx/dt64.

changes from v2:
- Add Reviewed-by from Krzysztof Kozlowski, thanks!
- Add NXP PTN5110HQZ to defconfig

changes from v1:
- as per review comments by Krzysztof Kozlowski <krzk@kernel.org>
  https://lore.kernel.org/linux-arm-kernel/20201215091729.GC29321@kozik-lap/
  - describe hardware parts not config options
  - rework commit messages to give more details
- don't keep buck3 always on but rather make sure the board
  doesn't hang when resuming the gpu power domain.
  There's a generic fix pending for that helps all boards
  https://lore.kernel.org/lkml/beba25e85db20649aa040fc0ae549895c9265f6f.camel@fi.rohmeurope.com/

Guido Günther (4):
  arm64: defconfig: Enable Librem 5 devkit components
  arm64: dts: imx8mq-librem5-devkit: Tweak pmic regulators
  arm64: dts: imx8mq-librem5-devkit: Disable snvs_rtc
  arm64: dts: imx8mq-librem5-devkit: Drop custom clock settings

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 20 ++++++++++++++-----
 arch/arm64/configs/defconfig                  |  9 +++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.29.2

