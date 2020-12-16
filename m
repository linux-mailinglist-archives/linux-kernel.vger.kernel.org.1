Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB902DC630
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgLPSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:23:16 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:45126 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgLPSXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:23:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 25845FB04;
        Wed, 16 Dec 2020 19:22:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lot8rLTxDS_T; Wed, 16 Dec 2020 19:22:33 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B35B043FDC; Wed, 16 Dec 2020 19:22:32 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Wed, 16 Dec 2020 19:22:32 +0100
Message-Id: <cover.1608142884.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to shut down the mipi power domain on the imx8. The alternative
would be to drop the dphy from the mipi power domain in the SOCs device tree
and only have the DSI host controller visible there but since the PD is mostly
about the PHY that would defeat it's purpose.

This is basically a resend from February 2020 which went without feedback.

This allows to shut off the power domain hen blanking the LCD panel:

pm_genpd_summary before:

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
mipi                            on
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

after:

mipi                            off-0
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

Changes from v1:
 - Tweak commit message slightly

Changes from v2:
  - As pre review comment by Lucas Stach
    https://lore.kernel.org/linux-arm-kernel/ee22b072e0abe07559a3e6a63ccf6ece064a46cb.camel@pengutronix.de/
    Check for pm_runtime_get_sync failure

Guido Günther (1):
  phy: fsl-imx8-mipi-dphy: Hook into runtime pm

 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
2.29.2

