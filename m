Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A973040EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbhAZOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:51:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38840 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391282AbhAZJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653882; x=1643189882;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NMyubT7ft1GnS8iH61qx4woIIkpCUMsKjr6KUJqttL8=;
  b=VQuMJdu6X/Zv3Dmuh34dAiWrhnWzbJszGApbJYgupyth/+dknUaRb5mQ
   xtEHEb/WfQXOgOPbG7fPcSFSc8T01BSGOGEzb9yEqmfX+nulbNiZm9zyS
   FO756KAlkA2OK1ANJ8svEziY8iTG1lKZXj3jzcd9ECCItzX3QwXrSnBe1
   OARdHQaqhLAeFJnf4DlQ2CSKH0l7m3jqfgGytuJtXOMJQSZBR6Pi3wn2a
   hA0juNGlcOLvEM0VXETUpVFcg9DErkKnu6jg6Io9IuL+9PpwlvOUigSvn
   qsU1IgRE4T07oFgB97l6viV6/mX8xe/mUQkiH7jP0dBJnu2r2TD3j7yGH
   g==;
IronPort-SDR: UdXB937ZseT8WNzFv5CCmmKSXidoB3eNobxaRyWF4yyepXtVqO7YEM81dagFHUHnpLSiIGT7WQ
 XL0KdB1Dj1iKLGt3KqKXHj+nXILZV7bt1sJr8MqxjfgPrlv3891oOPsxGzMMPVB/T2FtwZLpXm
 y6p8XIMaoFq3dLmJOkU9w6vKYUz553TK2ROpeJu2ukL/kCXNk9h1MgnXNv9suSMCjXF1CUijoA
 ZNoOb99iLJMAlFOX7bbWhFFN1N6uDk0qv9dIBDxlIiWN49S19AJVEWjVQwUuFlrG1eKeG1ke1O
 5sA=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="41780808"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:36:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:36:45 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:36:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/7] drivers: soc: atmel: add support for sama7g5
Date:   Tue, 26 Jan 2021 11:29:29 +0200
Message-ID: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes in v2:
- use proper license identifier
- s/licence/license/g

Claudiu Beznea (7):
  drivers: soc: atmel: add spdx license identifier
  drivers: soc: atmel: use GENMASK
  drivers: soc: atmel: fix "__initconst should be placed after socs[]"  
      warning
  drivers: soc: atmel: add null entry at the end of
    at91_soc_allowed_list[]
  drivers: soc: atmel: add per soc id and version match masks
  dt-bindings: atmel-sysreg: add "microchip,sama7g5-chipid"
  drivers: soc: atmel: add support for sama7g5

 .../devicetree/bindings/arm/atmel-sysregs.txt      |   2 +-
 drivers/soc/atmel/soc.c                            | 219 ++++++++++++++-------
 drivers/soc/atmel/soc.h                            |  14 +-
 3 files changed, 166 insertions(+), 69 deletions(-)

-- 
2.7.4

