Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B962F2BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404126AbhALJzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:55:12 -0500
Received: from comms.puri.sm ([159.203.221.185]:34884 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403989AbhALJzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:55:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 5FC65DFE40;
        Tue, 12 Jan 2021 01:53:35 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2CT5hzCpR7Hs; Tue, 12 Jan 2021 01:53:34 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 9/9] dt-bindings: arm: fsl: Add the librem 5 Evergreen revision
Date:   Tue, 12 Jan 2021 10:51:51 +0100
Message-Id: <20210112095151.4995-10-martin.kepplinger@puri.sm>
In-Reply-To: <20210112095151.4995-1-martin.kepplinger@puri.sm>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Librem 5 phone, Evergreen revision which is supported
by "r4". Schematics and more information can be found at
https://developer.puri.sm/Librem5/Hardware_Reference/Evergreen.html

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 34000f7fbe02..5921ccf218d9 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -724,6 +724,7 @@ properties:
           - enum:
               - purism,librem5r2          # Purism Librem5 phone "Chestnut"
               - purism,librem5r3          # Purism Librem5 phone "Dogwood"
+              - purism,librem5r4          # Purism Librem5 phone "Evergreen"
           - const: purism,librem5
           - const: fsl,imx8mq
 
-- 
2.20.1

