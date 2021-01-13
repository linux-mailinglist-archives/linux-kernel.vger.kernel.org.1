Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC32F4BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbhAMMyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:54:04 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44084 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbhAMMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:54:04 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3462B200400;
        Wed, 13 Jan 2021 13:53:17 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2724E2003FE;
        Wed, 13 Jan 2021 13:53:17 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C673220309;
        Wed, 13 Jan 2021 13:53:16 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] MAINTAINERS: Add section for NXP i.MX clock drivers
Date:   Wed, 13 Jan 2021 14:53:08 +0200
Message-Id: <1610542388-12078-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section for NXP i.MX clock drivers and list myself
as the maintainer.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2894657..9eafd4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12827,6 +12827,13 @@ F:	drivers/iio/gyro/fxas21002c_core.c
 F:	drivers/iio/gyro/fxas21002c_i2c.c
 F:	drivers/iio/gyro/fxas21002c_spi.c
 
+NXP i.MX CLOCK DRIVERS
+M:	Abel Vesa <abel.vesa@nxp.com>
+L:	linux-clk@vger.kernel.org
+L:	linux-imx@nxp.com
+S:	Maintained
+F:	drivers/clk/imx/
+
 NXP i.MX 8MQ DCSS DRIVER
 M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
 R:	Lucas Stach <l.stach@pengutronix.de>
-- 
2.7.4

