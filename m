Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF713002D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbhAVMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:24:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7552 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbhAVMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318179; x=1642854179;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CfZV788iNlFza3rn6eghPWT9h6nWgOEJTBQ/9EjsJk8=;
  b=IFP6Lc4dTb938WnDykzBfZo1ApT2pF/4GQAZNM/m1Gdsaxcw/9s2cO7c
   gvQkgleyReVDGBy7eKg9+/RUm9H9xxtcYT5AZ1/rKx18TUksmqSQ4Zs/K
   PAkp37jQGWEQv7wFMQZnztNdw6MShnwGMYGexKNQ5yWENk6UHhjXEvrV0
   5Fw63ZqvWAMG6MuwzsJNKDHXb6JnUajPTx99imOFSgLp3JUyWgq9FZSID
   xT3IgrbHe+0LRf3GYmt7P6esgUEPvR6CQCUhBH0Bt++IiPVHmw3BZkgH+
   VDAK/yxTykXLl/IFoOsWZhyIhuHlYHQ09qVKobLY3ENXxyhl57j8DizeD
   g==;
IronPort-SDR: 3dy2208EWIpqC37yVyFWA5M+/LIjR0sNJpUrnT62X24oZ1vZr7ILoQqiyrE4WSYbvxlheWwUVl
 soeBLwcjLygv4L4xau8DTKewd3zkDMZ4xzY6YzM2uzZkwy+7Wc9fMPBPGaD5nnXaXgG3fw/uRz
 a8f8u5IdSnCVDkEQurw2JchU8YNrN8282+3GCPpI31FQ4BuyBtLM1FkKyy7+Dqx7tvTp6uiTnh
 yS48q8+VT9C+i6pthEZ+bfn4+q7zaFIzNZ3DwKcLotBQ3lUx9e+o5ousT8AZitPZA4p/8MaUbm
 1E8=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="112079672"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:21:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:21:43 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:21:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/7] drivers: soc: atmel: add support for sama7g5
Date:   Fri, 22 Jan 2021 14:21:30 +0200
Message-ID: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for SAMA7G5 identification. Along with this
included also some fixes.

Thank you,
Claudiu Beznea

Claudiu Beznea (7):
  drivers: soc: atmel: add spdx licence identifier
  drivers: soc: atmel: use GENMASK
  drivers: soc: atmel: fix "__initconst should be placed after socs[]"  
      warning
  drivers: soc: atmel: add null entry at the end of
    at91_soc_allowed_list[]
  drivers: soc: atmel: add per soc id and version match masks
  dt-bindings: atmel-sysreg: add "microchip,sama7g5-chipid"
  drivers: soc: atmel: add support for sama7g5

 .../devicetree/bindings/arm/atmel-sysregs.txt      |   2 +-
 drivers/soc/atmel/soc.c                            | 225 ++++++++++++++-------
 drivers/soc/atmel/soc.h                            |  14 +-
 3 files changed, 171 insertions(+), 70 deletions(-)

-- 
2.7.4

