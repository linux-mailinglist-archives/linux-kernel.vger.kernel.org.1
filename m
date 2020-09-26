Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39F279ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgIZQ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbgIZQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:39 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DE42177B;
        Sat, 26 Sep 2020 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137718;
        bh=VhHrgQP4YBxQWSmABYBOWMjYNjyMQ4UGl8VaLw/NU5E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rU+ZMeX7PAptfi2TUgxrrv6lfW6r46DnpiYgWQdXq7ch91RiQ1TgsAGTxjhXkb4rK
         08rjWmptxpvc0ryFN8g1sVm5HDgup1JdI3yu9z99p2GJ9bZ8lhoCXJ+rFcmkcx4P9C
         zGi3OnBI27iRNPXIWc8RP7i5v1juOUlawo2yW5Yk=
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
Subject: [PATCH 05/14] dt-bindings: vendor-prefixes: add Zealz
Date:   Sat, 26 Sep 2020 18:28:02 +0200
Message-Id: <20200926162811.5335-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document vendor prefix for Zealz.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f0bce3c17db9..789a01b3d93a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1210,6 +1210,8 @@ patternProperties:
     description: Yones Toptech Co., Ltd.
   "^ysoft,.*":
     description: Y Soft Corporation a.s.
+  "^zealz,.*":
+    description: Zealz
   "^zarlink,.*":
     description: Zarlink Semiconductor
   "^zeitec,.*":
-- 
2.17.1

