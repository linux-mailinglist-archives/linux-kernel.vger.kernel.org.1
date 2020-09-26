Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96D1279AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgIZQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgIZQ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:10 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3212177B;
        Sat, 26 Sep 2020 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137749;
        bh=+pGiHI+gmRb0sgk/hD3VqHj4NWdhOtq7RZiG2kmpYsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsG04BXWf3tpOZAzs+6hub+impcY/qOuRdjQlU3yBIF2Ok51f3siG9j7laff/lVcG
         KZWsGJltx09s8C0LSvAjq34mql/aUkvhuLv+miYKOLGj9zhCVo2PfrFNkFckI52t/d
         Yz2FZmAd9TAIx1DFsOS+bKNl1QoPkJiPpa6S3ixM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>
Subject: [RFC 12/14] dt-bindings: vendor-prefixes: add Aristainetos
Date:   Sat, 26 Sep 2020 18:28:09 +0200
Message-Id: <20200926162811.5335-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document binding for an unknown entity Aristainetos with few boards
mainlined.

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

I tried to Google but except the patches from Heiko Schocher, I could
not find any meaningful data.

Heiko, you posted this. Do you know what is it?
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 789a01b3d93a..bb4c85f00c8f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -105,6 +105,8 @@ patternProperties:
     description: arcx Inc. / Archronix Inc.
   "^aries,.*":
     description: Aries Embedded GmbH
+  "^aristainetos,.*":
+    description: Aristainetos
   "^arm,.*":
     description: ARM Ltd.
   "^armadeus,.*":
-- 
2.17.1

