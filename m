Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A542B4AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgKPQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:24:34 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37175 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbgKPQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:24:33 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C1723C0012;
        Mon, 16 Nov 2020 16:24:30 +0000 (UTC)
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
Subject: [PATCH v3 0/5] Extend irqchip ocelot driver to support other SoCs
Date:   Mon, 16 Nov 2020 17:24:22 +0100
Message-Id: <20201116162427.1727851-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
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

Changelog:
v2 -> v3
 - Fix new-line-at-end-of-file error in the yaml file

v1 -> v2:
 - Convert the binding to yaml
 - Squashed the patches adding new binding in a single one

Gregory CLEMENT (5):
  dt-bindings: interrupt-controller: convert icpu intr bindings to
    json-schema
  dt-bindings: interrupt-controller: Add binding for few Microsemi
    interrupt controllers
  irqchip: ocelot: Add support for Luton platforms
  irqchip: ocelot: Add support for Serval platforms
  irqchip: ocelot: Add support for Jaguar2 platforms

 .../mscc,ocelot-icpu-intr.txt                 |  21 --
 .../mscc,ocelot-icpu-intr.yaml                |  63 ++++++
 drivers/irqchip/irq-mscc-ocelot.c             | 183 ++++++++++++++++--
 3 files changed, 225 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml

-- 
2.29.2

