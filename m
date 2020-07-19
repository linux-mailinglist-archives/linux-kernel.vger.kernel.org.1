Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F42224FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 07:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgGSFLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 01:11:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18194 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSFK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:10:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f13d5d60000>; Sat, 18 Jul 2020 22:10:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 18 Jul 2020 22:10:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 18 Jul 2020 22:10:59 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:10:58 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:10:58 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f13d5dd0000>; Sat, 18 Jul 2020 22:10:58 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 04/10] ASoC: audio-graph: Support for empty end point
Date:   Sun, 19 Jul 2020 10:40:11 +0530
Message-ID: <1595135417-16589-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595135446; bh=HkkxSZUXnkgEAR4RIV6F9Lzbhbv2UzpeAGbctAXt9Ns=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DZEmY2ykCS8Ubg6zVBozW7F66VBiQWtvkLp+n1WZ6UBf2oYh/Sz+BB5210VG4vgrA
         PRjrVyPESh5+Rf6ELlIV3Em/MAAfabAKzhPDuF56tjqKvRL47eBJY9Fw7nGWBJ73yw
         nhpPiy3g6ZJo6PtQLk61mixb83ioSOfeMc6W3cjYauAwOP+4QpZW258Sd69Hp0nOTM
         Egl83BDq0i9HjO66/DqEWlXgjKEQLIFlKt66tvSDv5pxEkm6E6EaE0OXjEvIrvFIwF
         pWcpIvAfTnczcLiAvdR3NTwOwkK4MOGVUT/yPkt0FrbjziEx/Ak+GrRFEcYKIl/5r1
         WfwMFb3Hkbp/w==
Sender: linux-kernel-owner@vger.kernel.org
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
---
 sound/soc/generic/audio-graph-card.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index b1903f9..caa8a77 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -216,6 +216,14 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	int ret;
 
+	/*
+	 * Codec endpoint can be NULL for pluggable audio HW.
+	 * Platform DT can populate the Codec endpoint depending on the
+	 * external codec.
+	 */
+	if (!ep)
+		return 0;
+
 	port	= of_get_parent(ep);
 	ports	= of_get_parent(port);
 	node	= of_graph_get_port_parent(ep);
@@ -532,9 +540,11 @@ static int graph_count_dpcm(struct asoc_simple_priv *priv,
 	li->dais++; /* 1xCPU */
 
 	/* Codec */
-	li->link++; /* 1xdummy-Codec */
-	li->conf++; /* 1xdummy-Codec */
-	li->dais++; /* 1xCodec */
+	if (codec_ep) {
+		li->link++; /* 1xdummy-Codec */
+		li->conf++; /* 1xdummy-Codec */
+		li->dais++; /* 1xCodec */
+	}
 
 	dev_dbg(dev, "Count As DPCM\n");
 
-- 
2.7.4

