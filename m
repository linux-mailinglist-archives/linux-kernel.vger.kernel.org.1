Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A37C274E13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIWBEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:04:54 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:49528 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgIWBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:04:54 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 21:04:52 EDT
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 5EC82260EB;
        Wed, 23 Sep 2020 01:04:51 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 1B9B43F1D0;
        Wed, 23 Sep 2020 03:04:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id DE5FE2A911;
        Wed, 23 Sep 2020 03:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600823089;
        bh=aXR7xPnkb1VkCdoCMFfaRtdlFal/vO4vaqvqE/5gW/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmCScHUy/CFFrpE4DFL5EzVIuVSRu6PgeMAfpTF9XTaMvtPRRHuc+Un3pdm4+qQ3j
         k4hMfV00gS7Kr30j++46uSfYlz7HgHQ3jLpKws/A9jBITsk/pk3smaNSzY2fVRZPV1
         FurU+r651hvAzh0Dzn02rqymVXqHt2LcU1HxjR4s=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yVVm0doqsTAG; Wed, 23 Sep 2020 03:04:48 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 03:04:48 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 5CDBC41009;
        Wed, 23 Sep 2020 01:04:48 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="rYA8C40f";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id A039F41024;
        Wed, 23 Sep 2020 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822828; bh=aXR7xPnkb1VkCdoCMFfaRtdlFal/vO4vaqvqE/5gW/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYA8C40fZGTUfbjpDbHZ9RrA5pG3sudW4PiQuz2lqH0s6IUevqs7ew2gkDF5UVdNt
         fgjTh2pHDZFKeMNUBkQLks0OpgUbodm4isMvNfM8V3alNaf+T7gTvazxzpjUVSPXYc
         gkyy2PsZqplzgNrRblfnGLPKBwG+/3BVmFExqnfM=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 5/7] ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
Date:   Wed, 23 Sep 2020 09:00:12 +0800
Message-Id: <20200923010014.148482-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923010014.148482-1-icenowy@aosc.io>
References: <20200923005709.147966-1-icenowy@aosc.io>
 <20200923010014.148482-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CDBC41009
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.155:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
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

I2C1 controller is available at PE bank, usually used for
connecting an I2C-controlled camera sensor.

Add pinctrl node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 19fba1a9115b..bae8fa9e356a 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -331,6 +331,12 @@ i2c0_pins: i2c0-pins {
 				function = "i2c0";
 			};
 
+			/omit-if-no-ref/
+			i2c1_pe_pins: i2c1-pe-pins {
+				pins = "PE21", "PE22";
+				function = "i2c1";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB8", "PB9";
 				function = "uart0";
-- 
2.27.0
