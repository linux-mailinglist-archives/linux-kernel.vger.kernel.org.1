Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA22A849B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgKERPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:15:55 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36439 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbgKERPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:15:54 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9D69F2006E;
        Thu,  5 Nov 2020 17:15:51 +0000 (UTC)
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
Subject: [PATCH 0/6] Extend irqchip ocelot driver to support other SoCs
Date:   Thu,  5 Nov 2020 18:15:29 +0100
Message-Id: <20201105171535.923570-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ocelot SoC belongs to a larger family of SoCs which use the same
interrupt controller with a few variation.

This series of patches add support for Luton, Serval and Jaguar2, they
are all MIPS based.

The first patches of the series also updates the binding documentation
with the new compatible strings.

Gregory

Gregory CLEMENT (6):
  dt-bindings: interrupt-controller: Add binding for the Microsemi Luton
    interrupt controller
  dt-bindings: interrupt-controller: Add binding for the Microsemi
    Serval interrupt controller
  dt-bindings: interrupt-controller: Add binding for the Microsemi
    Jaguar2 interrupt controller
  irqchip: ocelot: Add support for Luton platforms
  irqchip: ocelot: Add support for Serval platforms
  irqchip: ocelot: Add support for Jaguar2 platforms

 .../mscc,ocelot-icpu-intr.txt                 |   6 +-
 drivers/irqchip/irq-mscc-ocelot.c             | 183 ++++++++++++++++--
 2 files changed, 167 insertions(+), 22 deletions(-)

-- 
2.28.0

