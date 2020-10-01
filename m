Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133B2280565
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbgJAReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:34:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9986 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbgJAReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:34:18 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7612e60000>; Thu, 01 Oct 2020 10:33:26 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 17:34:14 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 1 Oct 2020 17:34:09 +0000
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
Subject: [PATCH v3 05/13] ASoC: audio-graph: Support empty Codec endpoint
Date:   Thu, 1 Oct 2020 23:02:59 +0530
Message-ID: <1601573587-15288-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601573606; bh=xesz+C4t0YPTEFk/rqoe+zcMPgDi6HPptJd7hjC0VQQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=JzJBA1RuXOHgUu2eDrsEpKVQqr8gQFQAInbH/EUxhlR8CkQ1yzLjM2yrPrZhEPndl
         AOkHtCLO80qIyrijDr5Fi0TEuHZ1eM11//KRjNqEEWlhWr9mat+cf1u3nOL8cxwC52
         qKyl0J1l1ZQTzWp2NNQnso2GKnq3GgT0RV91A0HdmU3LN38tK21rqZXaJ4mLRu3pUT
         m+tcvkxhoYHmOokmmS8V4/ACrpT7Md9P5AscHlTqtCgrQY7oOk1prpDvcdzlveIFUB
         5umfj2aXsP8yWkndb0dX+5U8RvqI2E4os/ODUNLpSL7o31CLukbHKFO1u2g8y/Vv60
         2pn/AeUdhZmDg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For open platforms, which can support pluggable audio cards, Codec
endpoint is not fixed always. It actually depends on the compatible
HW module that is going to be connected. From SoC side the given I/O
interface is always available. Hence such links have fixed CPU endpoint
but no Codec endpoint. This patch helps to support such links where
user can populate Codec endpoint only and its fields in Platform DT
depending on the plugged HW.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-card.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 9b06841..0ba50be9 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -229,6 +229,14 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	int ret;
 
+	/*
+	 * Codec endpoint can be NULL for pluggable audio HW.
+	 * Platform DT can populate the Codec endpoint depending on the
+	 * plugged HW.
+	 */
+	if (!li->cpu && !codec_ep)
+		return 0;
+
 	/* Do it all CPU endpoint, and 1st Codec endpoint */
 	if (!li->cpu && dup_codec)
 		return 0;
@@ -565,7 +573,7 @@ static int graph_count_dpcm(struct asoc_simple_priv *priv,
 	li->link++; /* 1xCPU-dummy */
 	li->dais++; /* 1xCPU */
 
-	if (!dup_codec) {
+	if (!dup_codec && codec_ep) {
 		li->link++; /* 1xdummy-Codec */
 		li->conf++; /* 1xdummy-Codec */
 		li->dais++; /* 1xCodec */
-- 
2.7.4

