Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE82BB0C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgKTQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:41:19 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57627 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbgKTQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:18 -0500
Received: from localhost (lfbn-lyo-1-1010-39.w86-194.abo.wanadoo.fr [86.194.86.39])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B517820000D;
        Fri, 20 Nov 2020 16:41:15 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 2/6] dt-bindings: interrupt-controller: Add binding for few Microsemi interrupt controllers
Date:   Fri, 20 Nov 2020 17:41:04 +0100
Message-Id: <20201120164108.2096359-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120164108.2096359-1-gregory.clement@bootlin.com>
References: <20201120164108.2096359-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Device Tree binding documentation for the Microsemi Jaguar2,
Luton and Serval interrupt controller that is part of the ICPU. It is
connected directly to the MIPS core interrupt controller.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
index f34b319c7874..92fb1baf600f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
@@ -21,7 +21,11 @@ properties:
   compatible:
     items:
       - enum:
+          - mscc,jaguar2-icpu-intr
+          - mscc,luton-icpu-intr
           - mscc,ocelot-icpu-intr
+          - mscc,serval-icpu-intr
+
 
   '#interrupt-cells':
     const: 1
-- 
2.29.2

