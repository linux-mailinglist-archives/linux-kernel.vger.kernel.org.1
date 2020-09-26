Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058F3279AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgIZQ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZQ20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FD821D95;
        Sat, 26 Sep 2020 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137706;
        bh=NWgaVvTlf0oElDxMo3vhSmDwE4f+dup147Lus7fxjyA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tWnbZZIvaV81Wq43WlgHc6Gz2k3aYDQebfX2zEHrkVpT9vpazBuMK0r0Ksdki9LOk
         yV3S6yGRKvwOrejuYYFMlfMJjI7B3nUZQibjDC9dJD/oHQlfdN5FKUkso/pbgvu8dH
         t0uWMKU9mjq+Qt5JWralOmsvts8IMuwvx7ijvJlY=
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
Subject: [PATCH 02/14] dt-bindings: vendor-prefixes: add iMX6 Rex Project
Date:   Sat, 26 Sep 2020 18:27:59 +0200
Message-Id: <20200926162811.5335-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document vendor prefix for iMX6 Rex Project.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6c796956d246..9151804f9940 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -886,6 +886,8 @@ patternProperties:
     description: Realtek Semiconductor Corp.
   "^renesas,.*":
     description: Renesas Electronics Corporation
+  "^rex,.*":
+    description: iMX6 Rex Project
   "^rervision,.*":
     description: Shenzhen Rervision Technology Co., Ltd.
   "^richtek,.*":
-- 
2.17.1

