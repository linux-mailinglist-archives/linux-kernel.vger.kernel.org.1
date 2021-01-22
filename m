Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF21E30061A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbhAVOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:52:47 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17393 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbhAVOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611327129; x=1642863129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KsXcy5y83xCRPNuARdSZENXQpQEChqeJyPUSi+46dLw=;
  b=fxDkGgrWaPmVCRDG+8lf8+DQtaKMraG9Ez6quC9iJ5pfc7RalyDa/fUc
   zXIDD0hESJjJe3/hLJqDvU9Hg1FakPsMC+0qyB/DMUTotWelh3trsAnCu
   oyyWaRrlY0jFOJbcLdBjnm5ivzLTT4bhhfS2D/cXwj2T0YTWLvKUs5iBI
   zrqU3T/CtKyFIfPJQymxg9G81UCUuIoVFFLVX3QMo+/OSaZdIxwSvkLT9
   ydxBUK6r2cWP+LzkU5GmmlGZhA8MSdpOSxWxBIQ2guQP+siCbbv8yKjCU
   dAVzqA6CVLR1qIijz3w/yyA+OJ5DPVSaFxxVxkgRobyid3UZQeTp+/oJJ
   g==;
IronPort-SDR: 0rs1KO37lE8cqXN5iAaWUTWynG9+Z/wB1Lksgv6EfC/A2IXAfxJqbDC2WLW7qHenNWJQz3bFGe
 43PjSCXEfbpudDSk6U9Xm2i/BiPO7wzThvVThzz/ssTs7RyG+Kpv5Z7tN1FAeTue7CKcLrAf05
 PujrSBaQfgQz5vXww5pSVdaOxsEoG0sFg2+9ziiGDYl2mjrcVKoxS34/N4CjZR7S0qMttX7WOb
 0t1SA6xLHHGlqt8he0l3QTwDO8VABweDpX9f8NpzQIy2nXxDzopcn3waEFpa52guam9NidNBxc
 HE8=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="106927510"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 07:50:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 07:50:46 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 07:50:45 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.12
Date:   Fri, 22 Jan 2021 15:46:38 +0100
Message-ID: <20210122144638.170565-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the defconfig changes for 5.12 which contains the removal of old
wrapper code that we called tclib. No such config option to be used anymore in
next kernel.

Thanks, best regards,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.12

for you to fetch changes up to 00a1aa475f507454fab82f02c6230c8fb2312a12:

  ARM: configs: multi_{v5,v7}: remove ATMEL_TCLIB (2021-01-02 14:06:48 +0100)

----------------------------------------------------------------
AT91 defconfig for 5.12:

- remove ATMEL_TCLIB as the driver was deleted

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: configs: at91: remove ATMEL_TCLIB
      ARM: configs: multi_{v5,v7}: remove ATMEL_TCLIB

 arch/arm/configs/at91_dt_defconfig  | 1 -
 arch/arm/configs/multi_v5_defconfig | 1 -
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/sama5_defconfig    | 1 -
 4 files changed, 4 deletions(-)

-- 
Nicolas Ferre
