Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8302532F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHZPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 11:09:01 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:18242 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:08:58 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5f467afd636-5b72a; Wed, 26 Aug 2020 23:08:45 +0800 (CST)
X-RM-TRANSID: 2eea5f467afd636-5b72a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.112])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25f467afb20d-10b8c;
        Wed, 26 Aug 2020 23:08:45 +0800 (CST)
X-RM-TRANSID: 2ee25f467afb20d-10b8c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, timur@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl_spdif: Fix unnecessary check in fsl_spdif_probe()
Date:   Wed, 26 Aug 2020 23:09:18 +0800
Message-Id: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function fsl_spdif_probe() is only called with an openfirmware
platform device. Therefore there is no need to check that the passed
in device is NULL.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_spdif.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 7858a5499..395c50167 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1221,9 +1221,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	int irq, ret, i;
 
-	if (!np)
-		return -ENODEV;
-
 	spdif_priv = devm_kzalloc(&pdev->dev, sizeof(*spdif_priv), GFP_KERNEL);
 	if (!spdif_priv)
 		return -ENOMEM;
-- 
2.20.1.windows.1



