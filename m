Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF2224F88
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 07:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgGSFCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 01:02:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4446 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGSFCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:02:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f13d3a30000>; Sat, 18 Jul 2020 22:01:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 18 Jul 2020 22:02:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 18 Jul 2020 22:02:24 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:02:24 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:02:24 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f13d3da0004>; Sat, 18 Jul 2020 22:02:23 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v5 08/11] arm64: defconfig: Build AHUB component drivers
Date:   Sun, 19 Jul 2020 10:31:27 +0530
Message-ID: <1595134890-16470-9-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595134883; bh=IfeDiGX/H8TVBJvlfUU8oQ7iD1y/zcDu3dEoQCGpfpE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UGxeigueo8G36No5HD7sD+SwSvtDSGVO6OxgzMx6N/b0ec9eZfWaeIhfJHrdxt1aC
         3hNG/iBYlhn+qDjjMAwee9L6vVgr7WPAZ9g0bY/dEJfhGFT/KXD6koHwMbV7GfTehN
         ZGTU26BoDMRmrZqs/8GFZKD2u/vQxZ+A1k0J+Vtcpz8N7T9teHmPZeGOQt7P/SP1zP
         2X1mfiXf/seiHthuQkgp3dJbMKj6suK195uu8xh2BOL33nfwVKF/BhvzltviCRpboa
         OWdInDpQ4b+j6l0AbwHtx/9fDj0aG+x3lAo9UyTMzcaaN7htkLJSss1QAMaGT0eloP
         DZ/RdqyTBO+Ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch helps to build AHUB and its client drivers (I2S, DMIC,
DSPK, ADMAIF and AHUB). These register components with ASoC core.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 89538d9..4976e1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -669,6 +669,12 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SUN4I_SPDIF=m
+CONFIG_SND_SOC_TEGRA=m
+CONFIG_SND_SOC_TEGRA210_AHUB=m
+CONFIG_SND_SOC_TEGRA210_DMIC=m
+CONFIG_SND_SOC_TEGRA210_I2S=m
+CONFIG_SND_SOC_TEGRA186_DSPK=m
+CONFIG_SND_SOC_TEGRA210_ADMAIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.7.4

