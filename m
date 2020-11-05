Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624642A84A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgKERQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:16:02 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48613 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbgKERP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:15:59 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 78B2DC0013;
        Thu,  5 Nov 2020 17:15:56 +0000 (UTC)
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
Subject: [PATCH 3/6] dt-bindings: interrupt-controller: Add binding for the Microsemi Jaguar2 interrupt controller
Date:   Thu,  5 Nov 2020 18:15:32 +0100
Message-Id: <20201105171535.923570-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105171535.923570-1-gregory.clement@bootlin.com>
References: <20201105171535.923570-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Device Tree binding documentation for the Microsemi Jaguar2
interrupt controller that is part of the ICPU. It is connected directly to
the MIPS core interrupt controller.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../interrupt-controller/mscc,ocelot-icpu-intr.txt         | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
index 42de86e023a6..916832064d64 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
@@ -1,11 +1,12 @@
 Microsemi Ocelot SoC ICPU Interrupt Controller
 
-Luton and Servals belong the same family as Ocelot: the VCoreIII family
+Luton, Servals and Jaguar 2 belong the same family as Ocelot: the
+VCoreIII family
 
 Required properties:
 
-- compatible : should be "mscc,ocelot-icpu-intr" or "mscc,luton-icpu-intr"
-               or "mscc,serval-icpu-intr"
+- compatible : should be "mscc,ocelot-icpu-intr", "mscc,luton-icpu-intr",
+               "mscc,serval-icpu-intr" or "mscc,jaguar2-icpu-intr"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.28.0

