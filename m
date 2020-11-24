Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981172C3449
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgKXXAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:00:10 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:57155 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgKXXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:00:09 -0500
X-Greylist: delayed 121743 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 18:00:07 EST
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id D9CE72008F;
        Tue, 24 Nov 2020 23:00:05 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 06A1A3F1C5;
        Tue, 24 Nov 2020 23:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 4CE992A522;
        Wed, 25 Nov 2020 00:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606258801;
        bh=iOyQ89pPddtKPEHY+rw1M3ypa8TpeYx6ftwm76ODn8k=;
        h=From:To:Cc:Subject:Date:From;
        b=DEHSjyJI4/zbJ2r6WLAmm26cvXczFgFmLd+NsOqL4mGFQ0V130sP5h/JEaO0pgh2M
         WLCPux9xqgddcwDpBQIS+DSpmlPsP0xzOUeaJ4Gc+go/bcAAMBYROvWVZqpfoxEfNk
         eD3Aa9Tsf3UStIIzjaFqKTYweH0lcW5zvyu/0ITI=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rlbUiSNneNyf; Wed, 25 Nov 2020 00:00:00 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 24 Nov 2020 23:59:59 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 896BA40FF4;
        Tue, 24 Nov 2020 22:59:57 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="XKlFf575";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 33EB340FF4;
        Tue, 24 Nov 2020 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606258791; bh=iOyQ89pPddtKPEHY+rw1M3ypa8TpeYx6ftwm76ODn8k=;
        h=From:To:Cc:Subject:Date:From;
        b=XKlFf575BpCxn4fiNV3tTMULwOVza3jgFsMHO8HfI2L8MQ5ITG0MR1o70PgWox2lo
         Sgu7hhnr2yjjZzCxwohQfCdPZ5JNPlRvybcEyDNF3AS+rW0qozwkt3WtCC8NjzafHN
         XuMOsHxDcpXd6514lSyuzPzDSwjxvIjE0tZ/sgEM=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] ARM: dts: sun8i: s3: pinecube: add ethernet alias for Wi-Fi
Date:   Wed, 25 Nov 2020 06:59:40 +0800
Message-Id: <20201124225940.3750388-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 896BA40FF4
X-Spamd-Result: default: False [4.90 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.143:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.1:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PineCube board has a RTL8189ES Wi-Fi module on board, and the module
doesn't have any MAC address programmed in.

Add a ethernet alias in the DT, thus the bootloader will then be able to
generate a MAC address into the device tree node of Wi-Fi.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-s3-pinecube.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
index 4aa0ee897a0a..5086f713467a 100644
--- a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
+++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
@@ -13,6 +13,7 @@ / {
 	compatible = "pine64,pinecube", "sochip,s3", "allwinner,sun8i-v3";
 
 	aliases {
+		ethernet0 = &rtl8189es;
 		serial0 = &uart2;
 	};
 
@@ -156,6 +157,10 @@ &mmc1 {
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
+
+	rtl8189es: wifi@1 {
+		reg = <1>;
+	};
 };
 
 &pio {
-- 
2.28.0
