Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E38E1E05DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 06:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbgEYENI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 00:13:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58375 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgEYEMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2FFEF580093;
        Mon, 25 May 2020 00:12:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=EgpbtN/+ei+48
        TUPE6rJYI7EBx+b/wvisfgtTkfb6gU=; b=qpXxGAAjLUpAy9WDNMYjbZ5O0Ljyw
        IzOx73Osb8vd/SNqV78gEYSp4+wDv0KNYSjZSDWydMtvKFp3RNbr6LvnzcS0KLXP
        dX6xHVIMQ+sDPpflqy2lVidGxJzK/a3nXxxzR1DTwn6AYxhYgzyrhugHpAZtJ/jO
        mAXB21LORPmUnNTohTPGmuDtRTaIS1S+VL8987QD53KOcSBnq0E9xz/hfbS/DCKF
        B25171mgORxD5aFg2XdtGpUF86KuGK/6XgfJQ4hZn1mBar3zaloRu0wSowgWEFkP
        jdHrabb+FIHKgiuKp4d7Qsb561CY0VZfz/s/QIz6xTpqhHOWUB0GLfH8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=EgpbtN/+ei+48TUPE6rJYI7EBx+b/wvisfgtTkfb6gU=; b=PRzOewQ+
        Phs1aVdVZtrv1lvhroOOrMhOnVLE43OnsCsU4ijXhcxXA3ATKSCOK4K2gKvwewqZ
        J2IutSyq/MVtONgCWdG4/VZBtrAEoYFsrSujyRQ99zcT3YbqQp5csiiBxGmfyDBS
        vB/9ecZTosNNCLPaJgs72TgkhHzOrnRHIprzgdRVlhm4sZ4NwzaWORGXyPhu9WyA
        WrFeL38Wug6b37/0OniGvI+7UXABz2sLrMtBb6iGzvAGu1XVSsIRfbHLi6MaTB6N
        orguUPjNtn+kfcaO9GQ++5mdS9n04C/AbNj+w5mG1XHXFwTfDAB6bwqYOU9QapMC
        /HNLznxGnPrWcg==
X-ME-Sender: <xms:uEXLXt-JNE6ahII_u9VUM9sgToLpHH_CqnZ-bvdMAyeA8zFLMnykbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:uEXLXhsqx0OJg0rE9kBQIYaWKtcJNKvfq_vfmrWdX5HD_kow8dZjig>
    <xmx:uEXLXrCH5f0WmaY8Xg_Z8oGAxSvkV46iLicv0LDHcxWm3Lx7vF6anA>
    <xmx:uEXLXhdSxk0vdtZMl__FuOG50FVtd6_0u4s57SR9IrYTAyDJa7iJTA>
    <xmx:uEXLXjHDCEypRycqwy5ViMOImS67LFUZd3wmdf3Lr9fhDQDm0J-iMA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BB5C306653A;
        Mon, 25 May 2020 00:12:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 4/9] ARM: dts: sunxi: h3/h5: Add r_intc node
Date:   Sun, 24 May 2020 23:12:57 -0500
Message-Id: <20200525041302.51213-5-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200525041302.51213-1-samuel@sholland.org>
References: <20200525041302.51213-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
index 01a5df9aa71b..94f648ad1c9e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -836,6 +836,15 @@ rtc: rtc@1f00000 {
 			#clock-cells = <1>;
 		};
 
+		r_intc: interrupt-controller@1f00c00 {
+			compatible = "allwinner,sun8i-h3-r-intc",
+				     "allwinner,sun6i-a31-r-intc";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c00 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-- 
2.24.1

