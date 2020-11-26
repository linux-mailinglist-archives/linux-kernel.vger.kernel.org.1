Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C32C4EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgKZGWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:22:06 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39962 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387991AbgKZGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:22:06 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E18571A0A4C;
        Thu, 26 Nov 2020 07:22:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D25B61A010B;
        Thu, 26 Nov 2020 07:22:00 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1C49F402A6;
        Thu, 26 Nov 2020 07:21:54 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl: Fix config name of CONFIG_ARCH_MXC
Date:   Thu, 26 Nov 2020 14:14:53 +0800
Message-Id: <1606371293-29099-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARCH_MXC should be ARCH_MXC

Fixes: 674226db62ec ("ASoC: fsl: SND_SOC_FSL_AUD2HTX should depend on ARCH_MXC")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7d48f4f98e8b..835a14821360 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -107,7 +107,7 @@ config SND_SOC_FSL_XCVR
 
 config SND_SOC_FSL_AUD2HTX
 	tristate "AUDIO TO HDMI TX module support"
-	depends on CONFIG_ARCH_MXC || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Say Y if you want to add AUDIO TO HDMI TX support for NXP.
 
-- 
2.27.0

