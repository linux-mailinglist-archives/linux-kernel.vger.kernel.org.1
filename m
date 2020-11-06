Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A22A8E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKFEPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:15:35 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40601 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgKFEPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:15:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6474258054D;
        Thu,  5 Nov 2020 23:15:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=LPrGREj8LnC7H
        4kT27R+89/vsU1CuTFnKI4ITrAeHRM=; b=L4PBzOvYizZM8pY68bEa7Mb+pVhy6
        WGH8jt33WtBDSU1lOCf6pTGzXml2Xz9VZaouoe1vX9kvW4NM8U5ZufMQ5UubdYya
        gvyFsbzMsZJajlr24frzHvFJqLh9j+N2m9VrdwXuWx0LZsBmzo0wqZUspIsEr0L2
        VibWp8RJN3FY3LKMcww3HyetlEPpGrxzncWZniPFzamfbAid6NwLSHNqnA8+p47g
        qL5k4D3v9f8SWKCrX8JcAaP57coqxGFLe2Of6G4bbL2Z2OwTQOqV0fs1r7sTpfBf
        5GxeIsaD/17NbJ4lUmPuxgTT8Jx54fccEuBW2Uxpewu8fFNtrQxS8/ryQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LPrGREj8LnC7H4kT27R+89/vsU1CuTFnKI4ITrAeHRM=; b=OJ85DmjV
        zN8KKXU3KomZCxapK1LKs304mkkFGfblyjBFt3cxHNSXNpcUn+i9oJykm5IIOge5
        dxOqyAwENCvgipHKwTfbQWAhK0ghbNDZsPxb6o/wT0KMvMDqTwWZ3BhcLxXMxQU0
        MC1nn0VPlrzGtncWUzhRIPTSpWPMXBoWTcvPyPA1nFCScGIqBVcIg2F10J4Tq7Hp
        c2IVMHb9XrFID5wguKEOTuzxCb+ov35VlXRbie7Px2GPZ4k6eOLz4Eg5fRYQZnvX
        fT9/wQNMPePSlVmoxlkcP95FncpEyIwBhU9aLQeCwx3bCcNRVoGtGFE0d7FEd9e1
        3QAHsS6AVRuQqA==
X-ME-Sender: <xms:1M2kX4Zcwgm42ZGuw8pqfLg_GytHF8Q0jTemh_HJRWQ6Rfk8zpDUNA>
    <xme:1M2kXzblX44RBnKio72B1HEm3zkNYmTcLh0h5-mMS0EW18CsEgrTmNDEXT_eq3yFU
    lwGSoRCifvlP5x1Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:1M2kXy9069_7WN3DkcOkqTG-5JteHVeQk685WrWMr9w2Np4FkNN-Nw>
    <xmx:1M2kXyoe2gOUBOlxLXULMQzQvi-B4nIsPijrkzhjg_0WTZoYDk33og>
    <xmx:1M2kXzpY9BFGV4KPJAVASa7o4_E0nHLdhJaXVKpOQ327q4uNKiirEw>
    <xmx:1M2kX20duzaBUtR9zT6fl94OVq5c5fItlzotqzSTgjMYKZCE2ZdYfA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9CBC03060057;
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
Subject: [PATCH 4/7] arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
Date:   Thu,  5 Nov 2020 22:15:10 -0600
Message-Id: <20201106041513.38481-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
References: <20201106041513.38481-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the sun8i-codec driver supports AIF2 and AIF3, boards can use
them in DAI links. Add the necessary pinmux nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index b70596c06c4f..97334e25ddd3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -654,6 +654,18 @@ pio: pinctrl@1c20800 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			aif2_pins: aif2-pins {
+				pins = "PB4", "PB5", "PB6", "PB7";
+				function = "aif2";
+			};
+
+			/omit-if-no-ref/
+			aif3_pins: aif3-pins {
+				pins = "PG10", "PG11", "PG12", "PG13";
+				function = "aif3";
+			};
+
 			csi_pins: csi-pins {
 				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
 				       "PE7", "PE8", "PE9", "PE10", "PE11";
-- 
2.26.2

