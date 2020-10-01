Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E52804A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbgJARIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:08:47 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6BC20897;
        Thu,  1 Oct 2020 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572127;
        bh=5ZDv0UnXZcemm1YB+gC6TKHuek1DzGgI0+04vfAgkZ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=y7xrcPppRdq8SbYRkcXVNeHt5rM2FN9gogUVQVpC9NVZNSNMQ/jJ0MjF1pADHV88X
         pl4qRlyVMLPgAJXX1sDA8jNfmJ8EgFAFN4PtTtkyICc8fSICzpDQVeEFBWlOB99fUZ
         c5o3XU/WWdXjnXqZnru3Jomaw7+pcVcfbndhf9/4=
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
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/12] dt-bindings: arm: fsl: document i.MX6SX boards
Date:   Thu,  1 Oct 2020 19:07:52 +0200
Message-Id: <20201001170759.9592-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6SX based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7d0f2b7e7b00..7120e3a34339 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -466,9 +466,14 @@ properties:
       - description: i.MX6SX based Boards
         items:
           - enum:
+              - boundary,imx6sx-nitrogen6sx
               - fsl,imx6sx-sabreauto      # i.MX6 SoloX Sabre Auto Board
               - fsl,imx6sx-sdb            # i.MX6 SoloX SDB Board
               - fsl,imx6sx-sdb-reva       # i.MX6 SoloX SDB Rev-A Board
+              - samtec,imx6sx-vining-2000 # Softing VIN|ING 2000 Board
+              - udoo,neobasic             # UDOO Neo Basic Board
+              - udoo,neoextended          # UDOO Neo Extended
+              - udoo,neofull              # UDOO Neo Full
           - const: fsl,imx6sx
 
       - description: i.MX6UL based Boards
-- 
2.17.1

