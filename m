Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA522E240
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 21:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGZT2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 15:28:15 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33859 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGZT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:28:15 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8B183E0004;
        Sun, 26 Jul 2020 19:28:10 +0000 (UTC)
Date:   Sun, 26 Jul 2020 21:28:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 5.9
Message-ID: <20200726192810.GA181818@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here are a few sama5 defconfig changes, mainly adding DSA support for
the switch on an evaluation board.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-defconfig-5.9

for you to fetch changes up to c12b539787efff5b4fc5abac1debf3ea1901348e:

  ARM: configs: at91: sama5: enable CAN PLATFORM driver (2020-07-25 00:13:20 +0200)

----------------------------------------------------------------
AT91 defconfig for 5.9

 - Add ClassD, KSZ ethernet switches, brdige, vlan to sama5_defconfig
 - Reenable CAN support in sama5_defconfig

----------------------------------------------------------------
Codrin Ciubotariu (1):
      ARM: configs: at91: sama5: Enable CLASSD

Cristian Birsan (1):
      ARM: configs: at91: sama5: enable CAN PLATFORM driver

Razvan Stefanescu (2):
      ARM: configs: at91: sama5: add support for KSZ ethernet switches
      ARM: configs: at91: sama5: enable bridge and VLAN filtering

 arch/arm/configs/sama5_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
