Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F214280552
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbgJARdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:33:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17916 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:33:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7612d50004>; Thu, 01 Oct 2020 10:33:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 17:33:20 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 1 Oct 2020 17:33:15 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>,
        <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 00/13] Audio graph card updates and usage with Tegra210 audio
Date:   Thu, 1 Oct 2020 23:02:54 +0530
Message-ID: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601573589; bh=zIvUzbc372htqDG/kgYhVBEV7XV+PVNNp5+Sxf3SNgs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=msj1eZReDZtL2j2G91y9txTk98M5l8Wv36m5qqRHxQvAJnI0aYkX7BGwQTJTqG/78
         RrPMpvDF5v5uGKYkKOSImbU36Hu8Xe9UHvlJ7dSt5t1pwQRGPaYYWpF4VQR/qWs69i
         rLbEEf2HGyQk4uadJgI7id70udcfP8S865fOzcWBOCf30p0yU4OynNKWkBgW58Vufm
         REpiIkOMX0tKqnUmsGcbYUw6e+Haa9wvZ27mExyLfZm7EO1RbL8UwaW7GfxuYCkvFS
         lHIjMmMC7UhmP5pmYfSwU5jivdbi8egSpeMCqXfKusW91Ezqa+jWmbeOeRjBVPH74T
         JFDrya9M8/Osg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of changes:
 * Support multiple instances of a component. For example there can be
   multiple I2S devices which can use the same component driver.

 * Support open platforms with empty Codec endpoint. Customers can plug
   their own HW and can populate codec endpoint.

 * In a component model there can be many components which can be
   connected togethe. In such cases Identify no-pcm DPCM DAI links which
   can be used in BE<->BE connections.

 * Add Tegra audio graph driver which is based on generic audio graph
   driver and specific customizations are done in Tegra driver.

 * This pushes DT support for Tegra210 based platforms which uses
   audio-graph card and above enhancements.

The series is based on following references where DPCM usgae for Tegra
Audio and simple-card driver proposal were discussed.

 * https://lkml.org/lkml/2020/4/30/519 (DPCM for Tegra)
 * https://lkml.org/lkml/2020/6/27/4 (simple-card driver)

Changelog
=========

v1 -> v2
--------
 * Re-organized ports/endpoints description for ADMAIF and XBAR.
   Updated DT patches accordingly.
 * After above change, multiple Codec endpoint support is not
   required and hence dropped for now. This will be considered
   separately if at all required in future.
 * Re-ordered patches in the series.


v2 -> v3
--------
 * Dropped new compatible addition in generic graph driver
   after reviewing it with Morimoto-san. Instead added Tegra
   audio graph driver and new compatibles are added in the same.
 * Added new patches to expose new members for customization
   in audio graph driver.
 * Added new patch for Tegra audio graph driver and related
   documentation.
 * Minor change in below commit where mutex version of helper is used
   "ASoC: audio-graph: Identify 'no_pcm' DAI links for DPCM"
 * DT binding is updated to use the newly exposed compatibles
 * No changes in other patches


Sameer Pujar (13):
  ASoC: soc-core: Fix component name_prefix parsing
  ASoC: soc-pcm: Get all BEs along DAPM path
  ASoC: audio-graph: Use of_node and DAI for DPCM DAI link names
  ASoC: audio-graph: Identify 'no_pcm' DAI links for DPCM
  ASoC: audio-graph: Support empty Codec endpoint
  ASoC: simple-card-utils: Expose new members for asoc_simple_priv
  ASoC: audio-graph: Update driver as per new exposed members
  ASoC: audio-graph: Expose helpers from audio graph
  ASoC: dt-bindings: tegra: Add schema for audio graph card
  ASoC: tegra: Add audio graph based card driver
  arm64: defconfig: Enable Tegra audio graph card driver
  arm64: tegra: Audio graph header for Tegra210
  arm64: tegra: Audio graph sound card for Jetson Nano and TX1

 .../sound/nvidia,tegra-audio-graph-card.yaml       |  67 +++++
 .../boot/dts/nvidia/tegra210-audio-graph.dtsi      | 138 ++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 219 ++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 124 +++++++++
 arch/arm64/configs/defconfig                       |   1 +
 include/sound/graph_card.h                         |  19 ++
 include/sound/simple_card_utils.h                  |   4 +
 include/sound/soc.h                                |   1 +
 sound/soc/generic/audio-graph-card.c               |  92 +++++--
 sound/soc/soc-core.c                               |   3 +-
 sound/soc/soc-pcm.c                                |   3 +-
 sound/soc/tegra/Kconfig                            |   9 +
 sound/soc/tegra/Makefile                           |   2 +
 sound/soc/tegra/tegra_audio_graph_card.c           | 291 +++++++++++++++++++++
 14 files changed, 955 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi
 create mode 100644 include/sound/graph_card.h
 create mode 100644 sound/soc/tegra/tegra_audio_graph_card.c

-- 
2.7.4

