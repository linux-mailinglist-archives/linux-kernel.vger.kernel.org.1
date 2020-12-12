Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850D2D8436
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 05:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438054AbgLLEFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 23:05:20 -0500
Received: from relay5.mymailcheap.com ([159.100.248.207]:33928 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407044AbgLLEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 23:04:57 -0500
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 33C0B260EB;
        Sat, 12 Dec 2020 04:04:05 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 6A9A03F1CC;
        Sat, 12 Dec 2020 05:02:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id B58642A379;
        Fri, 11 Dec 2020 23:02:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607745751;
        bh=Ex4mc7NXJhRGG+TeDdcdGf93CvUJv28QuAB1JF2sM8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOCUCLIiCJlreMW3+kthjjz/Zanv6y2We+L27XPYDEaq6EIl1MocZnYF9w+FGFP+V
         HTkXpMQ+Xt/g4CjGDiNDfyGRjX5ES/daDipXkwis4dET5V0uY2skfS+sZKjorHixl6
         zGRt4UoQ4tQYqF37KCeALOMX+TT6ZUZK2ABpyEOI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dkp42BNtIuuS; Fri, 11 Dec 2020 23:02:30 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 11 Dec 2020 23:02:30 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 7EE2442F46;
        Sat, 12 Dec 2020 04:02:29 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="eiqE8c/L";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 147EE42F46;
        Sat, 12 Dec 2020 04:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607745746; bh=Ex4mc7NXJhRGG+TeDdcdGf93CvUJv28QuAB1JF2sM8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eiqE8c/LzheGddmbuadAEFGA/KR/z5s6K5CR7qffAL5+ctXfJY8y6Mjtl+DPEXxXl
         /xs9cFxJ1WHc4TQbA3qiul6YazhmjWpfCU5Zllyr53FEe5Pv1EaviEGtu4RQm7uvDU
         FGyB9cejkKf1PEjywy4GMewvC2G1pwl8DVfoNj40=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 01/12] dt-bindings: clock: sunxi-ng: add compatible for V831/V833 CCU
Date:   Sat, 12 Dec 2020 12:01:57 +0800
Message-Id: <20201212040157.3639864-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201212040157.3639864-1-icenowy@aosc.io>
References: <20201212040157.3639864-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.2:received];
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
X-Rspamd-Queue-Id: 7EE2442F46
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V831/V833 has a CCU similar to the ones on H6/A100.

Add a compatible string for it.

As the user manual do not mention the difference between V831 and V833
in the CCU chapter, only a single compatible string for V833
(full-functional chip) is made.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 3b45344ed758..b874d887995a 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -33,6 +33,7 @@ properties:
       - allwinner,sun8i-r40-ccu
       - allwinner,sun8i-v3-ccu
       - allwinner,sun8i-v3s-ccu
+      - allwinner,sun8i-v833-ccu
       - allwinner,sun9i-a80-ccu
       - allwinner,sun50i-a64-ccu
       - allwinner,sun50i-a64-r-ccu
@@ -98,6 +99,7 @@ else:
     properties:
       compatible:
         enum:
+          - allwinner,sun8i-v833-ccu
           - allwinner,sun50i-a100-ccu
           - allwinner,sun50i-h6-ccu
 
-- 
2.28.0
