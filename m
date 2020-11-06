Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485DE2A92BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgKFJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:31:23 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:16947 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:31:23 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4CF1C240013;
        Fri,  6 Nov 2020 09:31:20 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/4] Extend pinctrl ocelot driver to support other SoCs
Date:   Fri,  6 Nov 2020 10:31:14 +0100
Message-Id: <20201106093118.965152-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ocelot SoC belongs to a larger family of SoCs which use the same
interrupt controller with a few variation.

This series of patches add support for Luton and Serval, they are all
MIPS based.

The first patches of the series also updates the binding documentation
with the new compatible strings.

Gregory

Gregory CLEMENT (2):
  dt-bindings: pinctrl: ocelot: Add Luton SoC support
  dt-bindings: pinctrl: ocelot: Add Serval SoC support

Lars Povlsen (2):
  pinctrl: ocelot: Add support for Luton platforms
  pinctrl: ocelot: Add support for Serval platforms

 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |   3 +-
 drivers/pinctrl/pinctrl-ocelot.c              | 184 ++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)

-- 
2.28.0

