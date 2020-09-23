Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8472274E15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIWBE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:04:58 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:49529 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgIWBE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:04:57 -0400
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 492B0260EB;
        Wed, 23 Sep 2020 01:04:54 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id E1C0B3F202;
        Wed, 23 Sep 2020 01:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id C8BBE2A3CC;
        Tue, 22 Sep 2020 21:04:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600823092;
        bh=lGGQP3uOC1+o8heVDFTEK+4+dQ+oafICIec/tyjv7zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cN/L2QfKu/+OvSQ8EqG6illinIOubDLhdzsoysutIRdWkDQaFP21t/CGaqUZiqKJc
         wv6Tjpbd2NHwK6L8YNzUy4tFH/fO9TV/iRLloZ084Oq1a1qcBv6b6N8GtD974PY0l1
         OHx0KRijvv8RFZBmJH0u5Gl0pZKuizqYYmQcyCUQ=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pEQ5BAQ6zHUj; Tue, 22 Sep 2020 21:04:52 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 22 Sep 2020 21:04:51 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id A448241009;
        Wed, 23 Sep 2020 01:04:50 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="E7yJxjFH";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id A4DB841009;
        Wed, 23 Sep 2020 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822892; bh=lGGQP3uOC1+o8heVDFTEK+4+dQ+oafICIec/tyjv7zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7yJxjFHXxqqs1Xo60G0fc3N9pMkkocPvrm6ALdwUlZM4E6KVum7vbYjZwo6fHby+
         rIEFsfHv6DeWQUtKhMSdgLZGeqYoKUY0AmkDVwhr61jEsopey+OFzT4lFqgsIOtWIO
         P3Y68Dode0MukneNxGPOeY3VsJPWAG6RWL4i4AvM=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/7] ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
Date:   Wed, 23 Sep 2020 09:01:21 +0800
Message-Id: <20200923010122.148661-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923005709.147966-1-icenowy@aosc.io>
References: <20200923005709.147966-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A448241009
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
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
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
