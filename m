Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFA2B4EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgKPSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 13:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbgKPSOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:14:06 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D955E2078E;
        Mon, 16 Nov 2020 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605550446;
        bh=rryR7gEWIpjU4vN8PjeQodDDv/FqOgqr5+c2J5MS73o=;
        h=From:To:Cc:Subject:Date:From;
        b=UwoPRnA1ZTXNbn9yuyqT4A+6bIRkE02jOB4LE7zvhPv0bxIK6coVhLIwBItPlmOnf
         QCtWcFcfFvIoXffGdrKIP4t3gVQ/72/IzdIUxpFXb869k89agGwSjmyooEuVpmJCTs
         XpaYSpj/jJyK4biO4tlobknPh8yoQVoMjP9RN/2A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] drm/imx: depend on COMMON_CLK to fix compile tests
Date:   Mon, 16 Nov 2020 19:14:00 +0100
Message-Id: <20201116181400.543718-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iMX DRM drivers use Common Clock Framework thus they cannot be built
on platforms without it (e.g. compile test on MIPS with RALINK and
SOC_RT305X):

    /usr/bin/mips-linux-gnu-ld: drivers/gpu/drm/imx/imx-ldb.o: in function `imx_ldb_encoder_disable':
    imx-ldb.c:(.text+0x400): undefined reference to `clk_set_parent'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/imx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
index 6231048aa5aa..65f9ef625337 100644
--- a/drivers/gpu/drm/imx/Kconfig
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -5,7 +5,8 @@ config DRM_IMX
 	select VIDEOMODE_HELPERS
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
-	depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM || COMPILE_TEST)
+	depends on DRM
+	depends on ARCH_MXC || ARCH_MULTIPLATFORM || COMPILE_TEST && COMMON_CLK
 	depends on IMX_IPUV3_CORE
 	help
 	  enable i.MX graphics support
-- 
2.25.1

