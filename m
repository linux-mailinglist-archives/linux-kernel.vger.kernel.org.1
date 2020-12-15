Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC46B2DADEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLONVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgLONVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:21:30 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Adrien Grassein <adrien.grassein@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: pf8x00: Use specific compatible strings for devices
Date:   Tue, 15 Dec 2020 13:20:24 +0000
Message-Id: <20201215132024.13356-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=iFPmsa3+jnoQAinLCLIyJYrJYVQ0K71zonFwtGd5EuE=; m=wb+pZI7xM+FR+JNfGwZpv0zbVDoPhtbL9e93YelLGuA=; p=HciRgTybYC14UMhoVbWDEyRjUGLc8P1po22O0WJcF7s=; g=2d9d2c6a6c375e43d76a5a3ddf0571f7565bdeba
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/YtwwACgkQJNaLcl1Uh9BuBQgAgEu 02tONuxW1LaE6GX9LyGK1zX/sFsJQFtoUvFyeppPnwEs/Ie/wcowd1XD8bJ/GtdeWY40TrLyA6b6w 7XvwEFkNheIXFWykhTjkfyOiL/XaQgmHh+I9CxmkV0RFCfLcAf28RIELTmWyxAjQMxIcSrzgA4zx3 UnUlXHB78i0a2XTAxs0zeXVGeNsUtbzrQxsQ+HBRXSv1NGpT16fM22MsPWlJQeR/yKNd/t5+XFKmp 6+fT4QKNMJyQ2f5udfQjLR7D+NMjuxHZQQQzL8Mvlzqh+AKFXu13x9+KftI6pqA8DC1l7tkTgeBWR fXISfx62GumcMBTLWRVUT6f91vAFVFw==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pf8x00 driver supports three devices, the DT compatible strings
and I2C IDs should enumerate these specifically rather than using a
wildcard so that we don't collide with anything incompatible in the
same ID range in the future and so that we can handle any software
visible differences between the variants we find.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/nxp,pf8x00-regulator.yaml          | 6 ++++--
 drivers/regulator/pf8x00-regulator.c                      | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index a6c259ce9785..956156fe52a3 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -19,7 +19,9 @@ description: |
 properties:
   compatible:
     enum:
-      - nxp,pf8x00
+      - nxp,pf8100
+      - nxp,pf8121a
+      - nxp,pf8200
 
   reg:
     maxItems: 1
@@ -118,7 +120,7 @@ examples:
         #size-cells = <0>;
 
         pmic@8 {
-            compatible = "nxp,pf8x00";
+            compatible = "nxp,pf8100";
             reg = <0x08>;
 
             regulators {
diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 308c27fa6ea8..af9918cd27aa 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -469,13 +469,17 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id pf8x00_dt_ids[] = {
-	{ .compatible = "nxp,pf8x00",},
+	{ .compatible = "nxp,pf8100",},
+	{ .compatible = "nxp,pf8121a",},
+	{ .compatible = "nxp,pf8200",},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pf8x00_dt_ids);
 
 static const struct i2c_device_id pf8x00_i2c_id[] = {
-	{ "pf8x00", 0 },
+	{ "pf8100", 0 },
+	{ "pf8121a", 0 },
+	{ "pf8200", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, pf8x00_i2c_id);
-- 
2.20.1

