Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D57282772
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgJCXuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 19:50:51 -0400
Received: from relay4.mymailcheap.com ([137.74.80.156]:57445 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgJCXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 19:50:50 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id D24233F162;
        Sun,  4 Oct 2020 01:50:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id A37D62A504;
        Sun,  4 Oct 2020 01:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1601769046;
        bh=3YwFZIS3mnB8xY7diOQnQ/GCzDriA8oEcakySXi/SqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF+DiIoQzZOrBx8sBS8S2qRr5DAf0iijq+6Emt5xuv1YNw/Bsrawq4bBaY7P1YPhh
         z1JLdaRq0NGQPa13iX460ZXNM/wFPWFq8vnxRUZXg8H23f+kLJTfKdT+1Zp/cvKua5
         h9A7PblKTq44boSP5SG3Pv3l5HbXhztRZqvTfVA8=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YBCXljkEncsj; Sun,  4 Oct 2020 01:50:45 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sun,  4 Oct 2020 01:50:45 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 4FE7340BFB;
        Sat,  3 Oct 2020 23:50:45 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="Jb66lCVn";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 10C2840E55;
        Sat,  3 Oct 2020 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1601769037; bh=3YwFZIS3mnB8xY7diOQnQ/GCzDriA8oEcakySXi/SqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jb66lCVnokk5ZKHUnOLMg9yHIYfwAB7GgetBFdFEvHhJHWyLys+TXmjLWxBeG5h7H
         XqaWNMcXLjGZA3C/1hGy1vOJ2P6bWo+xHXVec4arWihNb5sh+EJT1ByAy5EWzn/BYS
         v6mfNYiWZvRfrrHvkvktrtFLz4hCmNB1ZqENomkg=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] dt-bindings: sram: sunxi-sram: add V3s compatible string
Date:   Sun,  4 Oct 2020 07:50:18 +0800
Message-Id: <20201003235018.1121618-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201003234842.1121077-1-icenowy@aosc.io>
References: <20201003234842.1121077-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4FE7340BFB
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         FREEMAIL_TO(0.00)[kernel.org,csie.org,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
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
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for V3s, with H3 one as fallback.

This is used in device tree now, but not standardized in DT binding.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../bindings/sram/allwinner,sun4i-a10-system-control.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 6ebcbc153691..b66a07e21d1e 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -33,6 +33,9 @@ properties:
           - const: allwinner,sun4i-a10-system-control
       - const: allwinner,sun8i-a23-system-control
       - const: allwinner,sun8i-h3-system-control
+      - items:
+          - const: allwinner,sun8i-v3s-system-control
+          - const: allwinner,sun8i-h3-system-control
       - items:
           - const: allwinner,sun8i-r40-system-control
           - const: allwinner,sun4i-a10-system-control
-- 
2.28.0
