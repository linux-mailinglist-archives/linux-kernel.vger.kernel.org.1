Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D972E23C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgLXCne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:43:34 -0500
Received: from relay1.mymailcheap.com ([144.217.248.102]:60795 "EHLO
        relay1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgLXCne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:43:34 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id C98803F202;
        Thu, 24 Dec 2020 02:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 19CE32A510;
        Thu, 24 Dec 2020 03:42:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1608777721;
        bh=xSmYZX90IiqaVb/YrLKw7Zd6GtMUdDIgncu6PF73Ff0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkjNr46K253DjV0kh5BYS8tQ6nE/VzV8RvGE2XhDxHKQplOgLTXLg4PyS39kd1oim
         sT399Ozgey3YpqPd9GNKpxJFWJoxZgEp7I8EORWtMKtVa+0tj+ATXm4kBBGItbohKp
         /x4MjSgj7QUdxnNaJk2ZCG0wR7L6SKELuMWXY3X0=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 90_s9ByOmeDK; Thu, 24 Dec 2020 03:41:59 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 24 Dec 2020 03:41:59 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 9042C422D4;
        Thu, 24 Dec 2020 02:41:59 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="HE8qwedi";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id E25A5422D4;
        Thu, 24 Dec 2020 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1608777710; bh=xSmYZX90IiqaVb/YrLKw7Zd6GtMUdDIgncu6PF73Ff0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HE8qwedi7WNTgN/1QpvOmnK38SRblC2/U1Dmquez6NAypceBt6k0bqNCchecA/Gu1
         R2fmQXptk+1gPsc9TnY/SrWE5LR13qxoH8rLxqtliAVLorfl0fnvZJZOcrw+kVMaUh
         T8Yxg1pm3fw84PkNHbpMFxp0W31fKW76CFRCIl+w=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 3/3] dt-bindings: arm: sunxi: document orig PineTab DT as sample
Date:   Thu, 24 Dec 2020 10:41:38 +0800
Message-Id: <20201224024138.19422-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201224024001.19248-1-icenowy@aosc.io>
References: <20201224024001.19248-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.103:received];
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
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: 9042C422D4
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the original PineTab DT (which uses sun50i-a64-pinetab name) is only
for development samples, document this.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 8c62a1e2a498..7eec85be7ab9 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -695,7 +695,7 @@ properties:
           - const: pine64,pinephone-1.2
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineTab
+      - description: Pine64 PineTab, Development Sample
         items:
           - const: pine64,pinetab
           - const: allwinner,sun50i-a64
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 0494bfaf2ffa..422a8507f674 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -14,7 +14,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "PineTab";
+	model = "PineTab, Development Sample";
 	compatible = "pine64,pinetab", "allwinner,sun50i-a64";
 
 	aliases {
-- 
2.28.0
