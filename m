Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E3A2C6CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgK0VpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:45:14 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41357 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732206AbgK0Vlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:41:51 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 762E8FF804;
        Fri, 27 Nov 2020 21:41:40 +0000 (UTC)
Date:   Fri, 27 Nov 2020 22:41:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: Drivers for 5.11 (bis)
Message-ID: <20201127214140.GA1688544@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

As discussed with Arnd, here are two cleanup patches for at91_cf. My end
goal is to get rid of include/linux/platform_data/atmel.h.
Also a very small patch adding SoC IDs for the sam9x60 SiPs.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-drivers-5.11

for you to fetch changes up to 264788c8f23703d0d3e967fb5aea83eb64d2cb2b:

  pcmcia: at91_cf: remove platform data support (2020-11-27 22:25:15 +0100)

----------------------------------------------------------------
AT91 drivers for 5.11:

 - add sam9x60 SiP IDs
 - at91_cf cleanups

----------------------------------------------------------------
Alexandre Belloni (2):
      pcmcia: at91_cf: move definitions locally
      pcmcia: at91_cf: remove platform data support

Kai Stuhlemmer (1):
      ARM: at91: sam9x60 SiP types added to soc description

 drivers/pcmcia/Kconfig              |  1 +
 drivers/pcmcia/at91_cf.c            | 50 ++++++++++++++-----------------------
 drivers/soc/atmel/soc.c             |  6 +++++
 drivers/soc/atmel/soc.h             |  3 +++
 include/linux/platform_data/atmel.h | 12 ---------
 5 files changed, 29 insertions(+), 43 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
