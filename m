Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821912A7722
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgKEFlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41313 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730751AbgKEFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7CA205C0124;
        Thu,  5 Nov 2020 00:41:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=1DeLvsz3Vh2Tq
        naJT1F6Tq65fu4iaiULawNvWxF4wS8=; b=VE0PaOm0vHlvkr/0NRN5krsg++4k9
        OdQKcfPV52iaZIpypvX9oo/+qTeoiLF0L8y+Qhu5QyA8DiIX1MyKqy5PWSM2vxQw
        BPJtWF8w6EWlQAqW1Lu4UcWqJoASUFwt4eitj0Pwv5G6kdXW9pn/OynpkBh689Ls
        qYVQM7EZUZ5x2zD9PhgFFbwAp4eoEtJ5+mBlx/4khutF1pdVX/DFivs94vH0mE98
        RCESIOoyY8XjrGSSIY7V1YlFHf39pPck3eyf877q4PYPLfV0bE+Q1FPKMagi7Jxz
        HILLo8IrZ9o1JAD2+BQApfHKkbWzn0s4qkNkyXyUFdXqke2co45rBPq4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1DeLvsz3Vh2TqnaJT1F6Tq65fu4iaiULawNvWxF4wS8=; b=g7ijo1vs
        2eZ5KwBhndN8CW/wCBLGLw+Ub/4/qPrkDX5roGquTl/vMShI5hw+mP/UiH/bNr4l
        Sl8DIRUUd/T0fHRiaow8aN5rWhMseAqbOlZ8olr2DmwqgmzhV8ZJdUzLt4YF1Yr0
        lQAwL2pWYk8+tCqYf8IhggOHz+C5v/hoOewR5t9ivpAadhZAdsrOvUEEiAvB8iyf
        o52YwsAwmhRxyiSsIT37lA1HC3Dv+lGwvVOKTWuAZXo04jdcSzRGcY2h/ZFtguoy
        aGUoqFCIjbg/uB9z0gPLs67UMp7FfX7IE0uxW1Qv08hF2bLyO2RisPzoCgXDuJ7V
        GA7cn3jj2nWkyA==
X-ME-Sender: <xms:kZCjX8npjBg9OYmstQ3am_BoKpXngFDStAjXDpmhvI-KF0PPwtgtxA>
    <xme:kZCjX708TCl8Nmqu3o0bFsW8g_OKDl6t8YxmRzwgjGQo07XC-a0LyUSzbvy2zKou7
    dgIz7XfojxTzBx6ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:kZCjX6oCpO-5Nyz1S161q0B_AzaoNb09EFxR6mUHR9hOkaVi6AaxZQ>
    <xmx:kZCjX4lK1Yj-_sdw3_uFIUwHYmPJARCL71iX5grPTpgWoQd6Lw4LBw>
    <xmx:kZCjX62WV6TZol5QSdkYYnhR7xdlAM7P2TC0NbpodIdhqiNaiil69g>
    <xmx:kZCjX0pTHFDT8UxsYtiMphGGs6H0Np1U6nD5CirD2Zhyx4GpHMfgbQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC75B328038D;
        Thu,  5 Nov 2020 00:41:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/6] arm64: dts: allwinner: pinephone: Set ALDO3 to exactly 3v0
Date:   Wed,  4 Nov 2020 23:41:31 -0600
Message-Id: <20201105054135.24860-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALDO3 is used as the power supply for the LRADC keys voltage divider,
in addition to supplying AVCC and VCC-PLL. While AVCC and VCC-PLL will
accept any voltage between 2v7 and 3v3, LRADC needs a precise 3v0 input
to maintain the expected 2:3 ratio between the internal 2v0 reference
voltage and the external supply.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 48050bbd941d..57c89c3b71e9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -270,8 +270,8 @@ &reg_aldo2 {
 
 &reg_aldo3 {
 	regulator-always-on;
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
 	regulator-name = "vcc-pll-avcc";
 };
 
-- 
2.26.2

