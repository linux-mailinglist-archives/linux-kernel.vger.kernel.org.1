Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE22A10FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJ3Wkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:40:37 -0400
Received: from mail.msweet.org ([173.255.209.91]:57360 "EHLO mail.msweet.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ3Wkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:40:37 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2020 18:40:37 EDT
Received: from mbp16-ubuntu-lts (host-24-231-71-254.public.eastlink.ca [24.231.71.254])
        by mail.msweet.org (Postfix) with ESMTPSA id 1B5CF820E3;
        Fri, 30 Oct 2020 22:34:27 +0000 (UTC)
From:   Michael R Sweet <msweet@msweet.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, msweet@msweet.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix default q_len for usb_f_printer gadget driver
Date:   Fri, 30 Oct 2020 18:34:19 -0400
Message-Id: <20201030223419.3780-1-msweet@msweet.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_f_printer gadget driver uses a default q_len value of *0* which prevents
any IO from occurring.  Moreover, once the driver is instantiated it is
impossible to change the q_len value.

The following patch uses a default q_len value of 10 which matches the legacy
g_printer gadget driver.  This minimizes the possibility that you end up with a
non-working printer gadget.  It is still possible to set the q_len to a
different value using the configfs path of the same name.

Signed-off-by: Michael R Sweet <msweet@msweet.org>
---
 drivers/usb/gadget/function/f_printer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 9c7ed2539ff7..4f3161005e4f 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -50,6 +50,8 @@
 #define GET_PORT_STATUS		1
 #define SOFT_RESET		2
 
+#define DEFAULT_Q_LEN		10 /* same as legacy g_printer gadget */
+
 static int major, minors;
 static struct class *usb_gadget_class;
 static DEFINE_IDA(printer_ida);
@@ -1317,6 +1319,9 @@ static struct usb_function_instance *gprinter_alloc_inst(void)
 	opts->func_inst.free_func_inst = gprinter_free_inst;
 	ret = &opts->func_inst;
 
+	/* Make sure q_len is initialized, otherwise the bound device can't support read/write! */
+	opts->q_len = DEFAULT_Q_LEN;
+
 	mutex_lock(&printer_ida_lock);
 
 	if (ida_is_empty(&printer_ida)) {
-- 
2.17.1

