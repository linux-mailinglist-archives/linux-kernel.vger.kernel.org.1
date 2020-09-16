Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3136E26C8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgIPS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:59:32 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15707 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgIPRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600278677; x=1631814677;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=9AnX9Owbeq7YKtr3bmjW5mDPEDCAIdPDn9C4shVYP/I=;
  b=iE7psJOVP5wEGPEwkC8Ne/+5Jqt8Ki4mx7IIG2EYTdB2HJGdIn7B8rdn
   h9TEa4RsYMTZPGC979hrN1a4J2I2V5AEQHNS34lTjpMJ8zDHpkXn2/Cql
   fWXZL+HVLOZ4UNtnHIMLQVrcoWXVkChZb4ynwKgtm3Pgnvp6DlkIoAqK6
   Hl35EcP/UEuGRK7msEGhE+Pknpvmj10UiRfNzVTP1z5KIctVB07NOynxi
   wkx9GaQCwC8XJHATLjr3hLtDPfLFuFaSqmYyMnxKH2mAhTGvtYHTOnj8R
   ZHxuE6ZbgXsuFW55ZFBooBXmlXUIs0lGLA/81YjoQlcNVyhn96QMUHAXh
   w==;
IronPort-SDR: YL8khqUdgAeulZ5MFaj9DxTfNlADE8JrnZlVclI/YWwVse8HJQQGWudMYGLTgc2HG0HVctPw3+
 1NUQXPlu4VFmCtec6A/YLXhCB8sHuajOIW9C4gRziqmLQ2pAKHO2Hu/dizSdm48y5wA9HkZ5yA
 RtElREe8CdWbkkXpC7hfuBWzmmm1rFDASYnHQmcIvjvjtC32uHeO83LdmWw7C3eF5/OAi2bsxq
 fp6/A7Be+wnx+QOzUoB6+vQUyYKpZMOVOnMdO54Cn0X0blOa3wK0H0BGCXdFHB3nTRVXp91cD8
 Vbo=
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="91200839"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 03:59:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 03:59:01 -0700
Received: from soft-dev10.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 16 Sep 2020 03:58:59 -0700
User-agent: mu4e 1.2.0; emacs 26.3
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ARM: sparx5: SoC for 5.9
Date:   Wed, 16 Sep 2020 12:59:15 +0200
Message-ID: <878sda2dj0.fsf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://github.com/microchip-ung/linux-upstream.git tags/sparx5-dt-5.10

for you to fetch changes up to 5df50128050d01d300f28d9bca4dd89d6d24de3d:

  arm64: dts: sparx5: Add spi-nand devices (2020-09-16 11:39:51 +0200)

----------------------------------------------------------------
Sparx5 DT updates for Linux 5.10

- Add public repo to MAINTAINERS
- Add SPI controller and devices
- Add eMMC controller and devices
- Add temperature sensor

----------------------------------------------------------------
Lars Povlsen (6):
      arm64: dts: sparx5: Add Sparx5 eMMC support
      arm64: dts: sparx5: Add hwmon temperature sensor
      MAINTAINERS: Add git tree for Sparx5
      arm64: dts: sparx5: Add SPI controller and associated mmio-mux
      arm64: dts: sparx5: Add spi-nor support
      arm64: dts: sparx5: Add spi-nand devices

 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi          | 81 ++++++++++++++++++++++
 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi     | 31 +++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts    | 53 ++++++++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb134.dts    |  1 +
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi    | 32 +++++++++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts      | 23 ++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb135.dts    |  1 +
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi    | 32 +++++++++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts      | 23 ++++++
 10 files changed, 278 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi


-- 
Lars Povlsen,
Microchip
