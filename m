Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C601D8A10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 23:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgERVc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 17:32:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53601 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:32:57 -0400
X-Originating-IP: 90.65.91.255
Received: from localhost (lfbn-lyo-1-1912-bdcst.w90-65.abo.wanadoo.fr [90.65.91.255])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 36E80FF805;
        Mon, 18 May 2020 21:32:55 +0000 (UTC)
Date:   Mon, 18 May 2020 23:32:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 5.8
Message-ID: <20200518213254.GA26598@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Very little is added to the sama5_defconfig: support for the gpios from
the security module and a pmic for the SAMA5D27 WLSOM1.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.8-defconfig

for you to fetch changes up to 6a2ab88ca789804cad89d558625147edd26a1d37:

  ARM: configs: at91: sama5: enable MCP16502 regulator (2020-04-13 13:00:16 +0200)

----------------------------------------------------------------
AT91 defconfig for 5.8

 - Add PIOBU and MCP16502 regulator to sama5 defconfig

----------------------------------------------------------------
Razvan Stefanescu (2):
      ARM: configs: at91: sama5: enable SAMA5D2_PIOBU
      ARM: configs: at91: sama5: enable MCP16502 regulator

 arch/arm/configs/sama5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
