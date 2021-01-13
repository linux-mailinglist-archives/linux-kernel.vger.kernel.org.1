Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F052F41F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbhAMCno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:43:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49630 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728426AbhAMCnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:43:42 -0500
X-UUID: 71b2aa0d57e04507b7eae46303cd61bc-20210113
X-UUID: 71b2aa0d57e04507b7eae46303cd61bc-20210113
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 598851444; Wed, 13 Jan 2021 10:42:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 10:42:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 10:42:49 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH RESEND v4 06/11] usb: gadget: bdc: add identifier name for function declaraion
Date:   Wed, 13 Jan 2021 10:42:23 +0800
Message-ID: <1610505748-30616-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 800F1379F4D96C635A547F98A4EF65C24491E16C1062665AA83C29A25FD284482000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to avoid the warning of function arguments, e.g.
  WARNING:FUNCTION_ARGUMENTS: function definition argument 'u32'
  should also have an identifier name

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v4 resend: base on kernel 5.11-rc1
v4: no changes, but rebase on kernel 5.10-rc1
v3: add acked-by Florian
v2: add Cc Florian
---
 drivers/usb/gadget/udc/bdc/bdc.h     | 28 ++++++++++++++--------------
 drivers/usb/gadget/udc/bdc/bdc_cmd.h | 18 +++++++++---------
 drivers/usb/gadget/udc/bdc/bdc_dbg.h |  8 ++++----
 drivers/usb/gadget/udc/bdc/bdc_ep.h  |  8 ++++----
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index c0ee735bd887..658abeff59d4 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -466,24 +466,24 @@ static inline void bdc_writel(void __iomem *base, u32 offset, u32 value)
 }
 
 /* Buffer descriptor list operations */
-void bdc_notify_xfr(struct bdc *, u32);
-void bdc_softconn(struct bdc *);
-void bdc_softdisconn(struct bdc *);
-int bdc_run(struct bdc *);
-int bdc_stop(struct bdc *);
-int bdc_reset(struct bdc *);
-int bdc_udc_init(struct bdc *);
-void bdc_udc_exit(struct bdc *);
-int bdc_reinit(struct bdc *);
+void bdc_notify_xfr(struct bdc *bdc, u32 epnum);
+void bdc_softconn(struct bdc *bdc);
+void bdc_softdisconn(struct bdc *bdc);
+int bdc_run(struct bdc *bdc);
+int bdc_stop(struct bdc *bdc);
+int bdc_reset(struct bdc *bdc);
+int bdc_udc_init(struct bdc *bdc);
+void bdc_udc_exit(struct bdc *bdc);
+int bdc_reinit(struct bdc *bdc);
 
 /* Status report handlers */
 /* Upstream port status change sr */
-void bdc_sr_uspc(struct bdc *, struct bdc_sr *);
+void bdc_sr_uspc(struct bdc *bdc, struct bdc_sr *sreport);
 /* transfer sr */
-void bdc_sr_xsf(struct bdc *, struct bdc_sr *);
+void bdc_sr_xsf(struct bdc *bdc, struct bdc_sr *sreport);
 /* EP0 XSF handlers */
-void bdc_xsf_ep0_setup_recv(struct bdc *, struct bdc_sr *);
-void bdc_xsf_ep0_data_start(struct bdc *, struct bdc_sr *);
-void bdc_xsf_ep0_status_start(struct bdc *, struct bdc_sr *);
+void bdc_xsf_ep0_setup_recv(struct bdc *bdc, struct bdc_sr *sreport);
+void bdc_xsf_ep0_data_start(struct bdc *bdc, struct bdc_sr *sreport);
+void bdc_xsf_ep0_status_start(struct bdc *bdc, struct bdc_sr *sreport);
 
 #endif /* __LINUX_BDC_H__ */
diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.h b/drivers/usb/gadget/udc/bdc/bdc_cmd.h
index a3a6dbd0022c..533ad52fa6d0 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.h
@@ -10,14 +10,14 @@
 #define __LINUX_BDC_CMD_H__
 
 /* Command operations */
-int bdc_address_device(struct bdc *, u32);
-int bdc_config_ep(struct bdc *, struct bdc_ep *);
-int bdc_dconfig_ep(struct bdc *, struct bdc_ep *);
-int bdc_stop_ep(struct bdc *, int);
-int bdc_ep_set_stall(struct bdc *, int);
-int bdc_ep_clear_stall(struct bdc *, int);
-int bdc_ep_bla(struct bdc *, struct bdc_ep *, dma_addr_t);
-int bdc_function_wake(struct bdc*, u8);
-int bdc_function_wake_fh(struct bdc*, u8);
+int bdc_address_device(struct bdc *bdc, u32 add);
+int bdc_config_ep(struct bdc *bdc, struct bdc_ep *ep);
+int bdc_dconfig_ep(struct bdc *bdc, struct bdc_ep *ep);
+int bdc_stop_ep(struct bdc *bdc, int epnum);
+int bdc_ep_set_stall(struct bdc *bdc, int epnum);
+int bdc_ep_clear_stall(struct bdc *bdc, int epnum);
+int bdc_ep_bla(struct bdc *bdc, struct bdc_ep *ep, dma_addr_t dma_addr);
+int bdc_function_wake(struct bdc *bdc, u8 intf);
+int bdc_function_wake_fh(struct bdc *bdc, u8 intf);
 
 #endif /* __LINUX_BDC_CMD_H__ */
diff --git a/drivers/usb/gadget/udc/bdc/bdc_dbg.h b/drivers/usb/gadget/udc/bdc/bdc_dbg.h
index 859d588e209d..acd8332f8584 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_dbg.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_dbg.h
@@ -12,10 +12,10 @@
 #include "bdc.h"
 
 #ifdef CONFIG_USB_GADGET_VERBOSE
-void bdc_dbg_bd_list(struct bdc *, struct bdc_ep*);
-void bdc_dbg_srr(struct bdc *, u32);
-void bdc_dbg_regs(struct bdc *);
-void bdc_dump_epsts(struct bdc *);
+void bdc_dbg_bd_list(struct bdc *bdc, struct bdc_ep *ep);
+void bdc_dbg_srr(struct bdc *bdc, u32 srr_num);
+void bdc_dbg_regs(struct bdc *bdc);
+void bdc_dump_epsts(struct bdc *bdc);
 #else
 static inline void bdc_dbg_regs(struct bdc *bdc)
 { }
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.h b/drivers/usb/gadget/udc/bdc/bdc_ep.h
index 5bbd73f99c6f..4d3affd07a65 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.h
@@ -9,9 +9,9 @@
 #ifndef __LINUX_BDC_EP_H__
 #define __LINUX_BDC_EP_H__
 
-int bdc_init_ep(struct bdc *);
-int bdc_ep_disable(struct bdc_ep *);
-int bdc_ep_enable(struct bdc_ep *);
-void bdc_free_ep(struct bdc *);
+int bdc_init_ep(struct bdc *bdc);
+int bdc_ep_disable(struct bdc_ep *ep);
+int bdc_ep_enable(struct bdc_ep *ep);
+void bdc_free_ep(struct bdc *bdc);
 
 #endif /* __LINUX_BDC_EP_H__ */
-- 
2.18.0

