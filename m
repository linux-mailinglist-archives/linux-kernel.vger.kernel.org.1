Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC032AB2F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgKIIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:55:24 -0500
Received: from smtp2.axis.com ([195.60.68.18]:18086 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgKIIzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=994; q=dns/txt; s=axis-central1;
  t=1604912124; x=1636448124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QcYApQx6ATgZboadRHxRu9XHv0LjQTcBhXEqmxSLo+s=;
  b=gjgkAZ1B6Zcn/6si4IuLSMlcrjAZlf8osOkJUSFGTIvYVOy9R3Dlp8j8
   33GN75zO65R6+YRyQgu7/aeGHkskzc2Mh0aAw7LGE85Us8nb+5vgKFita
   WhSqlU6zctTF6/crGcq0R3oHlhGK4/tm9J1c1msMWhOZ0dGDZoCwsD+tu
   ZMX42/qnUoM1FxR3aXUqXMVB/rPda5Uj/ky9opcfpKhrHgIoNqRWTcPwa
   5l68tGfgzU2n+aA1qzGugaJ46IqHat5sr8sxskU9Vq66AgvAm225OmD4f
   yv1GyFx/vTabPwevQFMvKg7E3MfB1rwasWjbQwCC+Vx3H+WJVPngpJlBF
   Q==;
IronPort-SDR: gARHYXx/Vram6xKKFA2LQm60HbM/Nl0uAyabJrDT8TE00q6Mtrlz20vKL32ue3RfBjKh5HnRfp
 BmGrdKimY8JxX+zpoDdyEspFOluxEABMWuDtjSUsdaYU1g7Cyxq7nB551M1lzB9livFxi12qJG
 B6WXT6KYOaZkDxc+SiZeLdmsOupxmwpxzPGb3WuFlpFlo4bJY/eK2gi4jtR4sAUduJgMnmAEUF
 TbwPjng57GFrSsm5KEHhQN6FfaCva5MgbLW+h7/WpMbv8lM9mbQwH+d/T0elukDnJcCE3oIQAX
 44c=
X-IronPort-AV: E=Sophos;i="5.77,463,1596492000"; 
   d="scan'208";a="14332588"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: regulator: da9121: Use additionalProperties
Date:   Mon, 9 Nov 2020 09:54:37 +0100
Message-ID: <20201109085438.16230-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no $ref at the top level so use additionalProperties instead of
unevaluatedProperties.

This fixes the following warning with the latest dtschema:

 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml:
 'additionalProperties' is a required property

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index cde0d82dd201..2ece46ee1a59 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -22,7 +22,7 @@ properties:
     $ref: "regulator.yaml#"
     type: object
 
-unevaluatedProperties: false
+additionalProperties: false
 
 required:
   - compatible
-- 
2.28.0

