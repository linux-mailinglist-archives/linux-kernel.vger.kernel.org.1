Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFF2F9D62
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbhARLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:00:04 -0500
Received: from comms.puri.sm ([159.203.221.185]:59734 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389743AbhARK4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:56:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4C0FCE0167;
        Mon, 18 Jan 2021 02:55:22 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9DZlHRdndy3n; Mon, 18 Jan 2021 02:55:21 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 8/9] dt-bindings: arm: fsl: Add the librem 5 Evergreen revision
Date:   Mon, 18 Jan 2021 11:54:24 +0100
Message-Id: <20210118105425.425-9-martin.kepplinger@puri.sm>
In-Reply-To: <20210118105425.425-1-martin.kepplinger@puri.sm>
References: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Librem 5 phone, Evergreen revision which is supported
by "r4". Schematics and more information can be found at
https://developer.puri.sm/Librem5/Hardware_Reference/Evergreen.html

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2ae66407e2aa..aaac7ef78b38 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -738,6 +738,7 @@ properties:
           - enum:
               - purism,librem5r2          # Purism Librem5 phone "Chestnut"
               - purism,librem5r3          # Purism Librem5 phone "Dogwood"
+              - purism,librem5r4          # Purism Librem5 phone "Evergreen"
           - const: purism,librem5
           - const: fsl,imx8mq
 
-- 
2.20.1

