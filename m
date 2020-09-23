Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3437B274E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgIWBBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:01:43 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:49525 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWBBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:01:42 -0400
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 058E7260EB;
        Wed, 23 Sep 2020 01:01:40 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 3519D3F157;
        Wed, 23 Sep 2020 01:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 7BB902A911;
        Wed, 23 Sep 2020 03:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600822897;
        bh=lGGQP3uOC1+o8heVDFTEK+4+dQ+oafICIec/tyjv7zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgzJ+0D34FrANaACEb7+kWThsTh0UjsHNeo+tCPt8dKxUalprX/8Ly569kftys16X
         ZKb4mxUk8OPfrieQbf1cTJD69hEx7EwHJFxn4Fryvpebc0BsIBLUHxe//UKkond1b7
         Z0FaTHUpBbJoziasMQNDU6GPQO3HJXshLjxMu4jU=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5WixEX5A491P; Wed, 23 Sep 2020 03:01:36 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 03:01:36 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id E427E41009;
        Wed, 23 Sep 2020 01:01:35 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="E8bBB171";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 93E7841009;
        Wed, 23 Sep 2020 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822824; bh=lGGQP3uOC1+o8heVDFTEK+4+dQ+oafICIec/tyjv7zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8bBB171f7+9Y+/UVli2/zpemNzHTIObFMW0NenDbNAP7hQ6YJvSE2jCU+e891C00
         84lRbVnzpD08fwTLpgVwml7guelL6agZfLrF0nLYUsfscJ6FA4gMHgbavwfm+x9Hf2
         ADZu0G+BVqWFRmQxh3lM+TiC4ldeupH3WG52eTdQ=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/7] ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
Date:   Wed, 23 Sep 2020 09:00:11 +0800
Message-Id: <20200923010014.148482-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923005709.147966-1-icenowy@aosc.io>
References: <20200923005709.147966-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E427E41009
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

The CSI1 controller of V3/V3s/S3/S3L SoCs is used for parallel CSI.

As we're going to add support for Pine64 SCC board, which uses 8-bit
parallel CSI (and the MCLK output), add the pinctrl node of 8-bit
CSI and MCLK to the DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 3e079973672d..19fba1a9115b 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -312,6 +312,20 @@ pio: pinctrl@1c20800 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			csi1_8bit_pins: csi1-8bit-pins {
+				pins = "PE0", "PE2", "PE3", "PE8", "PE9",
+				       "PE10", "PE11", "PE12", "PE13", "PE14",
+				       "PE15";
+				function = "csi";
+			};
+
+			/omit-if-no-ref/
+			csi1_mclk_pin: csi1-mclk-pin {
+				pins = "PE1";
+				function = "csi";
+			};
+
 			i2c0_pins: i2c0-pins {
 				pins = "PB6", "PB7";
 				function = "i2c0";
-- 
2.27.0
