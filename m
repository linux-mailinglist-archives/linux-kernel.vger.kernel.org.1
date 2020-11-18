Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E222B780B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKRIGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:06:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12009 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgKRIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:06:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb4d60a0000>; Wed, 18 Nov 2020 00:06:34 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 08:06:44 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 08:06:41 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <sharadg@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/3] dt-bindings: tegra: Add missing HDA properties
Date:   Wed, 18 Nov 2020 13:36:22 +0530
Message-ID: <1605686782-29469-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605686782-29469-1-git-send-email-spujar@nvidia.com>
References: <1605686782-29469-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605686794; bh=g6WzfzkxGm1Rrc/PS9d7uqmNnF/hATJUD1WCAcXHzoM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=ocKWrZosAEr+oXyDNz64JWNL+ytD2HGQ/LePF+SpvAkSsiW/J6h71Mk0PCW3dynV+
         0F2NPhrRYYREh/Cut9/NUBUawQD1+d8d6NV/bbU3MDgt9+c2dLUs+/Il0VviB3T5Cm
         j8dUOdNu9hN31EtsBYd1wiyEfVPikO0LdDkDxOvni+89D6ZTxrEfXV2tgYcSLh/9JI
         K5bxVlTRu+JLPK9aIihxOmBUxiOK7x2Y1Vs89AZoZ6YvVxkyVqMT9/iEDjwYun4p5E
         Kfsp3ZOYQ4inoZPRSU4VeN+v217fRJx4uI++uTzkEgYXRZWMUJw+KBtfwFYv/pULkn
         fPGGDMO/W+auQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the missing properties which are currently required for
Tegra186/Tegra194 DT files.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
index 3059bc3..e543a61 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
@@ -60,6 +60,20 @@ properties:
       - const: hda2hdmi
       - const: hda2codec_2x
 
+  power-domains:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  iommus:
+    maxItems: 1
+
   nvidia,model:
     $ref: /schemas/types.yaml#/definitions/string
     description: |
-- 
2.7.4

