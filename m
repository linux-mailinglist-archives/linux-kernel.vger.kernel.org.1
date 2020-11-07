Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15CB2AA514
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgKGMvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:51:11 -0500
Received: from relay4.mymailcheap.com ([137.74.80.156]:59272 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:51:11 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id D5EB93F162;
        Sat,  7 Nov 2020 13:51:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id A28CF2A7DD;
        Sat,  7 Nov 2020 13:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604753467;
        bh=wEsfMq7gpjBHqLX4MHyejD8YLRSJyH+WU2cotQHLbjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OC5hvWmWPnC2Gx1DJs3aPuLsY7aemnkRRGSAU0EpkYBcwq6IbBIFSKWg+qPPLs83x
         rujANJn5V2ijY+I7Qm9njwXtkEf1KBUFEPsxdcLC1Hy8LAaQWKKtGQkjPYYXJCrRVv
         HLNtQhsYZf57jYpVnkWcsnd1V/fX4NwwcQFmh2oc=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NifvfYretagL; Sat,  7 Nov 2020 13:51:03 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  7 Nov 2020 13:51:03 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id CF1394102D;
        Sat,  7 Nov 2020 12:51:02 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="KCwSkF2Y";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7D9D44102D;
        Sat,  7 Nov 2020 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604753455; bh=wEsfMq7gpjBHqLX4MHyejD8YLRSJyH+WU2cotQHLbjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCwSkF2YUmXRIuMrcng2jqpkSlu7Erwp7kwzu/fP1BvdJ+gLXfVNfQyCqnUm5Ye06
         8ieN+llEXGcTiANU2OCh+j+sSNGOH7EAYMtDeNrbgKf2bVug82BNvttX7zfpr0w1al
         xLBw/7ZkPTgRw92WhTsMWgfJCeWc1mvL464fzl3U=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/3] arm64: allwinner: dts: a64: pinetab: switch LCD panel to production one
Date:   Sat,  7 Nov 2020 20:50:43 +0800
Message-Id: <20201107125043.2222367-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107124958.2222253-1-icenowy@aosc.io>
References: <20201107124958.2222253-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF1394102D
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.181:received];
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
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
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

All retail PineTabs use the new panel. Devices with the old panel are
only available to several developers as sample.

Switch the main PineTab DT to use the new panel, as it should reflect
what the retail device uses. Another DT for developers' sample will be
added later.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 0494bfaf2ffa..d91a019301bf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -150,12 +150,10 @@ &dsi {
 	status = "okay";
 
 	panel@0 {
-		compatible = "feixin,k101-im2ba02";
+		compatible = "feixin,k101-im2byl02";
 		reg = <0>;
-		avdd-supply = <&reg_dc1sw>;
-		dvdd-supply = <&reg_dc1sw>;
-		cvdd-supply = <&reg_ldo_io1>;
-		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+		power-supply = <&reg_dc1sw>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
 		backlight = <&backlight>;
 	};
 };
-- 
2.28.0
