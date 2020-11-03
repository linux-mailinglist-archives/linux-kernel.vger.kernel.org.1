Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13302A4580
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgKCMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:46:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33636 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgKCMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:46:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201103124630euoutp01fb65ef65e1e25f8b58791d4a660eb113~EADP44Jgq3097030970euoutp01C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 12:46:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201103124630euoutp01fb65ef65e1e25f8b58791d4a660eb113~EADP44Jgq3097030970euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604407590;
        bh=/Ghcln1cQ8GuKJWrQrUXaeTMPiIcSvuMQhF7SRSZ83o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVeH7AINO+fbweeDG2D94wysJk7/e2eY93Bocu4Aa6Rqe5l5QiLSyhsUPQ+l2KIxO
         Ug0eiwcHwniBMEfHNefe8PKug6yVByQIdiWBzzZUNrHm7cCvLRFtJqqoTqbuRLCT6c
         KmrToYwTRrKmvREsQ3Y2kL+VPQS2Fm/QbUVFEl9Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201103124622eucas1p286fac108143a588f2c339b86434315d3~EADIbwXA53203432034eucas1p2P;
        Tue,  3 Nov 2020 12:46:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.8B.06318.E1151AF5; Tue,  3
        Nov 2020 12:46:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201103124622eucas1p25be1feaf9194a0e6b183d041a574b406~EADIHf88c3207432074eucas1p2D;
        Tue,  3 Nov 2020 12:46:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201103124622eusmtrp2991c606adf2b68e76feb0763445fe261~EADIGy_tP1121611216eusmtrp2b;
        Tue,  3 Nov 2020 12:46:22 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-f0-5fa1511ec056
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.41.06017.E1151AF5; Tue,  3
        Nov 2020 12:46:22 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201103124621eusmtip153ff1a9c06d5d983b2970eb6ca184a0d~EADH8m5Jc0493104931eusmtip1E;
        Tue,  3 Nov 2020 12:46:21 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bart=C5=82omiej=20=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 5/5] ARM: dts: exynos: Add Ethernet interface description
 for Odroid X/X2
Date:   Tue,  3 Nov 2020 13:46:18 +0100
Message-Id: <20201103124618.21358-6-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103124618.21358-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87pygQvjDe4vFbfYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFzUMrGC02Pb7GanF51xw2ixnn9zFZrNt4i91i7ZG77Bate4+wO3B77Jx1
        l91j06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK2P77F7WgqtcFS/61jI1MK7n
        6GLk5JAQMJHYd+IPWxcjF4eQwApGiecn5rBAOF8YJZpntDNBOJ8ZJd7tfMQG0zKl9yhUYjmj
        xNofi9ghnOeMEhs/X2EHqWITcJToX3qCFSQhIjCdSWLpnvnMIA6zwD5GiZ33pjCDVAkLREu8
        +ncfbC6LgKrE5uf7wGxeAWuJ6/0XmSH2yUu0L98OFucUsJF48fY3E0SNoMTJmU9YQGx+AS2J
        NU3XwWxmoPrmrbPBlkkIXGKXOPCkF+gMDiDHReLLLleImcISr45vYYewZST+75zPBFFSLzF5
        khlEaw+jxLY5P1ggaqwl7pz7xQZSwyygKbF+lz5E2FHi34sTbBCtfBI33gpCXMAnMWnbdGaI
        MK9ER5sQRLWKxLr+PVADpSR6X61gnMCoNAvJL7OQ3D8LYdcCRuZVjOKppcW56anFxnmp5XrF
        ibnFpXnpesn5uZsYgSnp9L/jX3cw7vuTdIhRgINRiYfXIXVBvBBrYllxZe4hRgkOZiURXqez
        p+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYJQ9xrH8
        lcyCn1Omzk8u1J/sFPFEUXaKVIrCReGJiVyrxWoOa5bdSr+Tdi5SqfvY+ePJPZ8b+pN/aHze
        U7C+2avysfNdhc/hB7xehuQeT1gtqBxRmVn6xvDPhusn8qdOe7mQLXFznlH7F1dt6+s7rk7b
        9d6yr7BBPu3AqlOWxXIWy86F1U/leqTEUpyRaKjFXFScCABSDE/PRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7pygQvjDbZNYLHYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFzUMrGC02Pb7GanF51xw2ixnn9zFZrNt4i91i7ZG77Bate4+wO3B77Jx1
        l91j06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL2P77F7WgqtcFS/61jI1MK7n6GLk5JAQMJGY0nuUqYuRi0NI
        YCmjxJzd99i7GDmAElISK+emQ9QIS/y51sUGUfOUUeLZjVfMIAk2AUeJ/qUnWEESIgLzmSRO
        ze4Ac5gF9jFK7D+6mB2kSlggUuL7uk8sIDaLgKrE5uf72EBsXgFriev9F5khVshLtC/fDhbn
        FLCRePH2NxPIFUJANff+K0CUC0qcnPmEBSTMLKAusX6eEEiYX0BLYk3TdbDpzEBTmrfOZp7A
        KDQLSccshI5ZSKoWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIy/bcd+btnB2PUu+BCj
        AAejEg+vQ+qCeCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQF+nIis5Ro
        cj4wNeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCsX7KkQ2sD
        34WjbYImIY9Ejyy6lfwm+J6KVHaAebaxoegC6cSKm66d3Z9UI2fNq7cQYAq5b2bwq7MsJvN4
        1qFZR7LyMq7KXTps/FP+5ZG9vh/cTERUjTS/581a7Go4ZXbtg0MCjdpXZhw22DQrwvfp0lNB
        KyuevGLz7L61UWl51J/FBumbzygqsRRnJBpqMRcVJwIADRHAv9UCAAA=
X-CMS-MailID: 20201103124622eucas1p25be1feaf9194a0e6b183d041a574b406
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201103124622eucas1p25be1feaf9194a0e6b183d041a574b406
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201103124622eucas1p25be1feaf9194a0e6b183d041a574b406
References: <20201103124618.21358-1-l.stelmach@samsung.com>
        <CGME20201103124622eucas1p25be1feaf9194a0e6b183d041a574b406@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet interface description for Odroid X/X2.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 3ea2a0101e80..8f154f431f6c 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -15,6 +15,10 @@ / {
 	model = "Hardkernel ODROID-X board based on Exynos4412";
 	compatible = "hardkernel,odroid-x", "samsung,exynos4412", "samsung,exynos4";
 
+	aliases {
+		ethernet = &ethernet;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x3FF00000>;
@@ -72,8 +76,32 @@ &buck8_reg {
 };
 
 &ehci {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	phys = <&exynos_usbphy 2>;
 	phy-names = "hsic0";
+
+	hub@2 {
+		compatible = "usb0424,3503";
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@1 {
+			compatible = "usb0424:9514";
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet: usbether@1 {
+				compatible = "usb0424,ec00";
+				reg = <1>;
+				local-mac-address = [00 00 00 00 00 00]; /* Filled in by a bootloader */
+			};
+		};
+	};
+
+
 };
 
 &mshc_0 {
-- 
2.26.2

