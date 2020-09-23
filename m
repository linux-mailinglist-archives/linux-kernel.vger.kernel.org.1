Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7630D274E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIWA7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:59:19 -0400
Received: from relay4.mymailcheap.com ([137.74.80.156]:36074 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWA7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:59:18 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 20:59:17 EDT
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id EFB3F3F162;
        Wed, 23 Sep 2020 02:59:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 150532A3E1;
        Tue, 22 Sep 2020 20:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600822755;
        bh=2GPWCCvw894rUhZgXRfbyjz8WKkpTgKFBRimqBMWJ9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwsZYmm5ApOLmLgg/5dTmrArECI9n8Kj0iHiCKJKO37X/GQOS3V5aypeQ9XimgvOR
         DHV52TaSlqyONiyqHtjmzv+a4kfzHNTCd51xmZJJ/kkbSzmNPKwTJTsUnNNuWAkT4F
         y2OiSpbcSBu7sFY0JGGAi0nOaxVXFwH6XhCAzvF4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id znaVg3pixAS2; Tue, 22 Sep 2020 20:59:14 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 22 Sep 2020 20:59:14 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 30B9841009;
        Wed, 23 Sep 2020 00:59:13 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="k7sMhUkd";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id EF0A341009;
        Wed, 23 Sep 2020 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822748; bh=2GPWCCvw894rUhZgXRfbyjz8WKkpTgKFBRimqBMWJ9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7sMhUkdG4Fk95KOd0LLENUvGjqhuq+n96ou1++jnWHvH9kbQwZHf+HzazYdIjduE
         qvtMfqSmGjvbPAHN7jnc3IIxTSIh8bD7txeqiT7eTmAtgfH/b9zrp58nZcxRdoYROo
         o0YkgRbYhGdoVSuFHrHJ/c7AWENgdU02T0Fm+43U=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/7] ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
Date:   Wed, 23 Sep 2020 08:58:53 +0800
Message-Id: <20200923005858.148261-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923005709.147966-1-icenowy@aosc.io>
References: <20200923005709.147966-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30B9841009
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.155:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART2 RX/TX pins on Allwinner V3 series is at PB0/1, which is used
as debugging UART on some boards.

Add pinctrl node for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 7d40897dab09..4cfdf193cf88 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -322,6 +322,11 @@ uart0_pb_pins: uart0-pb-pins {
 				function = "uart0";
 			};
 
+			uart2_pins: uart2-pins {
+				pins = "PB0", "PB1";
+				function = "uart2";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
@@ -397,6 +402,8 @@ uart2: serial@1c28800 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART2>;
 			resets = <&ccu RST_BUS_UART2>;
+			pinctrl-0 = <&uart2_pins>;
+			pinctrl-names = "default";
 			status = "disabled";
 		};
 
-- 
2.27.0
