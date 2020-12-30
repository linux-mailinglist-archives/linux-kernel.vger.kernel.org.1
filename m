Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A2A2E7A92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgL3Ppb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgL3Pp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:45:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 413BD20725;
        Wed, 30 Dec 2020 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343088;
        bh=B6KEEyF4RQKJhn/Tlgm2gPhwOX1a1c48tzMAbskoqNY=;
        h=From:To:Cc:Subject:Date:From;
        b=HCKeDJ0KSZ7nc1CoEISb/ZRNzccPTaWWh06Nn2VIZBsId6eP9cn0oGFUJlOABZZZO
         iI0X3/jv9pxyQ5bU7W/XqVpiwAVKTetRviaE1CBU80GpLg/jmLlz66OeoO4ZhibBqQ
         PjjjdalMW1Zz2BoWMBZ8kelnigjz4DMVLkz9RLZvfhx2BBPns1SB0TRK+cYujQxlOH
         8MnDwDJqOqRtqV2yMQCPacw1DfF9pBrJ/RhsJA8R+VJ3BdV7xvpCIPfiT77gwd3boZ
         PiTBMWGGCaRfDf7RBRjRMAgbFOqHd28vArCHhJoja2QAirqWZnxT1vUTZKPDO8Anij
         h3IyOvDVmuzrg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ASoC: fsl: fix -Wmaybe-uninitialized warning
Date:   Wed, 30 Dec 2020 16:44:15 +0100
Message-Id: <20201230154443.656997-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang points out a code path that returns an undefined value
in an error case:

sound/soc/fsl/imx-hdmi.c:165:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsom
etimes-uninitialized]
        if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/fsl/imx-hdmi.c:212:9: note: uninitialized use occurs here
        return ret;

The driver returns -EINVAL for other broken DT properties, so do
it the same way here.

Fixes: 6a5f850aa83a ("ASoC: fsl: Add imx-hdmi machine driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/imx-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index 2c2a76a71940..ede4a9ad1054 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -164,6 +164,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 
 	if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
 		dev_err(&pdev->dev, "Invalid HDMI DAI link\n");
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.29.2

