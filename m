Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4C1FCC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQLeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 07:34:13 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:9271 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592393653; x=1623929653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kQsP/yVJQUNUJxvLd2o3N1wn7VHKUz9qL3WSHlmLZFk=;
  b=P1xngMJCZ5dKWh7iwAksVWFKWrKsiUVtY095aVDUL5SYbARZ+QXF5g/3
   zd2jmCPSBalYQb0LGEK11w7jtyvQsF784QDt9T/SuPWdJzgdRdL+ANxPx
   SQ2mPZXVU66E3DYM0PwUrOL1VFsMzmKLZBiZ/keQGcaewXkQXhm8gYLsL
   Tn9CbbdQS3v/mq590ju7NF2alStU9pJq2qyt7cJUQN5J+DiMHntS+xxcp
   YMYWOJU58QxRNYUsbqsG/JI5WC/oHJv2FVZHsp9ScLwbyogFtJ3PMCUTg
   stB2xoHRbaKAUfoDB8qqU7GG7qFcvqDexQADoyxFO1Nv/1CUM57QmIFcP
   Q==;
IronPort-SDR: g4ofiiEUYk3qfKBvdRaUwrDkrrQWuz/cgJ8wbSU7yz5q73bo2xNuwQlaTzPJ0Jd9vs80iw0zAA
 RzJV5u9MzHZ66Tky/1XjZ/6YUqkhit9+DzCdDv4rGeBSoy2CYt6IbLhgNEB/XIAYu9LcJO8TJy
 UXRbf6pRXRKwjE8eE75lQ+n7uF2BA80imXFmVhWraf77+wu83ibfBdIV65wGH7vA8NrC/rC5WU
 di/teQH4U4CtV7Qseni/nbk3ShCwa9d9T55bmIoKInutsMKDmt/VhvOV3NHmsrzz+IA37KlqdN
 wOM=
X-IronPort-AV: E=Sophos;i="5.73,522,1583218800"; 
   d="scan'208";a="79790505"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2020 04:34:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 04:34:11 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 17 Jun 2020 04:34:10 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <davem@davemloft.net>,
        <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net] bridge: uapi: mrp: Fix MRP_PORT_ROLE
Date:   Wed, 17 Jun 2020 13:32:49 +0200
Message-ID: <20200617113249.2001901-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the MRP_PORT_ROLE_NONE has the value 0x2 but this is in conflict
with the IEC 62439-2 standard. The standard defines the following port
roles: primary (0x0), secondary(0x1), interconnect(0x2).
Therefore remove the port role none.

Fixes: 4714d13791f831 ("bridge: uapi: mrp: Add mrp attributes.")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/mrp_bridge.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
index 84f15f48a7cb1..bee3665402129 100644
--- a/include/uapi/linux/mrp_bridge.h
+++ b/include/uapi/linux/mrp_bridge.h
@@ -36,7 +36,6 @@ enum br_mrp_port_state_type {
 enum br_mrp_port_role_type {
 	BR_MRP_PORT_ROLE_PRIMARY,
 	BR_MRP_PORT_ROLE_SECONDARY,
-	BR_MRP_PORT_ROLE_NONE,
 };
 
 enum br_mrp_tlv_header_type {
-- 
2.26.2

