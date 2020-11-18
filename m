Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ECB2B77FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgKRIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:06:35 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11997 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgKRIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:06:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb4d6010000>; Wed, 18 Nov 2020 00:06:25 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 08:06:34 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 08:06:31 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <sharadg@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/3] Convert Tegra HDA doc to json-schema
Date:   Wed, 18 Nov 2020 13:36:19 +0530
Message-ID: <1605686782-29469-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605686785; bh=+mKNcXPQxwCx+awvh3qmVh6msTm6zFNTg3ytvlVwQDs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=paq+oABr9TMcUz423TCs8j7XyC4Yt9wlv5Ti7x1lBF0yhDlBk6Kn/eiD/ztpuP69U
         ptNWxtVU55d8Msza0rQXrTEkjVLO/69atPL84sIUWRbommBnxLAlTlZSIj7tKeNCVe
         eNm+JBPIgxFYy8aM709yiVo8YzfNSOid06rwOEW1GPH+M6Rl36eAfDb7vTDrrnCXjt
         jl22wL3gcz/SWaeXDALvrNEkd3PoSHNEURjmz2ZOHgOchI9FQaRvnUto1xFbJ5E6rN
         8KOImO8rQ0ajuz5f86KX2PUDQ1rrp1sC4pYRVMiTHRBUxnlc86O+We6w06cds0XkN0
         8uvn/uWpmE/9w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Tegra194 DT and convert Tegra HDA doc to YAML format. Ran binding
validation checks to ensure there are no warnings/errors for HDA.

Sameer Pujar (3):
  arm64: tegra: Fix Tegra194 HDA {clock,reset}-names ordering
  dt-bindings: tegra: Convert HDA doc to json-schema
  dt-bindings: tegra: Add missing HDA properties

 .../bindings/sound/nvidia,tegra30-hda.txt          |  35 -------
 .../bindings/sound/nvidia,tegra30-hda.yaml         | 112 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  12 +--
 3 files changed, 118 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml

-- 
2.7.4

