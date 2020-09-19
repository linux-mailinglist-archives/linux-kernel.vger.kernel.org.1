Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B81270A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgISCwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:52:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgISCvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A0565A4C615191914BA;
        Sat, 19 Sep 2020 10:51:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:36 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Sylvain Lemieux" <slemieux.tyco@gmail.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] usb: gadget: lpc32xx_udc: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:52:08 +0800
Message-ID: <20200919025208.17863-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/usb/gadget/udc/lpc32xx_udc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index e8a4637a9..3f1c62adc 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -495,7 +495,7 @@ static void proc_ep_show(struct seq_file *s, struct lpc32xx_ep *ep)
 	}
 }
 
-static int proc_udc_show(struct seq_file *s, void *unused)
+static int udc_show(struct seq_file *s, void *unused)
 {
 	struct lpc32xx_udc *udc = s->private;
 	struct lpc32xx_ep *ep;
@@ -524,22 +524,11 @@ static int proc_udc_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int proc_udc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_udc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations proc_ops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_udc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(udc);
 
 static void create_debug_file(struct lpc32xx_udc *udc)
 {
-	udc->pde = debugfs_create_file(debug_filename, 0, NULL, udc, &proc_ops);
+	udc->pde = debugfs_create_file(debug_filename, 0, NULL, udc, &udc_fops);
 }
 
 static void remove_debug_file(struct lpc32xx_udc *udc)
-- 
2.23.0

