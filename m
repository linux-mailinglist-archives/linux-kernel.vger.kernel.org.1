Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13A42A8D79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgKFDVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:21:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60067 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKFDVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:21:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 98E4B5C0092;
        Thu,  5 Nov 2020 22:21:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 22:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=WJoHCueOR0DNEXXeYK8iIK+ALL
        Jtv8nShb95I+uDLfc=; b=P3H2SIz7adAOluTFuv782HnO/3fz6oY4HJ6t86ZMrM
        Eh/YUUv9By84XP9evBrkU/Z25FvN9ciasRvoxgTNYCWEZLW+8wlJQtCE5jxeXPEL
        9q9GYNyWf3feb/89BbnTseUEfuSYqbWtWLPa+0nyx01iyv+6hzCseZNnCaCyo29T
        JuhI2GgRlSEIVcoCpMDiYtStfMyeprGh08ytz0MFd77y58mcSHqvwcdFFMJIMzQK
        rFI1E6o4QZ+B/WvU3B1q8H6AUSViyQ1cGBCAFgPKLXfE6f+Rf9zMCQsnaOLYrtCw
        HBh0qg0Kf/hQAbq+96n7SWgRo9zfkEhUZah5CXYMI3kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WJoHCueOR0DNEXXeY
        K8iIK+ALLJtv8nShb95I+uDLfc=; b=KEVN33SDKiZJW70GsiEzGxjqA7po2qvSp
        WQYlm256HREekQ73GwEptPaCnJZbzVnuZ3r+jyCUOHJKuTfa1L3lunouhrPPdH3d
        MeRNqCmHOWSwNjkl32pGvnMLs3dHB7T9FqrDahtrKVct0NjJdG4LRghZoXjgd+FV
        fhKP28aziop8GDpnssWA8NPclxUpxsPCJKR3gY/lfX4p0UwqXMDDSaaDQ7UMO8Bu
        vwhDe/IkPbK/R0/1hjkfdnoh/TzafzIbk5xiBuvs9zynauFhISR6D+NDYu234HRz
        w3T5WAjXwCP94S29++59ZyV5Os9N8BnH6mFqvvuL0SEM1bWkJAKrg==
X-ME-Sender: <xms:OcGkX7jipgA0eXb9exzE9uQ6QBiSJfMrPgnMD9U3Zf8_7WDCey6s4w>
    <xme:OcGkX4D0VRCnP3bFaoym1BFXAeozDEW0tAkMBsVTCeYSaeoa4yDdQjbMyL5rcNxAe
    3VINMOTP81dMGv8lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:PsGkX7FypIvFmCpNbTqDR6LDBZyb8hKSNU6RP7-8bJR8XtXnCeodcg>
    <xmx:PsGkX4RHH7LiD5DCHEqSVqhYMQG-9npf2PfApowFAm0Z-5qBcF6a9g>
    <xmx:PsGkX4zPhZMWqXNADc9kcxgy6wWrSEHNED1nXRsd1S-4DP1pg8GDHQ>
    <xmx:QsGkX7yeJY7YazpLh7OrRtgm3k7DdyNaGXtWjMI3pMY4uCrJQCgFxQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1E913060057;
        Thu,  5 Nov 2020 22:21:21 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] arm64: dts: allwinner: pinephone: Use generic sensor node names
Date:   Thu,  5 Nov 2020 21:20:55 -0600
Message-Id: <20201106032055.51530-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating part of the compatible string in the node name,
use generic names as recommended by (and listed in) section 2.2.2 of the
Devicetree Specification.

Suggested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 2da69450eec1..2dfe9bae8c67 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -161,7 +161,7 @@ &i2c1 {
 	status = "okay";
 
 	/* Magnetometer */
-	lis3mdl: lis3mdl@1e {
+	lis3mdl: magnetometer@1e {
 		compatible = "st,lis3mdl-magn";
 		reg = <0x1e>;
 		vdd-supply = <&reg_dldo1>;
@@ -169,7 +169,7 @@ lis3mdl: lis3mdl@1e {
 	};
 
 	/* Light/proximity sensor */
-	stk3311@48 {
+	light-sensor@48 {
 		compatible = "sensortek,stk3311";
 		reg = <0x48>;
 		interrupt-parent = <&pio>;
@@ -179,7 +179,7 @@ stk3311@48 {
 	};
 
 	/* Accelerometer/gyroscope */
-	mpu6050@68 {
+	accelerometer@68 {
 		compatible = "invensense,mpu6050";
 		reg = <0x68>;
 		interrupt-parent = <&pio>;
-- 
2.26.2

