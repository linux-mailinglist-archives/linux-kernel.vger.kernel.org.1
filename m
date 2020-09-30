Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012C527F241
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgI3TCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbgI3TCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED312145D;
        Wed, 30 Sep 2020 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492550;
        bh=/OqLRI39AWdnlp/sqKWeFIkEMwhjrtz1XkjBvyFj6EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbk8yUk1AjPYLQMIVUaznl5TAqrv7G6C7OILNUun0YmGozyxNkxDbCPSK3PLCfqgZ
         oJ2hdN5N58ELxXNchPaylYFmol7s88xb2mbFM2tR72tOe+Kgb2xSuPv93Xnp5h9GhS
         iRkl3y3nmDE05Fqt0OjjDgV8fIdXoTyuLAlXkUXM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 10/12] dt-bindings: arm: fsl: document i.MX6DL Aristainetos boards
Date:   Wed, 30 Sep 2020 21:01:41 +0200
Message-Id: <20200930190143.27032-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6DL based Aristainetos
boards from ABB.

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use ABB vendor prefix
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c90050ca3384..fc3a837d7dba 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -269,6 +269,10 @@ properties:
       - description: i.MX6DL based Boards
         items:
           - enum:
+              - abb,aristainetos-imx6dl-4     # aristainetos i.MX6 Dual Lite Board 4
+              - abb,aristainetos-imx6dl-7     # aristainetos i.MX6 Dual Lite Board 7
+              - abb,aristainetos2-imx6dl-4    # aristainetos2 i.MX6 Dual Lite Board 4
+              - abb,aristainetos2-imx6dl-7    # aristainetos2 i.MX6 Dual Lite Board 7
               - boundary,imx6dl-nit6xlite     # Boundary Devices Nitrogen6 Lite
               - boundary,imx6dl-nitrogen6x    # Boundary Devices Nitrogen6x
               - bticino,imx6dl-mamoj      # BTicino i.MX6DL Mamoj
-- 
2.17.1

