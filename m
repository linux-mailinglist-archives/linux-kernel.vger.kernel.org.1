Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E502AA516
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgKGMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:53:08 -0500
Received: from relay4.mymailcheap.com ([137.74.80.156]:57195 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgKGMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:53:08 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 661313F162;
        Sat,  7 Nov 2020 13:53:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 338802A7DD;
        Sat,  7 Nov 2020 13:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604753585;
        bh=iDwvvSxFFwz24xKlr0qu/VJeJuNEIFWADnWs7mZO4Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HthxqxERh8sDS5J8sExzYslAhqIMYfzJArZr64siT6HyXdDoyf5ZIFgzsNPiWy3/l
         nugp1z7yCS9skKtnMVX6Yty988xGW9muY4dvLr4F1rfpw7d+BNwZJMqfNx8OPF6WIV
         nw3qcN8pwRyAXNUpUJTY5TqwNuorAnhuSgBYF8EM=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id en45KRedPDv9; Sat,  7 Nov 2020 13:53:04 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  7 Nov 2020 13:53:04 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id C15204102D;
        Sat,  7 Nov 2020 12:53:03 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="SeBAYQZE";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2198D41E45;
        Sat,  7 Nov 2020 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604753578; bh=iDwvvSxFFwz24xKlr0qu/VJeJuNEIFWADnWs7mZO4Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeBAYQZETfM82wJtWUuqV5vYmq71+lWwva/EUMkHNCh5P2bebTPxaO2+VgnXMR5s2
         Xfi2ixW+5JXXXvAcTQqtroGpco2Ajcwx1Bu4bOVq4FcX76LoXY7sUKYrKZpCbdLFSG
         8fogXP2+CSeuUHaN7lMf5yJE/WORgCS+h/Moivr4=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/3] dt-bindings: arm: sunxi: add PineTab developer sample DT binding
Date:   Sat,  7 Nov 2020 20:52:33 +0800
Message-Id: <20201107125233.2222754-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107124958.2222253-1-icenowy@aosc.io>
References: <20201107124958.2222253-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C15204102D
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
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
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

Some developer samples of PineTab are distributed with the old and
incompatible LCD panel.

Add a device tree binding for this version of PineTab.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ea07f57379d3..9cc5990dc311 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -682,6 +682,11 @@ properties:
           - const: pine64,pinetab
           - const: allwinner,sun50i-a64
 
+      - description: Pine64 PineTab (Developer sample with the old LCD panel)
+        items:
+          - const: pine64,pinetab-dev
+          - const: allwinner,sun50i-a64
+
       - description: Pine64 SoPine Baseboard
         items:
           - const: pine64,sopine-baseboard
-- 
2.28.0
