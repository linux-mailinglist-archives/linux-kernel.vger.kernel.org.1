Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67513002D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbhAVMYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:24:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7566 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbhAVMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318183; x=1642854183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7rYGNcTg/1HVKG5Q5+jhx/w2uW/fXDa0rnOsfsil3bI=;
  b=cI132cSG/3Aa2/nyxMcdY9joPmqgFxQxtLU4tY05fen8uGNFztx7j3en
   +E41PeTddL9t8fMLF1SgeT5SVD0+muzrCGTQ6o6YXbdVuTUYKJrILJP0U
   K2EDgAO9urf+COO+pGkBCZ9qCZxlJV0PeEKBudRFfDpROYfQOXHIPjNRs
   zo2Qr/7Otf2TKdo7yToUzUydJmk4xzyrTRoxw991iKcHldu51anB/i+Gn
   Btqwjl9LcO4xxLb5JhxhI9wqQHOvPLdkGiwL+kJ7qcSzVzd10AxkDA7F5
   MLbNtGRUVonecauTi6N5zVq82Y64sd2ihSVEh0u72L+isU7JH73eRouac
   Q==;
IronPort-SDR: b6SCs0xzQiTO+6xlEO4WbAgc4JSGLfhhKitszkZewA72GYGpCil08H/NjDbxlIkvkcx56twSsX
 kis68F4tFxG9PmHvP0cJqvgtRX9lAb7MzLAaYexoN20+pHpgAUSO6YiW2mmB73kSj1uoUtRCUt
 0VAzkSnzReZ4nIBZYeDmD/QUahQQqeVwz43q2GNt4ccBt+vwg8ul+X7lcN0lmofGsR51aEvOCK
 MB54hRIWjhMYItrejjpWriA4SYyXopRMTQe04+WdZgjX8wIoDuIG2rilBml2R7l/PGNGDnWRhG
 f28=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="112079684"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:21:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:21:48 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:21:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/7] drivers: soc: atmel: add spdx licence identifier
Date:   Fri, 22 Jan 2021 14:21:31 +0200
Message-ID: <1611318097-8970-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX-Licence-Identifier.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 1 +
 drivers/soc/atmel/soc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 728d461ad6d6..1a6cb4bc7d67 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Atmel
  *
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 5849846a69d6..3dc19c44e3a8 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (C) 2015 Atmel
  *
-- 
2.7.4

