Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39B42E69A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgL1RTG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Dec 2020 12:19:06 -0500
Received: from mail.msweet.org ([173.255.209.91]:54870 "EHLO mail.msweet.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbgL1RTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:19:06 -0500
Received: from [10.0.1.64] (host-148-170-144-200.public.eastlink.ca [148.170.144.200])
        by mail.msweet.org (Postfix) with ESMTPSA id 9EE5E81BF3;
        Mon, 28 Dec 2020 17:18:25 +0000 (UTC)
From:   Michael R Sweet <msweet@msweet.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: [PATCH] Fix default q_len for usb_f_printer gadget driver
Message-Id: <9DFB1605-63A5-46DB-A5A4-B59B315D8115@msweet.org>
Date:   Mon, 28 Dec 2020 12:18:24 -0500
Cc:     Michael Sweet <msweet@msweet.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
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

