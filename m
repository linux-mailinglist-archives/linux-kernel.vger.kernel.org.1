Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFB2F9996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbhARF5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:57:16 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50221 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731575AbhARFwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:52:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 49D391658;
        Mon, 18 Jan 2021 00:50:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=6mBFvu4PMi18X
        HKg4DexDF3uHC56dBWtP9wZC5WADak=; b=dB2BE0F3SIjUli2w+AWTMNVd7knDF
        TX76qkyVlClUBlbEkufrYMNa5d/rJnyqXb6ThS/Kw3T9PHeh68BxXOj5fuuFBuNm
        XodPewyKiUc1W+caH1dYarHD1K5exaTSZ5ACuGANkosEExsmSY8Nul9EKSG5b/Ux
        GrxdSxD6tWm2ehoMVHsjfZZMrKI4reQ1DelpD+pZLNVOWgnKDtjG4zPrHQ9qsshx
        G0jzEqadmQtrpxiIClK+zDz734cuo7d6WESB/dKZsq0kI7e3i0Pq+VKLrYyeGftg
        g4ggZxzFotKelXcnlwNQC1KNYxDqfqBo2z/t94ojzl/JXB2fBG/y0Q8iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6mBFvu4PMi18XHKg4DexDF3uHC56dBWtP9wZC5WADak=; b=SgCX8ltZ
        Y+kTYzml8QPxT1+Os/o9x/dM8ZS8k93RvGrP50Sd9K8/9yLVrPwHxrdhyJheSYos
        zuSe1EcPcpPFmoXrrQ0QyoH49GoggNQCuqgCG3l8qFRQD5ki8ku/yPUMs580tKI5
        mdWy8qePurmZE7tuZzY6MTzyrbTZgowhYLcDBhog+tpib4NwX7SRLq9dx9yNfakb
        32wuJ4n567Z2PUgetDaxndfaVU0kDRtjusJVmPJ7DAlQ1d70gi8l4TbjmjKRIi43
        KfpfQfdQmWfp0Eh1cxn32jwizsUuFdcUqHCeAW0aIiU89nm/BBw1d94uxKg95pZ0
        kaee705GbmP/Uw==
X-ME-Sender: <xms:tCEFYGS2TtIakxwbyhG_ok7aLBzsaiaMcKA8nJjEQgW4mjiIuv4E1w>
    <xme:tCEFYPCID1Rw5bH30K8ubR-bHLgSX1yMXLAHx-2vOJC8TxDBRBjdjyJJb1GWs1ix7
    4PvrRri8dJDhFY63A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:tCEFYNRxrwVz6NBzXmc01y_TbnKM6SS31b22_QZL--gaJit3IJAC9g>
    <xmx:tCEFYNpqyT28zBpadFD76NHjWdrT7kzRTovECZQQpQ6GsJT2-0u9vg>
    <xmx:tCEFYPzbS9wi0wZ_BX0AQDU2WQ7hgBJrSH9szyITDCdQXkPtTFR09A>
    <xmx:tCEFYCEkSG2CL9eAKFlg6dkk-i7fc4kIjWh7vnNXnW-NVXR0GsSmU_X5KBk>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6421824005A;
        Mon, 18 Jan 2021 00:50:44 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 07/10] ARM: dts: sunxi: h3/h5: Add r_intc node
Date:   Sun, 17 Jan 2021 23:50:37 -0600
Message-Id: <20210118055040.21910-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs have an additional interrupt controller in the RTC
power domain that can be used to enable wakeup for certain IRQs.

Add a node for it.

Acked-by: Maxime Ripard <mripard@kernel.org>
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

