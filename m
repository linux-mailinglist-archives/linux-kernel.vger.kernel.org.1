Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5042A8E30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgKFEPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:15:42 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60055 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgKFEPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:15:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD721580518;
        Thu,  5 Nov 2020 23:15:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=HjPRAtmWDHpsB
        ofnlqe6mFYpt2u4m3UE5sd2bFJ0WRM=; b=e2SH2GrMmX2wf3rPvikRLJ52mcVo1
        XmIYCIfbR3VluFuOOb4IR4gD7dXTAMdz3A9iaSrU+NVwYmjp9ZDh4gCnumnqjGNZ
        AVE4Pt0kJQuZnKs4iX42j2MClXhzimIpRoVcWOsTVLaJjr33hmn8cZdaAZihq9Db
        xKGs6yPkWw2a1hnEE5mEsY0l2VhNFlGuAGt/unmvMLdVEoHQOubYFJjXDy645c3Q
        lfIA4+rKJlRhSHw5QywGybQggyxEfw80vBUMHaeJ2AclviSmQ2pLk2bFNBCxtFZG
        u2Ile7bPPBfOda5/IgytA/bOrItLl1FM/4wXEH5JXpTcvWlJxxQ3rlFcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=HjPRAtmWDHpsBofnlqe6mFYpt2u4m3UE5sd2bFJ0WRM=; b=UYbbbBWk
        cd0XnNAR3UdUR7aW7NfzI7JUuxvArRX+QsSgYDml9b02oq7+/SpZeSG5h7ZvbTJw
        xdCOqxxzxz/j9q4HToLNJAU/575ZpaT9gnAT01u/97HZdHlVdmaEl9S42rxmfm1J
        oAhz3HXGDvM104xo9uwnTexD3yU1aFwnlb6uHgcjJzsdE+qsgtpLm80wLQVPLlVW
        xZ/Zloo2oHTSawgSecWYIogSjGWtZ3CZy6XeOW8A7G5avQs2XsAx93U3210BPgi5
        +KjTi24TRl+iS4Zmhs39QEN59DQnEPGG8WTbuzWzL+upouO6AN8AKvpHs3Hmq1jB
        s0axFguMuDXPPA==
X-ME-Sender: <xms:082kX49-UKwZc8QvAmRNhtJz4bvp9pqP0KwoaMmBoOqQ7Pw1lWshOw>
    <xme:082kXwt5xKWHhqR2Kv4gS7lU8gKGoUrPCuxEJdvflUUbPOcZfqcbk6lZCyZYLH30f
    x5Auia31d3QjxtSmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:082kX-DD6zBd2x4E8aKr-LeO_paPnD9fjvUhum6hFzfYm2rYBHWsZw>
    <xmx:082kX4cSwb257mhJxFF2nS7bq91jJXl9vNUkiBlv3R1PkGIc_zYGoA>
    <xmx:082kX9PxkaTdGqVzakvMGbpvFtlHO5Eu_Bx0lSN_faeNezclk6WICw>
    <xmx:082kXwrja9JmCygt17FK8RoykY1Vh1RMaYKl5fcgNVVx0xLQ3esNWg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22E3E3060064;
        Thu,  5 Nov 2020 23:15:15 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/7] arm64: dts: allwinner: a64: Allow using multiple codec DAIs
Date:   Thu,  5 Nov 2020 22:15:09 -0600
Message-Id: <20201106041513.38481-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
References: <20201106041513.38481-1-samuel@sholland.org>
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
index dc238814013c..b70596c06c4f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -150,7 +150,7 @@ cpudai: simple-audio-card,cpu {
 		};
 
 		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&codec 0>;
 		};
 	};
 
@@ -860,7 +860,7 @@ dai: dai@1c22c00 {
 		};
 
 		codec: codec@1c22e00 {
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			compatible = "allwinner,sun50i-a64-codec",
 				     "allwinner,sun8i-a33-codec";
 			reg = <0x01c22e00 0x600>;
-- 
2.26.2

