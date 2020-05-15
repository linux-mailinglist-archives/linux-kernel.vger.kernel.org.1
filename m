Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5951D4AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgEOKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 06:20:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43154 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgEOKUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:20:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D8DE200758;
        Fri, 15 May 2020 12:20:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3103F200754;
        Fri, 15 May 2020 12:20:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 63CC5402ED;
        Fri, 15 May 2020 18:20:18 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ASoC: fsl_esai: Add support for imx8qm
Date:   Fri, 15 May 2020 18:10:49 +0800
Message-Id: <cover.1589537601.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for imx8qm.

Shengjiu Wang (2):
  ASoC: fsl_esai: introduce SoC specific data
  ASoC: fsl_esai: Add new compatible string for imx8qm

Changes in v2
- drop the 0002 patch in v1, the dma relate limitation should
  be done in dma driver, or define a new DMA API for it.


 .../devicetree/bindings/sound/fsl,esai.txt    |  1 +
 sound/soc/fsl/fsl_esai.c                      | 46 +++++++++++++++----
 2 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.21.0

