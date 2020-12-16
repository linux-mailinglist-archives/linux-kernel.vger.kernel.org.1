Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C182DC415
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLPQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLPQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:26:21 -0500
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C32C061794;
        Wed, 16 Dec 2020 08:25:41 -0800 (PST)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id D5592103ADC; Wed, 16 Dec 2020 17:25:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:79:5902:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 33DBB103AD4;
        Wed, 16 Dec 2020 17:25:38 +0100 (CET)
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     kernel@pengutronix.de,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Webasto SE
Date:   Wed, 16 Dec 2020 17:25:34 +0100
Message-Id: <20201216162535.9452-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "webasto" entry for Webasto SE: https://www.webasto.com

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..623c6002c622 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1168,6 +1168,8 @@ patternProperties:
     description: Western Digital Corp.
   "^we,.*":
     description: Würth Elektronik GmbH.
+  "^webasto,.*":
+    description: Webasto SE
   "^wetek,.*":
     description: WeTek Electronics, limited.
   "^wexler,.*":
-- 
2.29.2

