Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB22AF811
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKKSfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:35:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2171 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgKKSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fac2eec0001>; Wed, 11 Nov 2020 10:35:24 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 18:35:17 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 18:35:14 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v5 4/6] arm64: defconfig: Enable Tegra audio graph card driver
Date:   Thu, 12 Nov 2020 00:04:34 +0530
Message-ID: <1605119676-32273-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605119676-32273-1-git-send-email-spujar@nvidia.com>
References: <1605119676-32273-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605119724; bh=x6W8IE1maKuSB+UkT+0IXnUq/MLZtEHuKZmV/XvTnXo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=Z7w4CtzWDgCgB7qeQwhVfnZLrbQI4NpaXLsAdP2uSyelYbB2R2wmVtK3VWwQBK6ZG
         5TMPafLy5Ukvi7YCnMb1h9wQ8qgBPmFzRK7DXNdBUeIjUIbkz44mH0HBiRZiSliolv
         89iqjDTBC/0voyhb4Y2CTc+mLcMhRItj0bfqJrrjbunVAA/xQPkBFuAI9HJx850kHq
         XZaM6C4sOTp4Siaa3N+pV6ZVX4znMBfwm48iAI9JXD2OaK4kI738kBmbNAZLHKKI+5
         hz2Ff/6ig+QT0f4C02Am1eOVgcKE1/8vpVSlvN0cmU6QQQ7ydvDgJhxpGQdCiGr/Qk
         t0ABaLkr9QsiA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables Tegra audio graph card driver which is based on
the generic audio-graph card driver. This is intended to be used
on platforms based on Tegra210 and later chips.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c5f404c..e07dea93 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -722,6 +722,7 @@ CONFIG_SND_SOC_TEGRA210_DMIC=m
 CONFIG_SND_SOC_TEGRA210_I2S=m
 CONFIG_SND_SOC_TEGRA186_DSPK=m
 CONFIG_SND_SOC_TEGRA210_ADMAIF=m
+CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.7.4

