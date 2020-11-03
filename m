Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75AF2A4579
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKCMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:46:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33575 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgKCMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:46:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201103124622euoutp016f98cd3b01a35cf0834bea79760798fb~EADIfTzDY3091430914euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 12:46:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201103124622euoutp016f98cd3b01a35cf0834bea79760798fb~EADIfTzDY3091430914euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604407582;
        bh=L2IxNRN/okRTavoe2InesX9N/lhmRVE5zTluZjyeoH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EABSul1WrBlfkD4jXTb6jRsIqRM/MGu5eRoQTUXDEDKLP9canAkVnFHXPBydZ/5hT
         hZ1JKxGfTc7ZG5ba42ZVhNrr/zwBTay9RY+LjgzU11vY7p7WDYb+310LTX276Ytnmu
         z2Ok6eZvf1kzwXw1+oCWjLUivkjRxldQdT3g78CM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201103124622eucas1p2b870ceb2c84ef2770c07fce1f2580eee~EADIHnkbW3021330213eucas1p2D;
        Tue,  3 Nov 2020 12:46:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8C.DF.06456.E1151AF5; Tue,  3
        Nov 2020 12:46:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201103124621eucas1p1a65f4d88466206a9646e139eaac3e1ed~EADHyNJFD0367203672eucas1p1Y;
        Tue,  3 Nov 2020 12:46:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201103124621eusmtrp23e79f2c041c19cc843b1ca7b7cffe8a2~EADHxj_aY1156311563eusmtrp2J;
        Tue,  3 Nov 2020 12:46:21 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-78-5fa1511e5ee7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.41.06017.D1151AF5; Tue,  3
        Nov 2020 12:46:21 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201103124621eusmtip2df08e6f648d039b60fc1c85e001ed38a~EADHn031-1610716107eusmtip2C;
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
Subject: [PATCH 4/5] ARM: dts: exynos: Add Ethernet interface description
 for Odroid U3
Date:   Tue,  3 Nov 2020 13:46:17 +0100
Message-Id: <20201103124618.21358-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103124618.21358-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87pygQvjDb6dY7bYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFzUMrGC02Pb7GanF51xw2ixnn9zFZrNt4i91i7ZG77Bate4+wO3B77Jx1
        l91j06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK+PTlW7mglccFQv/32NqYJzO
        3sXIySEhYCKxc8ZsIJuLQ0hgBaPEh74pbBDOF0aJz4d6oTKfGSUefzsF17Jy2m9WiMRyRokT
        S+8zQjjPGSWWdEJUsQk4SvQvPQFWJSIwnUli6Z75zCAOs8A+Romd96Ywg1QJC0RKXL80lRHE
        ZhFQlXj3fxEriM0rYC1x/SBEXEJAXqJ9+XY2EJtTwEbixdvfTBA1ghInZz5hAbH5BbQk1jRd
        B7OZgeqbt84GWyYhcIldoqv9MCvEIBeJy/33oGxhiVfHt0A9JCPxf+d8oKEcQHa9xORJZhC9
        PYwS2+b8YIGosZa4c+4XG0gNs4CmxPpd+hBhR4kTL3pYIVr5JG68FYQ4gU9i0rbpzBBhXomO
        NiGIahWJdf17oAZKSfS+WsE4gVFpFpJnZiF5YBbCrgWMzKsYxVNLi3PTU4sN81LL9YoTc4tL
        89L1kvNzNzECk9Lpf8c/7WD8einpEKMAB6MSD69D6oJ4IdbEsuLK3EOMEhzMSiK8TmdPxwnx
        piRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXA6Hp8JtfcQ82m
        BnaTW17kKU1bffzyLtNn0Ws2bgyY3b3Pq5vtzdv4VawJ34Q/zw+9WONltVBbJ+twmMHyzm/F
        0nNPbWmbvHHH+lfXcl4nuTSET8h5a/BBc9eBtP4Zn2Oei1bkPF/9LfrjhNBrt9aw11pO0Hm7
        uDfKPkT0TXeFxP2dTlo2JZYeGkosxRmJhlrMRcWJAMHBXwlGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7qygQvjDRY+1LbYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFzUMrGC02Pb7GanF51xw2ixnn9zFZrNt4i91i7ZG77Bate4+wO3B77Jx1
        l91j06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+PTlW7mglccFQv/32NqYJzO3sXIySEhYCKxctpv1i5GLg4h
        gaWMEt+XdLN0MXIAJaQkVs5Nh6gRlvhzrYsNouYpo8StvunMIAk2AUeJ/qUnwJpFBOYzSZya
        3QHmMAvsY5TYf3Qx2AphgXCJD8/+MYHYLAKqEu/+L2IFsXkFrCWuH5zKCLFCXqJ9+XY2EJtT
        wEbixdvfTCBXCAHV3PuvAFEuKHFy5hOw45gF1CXWzxMCCfMLaEmsabrOAmIzA01p3jqbeQKj
        0CwkHbMQOmYhqVrAyLyKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMP62Hfu5ZQdj17vgQ4wC
        HIxKPLwOqQvihVgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RToy4nMUqLJ
        +cDUkFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXGKSvqSo9pp
        gl/3sud1hr3hDAzgDQ1obKzavvrvkuRjN8OFuavvXt/OYBsy80VwneWRGc3/dbs3zRY2tfsX
        PmXW97iYz6Gz3VZkRrM5r6g1lf6ZN+V8740gzii+XG7piJDk5FXRb6QeTL3yZl3ITNapa9pO
        3L3i+Jmp7Nx81R29fL/ufrnub6vEUpyRaKjFXFScCAC9WdW31QIAAA==
X-CMS-MailID: 20201103124621eucas1p1a65f4d88466206a9646e139eaac3e1ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201103124621eucas1p1a65f4d88466206a9646e139eaac3e1ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201103124621eucas1p1a65f4d88466206a9646e139eaac3e1ed
References: <20201103124618.21358-1-l.stelmach@samsung.com>
        <CGME20201103124621eucas1p1a65f4d88466206a9646e139eaac3e1ed@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet interface description for Odroid U3.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index b8549d846f86..b503f04db923 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -16,6 +16,10 @@ / {
 	model = "Hardkernel ODROID-U3 board based on Exynos4412";
 	compatible = "hardkernel,odroid-u3", "samsung,exynos4412", "samsung,exynos4";
 
+	aliases {
+		ethernet = &ethernet;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x7FF00000>;
@@ -101,8 +105,16 @@ &usb3503 {
 };
 
 &ehci {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
 	phy-names = "hsic0", "hsic1";
+
+	ethernet: usbether@2 {
+		compatible = "usb0424,9730";
+		reg = <2>;
+		local-mac-address = [00 00 00 00 00 00]; /* Filled in by a bootloader */
+	};
 };
 
 &sound {
-- 
2.26.2

