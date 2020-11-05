Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008772A7723
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgKEFll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:41 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41311 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbgKEFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E1465C012C;
        Thu,  5 Nov 2020 00:41:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=2C6TglOhcnmUj
        vInlPf//jN+FgeWJ9nu0Hxe9wqASW4=; b=A5dMCToC/w8UeQ55ITJdpdCfqIPNY
        kSzAWIZuZTCU0OP04txijR14fAdR/fFsPbZf8nIvjVZrK0PrZ7U3dfclJToR4aQ6
        h8WZsnQ23pSsKZHrQJ1ufT9z2wKd7z38AaCgEWKpP35tTUshychhc0vS8IDaMLRv
        EAxU9fuLHEQuoTWHiLhbdHVM3quhLYy0H1y567ClhHBWRUaqqKrqJGtevsWSarBk
        vFOWHukIDT12+pilDtVV2TfdujUoCU+SSHSDL7vCi1hykPaEIp1J+LGyZZsUsj1v
        twXYbYqQ2QeDgsdfz6ETK6Vxs6YcUUctROotVD/MaUwTYJ+PGj0s24XDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2C6TglOhcnmUjvInlPf//jN+FgeWJ9nu0Hxe9wqASW4=; b=jPjlGJa7
        5Vjb1k0u+H3eQXWGbOmlUZVKIyXb1BroubFxai2vzb/prwYxdg3EEDffTeQzn28z
        aWprraUA7WnwcSQUQcorhkx/2856YofGZwrbWwpQJo3rMf+OBGViNrp9orGrCzve
        ej493HQ7ocWCnpM//vHHNuU6BL+OTc/QunUX1rHsNbcCqnhSG3WnubBGuzIBGQCs
        AxcXwmzQM2XnHJTvKf+hk/06UJ91vaUabWxv1prKSTfFf2K6KapxfEjlnw+C91g4
        65mbj7ptfRDxAbF3HZ68Jm4fcG5F8P6cX3ZE5kUBYYsGU7y0hc8ojpVry0C8NrMR
        Zzq2R1dM+HZjTg==
X-ME-Sender: <xms:kJCjX7bMqpBeCrFpKmFu5i6q2Wp6ksVppaQBYoV7LRE71AkRItfpEA>
    <xme:kJCjX6bJYuBPRz7LtR_EYzSik3_iVSxejokZAe6gqMJUWdEEXbCLT-iu8lSZ-PDNV
    sr_zJcd9-GOQjGt6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:kJCjX99XoxtLPHyOjw0HDBUC_twmw_9jbkHfpDj6sUQJlx3yMBwatw>
    <xmx:kJCjXxow9i0Hkpge0YYUaWKHa2GGRlQHVAYqiwXbfQoYGCQZ42a-_Q>
    <xmx:kJCjX2qbReGnHmzT0fEMymVk-av_MDH3IbOPEId23Yyq2EzgnzinAQ>
    <xmx:kZCjX3fL3L7vKUaMyMbVpoCqbKJqqvyts2wCw7HfzA5NTG3zor9Xhg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69CB732801D7;
        Thu,  5 Nov 2020 00:41:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/6] arm64: dts: allwinner: pinephone: Remove AC power supply
Date:   Wed,  4 Nov 2020 23:41:30 -0600
Message-Id: <20201105054135.24860-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803 in the Pinephone has its ACIN and VBUS pins shorted together.
In this configuration, the VBUS control registers take priority over the
ACIN control registers, which means the ACIN sysfs knobs have no effect.
Remove the AC power supply from the DTS, since VBUS is really the only
power supply.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 25150aba749d..48050bbd941d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -251,10 +251,6 @@ axp803: pmic@3a3 {
 
 #include "axp803.dtsi"
 
-&ac_power_supply {
-	status = "okay";
-};
-
 &battery_power_supply {
 	status = "okay";
 };
-- 
2.26.2

