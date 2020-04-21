Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB81B21FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgDUItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 04:49:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39700 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgDUItx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:49:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C8DF1A0C15;
        Tue, 21 Apr 2020 10:49:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 582C61A0C34;
        Tue, 21 Apr 2020 10:49:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3CA4F4029E;
        Tue, 21 Apr 2020 16:49:40 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_esai: Remove expensive print in irq handler
Date:   Tue, 21 Apr 2020 16:41:23 +0800
Message-Id: <1587458483-2166-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_dbg instead of dev_err in irq handler, the dev_err
is expensive, we don't need the message to be printed everytime,
which is almost a debug option.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7a49d03463a..453392a9cd68 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -94,10 +94,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
 		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
 
 	if (esr & ESAI_ESR_RFF_MASK)
-		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
+		dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
 
 	if (esr & ESAI_ESR_TFE_MASK)
-		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
+		dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
 
 	if (esr & ESAI_ESR_TLS_MASK)
 		dev_dbg(&pdev->dev, "isr: Just transmitted the last slot\n");
-- 
2.21.0

