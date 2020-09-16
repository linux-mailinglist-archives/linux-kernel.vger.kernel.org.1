Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D690A26CE40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIPWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:04:09 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50909 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIPVLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 17:11:23 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 081BEFF80B;
        Wed, 16 Sep 2020 21:11:19 +0000 (UTC)
Date:   Wed, 16 Sep 2020 23:11:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 5.10
Message-ID: <20200916211119.GA275438@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

As usual, only PM related work in this pull request. A new mode is
added, improving the wakeup latency on sam9x60.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-soc-5.10

for you to fetch changes up to faf6dc64c4b14563c82bb9c5ece8d4a69c9c1ace:

  ARM: at91: pm: remove unnecessary at91sam9x60_idle (2020-08-17 11:18:59 +0200)

----------------------------------------------------------------
AT91 SoC for 5.10

 - ULP0 fast wakeup support
 - PM cleanups

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: pm: remove unnecessary at91sam9x60_idle

Claudiu Beznea (3):
      ARM: at91: pm: add support for ULP0 fast wakeup
      ARM: at91: pm: add per soc validation of pm modes
      ARM: at91: pm: of_node_put() after its usage

 arch/arm/mach-at91/pm.c         | 97 ++++++++++++++++++++++++++++++++++++-----
 arch/arm/mach-at91/pm.h         |  5 ++-
 arch/arm/mach-at91/pm_suspend.S | 41 +++++++++++++++--
 3 files changed, 126 insertions(+), 17 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
