Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3279E2D55A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbgLJIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:48:03 -0500
Received: from relay1.mymailcheap.com ([144.217.248.102]:34138 "EHLO
        relay1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLJIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:48:01 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 76EC03F202;
        Thu, 10 Dec 2020 08:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 4968A2A3E6;
        Thu, 10 Dec 2020 03:46:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607589989;
        bh=X/nTSkbPqr6vKKgXzf57nKcH+Yn+Q4agIeaKKW0GQjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJkfI0pTwtPfuJFZkS62SKZy0JFeDhtOuZG0kwpFCcIaMoT/2BIAKzrv9CF3/Ljjf
         QDg98BTCIQ3312NkUbfpzFmak3JocPajrvWfFdbkFzmbe8fXpvEeBSmNmQoeLXjp5S
         RIUCB4H6QEHqrRR8Kr2uq7ZbUOkE1fqDLbj0TqEo=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K2GE1c3fruPh; Thu, 10 Dec 2020 03:46:28 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 10 Dec 2020 03:46:28 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 745C540AA1;
        Thu, 10 Dec 2020 08:46:27 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="KwM5uJ14";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id D0C65411A2;
        Thu, 10 Dec 2020 08:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607589970; bh=X/nTSkbPqr6vKKgXzf57nKcH+Yn+Q4agIeaKKW0GQjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwM5uJ14OYNYAGcL73+2ukR/ddj6o5wFgtaoQcxTJAWFmhLGdviyYpGYNEg7HCpAz
         2tCq1E8FUF4QECx7JGRvIRv/dauF5DgFa62YzMGd7VxwPomkCS0FHpqOZtWfnLOJIB
         9kokITd4g+kAqW1jlY1JoQXUcb+xW2Xa2dePRAHI=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] dt-bindings: arm: sunxi: note that old PineTab compatible has old panel
Date:   Thu, 10 Dec 2020 16:45:58 +0800
Message-Id: <20201210084558.1917246-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210083722.1912981-1-icenowy@aosc.io>
References: <20201210083722.1912981-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.121:received];
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
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: 745C540AA1
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the old LCD panel used by PineTab developer samples are discontinued,
there won't be furtherly any more units of the sample, and this should
be noted in the document.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 73a6c8421172..9f29b5811aa1 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -695,7 +695,7 @@ properties:
           - const: pine64,pinephone-1.2
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineTab
+      - description: Pine64 PineTab (developers' sample with old discontinued LCD panel, discontinued)
         items:
           - const: pine64,pinetab
           - const: allwinner,sun50i-a64
-- 
2.28.0
