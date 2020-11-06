Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D832A8E22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKFEPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:15:19 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48103 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgKFEPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:15:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4AD0558054B;
        Thu,  5 Nov 2020 23:15:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=fM+mBIXLYcK3O
        mS1n9AWddTUKsKTi5ZEVIA4pgh+LXo=; b=qP3Y7zh0nuyqmDe2Zmj0O2CARqUzr
        b5necBApgGlt3XJEx8sOppxkmVH6WHv9YKvcFx72IMoF4xXX9MjhB2dSD5eyOPrC
        91urB2kA9sMtBhmI1WbiaAYeWzr2gBBXDenjS3+kh79Vvx8WB48yvoSGUokT5bVH
        Nm8RfYYSUjiXXlEFzMlZomCiiOim3vweKWg8TONRzeO+F28/CX1RZwKepwif7B/k
        DAYzqInnAiOJE0KcsUDDhyXnjNVtli18G3cjZYNxZM3ZOWxt2SGsXjaVA/uqPsBq
        XFxAyGQRRTVA/lH6/UfwdkHmMSla24T8T9LLqbc18eBN9tIA0M1RZCscQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fM+mBIXLYcK3OmS1n9AWddTUKsKTi5ZEVIA4pgh+LXo=; b=L6eMSLRs
        wgjhVdUGJjWzbu1S/k0P+OasGaua9Rg7Vmww0ZnmML7PT3aJg6KcccEb90rpCWky
        z/fa/AQW4snqs10I4CUVYQt8TKmCe1sFaA2U3cYAytIWfsBjXSnpz/o/Yf/jWV9j
        5HncSId2x5BK0L/ROvME9hQqBF5gDF2k9N5Inf0sErRepkqLW0GKeM++/7HTk93j
        6cVllQwl1eMHNNuXOFDow2ajRiXvW/N+JofygYt9ZllvWat5oxKsW9JlDoaVtKNu
        e46MonYQN+kdbDtxafoCWrgUWqcDlLZaW9rnHbxpluW8ChDSd2+BX1PE+Eyxua5X
        jb2/7CdTRkbAJg==
X-ME-Sender: <xms:0s2kX5VE5Our2X_bgrzvAu4m8yxvMweaWLiXr_TUtmR0Lte2mJh4_Q>
    <xme:0s2kX5ktIT3Mnd4cwnio9Yf3kL2MdLUvkUdvHapGESjr_rcnTQUq_be6HScVzkipR
    aVolwi5DWDg0mXvUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:0s2kX1Y4hITkQLECWWP4VitUCx0NeUxTRzyPes9u4H0uOWPNgVo0JQ>
    <xmx:0s2kX8WsFP9waegg5_yVvcJJnmFMUjD6NEmSPnzfGfTnELlDJq_EOA>
    <xmx:0s2kXzlS5oZDZZ538XMargNqpCpIWwsDIjS8RILFhuDNOuuB93b6IQ>
    <xmx:082kX8iI8jM7-yVPGVLbJS5AuiR3fhjWC7IkW2ZeJMmAVq_WWZx1uA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21F333060060;
        Thu,  5 Nov 2020 23:15:14 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/7] ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
Date:   Thu,  5 Nov 2020 22:15:07 -0600
Message-Id: <20201106041513.38481-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
References: <20201106041513.38481-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase sound-dai-cells to 1 to allow using the DAIs in the codec
corresponding to AIF2 and AIF3.

The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
with no impact to the driver, so this is a backward-compatible change.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 67405e6d8168..1a2590f54b9b 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 properties:
   "#sound-dai-cells":
-    const: 0
+    const: 1
 
   compatible:
     oneOf:
-- 
2.26.2

