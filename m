Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583D92B7D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgKRMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:00:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:24512 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKRMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605700848; x=1637236848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=79q66fa8KvoX+T/PzaarTCLxple1Kss4VOpRJiDyplo=;
  b=Fvw62NR4OI1lOkpYcEHQqe2cA1lRx04ghcDrTcwZgTQ6Pfa5EWlV71zy
   5kTE5XG0+EuOtQQCKHaRy+oWMGQvsseQ9p1KDBO/i7aSvH6guDVwVKyTS
   tSw3raB9A4nWJLIXm7dzIAYvGIywd6NQEX0ZVYZClgdNAvjvTN8kHBm3q
   zelByRUv2yiSf9WNrFhN2lZaYnsNmKpqe/CmfjgPrVgR64kSFF9PkzQ+R
   ZbRrC9/T0fF5Sxln6/DGIeWKblo/Mgq9GWL+p8HO6mYwu3P/NNitcZzvy
   HbC/m0kGZCTViT9v/jStsHkEa7mh/cOK7Hmg9ndhzIyv+8zyz2OH+AFbD
   Q==;
IronPort-SDR: jl5QNZCc89EiT36bXVX1JYo76vADH4QimQGF3H225unx68UQ+My5rjGTsPm4INllVK8zzlZmV4
 Hfm84VLdTdRwAV6Alx2O7Ke/M24sJ+UhhNCP8i/Q3mgUzYF/IuzMDiAURmBBjhk68FQ1Yfzi4Q
 u5mtq02KCJ/q254OagUbEHaCfwZsZVzRO3Focd1mWGCZ5W6Ze8VGiQAQrVoxHQQ+jP/ka6ibJ+
 KWM8HMD2FCGrzmUneQsE6P2uSAuODCRoYHnm4OyNmWmXJPanx8dAyE8naa6DWLuVrmjmIqWOK9
 p5s=
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="104034917"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2020 05:00:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 05:00:46 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 18 Nov 2020 05:00:44 -0700
From:   <cristian.birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 0/3] ARM: dts: at91: add pincontrol node for USB Host
Date:   Wed, 18 Nov 2020 14:00:16 +0200
Message-ID: <20201118120019.1257580-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

The pincontrol node is needed for USB Host since Linux v5.7-rc1. Without
it the driver probes but VBus is not powered because of wrong pincontrol
configuration. The patch was tested on SAM9x60EK, SAMA5D4-EK and SAMA5D3-EK. 

Cristian Birsan (3):
  ARM: dts: sam9x60: add pincontrol for USB Host
  ARM: dts: at91: sama5d4_xplained: add pincontrol for USB Host
  ARM: dts: at91: sama5d3_xplained: add pincontrol for USB Host

 arch/arm/boot/dts/at91-sam9x60ek.dts        | 9 +++++++++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 7 +++++++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 7 +++++++
 3 files changed, 23 insertions(+)

-- 
2.25.1

