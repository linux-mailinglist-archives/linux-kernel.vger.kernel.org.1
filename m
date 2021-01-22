Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6D30006B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbhAVKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbhAVJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:34:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB3C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:34:06 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2spM-0003Hp-IG; Fri, 22 Jan 2021 10:34:00 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2spL-00046z-Of; Fri, 22 Jan 2021 10:33:59 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] add support for GPIO based counter 
Date:   Fri, 22 Jan 2021 10:33:55 +0100
Message-Id: <20210122093357.15750-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v2:
- add commas
- avoid possible unhandled interrupts in the enable path
- do not use of_ specific gpio functions

Add support for GPIO based pulse counter. For now it can only count
pulses. With counter char device support, we will be able to attach
timestamps and measure actual pulse frequency.

Never the less, it is better to mainline this driver now (before chardev
patches go mainline), to provide developers additional use case for the counter
framework with chardev support.

Oleksij Rempel (2):
  dt-bindings: counter: add gpio-pulse-counter binding
  counter: add GPIO based pulse counters

 .../bindings/counter/gpio-pulse-counter.yaml  |  39 +++
 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/gpio-pulse-cnt.c              | 244 ++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml
 create mode 100644 drivers/counter/gpio-pulse-cnt.c

-- 
2.30.0

