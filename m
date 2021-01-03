Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34A12E8BB2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhACKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:41 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45471 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbhACKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id AAB8B5803C5;
        Sun,  3 Jan 2021 05:31:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=F6mUEIL2CbL9d
        U/IvN0rEbcBZPmENgnExRcp/Qkz2Q4=; b=Et6iXn64gA6nwLmMiPLXw17PHp/jN
        0PCfTieZQoMsSG4g6DvLrP+n16KlDxyqD0LiiqkpaXFHPR9gNznh4rawK4skjS+G
        7G8Zx7rgranylUVvQLiBZehlttfZUZrxf+aZQXmULtFagyd4iCXzpBScC6+O5jC1
        SJXh9SgHtZ1JhN1Ond2cIuQH9l4WXYmTbAHlCsXCwoUq3ibMo/d6IF3DlxS218Yl
        eZeboKgC7d4b8egMdzx9ZaVFvNAyS8Ea9VheeZVoBc0rCaiHcCF4+z24JmDWyUPx
        KNYBm3p1MHRx6ikeF1QL8n4P0zY99kjFpqt91aNLNy/jAYebE4xELMhPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=F6mUEIL2CbL9dU/IvN0rEbcBZPmENgnExRcp/Qkz2Q4=; b=mOwJHAA0
        CodBEBrhUjaT8oyCUN/sKcbiEyqntMKGD0lAvugtxyWIWH8aEklZZ1RFF/AZNJrl
        UqPKJt7DXeCGMArOVVSNlA58QfvSZ0/JBlvIiMpQVLCeyCjzQUo4c0gyt06hP08v
        y0ffdOwesYCV0BBI74asEVrC8x4K47eIUELSfh1f1oO48bQC3lcWSN6F8/k7gkuJ
        NSoTApjfqCikh7mT1PwZdM+HUk32tlxrZLmWJEdi3Qchu1FFdVUr5tXHYrzMlEo7
        zAMQ8fJxsO/NqayAF0PBtOQqSpA6RonNGPcwlH63TvQrYT1Pv8ADiUE0hnDxPHbq
        crtqaLLA7JSx9Q==
X-ME-Sender: <xms:6pzxXw1_vDQjsIbZjcSP1zBK6cNhgoJk0_nhyzh5zJcArpMT5vlGfA>
    <xme:6pzxX7HiWXymqt_x8ft6qkmFK4JCL6ugTHx0_OfDeEHaVgTKZAm9BDxy0219zfgYD
    9gbNh3wi2wTjVzqtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:6pzxX47jfCR9Z8ssN6Uq8xV8VOal9vppO9-fxd43TNyO81_xLF1YEQ>
    <xmx:6pzxX53jae3qNeB_num23X_Ardn_skjMF7cFcqRaqCE3Xn2jRPUb9Q>
    <xmx:6pzxXzG8lG9S8kS-4xz7NWvxfgAa-zU9Aa839O9rAD-7SY5XFBrthw>
    <xmx:6pzxXyeb2Z0qGOZJFYivKIocDlecjsvf3yyUTnVZIL8cGWU4TL0tdg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E86B8108005C;
        Sun,  3 Jan 2021 05:31:05 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 07/10] ARM: dts: sunxi: h3/h5: Add r_intc node
Date:   Sun,  3 Jan 2021 04:30:58 -0600
Message-Id: <20210103103101.33603-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs have an additional interrupt controller in the RTC
power domain that can be used to enable wakeup for certain IRQs.

Add a node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 9be13378d4df..4bf25c5b873e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -859,6 +859,15 @@ rtc: rtc@1f00000 {
 			#clock-cells = <1>;
 		};
 
+		r_intc: interrupt-controller@1f00c00 {
+			compatible = "allwinner,sun8i-h3-r-intc",
+				     "allwinner,sun6i-a31-r-intc";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x01f00c00 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-- 
2.26.2

