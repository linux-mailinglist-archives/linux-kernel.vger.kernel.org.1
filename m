Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17793290784
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409181AbgJPOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:44:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11191 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406707AbgJPOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:44:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89b1830001>; Fri, 16 Oct 2020 07:43:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 14:43:55 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Oct 2020 14:43:49 +0000
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
Subject: [PATCH v4 05/15] ASoC: audio-graph: Support empty Codec endpoint
Date:   Fri, 16 Oct 2020 20:12:52 +0530
Message-ID: <1602859382-19505-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602859395; bh=xesz+C4t0YPTEFk/rqoe+zcMPgDi6HPptJd7hjC0VQQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=Z8ezYTMh1CUZ2F9693G5I6lgClSbA/MQ6mU+IUNk2oKIQ/8QeiwKs4hmiP95gfZH2
         XRjBxoR5v8YEz+o9xt8Rio2YUZBFJ1nOt7RD2qCysKejJZnmqqmWbVGUPT4dCZIQ1J
         +Xt5Bl3Za4OYvyws+yz8bClQSZsvZEHoErnJAdvLgERTmfWtX43549UBnMnZtw6cWL
         IGYOXRvPAFpiV36UB0ylEp33O9ivqKgWPGmt7mfsQpfL0DaksjRUpczPyU0mU0w5Ce
         Hiu4yDvhylsZ8LpRs5qvQtB/cxU949iuw8vQJiOOtv7bECWOOPSoC4/s7HKFhcmmg0
         v51r57ozWmT2g==
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

