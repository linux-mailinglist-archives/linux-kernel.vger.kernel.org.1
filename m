Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535182C67C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgK0OXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:23:08 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:46364 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730911AbgK0OXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:23:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A7481FB03;
        Fri, 27 Nov 2020 15:23:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UOGNbgSMnLM8; Fri, 27 Nov 2020 15:23:00 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 86D434068E; Fri, 27 Nov 2020 15:22:59 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] arm64: defconfig: Enable Librem 5 hardware
Date:   Fri, 27 Nov 2020 15:22:51 +0100
Message-Id: <cover.1606486893.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables components found on Purism's Librem 5
that are available in mainline. I've split this up in one
setting per commit so in case other defconfig changes conflict
the rest remains valid. Happy to squash things if preferred.

Patches are on top of Shawn's imx/defconfig

Guido Günther (8):
  arm64: defconfig: Enable CONFIG_REGULATOR_TPS65132
  arm64: defconfig: Enable CONFIG_DRM_PANEL_MANTIX_MLAF057WE5
  arm64: defconfig: Enable CONFIG_IMX_DCSS
  arm64: defconfig: Enable CONFIG_TYPEC_TPS6598X
  arm64: defconfig: Enable CONFIG_LEDS_LM3692X
  arm64: defconfig: Enable CONFIG_VCNL4000
  arm64: defconfig: Enable CONFIG_BATTERY_MAX17042
  arm64: defconfig: Enable CONFIG_CHARGER_BQ25980

 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.29.2

