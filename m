Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5C1C0F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgEAIVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 04:21:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33640 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgEAIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:21:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF01F1A0B67;
        Fri,  1 May 2020 10:21:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E93C1A0B36;
        Fri,  1 May 2020 10:20:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3EF32402BB;
        Fri,  1 May 2020 16:20:52 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ASoC: fsl_esai: Add support for imx8qm
Date:   Fri,  1 May 2020 16:12:03 +0800
Message-Id: <cover.1588320655.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for imx8qm.

Shengjiu Wang (3):
  ASoC: fsl_esai: introduce SoC specific data
  ASoC: fsl_esai: Add support for imx8qm
  ASoC: fsl_esai: Add new compatible string for imx8qm

 .../devicetree/bindings/sound/fsl,esai.txt    |  1 +
 sound/soc/fsl/fsl_esai.c                      | 65 ++++++++++++++++---
 2 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.21.0

