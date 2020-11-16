Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6532B40D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgKPKSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgKPKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:29 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F21F221F9;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=P/GEMxeGxaldEqXRpO9YI9VDpRvjUfzifZKnsBkxW1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVwCjgBYVSGPj3Fcnxmqr5wYdqiMZUTXA2kTlLzwUltx4ISicjk/j4+hkoKrFdMMK
         9s6AYnsHcALnFl9bmipHM+bUy4IiFsTU7xR2lsv2GhE8BqzBhInhKxCpqBD4rJWEu+
         iMv2NQLyHYwENu4XKdRb7vnXv3OuTNYpMd+nmoM4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwE7-51; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/27] parport: fix a kernel-doc markup
Date:   Mon, 16 Nov 2020 11:18:04 +0100
Message-Id: <a97c59a840d26ea41c4bf38154f23e06871aac43.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc markup inside share.c is actually for
__parport_register_driver. The actual goal seems to be
to document parport_register_driver().

So, fix the existing markup and add a new one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/parport/share.c |  2 +-
 include/linux/parport.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 7fec4fefe151..62f8407923d4 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -226,41 +226,41 @@ static int port_check(struct device *dev, void *dev_drv)
 
 	/* only send ports, do not send other devices connected to bus */
 	if (is_parport(dev))
 		drv->match_port(to_parport_dev(dev));
 	return 0;
 }
 
 /*
  * Iterates through all the devices connected to the bus and return 1
  * if the device is a parallel port.
  */
 
 static int port_detect(struct device *dev, void *dev_drv)
 {
 	if (is_parport(dev))
 		return 1;
 	return 0;
 }
 
 /**
- *	parport_register_driver - register a parallel port device driver
+ *	__parport_register_driver - register a parallel port device driver
  *	@drv: structure describing the driver
  *	@owner: owner module of drv
  *	@mod_name: module name string
  *
  *	This can be called by a parallel port device driver in order
  *	to receive notifications about ports being found in the
  *	system, as well as ports no longer available.
  *
  *	If devmodel is true then the new device model is used
  *	for registration.
  *
  *	The @drv structure is allocated by the caller and must not be
  *	deallocated until after calling parport_unregister_driver().
  *
  *	If using the non device model:
  *	The driver's attach() function may block.  The port that
  *	attach() is given will be valid for the duration of the
  *	callback, but if the driver wants to take a copy of the
  *	pointer it must call parport_get_port() to do so.  Calling
  *	parport_register_device() on that port will do this for you.
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 1fb508c19e83..f981f794c850 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -280,40 +280,71 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 
 /* Once a registered port is ready for high-level drivers to use, the
    low-level driver that registered it should announce it.  This will
    call the high-level drivers' attach() functions (after things like
    determining the IEEE 1284.3 topology of the port and collecting
    DeviceIDs). */
 void parport_announce_port (struct parport *port);
 
 /* Unregister a port. */
 extern void parport_remove_port(struct parport *port);
 
 /* Register a new high-level driver. */
 
 int __must_check __parport_register_driver(struct parport_driver *,
 					   struct module *,
 					   const char *mod_name);
 /*
  * parport_register_driver must be a macro so that KBUILD_MODNAME can
  * be expanded
  */
+
+/**
+ *	parport_register_driver - register a parallel port device driver
+ *	@driver: structure describing the driver
+ *
+ *	This can be called by a parallel port device driver in order
+ *	to receive notifications about ports being found in the
+ *	system, as well as ports no longer available.
+ *
+ *	If devmodel is true then the new device model is used
+ *	for registration.
+ *
+ *	The @driver structure is allocated by the caller and must not be
+ *	deallocated until after calling parport_unregister_driver().
+ *
+ *	If using the non device model:
+ *	The driver's attach() function may block.  The port that
+ *	attach() is given will be valid for the duration of the
+ *	callback, but if the driver wants to take a copy of the
+ *	pointer it must call parport_get_port() to do so.  Calling
+ *	parport_register_device() on that port will do this for you.
+ *
+ *	The driver's detach() function may block.  The port that
+ *	detach() is given will be valid for the duration of the
+ *	callback, but if the driver wants to take a copy of the
+ *	pointer it must call parport_get_port() to do so.
+ *
+ *
+ *	Returns 0 on success. The non device model will always succeeds.
+ *	but the new device model can fail and will return the error code.
+ **/
 #define parport_register_driver(driver)             \
 	__parport_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 
 /* Unregister a high-level driver. */
 extern void parport_unregister_driver (struct parport_driver *);
 void parport_unregister_driver(struct parport_driver *);
 
 /* If parport_register_driver doesn't fit your needs, perhaps
  * parport_find_xxx does. */
 extern struct parport *parport_find_number (int);
 extern struct parport *parport_find_base (unsigned long);
 
 /* generic irq handler, if it suits your needs */
 extern irqreturn_t parport_irq_handler(int irq, void *dev_id);
 
 /* Reference counting for ports. */
 extern struct parport *parport_get_port (struct parport *);
 extern void parport_put_port (struct parport *);
 void parport_del_port(struct parport *);
 
-- 
2.28.0

