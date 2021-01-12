Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF692F2829
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390885AbhALGBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:01:46 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54935 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390749AbhALGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:01:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5CDB2580564;
        Tue, 12 Jan 2021 00:59:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=F6mUEIL2CbL9d
        U/IvN0rEbcBZPmENgnExRcp/Qkz2Q4=; b=kHhqpEbe2DpvH53QDM97Yv+gZKZRy
        MV8Rfo31l+WMi7gO9/5wDa1HTbzf7quqobGQihGINv4lYur428RcLP90biNQUQF3
        4hxFRbCBMP2hWcaKsfgjdCFooPR9ceJbck9YzFO2y65b7R0nJ0LCx8qZ/z6E4XQE
        U+HrMHAdP1fkUEOOFGAokTWt8JuIcCPUo97xz6aWkvLwKSqVhI76YT33iaJm5CB1
        xjBNcH4Ntbc9juZ08vNHOwsT6IlFZipGqm5MmCkbtbPHNwKEJVr7NPPIW2aFbbj8
        L2maMvdKkG6y4r/s+VXJUplQ1xyRsOW0/+gagSMro6bv+dTFQUZLmIV1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=F6mUEIL2CbL9dU/IvN0rEbcBZPmENgnExRcp/Qkz2Q4=; b=QSPDhlQz
        jy4pgAmcJabwrKfdsaVTranDLEPd99PiBOtVuYpXfemeKAiWrD9imECSd24HZDyn
        1aeXzm09hxDKtss8RYDebblEO2sVQHIzqAhu+5/WKw9ou9f58D6pGmUCY0M+tasn
        I+yY6Nzz3HFUsok7zGrGDg4Y1FSTg0HJOT0dk3YT0pYxWpTuErvyL2GlQuEi15uM
        Bc+MlqRNTUkaTGs5s8GXjzl3XLuXnrFhH7RGLKrR00R2bOtetG+X49JYR4nrG6CR
        3blfG4MD1dW063CACTxqJ5uACiLJDLtV5N2Ai82DgmDGnLKn8Ravi3lWKprFFri9
        ssPt7npbDxor5A==
X-ME-Sender: <xms:2zr9X4DHszepKdRCHyFFnDVeK8zzoR1XKkdb86D75ghVglwPCRXOvg>
    <xme:2zr9X6gNv277Wxzff2EQMoaUeMvmgt1x26Jp3XRIV0emiR2oD0uaz0pDdZTi4SWqt
    TVEH1pPyekUQJgFOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:2zr9X7kY3gvhb7M1vC04BXMlZ6zeHqv_zpi-nQC3kxbOz4YIiPR_tw>
    <xmx:2zr9X-woNhUZyqt-Xhm5A9U2v8llI_HHuRAWpJpRNb6xYq2h0ohK7w>
    <xmx:2zr9X9Q4p04nXeeINw_bqzYUahh07Xvp0aLDw0xxJAGnfpoDJ9mM5w>
    <xmx:2zr9X4GhGIvLHmKfOIvjEpGjkGyJwE04eL7KLyv3DEhr37VWFc_TCw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B16A224005A;
        Tue, 12 Jan 2021 00:59:54 -0500 (EST)
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
Subject: [PATCH v4 07/10] ARM: dts: sunxi: h3/h5: Add r_intc node
Date:   Mon, 11 Jan 2021 23:59:47 -0600
Message-Id: <20210112055950.21209-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
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

