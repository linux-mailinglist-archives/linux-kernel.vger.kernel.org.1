Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166FD2BA1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgKTFJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:09:50 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:33876 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKTFJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:09:50 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id A373E20DE7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:09:48 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 73B24200FE;
        Fri, 20 Nov 2020 05:09:43 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id E93F83F162;
        Fri, 20 Nov 2020 06:09:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 289BA2A36E;
        Fri, 20 Nov 2020 00:09:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1605848980;
        bh=MsialF+u0+K+ZGHU7SkICmCMtRbv1QivHAJHfqNPIPw=;
        h=From:To:Cc:Subject:Date:From;
        b=VPPi0mk4XrQj512L8C9sLp8ruCRwJzRvK2W5F0vj+srhK9jKyfbP7b1Ybk6jzNuX5
         s3VN82Y5YUeUQUQWWHjQoY7zsDM/U5E/CcIN+14W0kPiKOefL99rhH0IB5mvTn4iwN
         jRsE9b8OxTzlVV0r/3Qi0Q8drPM7VB/HT5/voWsI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8AIfHbbZIg6i; Fri, 20 Nov 2020 00:09:37 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 20 Nov 2020 00:09:37 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id AE27F41FA3;
        Fri, 20 Nov 2020 05:09:34 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="VHaIfSyr";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5F76A41EA4;
        Fri, 20 Nov 2020 05:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1605848968; bh=MsialF+u0+K+ZGHU7SkICmCMtRbv1QivHAJHfqNPIPw=;
        h=From:To:Cc:Subject:Date:From;
        b=VHaIfSyrWUDrOBRc2SHn3kMi4NAyyP8Xvq/RVBW+fQMb4P3b25mri9oEHDGG7/kKX
         w27ujmAbrf/cwItjXRmXb7PG3OmEGJDSW6UzVKWuX65JqserT0AbjACIhwC5VdDUAn
         heVuQFohfDmyQdpZHtjUrtNqnsurC3wKgH3EQGcA=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] ARM: dts: sun8i: v3s: fix GIC node memory range
Date:   Fri, 20 Nov 2020 13:08:51 +0800
Message-Id: <20201120050851.4123759-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE27F41FA3
X-Spamd-Result: default: False [4.90 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.107:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the GIC node in V3s DTSI follows some old DT examples, and
being broken. This leads a warning at boot.

Fix this.

Fixes: f989086ccbc6 ("ARM: dts: sunxi: add dtsi file for V3s SoC")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 7b2d684aeb97..f8f19d8fa795 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -545,7 +545,7 @@ csi1: camera@1cb4000 {
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
-- 
2.28.0
