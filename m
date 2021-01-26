Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9549B303B99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392491AbhAZL2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:28:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38840 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390976AbhAZJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653930; x=1643189930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JOdG/Z1OAni9L4m9IjMWpESAQUvrPyDFCRJalxyKhRs=;
  b=pKpa/2mBL3pGWLdf114PCeeCzPbP+HIwRl4toZzs2mUiNhTCZdlMZQ1g
   zaWlHBorGlK1ilCK/1g5XAhHRCN7LSj9r+brrHhpKYYXo+/Zld7jFy4ev
   ZvQkT5mbkXqNWgxOogzLmLKOWaQCcS4isXgr0b+umMh3k2lRm6ygZ+heG
   0WM+WzR2h1/vwWYzfsM5HM6W/hCqcrxF1NP7GlqevvQ6b9PjteNnQS2CA
   ss2y7Ei9nhdGVx2UCvkEcdZL15+vCFBtuXUq2KcXNrjhcZbrBI3dSmLyJ
   4C9b/cU4nhUeaRBm3/rbMqoyYCB3ij4MPMKwUETGpKCiZz2DZY6LJQ8L2
   Q==;
IronPort-SDR: 78zvZlWiazOgh10+XluaKahQvDfrA2TlNi36d8QDOLBAyjdN3oESc2HqmQ/UuPNNdA1CfYMW2g
 0AnMHgjHqctKHFVlVjR/7FLLHY2RtJK/mkA/sidJlOjnQCXUdnuDaqPqvQvQTymPsrichARLLR
 zEOo92vHnc8ZatzLQfZVGe0J5fALrBL+kjWHe7+MKHVTJRWPfrZ1j2XgRnGmBzaEqw5lIUtwnz
 W5XquCgOvPnGW6u4GfreB9CCWQocIWbd5fDp/HzXeIuMxHn1TWk1nDIXWRgwyi1Tv0N2JmFr0q
 86k=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="41780833"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:36:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:36:48 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:36:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/7] drivers: soc: atmel: add spdx license identifier
Date:   Tue, 26 Jan 2021 11:29:30 +0200
Message-ID: <1611653376-24168-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX-License-Identifier.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 1 +
 drivers/soc/atmel/soc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 2dc86728b132..755a82502ef4 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2015 Atmel
  *
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index ee652e4841a5..77b27124362c 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2015 Atmel
  *
-- 
2.7.4

