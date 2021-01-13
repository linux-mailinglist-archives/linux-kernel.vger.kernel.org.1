Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12832F444C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAMGHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:07:05 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:33805 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbhAMGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:07:05 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id CDC631B9D;
        Wed, 13 Jan 2021 01:06:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jan 2021 01:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=qi0fOw9H8C1Vi
        Fkj0YkahjjwxVo63pIP76xBkJLDhaY=; b=qqLUECSgo5nTZwxFLsawsi3L3cR90
        NArrMg/z4vVlAKY62f53kMZO3pCzjOnsqqk3PttqXN1IWxZHRQiOjvwx36PNScsA
        wGAeJiSGcBt9/C2mNSQaNS0/mcztTjhukACnCt6VW//G3kT5fC9nDPc6LimK7cUZ
        37lI3n60XsUfFwzMeOiXDTGyDLaDuxThPsQ32CuT8+Lyk8NzX33nSawgV73OpFWz
        Gwtr0hreOKOyhxceAcnNoBhJ5OY/uYpUzSBQ/ugLmZc6795SQ6Nfjs0lqN3eVLvX
        inQTewhUuKGfK6cBBWgd6iBLzL8HUNIR+usEWfrJaQBap1ASTxWx9tP2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=qi0fOw9H8C1ViFkj0YkahjjwxVo63pIP76xBkJLDhaY=; b=TKAAkpgS
        fD6lxJw3LLnY8NIwPj43Gff9MSEtx216vBK7QgepNBbDzDcmg7D2psjAdJTV6Rfp
        5MJZovAo6YIqbwYyUlDA0M6jg3IrTxWf2p90Mh12NcKs9mhT+zPP8DRACBnWS7as
        mLh7oEfO6e/CMjNC//cLrRnRxclubdRnrHou8n3i4VPZtYU+WpM6ldUCSVVVI3RX
        SvXsIhpMCJFXFo3c7oGYdKn2QD97yMzM+5M7/gONWyEO7IQFkmmZChuDmpjq+QOd
        I3Hp28qJjXuuXYXok5w3rHMk+Q411f9zNPl4boAGQe7QAj7xBBr8gUHPyZaLJfTr
        QhHIYWAiN9mFCA==
X-ME-Sender: <xms:2o3-X8urZA3KAplB_CjZ9jRC7AMBZIYHp8VmoET1D7auxUpVqcHq7A>
    <xme:2o3-X5ejT9dTPEtDr0IrKl61jkeuN5PWO7_zG8dVezG9MKqgBle_rmMRuXijgXnGy
    _97U6wMQOzHYXfmZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:2o3-X3ypdvLIJFQKkzwOvUm_VdkFoyBOB5mY9W5K_29WOrSQk7lD7w>
    <xmx:2o3-X_P9_uOHzLYimC9szSSCUYNMyUbdcSKIclwVKMszy6yYeqnRDQ>
    <xmx:2o3-X882Aj55cQFYlWjLEQn2OCsOeX-M7rp3scjpj-ljW1vbTm6hGQ>
    <xmx:2o3-XwTpUgEpUeKqP_H9L7qx52g9C-Bob3z5q0vagasbkFLbehcXVs3vdVE>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C336024005A;
        Wed, 13 Jan 2021 01:06:17 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/7] arm64: dts: allwinner: a64: Allow using multiple codec DAIs
Date:   Wed, 13 Jan 2021 00:06:11 -0600
Message-Id: <20210113060615.53088-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113060615.53088-1-samuel@sholland.org>
References: <20210113060615.53088-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase #sound-dai-cells on the digital codec to allow using the other
DAIs provided by the codec for AIF2 and AIF3.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 51cc30e84e26..e788251e582f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -150,7 +150,7 @@ cpudai: simple-audio-card,cpu {
 		};
 
 		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&codec 0>;
 		};
 	};
 
@@ -874,7 +874,7 @@ dai: dai@1c22c00 {
 		};
 
 		codec: codec@1c22e00 {
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			compatible = "allwinner,sun50i-a64-codec",
 				     "allwinner,sun8i-a33-codec";
 			reg = <0x01c22e00 0x600>;
-- 
2.26.2

