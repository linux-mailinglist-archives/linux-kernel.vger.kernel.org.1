Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0FA2C2834
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbgKXNhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:37:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:9417 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgKXNhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606225028;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=l4RKmcHE9AoB+I3oA1SIVpSHWqTYKywjLKV8cJNu5Vw=;
        b=pf2XHfRUTXK1RtOrKjqDEfHE+xyCtGSDVpm0SYjsan7ULGQQBtqKQm8Las11pHvHo9
        +NVe/J5gTvCSq1O516Jmk+iFRqF74zKj42KqyV6IIYDVyNImM5Dwg+AYNwr1i5izAliQ
        i4AnDbPyzwYAjGBbxEI5fl+FD09PeaBPm9VAwbPgUywa9kx13Fe0Wa19IcLV+AKdQN80
        +eQ6KCxz4CojxL3cxaA7CbEeyQG5a4w0sly14GFOIQWQty8QVzpXfV9NOy8pB5M9bt66
        mSoM1jdzW14aHiEqG9YtMkUPsrpDKIWgH0N83Z1FpWpk1vYVv48IiOEeG/h8Aqx1DETE
        SBxA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAODb6DKK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 24 Nov 2020 14:37:06 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1khYVD-0006HR-W0; Tue, 24 Nov 2020 14:37:04 +0100
Received: (nullmailer pid 682809 invoked by uid 502);
        Tue, 24 Nov 2020 13:37:03 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: [PATCH v2] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node to DT
Date:   Tue, 24 Nov 2020 14:36:33 +0100
Message-Id: <20201124133633.672259-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124131933.2l2go6z6ltar5fpa@gilmour>
References: <20201124131933.2l2go6z6ltar5fpa@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add poweroff node to allow the board to power itself off after shutdown
by disabling the SYSTEM and CPUX regulators (U5 resp. U6).  The RST
button can be used to restart the board.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 4c6704e4c57e..ea2fa48a1647 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -46,6 +46,11 @@ sw4 {
 		};
 	};
 
+	poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+	};
+
 	reg_vdd_cpux: vdd-cpux-regulator {
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-cpux";
-- 
2.29.2

