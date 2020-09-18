Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5591726FB81
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRLdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:33:42 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17964 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgIRLcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:32:24 -0400
IronPort-SDR: b+W/WrFqp7ve4K4wz9I+Fw/+u1DLYKSkZPjPuvmhVtiRMN6nsiTfqjR2b/4D0PrvS/7D0w5Yy1
 2byppK59KlypwySB/mX4KnFNd23fzYCzFjZG990ogzRkubZtveJqDbo4hiGrNuiJwqg2MAkguC
 mlai5YCocW94lZ0BbQQhNpsY5frUJkOltH071jCacU/7gWGSW5R45EHHxCxvpt3yY8uAGdSX7k
 iwg6lX9ux8sl+Zz/l4uiCHUPr/7/1kJaRabj+IIbLwCt1gPhSlfvd3RqvW7WmxpzWvyDC6ICzp
 L+Q=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924474"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428672; x=1631964672;
  h=from:to:cc:subject:date:message-id;
  bh=kzBvPTa5wdFPMJv9xAl4y+bUetkzoTy0Y/gA21N/CFo=;
  b=ofLgLi3v0eLwJBqiF+ldRnyM9xNN1AABWuWWlpjfwQZDKNj4u3feELwE
   A5OytOeTKeJXvhJFdSQ6Kf5M63P2i7XpLwmy0bodDkwcKs8ezm0PON6Jc
   3cXLgXj7tWiXk28tyaIHBUJ1dcnC2tU/Z9DNcnLrAMConKmx5f8P7+X7l
   DeQXll4FZG3To/3LMT3QrVNk+BjKza8vNR17D/gTEEji6sHtT7eGxiXB+
   9AbZrid/dwQDJL6OalAUkaM9kUVCk6dlTrU5A0krK0mRgdbVEfkHLT0TZ
   +WGubeRk6PEBS1qri7keXpEv4npfY3+/rKTqU19XPEBIiGYZFAJ1jkKaE
   g==;
IronPort-SDR: PexZoztd2UMGCg930XXEMbl3EoSuTL7MpKKgz0rXmsxHksi6hFhYfqp44446L/hDwwtYm/a+Ez
 RQp6liso0J2iivxTwreraAu5r2MhtirlKqvtvFZm8kb4CZchU5F3lnZw5Etw4Oy+5/2nfs71Xr
 pVaAoa0KBCvJ3lqBnRCMvYSgtrP+51ObcmxT3KbBPWQWd3rCkoBE01OSQjiWBb5RS3pjiE892K
 TiN7aB3rKpM4bRH1gfP8o/1WnL0zQlwhERFThz4h9tRWCXpIxggT2Zt5Q6Wfns0MqXRYlFnzZf
 SZg=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924473"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E50B5280070;
        Fri, 18 Sep 2020 13:31:11 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 01/13] dt-bindings: arm: fsl: update TQ-Systems SoMs and boards based on i.MX7
Date:   Fri, 18 Sep 2020 13:29:30 +0200
Message-Id: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible strings for the TQMa7x SoMs.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 71acf14da715..d7233cef4d38 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -298,7 +298,12 @@ properties:
               - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
               - toradex,colibri-imx7s-aster     # Colibri iMX7 Solo Module on Aster Carrier Board
               - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on Colibri Evaluation Board V3
-              - tq,imx7s-mba7             # i.MX7S TQ MBa7 with TQMa7S SoM
+          - const: fsl,imx7s
+
+      - description: TQ-Systems TQMa7S SoM on MBa7x board
+        items:
+          - const: tq,imx7s-mba7
+          - const: tq,imx7s-tqma7
           - const: fsl,imx7s
 
       - description: i.MX7D based Boards
@@ -320,11 +325,16 @@ properties:
                                                         #  Colibri Evaluation Board V3
               - toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dual Module on
                                                         #  Colibri Evaluation Board V3
-              - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
 
+      - description: TQ-Systems TQMa7D SoM on MBa7x board
+        items:
+          - const: tq,imx7d-mba7
+          - const: tq,imx7d-tqma7
+          - const: fsl,imx7d
+
       - description:
           Compulab SBC-iMX7 is a single board computer based on the
           Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with
-- 
2.17.1

