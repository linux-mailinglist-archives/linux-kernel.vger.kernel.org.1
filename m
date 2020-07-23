Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA14C22B370
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgGWQZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 12:25:13 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50440 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595521512; x=1627057512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GmZjKvHA4i9aKtLNXB0oUxh93lHYoeSrTMVIgaJmzgU=;
  b=WoJnerbkPIwBehDLvCdN40tDmGwy6M0pQU8FGPa+Qy9bvz+9BYWWPGIj
   n7Xg/we2jUJYxMU7R77WmbK/qxC1aZ1S8HTXSqM6RXhBv3Jzp5pjOW+Lc
   kdAOTTTIderFsOU/4KYe/4zmDj6Sr6Zs7+7P11NDzuguqiFXumLi8AIU2
   OvWxVEVoy8NEUHnCIGfMwEBkCuSwzeYqwwJsaoelnDe6962iqmlrSk4Bn
   Hsql/REr+zgDTK/ByTOZD+DBhSaqiu3HsrRYi6oSRkr8ssHBllreM0ia7
   FJ1ZPTwFL2uNxz1OS7jaqw3BjVzrCpLooL4msVQ44CykxdqrFMzT/0Qdy
   Q==;
IronPort-SDR: PvTi7/sNZx75j3/s3VVK8G+NM+DWXFyea4Wrj9IzWNWCBatfNfGZexU7y5Y+WL+MslZCtWSKVm
 cuSe+JQlGNXrU0pwSEpt4GvLG8PjzKjZRt3sUBIpwy2UqqR9CCB4/LqZl3Sks0i6VfItk2OPE1
 xfWw+OrJCo/laauNB6OVDghPjuZ37jb84AmNVRBcwAsGtz9JahvWZMIxYKrr6UkXbpuadg8c3K
 tFBUjFl18N61LdFt1/nXNJOGAMXKTbh76brU2vsVslJvlfIfCSK8eHgUbKx/bJRekeCJNkMQqO
 BEY=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="83016633"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 09:25:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 09:25:12 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 23 Jul 2020 09:25:08 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <cristian.birsan@microchip.com>,
        <nicolas.ferre@microchip.com>, <arnd@arndb.de>,
        <ludovic.desroches@microchip.com>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/3] ARM: configs: at91: sama5: add support for KSZ ethernet switches
Date:   Thu, 23 Jul 2020 19:24:32 +0300
Message-ID: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

Enable DSA and KSZ9477 support as modules. Ethernet switches are used by
the SAMA5D2-ICP board.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index f688443fe7bf..123b95c1447a 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -49,6 +49,7 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_IPV6_SIT_6RD=y
+CONFIG_NET_DSA=m
 CONFIG_CAN=y
 CONFIG_CAN_AT91=y
 CONFIG_CAN_M_CAN=y
@@ -80,6 +81,8 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
+CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
 CONFIG_MACB=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
-- 
2.25.1

