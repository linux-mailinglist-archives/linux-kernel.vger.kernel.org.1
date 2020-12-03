Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE88E2CD957
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbgLCOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:37:44 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8678 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389202AbgLCOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:37:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8f80f0000>; Thu, 03 Dec 2020 06:37:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 14:37:03 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 14:37:00 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <sharadg@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [RESEND PATCH 0/2] Convert Tegra HDA doc to json-schema
Date:   Thu, 3 Dec 2020 20:06:40 +0530
Message-ID: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607006223; bh=oBVH1GkkdSd+6h69hwkZ2XZAHlPV4pT2Qs/l/nDYx3U=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=Lbr6OUW0wGesY0teHTXCdQB4XLfzLF45rs1G+FsTO3K4/WHVIoDcITzJJNPAnwMf/
         K9RtU+Y4j5kKW2eKChMWYnRQG2Awgav8ftJWOIuLnObj/9rUGjNM21k8gfhATvG2O3
         3Wbd7Vo0E+3qg+2hud5n421+vK18ju1SayNIN20j3wdW7ebqDuKZ7R/SyAtC52ooK2
         ARiKTR+49EQsu/vQJ0c5IpCo/P0ZlGdlO/JmVJq/zhen5IydbO4459zHxojABLOalq
         QHQ4XbBMFMRwGGcjN32y3AJohqKDkUm3c9LpFIxawOX7qsklGulUNFWpyBywEKmL9h
         TXLvAQP7su81w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Tegra HDA doc to YAML format. Ran binding validation checks to
ensure there are no warnings/errors for HDA.

Patch "arm64: tegra: Fix Tegra194 HDA {clock,reset}-names ordering" is
already merged and hence not included here.

Sameer Pujar (2):
  dt-bindings: tegra: Convert HDA doc to json-schema
  dt-bindings: tegra: Add missing HDA properties

 .../bindings/sound/nvidia,tegra30-hda.txt          |  35 -------
 .../bindings/sound/nvidia,tegra30-hda.yaml         | 112 +++++++++++++++++++++
 2 files changed, 112 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml

-- 
2.7.4

