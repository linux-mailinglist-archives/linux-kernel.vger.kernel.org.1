Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106172C0FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbgKWQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:11:13 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:27242 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbgKWQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606147871;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=r79O/P1839GmQYZ+SH8EHuSaDqcnxgnZm/rLG59yiHw=;
        b=dy/y8U9I2S3/SsJuQ1wENAToEtvIaJgJCxfbSfZT3y5ohvN/q/Ltq6oYJd7TZQ1akL
        kWO+6qyLyMcuxWnFzj8i7Uv/FKWWkTI6IpkhAzW69kKBNf6C64HOM+V6prIDK82MNY+I
        l9lN5ZjBfQtt0pBbaNxr9QjifuLc2siOtJ5MAxTypNg501djYUgdp2bbUy8zqI1W6J3r
        TrDLtatcyl9JGTYHjtOVggkHUvdJtOyMq9tQv2lqXXS0SRIa1jKKNgtMPkN0vZxYTEsC
        tqfRtsGFDkqKz3aeF2vdLwOPz23kzqvldWXX7z7gkau3YgeMXcw1mOkRqQtHT8f6GcgK
        V1cA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wANGB96rS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 23 Nov 2020 17:11:09 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1khEQk-0003gZ-9t; Mon, 23 Nov 2020 17:11:06 +0100
Received: (nullmailer pid 2304817 invoked by uid 502);
        Mon, 23 Nov 2020 16:11:06 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add gpio-poweroff to DT
Date:   Mon, 23 Nov 2020 17:10:41 +0100
Message-Id: <20201123161041.2304766-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-poweroff node to allow the board to power itself off after
shutdown by disabling the SYSTEM and CPUX regulators (U5 resp. U6).
The RST button can be used to restart the board.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 4c6704e4c57e..76e79e6db733 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -46,6 +46,11 @@ sw4 {
 		};
 	};
 
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+	};
+
 	reg_vdd_cpux: vdd-cpux-regulator {
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-cpux";
-- 
2.29.2

