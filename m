Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF691E5031
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 23:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgE0VTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 17:19:21 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:17379 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgE0VTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:19:21 -0400
X-IronPort-AV: E=Sophos;i="5.73,442,1583161200"; 
   d="scan'208";a="48177553"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 May 2020 06:19:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 257BB400C4CB;
        Thu, 28 May 2020 06:19:17 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] dt-bindings: thermal: rcar-thermal: Add device tree support for r8a7742
Date:   Wed, 27 May 2020 22:18:37 +0100
Message-Id: <1590614320-30160-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590614320-30160-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1590614320-30160-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal sensor support for r8a7742 SoC. The Renesas RZ/G1H
(r8a7742) thermal sensor module is identical to the R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-thermal".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index d2f4f1b..24d9d15 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -20,6 +20,7 @@ properties:
           - const: renesas,rcar-thermal # Generic without thermal-zone
       - items:
           - enum:
+              - renesas,thermal-r8a7742 # RZ/G1H
               - renesas,thermal-r8a7743 # RZ/G1M
               - renesas,thermal-r8a7744 # RZ/G1N
           - const: renesas,rcar-gen2-thermal # Generic thermal-zone
-- 
2.7.4

