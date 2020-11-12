Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF882B00BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKLH7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:59:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:15375 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbgKLH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:59:49 -0500
X-UUID: 3a1dcb1ef92a4d07be7a57d623318ee8-20201112
X-UUID: 3a1dcb1ef92a4d07be7a57d623318ee8-20201112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 353635932; Thu, 12 Nov 2020 15:59:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 15:59:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 15:59:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>, <linux-usb@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 01/11] usb: gadget: bdc: fix improper SPDX comment style for header file
Date:   Thu, 12 Nov 2020 15:59:24 +0800
Message-ID: <1605167974-28502-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9012CB0DEAAA3E5EACE7125E6B932DBF39650BB9E64F7ED589AEE4881631ED232000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v4: no changes, but rebase on kernel 5.10-rc1
v3: add acked-by Florian
v2: add Cc Florian
---
 drivers/usb/gadget/udc/bdc/bdc.h     | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.h | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_dbg.h | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.h  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index ac75e25c3b6a..fcba77e42fd1 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc.h - header for the BRCM BDC USB3.0 device controller
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.h b/drivers/usb/gadget/udc/bdc/bdc_cmd.h
index 29cc988a671a..373e674809e9 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc_cmd.h - header for the BDC debug functions
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc_dbg.h b/drivers/usb/gadget/udc/bdc/bdc_dbg.h
index 373d5abffbb8..859d588e209d 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_dbg.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_dbg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc_dbg.h - header for the BDC debug functions
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.h b/drivers/usb/gadget/udc/bdc/bdc_ep.h
index a37ff8033b4f..5bbd73f99c6f 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc_ep.h - header for the BDC debug functions
  *
-- 
2.18.0

