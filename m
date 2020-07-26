Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5622E244
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGZTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 15:33:38 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39909 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGZTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:33:38 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 321B6E0005;
        Sun, 26 Jul 2020 19:33:36 +0000 (UTC)
Date:   Sun, 26 Jul 2020 21:33:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 5.9
Message-ID: <20200726193335.GA182444@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Two non urgent small fixes for mach-at91 in this pull request.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-soc-5.9

for you to fetch changes up to f3a49f17845d81a032b83ef102fb24ffb2dfb3a0:

  ARM: at91: Replace HTTP links with HTTPS ones (2020-07-18 00:59:26 +0200)

----------------------------------------------------------------
AT91 SoC for 5.9

 - Two small fixes

----------------------------------------------------------------
Alexander A. Klimov (1):
      ARM: at91: Replace HTTP links with HTTPS ones

yu kuai (1):
      ARM: at91: pm: add missing put_device() call in at91_pm_sram_init()

 arch/arm/mach-at91/Makefile.boot |  2 +-
 arch/arm/mach-at91/pm.c          | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
