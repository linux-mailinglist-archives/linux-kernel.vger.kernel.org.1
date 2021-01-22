Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B443002EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbhAVM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:28:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27722 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbhAVMX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318238; x=1642854238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wWtTJIMWC1g5SNBwfFQV6VJAAcc5lnSYixiNCayZhp8=;
  b=PS+XHMBLFkAL08uXMkX+AuPv+AyRWNduUl/lSBniYy9/UaaMULCz6k2Z
   ERh0ErTI/YHD+qmw96QoR1WBscS1DLlwB5x/+mcBcGHaVkBRqHL61Yeuw
   ZbxIBJLK7FCMDtMWyLyObM8qAJLECUAYtToVr0HtH6Hp1RdO4fgobYdjp
   x0MDEdkzE0hauPXJHXt3jcV7aPljlPzOmu3yTO35F19wsQhVB3mJeDexo
   BjTzPMxfHH/ZGICjxhusaBtNNoOpMhQdkCro3qXCrxCzwto0HCQI2csWR
   BuZhQ0UKfgBiIeCB5qoOrxjPQXfdfXZ74R70W0PmPO0XiIVHsLOyunDCp
   w==;
IronPort-SDR: LMNcMZExVxPlwhmRYyQCeLTlZqEMRXYhQMKQC2w/osLv1OZHnV2Z9vANB0IqtEMCFxRmYpPIK4
 BFd5fx9SJ75SoUOzSI2y3/aZCu155LGd5FvYr1u2kpdXeIdrjFiNazt3NJ4TJ0CxBfQFG3owVQ
 bh5LK8FjjMEN9VEnkCz2M3kTyoTpPexyo/tYUx4EgpKqA9+H7AeW/p6coZ1oNdQwaDVSW/dF5C
 GKoZW6FvFiplCoJv57h6Tl3jVcWckBDwZ7qGHqeunNLAUEwo/0gYKk7L1O1aaUEkWYEKEBfJoH
 2Z4=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="106908946"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:21:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:21:57 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:21:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/7] drivers: soc: atmel: fix "__initconst should be placed after socs[]" warning
Date:   Fri, 22 Jan 2021 14:21:33 +0200
Message-ID: <1611318097-8970-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning: "__initconst should be placed after socs[]".

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index ef591b622583..9d10a526cd3c 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -30,7 +30,7 @@
 #define AT91_CIDR_EXT			BIT(31)
 #define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
 
-static const struct at91_soc __initconst socs[] = {
+static const struct at91_soc socs[] __initconst = {
 #ifdef CONFIG_SOC_AT91RM9200
 	AT91_SOC(AT91RM9200_CIDR_MATCH, 0, "at91rm9200 BGA", "at91rm9200"),
 #endif
-- 
2.7.4

