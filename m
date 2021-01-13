Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95B52F4206
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbhAMCs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:48:58 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:13922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728587AbhAMCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:48:56 -0500
X-UUID: b3889654b629499ca0c3bff64464e2d7-20210113
X-UUID: b3889654b629499ca0c3bff64464e2d7-20210113
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1576998926; Wed, 13 Jan 2021 10:42:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 10:42:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 10:42:52 +0800
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
Subject: [PATCH RESEND v4 09/11] usb: gadget: bdc: fix checkpatch.pl tab warning
Date:   Wed, 13 Jan 2021 10:42:26 +0800
Message-ID: <1610505748-30616-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0612FA1F73B92D5C6B98A1B315C0F97713B73D3F8113337783F52F3C6BF02CBA2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements
WARNING:TABSTOP: Statements should start on a tabstop

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v4 resend: base on kernel 5.11-rc1
v4: no changes, but rebase on kernel 5.10-rc1
v3: add acked-by Florian
v2: add Cc Florian
---
 drivers/usb/gadget/udc/bdc/bdc_cmd.c | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.c b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
index 44c2a5eef785..995f79c79f96 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
@@ -163,7 +163,7 @@ int bdc_config_ep(struct bdc *bdc, struct bdc_ep *ep)
 					usb_endpoint_xfer_isoc(desc)) {
 			param2 |= si;
 			if (usb_endpoint_xfer_isoc(desc) && comp_desc)
-					mul = comp_desc->bmAttributes;
+				mul = comp_desc->bmAttributes;
 
 		}
 		param2 |= mul << EPM_SHIFT;
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index 3fb36c8454fc..d227d2682dd8 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -275,7 +275,7 @@ static inline int find_end_bdi(struct bdc_ep *ep, int next_hwd_bdi)
 	end_bdi = next_hwd_bdi - 1;
 	if (end_bdi < 0)
 		end_bdi = ep->bd_list.max_bdi - 1;
-	 else if ((end_bdi % (ep->bd_list.num_bds_table-1)) == 0)
+	else if ((end_bdi % (ep->bd_list.num_bds_table-1)) == 0)
 		end_bdi--;
 
 	return end_bdi;
@@ -795,7 +795,7 @@ static int ep_dequeue(struct bdc_ep *ep, struct bdc_req *req)
 			start_pending = true;
 			end_pending = true;
 		} else if (end_bdi >= curr_hw_dqpi || end_bdi <= eqp_bdi) {
-				end_pending = true;
+			end_pending = true;
 		}
 	} else {
 		if (start_bdi >= curr_hw_dqpi) {
-- 
2.18.0

