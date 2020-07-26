Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9201D22DB1B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGZB0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 21:26:03 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57999 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbgGZB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:26:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7384A58014B;
        Sat, 25 Jul 2020 21:26:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Bc+s0nLaRpZIx
        yCBvQ4oj1VwkiAzKp+9hlsJuhGXWAM=; b=lHVvSAw1ZVEQfJMC1pDEJsvgNHUQC
        ToktL4COHMq/yhL+CXinpvhwck8N7ckpGHJoXgZAYW4+ZX+EACJHnGOZDE8N8dCu
        V8saNvMyvYjMsdCHLAorj2rKQZ6lU5hxsQvRIgt6DiBKLjfsOhwo+V+yqwdHNadP
        WFv9UrMrcwDiLgoJWK0pztN8TeivUK2wQQjrf2gNSZKnYF+IHvv3+tMRkfEV8WKF
        Ppx5V9wNX1el4R++U4QFa5GXmQ8gkl5cQ/qZygVTSTVayfQdakT39q5wuzGNilf7
        H/4Ex92+OvtrRIbnFNpL3HquZRt+rWhmwGr5dpUQYWDM4rDQp1mFnTyEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Bc+s0nLaRpZIxyCBvQ4oj1VwkiAzKp+9hlsJuhGXWAM=; b=o561a/MA
        JTGnE42PW2YjZgncOVPhgWjXBBRDNPrA1jPhpaM+PahPWgglJvDF8F1CZCGB0dBK
        B3VEEGZzmjJG6rYW/P5T83fOTqnzHQyIGLXZ3OrDjxNSVnwHL7ygazZoUItBOQ1k
        zG391ZxWp0MGbFe0GvD7xgrJfI+6lEVEQHTuY+XhuXsTz8PxXFmIS793bMxuQJ0Y
        jko94yEe56rowUcECducoVe4KeTWeScfvlYLMK5rBaPqDBd2bRL5vyPx41IfuJ+O
        nmmvyBFtoRTQUx2q4UmTZUgf9pi61eW5er3hI3vPttPso+/6e4ug939s0UsCbHE+
        WavsLeGyMD87Mg==
X-ME-Sender: <xms:p9scX6QxgGqbunpekQBTatw5eZIHwmitByMoW1-uhaDl3BLMN2SwMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:p9scX_yWVMgMMUn_Fe5R6YbGcjJxFfzI3QqyQmYquCbxdsu4ZzJp4w>
    <xmx:p9scX30JW_vZ9B0qbbut9WlqEOlb4LVRFTx1vV4k3CBjW7pex6Xj2w>
    <xmx:p9scX2DEaDqJW1M2axr7KmV1Y0446X32Nealw3SmpcZfnqyGYJk8Cg>
    <xmx:qNscX2pC0afVfIF804Gnm4lhCY4u0ZoXlGf6inmLtdE4lEpeZeWThA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFEF8306005F;
        Sat, 25 Jul 2020 21:25:58 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/7] ASoC: dt-bindings: Add a new compatible for the A64 codec
Date:   Sat, 25 Jul 2020 20:25:51 -0500
Message-Id: <20200726012557.38282-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio codecs in the A33 and A64 are both integrated variants of the
X-Powers AC100 codec. However, there are some differences between them
that merit having a separate compatible:
 - The A64 has a second DRC block, not present in the AC100 or A33.
 - The A33 has some extra muxing options for AIF1/2/3 in the
   AIF3_SGP_CTRL register, which are not present in the AC100 or A64.
 - The A33 is missing registers providing jack detection functionality.
 - The A33 is claimed to invert LRCK, but this is not seen on A64.

Since the driver will continue to work on the A64 using the A33
compatible, albeit without jack detection functionality and with
possibly inverted channels, as it does now, allow the A33 compatible
to be used as a fallback.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../bindings/sound/allwinner,sun8i-a33-codec.yaml           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 55d28268d2f4..67405e6d8168 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -15,7 +15,11 @@ properties:
     const: 0
 
   compatible:
-    const: allwinner,sun8i-a33-codec
+    oneOf:
+      - items:
+          - const: allwinner,sun50i-a64-codec
+          - const: allwinner,sun8i-a33-codec
+      - const: allwinner,sun8i-a33-codec
 
   reg:
     maxItems: 1
-- 
2.26.2

