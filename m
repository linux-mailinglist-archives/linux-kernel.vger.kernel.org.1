Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E82B26D436
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIQHGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgIQHFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:05:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB4D206E6;
        Thu, 17 Sep 2020 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600326351;
        bh=hX1In47qa8OCVR1/+Z+2iH6fj4+wNmfyDrAD9kegMnE=;
        h=From:To:Subject:Date:From;
        b=OGgk4kTNPctyksWF5avH2T7CgRRwqlo/9o4AcrznGvgvFy5vrDnKIlNSHNQ0pTiAR
         4pf0C8cEly7QqSgEleySU4IVb+7mwXPPDBTaMmqy1yc8lBGlh3a7DTe+bxuMCMsD2a
         FE/jMduluk8vasCcRVo2oWRbEI6BjXBc0L4ixnGA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: ti: ti,pruss: fix schema ID
Date:   Thu, 17 Sep 2020 09:05:43 +0200
Message-Id: <20200917070543.19064-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing '#' to fix schema errors:

  $id: 'http://devicetree.org/schemas/soc/ti/ti,pruss.yaml' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
  $schema: 'http://devicetree.org/meta-schemas/core.yaml' is not one of ['http://devicetree.org/meta-schemas/core.yaml#', 'http://devicetree.org/meta-schemas/base.yaml#']
  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml: ignoring, error in schema: $id

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index cf7dc83f724f..037c51b2f972 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml
-$schema: http://devicetree.org/meta-schemas/core.yaml
+$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: |+
   TI Programmable Real-Time Unit and Industrial Communication Subsystem
-- 
2.17.1

