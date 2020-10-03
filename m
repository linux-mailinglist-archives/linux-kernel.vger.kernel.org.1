Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19864282771
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 01:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgJCXuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 19:50:44 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:39878 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgJCXuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 19:50:44 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id D312E20E29;
        Sat,  3 Oct 2020 23:50:42 +0000 (UTC)
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id AF8702008F;
        Sat,  3 Oct 2020 23:50:40 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 2654E3ECDA;
        Sun,  4 Oct 2020 01:50:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 53B902A0F9;
        Sat,  3 Oct 2020 19:50:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1601769037;
        bh=1IJWP01IvxyCjjVX7o1zAY7YDWjMm7Oas7z1QglSFiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L20oDh3Dkm5Elorz6RuHOEXlqIuTIM9u6mDsYkweDhWkX+QiA3VX3kh6GfvVrKLW+
         J5ZR9EYNiLJ6RU7Asqwph30fHOS5Rm2P5i22bm5oPJCUCzIV7Qeil+ccLJPNpJuBqg
         FKWCX/EI+b//tUWiX4uc8sc5Jhkw1xiUQHAv53QI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F7x0fWTMjvBh; Sat,  3 Oct 2020 19:50:36 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  3 Oct 2020 19:50:36 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 4E44840FC3;
        Sat,  3 Oct 2020 23:50:35 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="faTVnbf3";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2A84740BFB;
        Sat,  3 Oct 2020 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1601769033; bh=1IJWP01IvxyCjjVX7o1zAY7YDWjMm7Oas7z1QglSFiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faTVnbf3IUSfLPSl2PEya3Ci19gQrmPgSPVUeGmNHFJGs7jT/ladU4jfMw7E0qLs+
         I6l4SuLUmLshvLyKzmzxYt7le/D61KXagKZ5Q+ukQyhcUq7S6SDUW0hfH3pXPq0oSn
         bxiKwCeD8THxyQsyFbbDReXdbxovDWmojvhY7YjY=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/2] ARM: dts: sun8i: s3: drop bogus cells for CSI subnode on PineCube
Date:   Sun,  4 Oct 2020 07:50:17 +0800
Message-Id: <20201003235018.1121618-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201003234842.1121077-1-icenowy@aosc.io>
References: <20201003234842.1121077-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E44840FC3
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         FREEMAIL_TO(0.00)[kernel.org,csie.org,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.122:received];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         MID_CONTAINS_FROM(1.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address and size cells infomation in CSI subnode is not necessary
(because the camera subnode has no reg property).

Drop them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-s3-pinecube.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
index 9bab6b7f4014..76c8a29e355b 100644
--- a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
+++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
@@ -64,9 +64,6 @@ &csi1 {
 	status = "okay";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		csi1_ep: endpoint {
 			remote-endpoint = <&ov5640_ep>;
 			bus-width = <8>;
-- 
2.28.0
