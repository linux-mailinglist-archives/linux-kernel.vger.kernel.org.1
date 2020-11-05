Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C52A7729
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgKEFlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34953 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731067AbgKEFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9BCA25C0170;
        Thu,  5 Nov 2020 00:41:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=D33AIT7REaO42
        I0oyofLCBVZfk49c1xYEtUgewG4c8Q=; b=IPtd1OrZ933FlMJhwROhJGwo/mikc
        yxlKixweFOu/aPrSwqYqZVk21dmxWWPgNupEI2YD20KbBY/KV09rHcgvpPjbwH80
        KqO9ADXsHlPyQpJXFeO227VBMY0cw/Zkidu0IYSj2XCfb55B8KMVJgPRSuzYg8O7
        IerBry65G0BDcGZmA/IfQ17URCp2W5QECpnoIZsu2Y8tclR9Q5Eqk2BgP+IFG3Km
        DxkvrOQA9diLpqUTdu2+X6QaCtkvGjqH2YHIAVzGhzZbUN/alxU/Ov2kRFWzDVj8
        028WyvGgeNDZB2Z+iwazeaPJFyxA6364QiRyTZjk+Y9T0Z9PfCHTAM+cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=D33AIT7REaO42I0oyofLCBVZfk49c1xYEtUgewG4c8Q=; b=k+XHEyS5
        6yDbAWcroux4K1AY6/k/JDX03DIGNT1jY9gW0ZwHp8Na70EFBpYeWEdu4xHPqhZ1
        3n8CGWI6xbtiCFKxUQ13yVBh05CNTgKFW82MihxoNZKnzzUZPwtQkdVdmenmtEPL
        xG1kXhs2bD9b29lika1WvaRs0mXNynscgz3mw9ncqdonUbmA8cenpKOz2pFqFE6/
        BgdTZ0fu2fAY4ZsrWUZmXEXlScAU8ABbUwsf/9tJXZW5EGQdLzqmDdMmab5JMU0m
        XQKGsvlocF0KgK6UM7mw9nYcUCalfOgsEUcFjBJUmGOxqA3n6pU48aA8WaalzvOi
        asgZVwOXpiSYhQ==
X-ME-Sender: <xms:kpCjX_5qsXiYM8lDFfR8GagAd1PN80V04HGsLh3qP0UCfazvoFOl4A>
    <xme:kpCjX07eyPerNi_b3ojyfaLNXfu2rxlG8MerCkgTYDE8iVWMT4K-Sy8GQqFUQOdWG
    MvC6mcYUsXZ_zb9sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:kpCjX2cTiYNjTHIrDQH3onepX9e0X7I6lU7lV57I2baMUuGCYocz0g>
    <xmx:kpCjXwI5o6LgoGrS-l8QT_Wy3ATrsdIpZW_W5ENpdHNCmGWroxcAQg>
    <xmx:kpCjXzLW0mrXh_xRo6coY5cVEISj9JOM33STnRh_vpg2d37Y3xeOUw>
    <xmx:kpCjXwqYfmnlXLX4ecD_4vDUWIb5rr_B0rZJ7uu1oQj-t8-2F_PIJw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A544F32801F2;
        Thu,  5 Nov 2020 00:41:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH 4/6] arm64: dts: allwinner: pinephone: Add light/proximity sensor
Date:   Wed,  4 Nov 2020 23:41:33 -0600
Message-Id: <20201105054135.24860-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Pinephone has STK3311-X proximity sensor. Add support for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index e595a8262920..9544d7658794 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -160,6 +160,16 @@ lis3mdl: lis3mdl@1e {
 		vddio-supply = <&reg_dldo1>;
 	};
 
+	/* Light/proximity sensor */
+	stk3311@48 {
+		compatible = "sensortek,stk3311";
+		reg = <0x48>;
+		interrupt-parent = <&pio>;
+		interrupts = <1 0 IRQ_TYPE_EDGE_FALLING>; /* PB0 */
+		vdd-supply = <&reg_ldo_io0>;
+		leda-supply = <&reg_dldo1>;
+	};
+
 	/* Accelerometer/gyroscope */
 	mpu6050@68 {
 		compatible = "invensense,mpu6050";
-- 
2.26.2

