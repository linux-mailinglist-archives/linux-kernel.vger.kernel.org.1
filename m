Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C552A7728
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbgKEFlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34165 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731187AbgKEFlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 471635C015A;
        Thu,  5 Nov 2020 00:41:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=DMFfDP5sKyjZy
        MXY7/MdyT+HBmUIZ8szMg3mFfRPJ3c=; b=nnAJJftSdi7klOyOeh5J1tRovXFHK
        OXmHSSXQ6xFGyaUGUNvq5hEFAxlbkrhi4F4iLlOQpYUHTgDB2PHvyOPL1dAYyL1M
        TSnWUUjeGzcE8OpwhQmDWKrV60Tlsut4sN4FCsxdJosMpjwynps8w+qy8C4W3Vhg
        Ri8qYLiOHCQLY5oh+4aJV4piHZyZefQj1cBLPaFjIhhfhXZ3sFRTwIbaPLH3b9Ei
        TSTWnkCw1enLASPA/0wJBClAf7cHTttpE98HOdPuPZ3RwGRb/PBNoNXUNLT/KXSQ
        4MU/Z59Gyeo8vD1FVpxvdWZVKumI63ppY5irQKnsQvCXNWqhafp4hz63Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DMFfDP5sKyjZyMXY7/MdyT+HBmUIZ8szMg3mFfRPJ3c=; b=liTYB3ev
        j3kRDV2ebqnZiZJggDA93QOYcmWVdVvwnuj3c7WU3II1StN28Z19d5uh7PJaU8e0
        JP5/a4++sizudKnF0FA+3hHyIU9YGkK9HumKRN66Jm00uv0uN9AtPiPhv7I63Off
        6Iv8QdEuRAm6z86wDVAgjnGoyza3qtZfA6e/njoONqGx1tqMYnhckZfJRgkMthbk
        nAl/P87aVspDBklRmJunUkjG0eBjToEBwqGX30Nh9qTgAV7VNNZbfhmwttTdSnJd
        PpRv3yU6TRC/uXZ4TmVq2SGTO88dnMBjtoi+wADnrfvold9qXG+9MQVolnFdr4cI
        EOfI2dIsIspLjw==
X-ME-Sender: <xms:kpCjX19ZFOGUCMisfVcbunBPAGRg-j8FDjJv4k5EYblwvohUesH6Bw>
    <xme:kpCjX5uDfysEF9wROu1fa1z1asNqE_jGVaEjBc2bU2hxpk_IQZGFgTZcI7dHja9X6
    ZNrsQ5oUbob_lmhyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:k5CjXzCjzMkNv2FpNgR_aczWL-0F5TzBhdXLz-bdVkOB9Nx7dbWA4A>
    <xmx:k5CjX5cH4huI7M2iT5RNLvPs1Y7dzbOmHwOw3oBjDhPylk5JDAwqpQ>
    <xmx:k5CjX6Ophh-6uoEyoo1ypHxc4lwSdhWhhwYZD7dt0IqNpXMMg69IoA>
    <xmx:k5CjX5cqDb-nFGDy3adGvs6SgqJ3EERrHV9um__CXpTupfCqjokosg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84FD63280393;
        Thu,  5 Nov 2020 00:41:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH 6/6] arm64: dts: allwinner: pinephone: Add Bluetooth support
Date:   Wed,  4 Nov 2020 23:41:35 -0600
Message-Id: <20201105054135.24860-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The PinePhone has a Realtek rtl8723cs Bluetooth controller.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index e173096a7e68..1083055a731f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -447,6 +447,19 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723cs-bt";
+		device-wake-gpios = <&pio 7 6 GPIO_ACTIVE_LOW>; /* PH6 */
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		host-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+	};
+};
+
 /* Connected to the modem (hardware flow control can't be used) */
 &uart3 {
 	pinctrl-names = "default";
-- 
2.26.2

