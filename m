Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019FA279AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgIZQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZQ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C954421D82;
        Sat, 26 Sep 2020 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137710;
        bh=BK6pcvKb2MbUlKXh35yQEfgvuxijh1RfnfTqY6j83PI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TRNtVZUIdVd1oR0NMBWXjz5TyUw0NNyxF38Oj+UFX9Y/erTRcMDoTaf0BZ/8URfjh
         pTsGh2KCasTCIF3vBGRMKEVQYmdJTxRriykyHM2DT3H+pgg1bVq/oGBflXTsGN7ELW
         lm/90Xyesj1117e8FzoImmFsF1WkDpMe1nEGmTYk=
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
Subject: [PATCH 03/14] dt-bindings: vendor-prefixes: add Embest RIoT
Date:   Sat, 26 Sep 2020 18:28:00 +0200
Message-Id: <20200926162811.5335-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document vendor prefix for Embest RIoT.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9151804f9940..f24400bbaa29 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -898,6 +898,8 @@ patternProperties:
     description: Rikomagic Tech Corp. Ltd
   "^riscv,.*":
     description: RISC-V Foundation
+  "^riot,.*":
+    description: Embest RIoT
   "^rockchip,.*":
     description: Fuzhou Rockchip Electronics Co., Ltd
   "^rocktech,.*":
-- 
2.17.1

