Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA2E29077D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409162AbgJPOnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:43:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4992 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409154AbgJPOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:43:46 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89b1950001>; Fri, 16 Oct 2020 07:43:33 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 14:43:42 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Oct 2020 14:43:37 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>,
        <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 03/15] ASoC: audio-graph: Use of_node and DAI for DPCM DAI link names
Date:   Fri, 16 Oct 2020 20:12:50 +0530
Message-ID: <1602859382-19505-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602859413; bh=DUfSjxqgTyMLeILJTEcFS/WZ2++sn+Xe/SbNNLGn5Pg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=UfObnKAf6dPl+KYxYIdHnlgEN2/Q75MTHaaDCw2MDjjVKH9pPlXdrdyO1PcFQPVjZ
         /WVRH7S+DGijXeL4ZYXVAtcpto0hOYpA+iDmFFbqSmBvicU2NhkrsVJR+GsAFS5MNP
         NOdtNpE9sEw6BvPoDuaGWUddlC7aKAC7a/rqgwxVRENXmialTBXPDG5uWjURFlr0VB
         VcNsVSsjj+V5WZJ/0QgT0N15LgxNgm2+ZranR7mY+5LPBr8UMB7luJUNBokL8wo1rM
         xkcJYEB3Z+ST7y/aThvGBUW3F7tQLeHRHmJhpyGEEEklTdjZNrBN3TuaFYJX9XW737
         rXDJhrVi/qOLA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multiple instances of components, using DAI name alone for DAI links
is causing conflicts. Components can define multiple DAIs and hence using
just a device name won't help either. Thus DT device node reference and
DAI names are used to uniquely represent DAI link names.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 97b4f54..1e20562 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -253,7 +253,8 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
-						   "fe.%s",
+						   "fe.%pOFP.%s",
+						   cpus->of_node,
 						   cpus->dai_name);
 		if (ret < 0)
 			goto out_put_node;
@@ -287,7 +288,8 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
-						   "be.%s",
+						   "be.%pOFP.%s",
+						   codecs->of_node,
 						   codecs->dai_name);
 		if (ret < 0)
 			goto out_put_node;
-- 
2.7.4

