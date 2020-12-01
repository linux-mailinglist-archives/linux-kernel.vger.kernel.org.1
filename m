Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC152CA22C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgLAMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbgLAMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:09:56 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2867E2080A;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=PXD2xWkrST4pHPka0zn/K0x+7DjY8Pl/j9RxoYjRIFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNXh4h8Y9SeKDuVhkgV3+5QH3c6Hc/h8/w4LQTKGNBhXJUtrWxq3KS9A6SFcs8cOI
         OqX2WktS4EYf+nrUaSHsSV4GT0jzqsn5Lnei4HkTuPoIvwT/eVlIEVNFUXy6Zq73ku
         fk7vfNSotYJFl95jCcYp5s8+IG9Fxl7ixYgTWmH8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T2-00DGcy-TR; Tue, 01 Dec 2020 13:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/16] parport: fix a kernel-doc markup
Date:   Tue,  1 Dec 2020 13:08:56 +0100
Message-Id: <77c8069df24d47ff970caad5dc7f989a2270f5f2.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
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
@@ -214,65 +214,65 @@ static void get_lowlevel_driver(void)
 	request_module("parport_lowlevel");
 }
 
 /*
  * iterates through all the devices connected to the bus and sends the device
  * details to the match_port callback of the driver, so that the driver can
  * know what are all the ports that are connected to the bus and choose the
  * port to which it wants to register its device.
  */
 static int port_check(struct device *dev, void *dev_drv)
 {
 	struct parport_driver *drv = dev_drv;
 
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
  *
  *	The driver's detach() function may block.  The port that
  *	detach() is given will be valid for the duration of the
  *	callback, but if the driver wants to take a copy of the
  *	pointer it must call parport_get_port() to do so.
  *
  *
  *	Returns 0 on success. The non device model will always succeeds.
  *	but the new device model can fail and will return the error code.
  **/
 
 int __parport_register_driver(struct parport_driver *drv, struct module *owner,
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 1fb508c19e83..f981f794c850 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -268,64 +268,95 @@ struct parport_driver {
 
 #define to_parport_driver(n) container_of(n, struct parport_driver, driver)
 
 int parport_bus_init(void);
 void parport_bus_exit(void);
 
 /* parport_register_port registers a new parallel port at the given
    address (if one does not already exist) and returns a pointer to it.
    This entails claiming the I/O region, IRQ and DMA.  NULL is returned
    if initialisation fails. */
 struct parport *parport_register_port(unsigned long base, int irq, int dma,
 				      struct parport_operations *ops);
 
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
 
 struct pardev_cb {
 	int (*preempt)(void *);
 	void (*wakeup)(void *);
 	void *private;
 	void (*irq_func)(void *);
 	unsigned int flags;
 };
 
 /*
  * parport_register_dev_model declares that a device is connected to a
  * port, and tells the kernel all it needs to know.
  */
-- 
2.28.0

