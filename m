Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D02CE19F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgLCW3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgLCW3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:29:46 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_aud2htx: mark PM functions as __maybe_unused
Date:   Thu,  3 Dec 2020 23:28:47 +0100
Message-Id: <20201203222900.1042578-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_PM is disabled, we get a warning for unused functions:

sound/soc/fsl/fsl_aud2htx.c:261:12: error: unused function 'fsl_aud2htx_runtime_suspend' [-Werror,-Wunused-function]
static int fsl_aud2htx_runtime_suspend(struct device *dev)
sound/soc/fsl/fsl_aud2htx.c:271:12: error: unused function 'fsl_aud2htx_runtime_resume' [-Werror,-Wunused-function]
static int fsl_aud2htx_runtime_resume(struct device *dev)

Mark these as __maybe_unused to avoid the warning without adding
an #ifdef.

Fixes: 8a24c834c053 ("ASoC: fsl_aud2htx: Add aud2htx module driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/fsl_aud2htx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_aud2htx.c b/sound/soc/fsl/fsl_aud2htx.c
index 4091ccc7c3e9..d70d5e75a30c 100644
--- a/sound/soc/fsl/fsl_aud2htx.c
+++ b/sound/soc/fsl/fsl_aud2htx.c
@@ -258,7 +258,7 @@ static int fsl_aud2htx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int fsl_aud2htx_runtime_suspend(struct device *dev)
+static int __maybe_unused fsl_aud2htx_runtime_suspend(struct device *dev)
 {
 	struct fsl_aud2htx *aud2htx = dev_get_drvdata(dev);
 
@@ -268,7 +268,7 @@ static int fsl_aud2htx_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int fsl_aud2htx_runtime_resume(struct device *dev)
+static int __maybe_unused fsl_aud2htx_runtime_resume(struct device *dev)
 {
 	struct fsl_aud2htx *aud2htx = dev_get_drvdata(dev);
 	int ret;
-- 
2.27.0

