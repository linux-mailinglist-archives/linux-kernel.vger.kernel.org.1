Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE5279AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgIZQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbgIZQ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373F322207;
        Sat, 26 Sep 2020 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137753;
        bh=mhZezoImVgpZRVLbJwyzaYQn4nDveKS0JgDFv9zlASU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr/GFre56cgtnBYM+xHHsdXfsxgPO+HnlF/7L+d2QogmUBoMWQ2M6GSyFsRQ8Vg5o
         otREdjkdX8N/YEqgAc9XBqwGfW4zNjr/rrQV5wrc2aQ0GEchTeG3WwBs5Ers0cgDt8
         4Laa+aIYrA1a7gmRdrJbFRDACC8okgx4yX7Wkwz0=
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
Subject: [RFC 13/14] dt-bindings: arm: fsl: document i.MX6DL Aristainetos boards
Date:   Sat, 26 Sep 2020 18:28:10 +0200
Message-Id: <20200926162811.5335-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6DL based Aristainetos
boards.

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

What's the vendor?
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 24c79cecd815..58426f83c85a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -257,6 +257,10 @@ properties:
       - description: i.MX6DL based Boards
         items:
           - enum:
+              - aristainetos,aristainetos-imx6dl-4
+              - aristainetos,aristainetos-imx6dl-7
+              - aristainetos,aristainetos2-imx6dl-4
+              - aristainetos,aristainetos2-imx6dl-7
               - boundary,imx6dl-nit6xlite     # Boundary Devices Nitrogen6 Lite
               - boundary,imx6dl-nitrogen6x    # Boundary Devices Nitrogen6x
               - bticino,imx6dl-mamoj      # BTicino i.MX6DL Mamoj
-- 
2.17.1

