Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683462A84A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgKERP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:15:59 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59297 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKERP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:15:58 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1DD6860006;
        Thu,  5 Nov 2020 17:15:54 +0000 (UTC)
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
Subject: [PATCH 2/6] dt-bindings: interrupt-controller: Add binding for the Microsemi Serval interrupt controller
Date:   Thu,  5 Nov 2020 18:15:31 +0100
Message-Id: <20201105171535.923570-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105171535.923570-1-gregory.clement@bootlin.com>
References: <20201105171535.923570-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Device Tree binding documentation for the Microsemi Serval
interrupt controller that is part of the ICPU. It is connected directly to
the MIPS core interrupt controller.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
index 94dc95cb815c..42de86e023a6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
@@ -1,10 +1,11 @@
 Microsemi Ocelot SoC ICPU Interrupt Controller
 
-Luton belongs the same family of Ocelot: the VCoreIII family
+Luton and Servals belong the same family as Ocelot: the VCoreIII family
 
 Required properties:
 
 - compatible : should be "mscc,ocelot-icpu-intr" or "mscc,luton-icpu-intr"
+               or "mscc,serval-icpu-intr"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.28.0

