Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19BC2C6D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgK0V4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:56:31 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57701 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732210AbgK0VzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:55:25 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3AD8D240002;
        Fri, 27 Nov 2020 21:55:18 +0000 (UTC)
Date:   Fri, 27 Nov 2020 22:55:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 5.11
Message-ID: <20201127215517.GA1733715@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Two patches limiting the number of compiled media drivers.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-defconfig-5.11

for you to fetch changes up to 036f224ef8f447928bfd3085220c28e158a4e4d6:

  ARM: configs: at91_dt: resync with media changes (2020-10-29 14:32:07 +0100)

----------------------------------------------------------------
AT91 defconfig for 5.11:

 - filter compiled media drivers

----------------------------------------------------------------
Eugen Hristev (2):
      ARM: configs: at91: sama5: resync with media changes
      ARM: configs: at91_dt: resync with media changes

 arch/arm/configs/at91_dt_defconfig | 5 +++++
 arch/arm/configs/sama5_defconfig   | 9 +++++++++
 2 files changed, 14 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
