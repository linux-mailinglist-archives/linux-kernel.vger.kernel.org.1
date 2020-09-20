Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6566271774
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgITTVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:21:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46489 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726126AbgITTVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:21:15 -0400
Received: (qmail 1191691 invoked by uid 1000); 20 Sep 2020 15:21:14 -0400
Date:   Sun, 20 Sep 2020 15:21:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     yasushi asano <yazzep@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew_gabbasov@mentor.com, Baxter Jim <jim_baxter@mentor.com>,
        "Natsume, Wataru \(ADITJ/SWG\)" <wnatsume@jp.adit-jv.com>,
        "Nishiguchi, Naohiro \(ADITJ/SWG\)" <nnishiguchi@jp.adit-jv.com>,
        =?utf-8?B?5rWF6YeO5oGt5Y+y?= <yasano@jp.adit-jv.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Martin Mueller <Martin.Mueller5@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3] USB: hub.c: decrease the number of attempts of
 enumeration scheme
Message-ID: <20200920192114.GB1190206@rowland.harvard.edu>
References: <20200907155052.2450-2-yazzep@gmail.com>
 <20200908190402.GA797206@rowland.harvard.edu>
 <CAEt1RjquJZzTctN6dNQSDbUZ9YG2FnEtzTZsoA3a9RtXHxwUmA@mail.gmail.com>
 <CAEt1RjpGcZ4T70tr83pmcD--PzAMboBkbv55qFcRfMz11ZUggw@mail.gmail.com>
 <20200911151228.GA883311@rowland.harvard.edu>
 <20200915094531.GA8046@lxhi-065.adit-jv.com>
 <20200915110111.GA269380@kroah.com>
 <20200915145258.GC1002979@rowland.harvard.edu>
 <CAEt1Rjop72j8Hb8s+yW5edfF0+dSV2DQHtqsPoK65QQ-+HRwZg@mail.gmail.com>
 <CAEt1RjpNHPuV8T2ufkHw4hk9otJXKdm-mAddxHCir6_+q2tXvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEt1RjpNHPuV8T2ufkHw4hk9otJXKdm-mAddxHCir6_+q2tXvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 12:00:10AM +0900, yasushi asano wrote:
> Dear Alan,
> Could you please proceed with your proposal(Kconfig option)?
> After all, Customer products need to get USB certification.
> Thank you for considering my request.

The patch is below.  It is simpler than what we were looking at before, 
more like what you were working on originally.

This actually is a combination of two separate patches, one to replace 
SET_CONFIG_TRIES with PORT_INIT_TRIES and improve use_new_scheme(), the 
other to add the USB_FEW_INIT_RETRIES Kconfig option.  Even so, it's not 
very complicated.

Alan Stern


Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -2705,11 +2705,18 @@ static unsigned hub_is_wusb(struct usb_h
 }
 
 
+#ifdef CONFIG_USB_FEW_INIT_RETRIES
+#define PORT_RESET_TRIES	2
+#define SET_ADDRESS_TRIES	1
+#define GET_DESCRIPTOR_TRIES	1
+#define PORT_INIT_TRIES		5
+
+#else
 #define PORT_RESET_TRIES	5
 #define SET_ADDRESS_TRIES	2
 #define GET_DESCRIPTOR_TRIES	2
-#define SET_CONFIG_TRIES	(2 * (use_both_schemes + 1))
-#define USE_NEW_SCHEME(i, scheme)	((i) / 2 == (int)(scheme))
+#define PORT_INIT_TRIES		4
+#endif	/* CONFIG_USB_FEW_INIT_RETRIES */
 
 #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
 #define HUB_SHORT_RESET_TIME	10
@@ -2717,23 +2724,31 @@ static unsigned hub_is_wusb(struct usb_h
 #define HUB_LONG_RESET_TIME	200
 #define HUB_RESET_TIMEOUT	800
 
-/*
- * "New scheme" enumeration causes an extra state transition to be
- * exposed to an xhci host and causes USB3 devices to receive control
- * commands in the default state.  This has been seen to cause
- * enumeration failures, so disable this enumeration scheme for USB3
- * devices.
- */
 static bool use_new_scheme(struct usb_device *udev, int retry,
 			   struct usb_port *port_dev)
 {
 	int old_scheme_first_port =
-		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
+		(port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME) ||
+		old_scheme_first;
 
+	/*
+	 * "New scheme" enumeration causes an extra state transition to be
+	 * exposed to an xhci host and causes USB3 devices to receive control
+	 * commands in the default state.  This has been seen to cause
+	 * enumeration failures, so disable this enumeration scheme for USB3
+	 * devices.
+	 */
 	if (udev->speed >= USB_SPEED_SUPER)
 		return false;
 
-	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
+	/*
+	 * If use_both_schemes is set, use the first scheme (whichever
+	 * it is) for the larger half of the retries, then use the other
+	 * scheme.  Otherwise, use the first scheme for all the retries.
+	 */
+	if (use_both_schemes && retry >= (PORT_INIT_TRIES + 1) / 2)
+		return old_scheme_first_port;	/* Second half */
+	return !old_scheme_first_port;		/* First half or all */
 }
 
 /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
@@ -4545,6 +4560,7 @@ hub_port_init(struct usb_hub *hub, struc
 	const char		*speed;
 	int			devnum = udev->devnum;
 	const char		*driver_name;
+	bool			do_new_scheme;
 
 	/* root hub ports have a slightly longer reset period
 	 * (from USB 2.0 spec, section 7.1.7.5)
@@ -4657,14 +4673,13 @@ hub_port_init(struct usb_hub *hub, struc
 	 * first 8 bytes of the device descriptor to get the ep0 maxpacket
 	 * value.
 	 */
-	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
-		bool did_new_scheme = false;
+	do_new_scheme = use_new_scheme(udev, retry_counter, port_dev);
 
-		if (use_new_scheme(udev, retry_counter, port_dev)) {
+	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
+		if (do_new_scheme) {
 			struct usb_device_descriptor *buf;
 			int r = 0;
 
-			did_new_scheme = true;
 			retval = hub_enable_device(udev);
 			if (retval < 0) {
 				dev_err(&udev->dev,
@@ -4773,11 +4788,7 @@ hub_port_init(struct usb_hub *hub, struc
 			 *  - read ep0 maxpacket even for high and low speed,
 			 */
 			msleep(10);
-			/* use_new_scheme() checks the speed which may have
-			 * changed since the initial look so we cache the result
-			 * in did_new_scheme
-			 */
-			if (did_new_scheme)
+			if (do_new_scheme)
 				break;
 		}
 
@@ -5106,7 +5117,7 @@ static void hub_port_connect(struct usb_
 		unit_load = 100;
 
 	status = 0;
-	for (i = 0; i < SET_CONFIG_TRIES; i++) {
+	for (i = 0; i < PORT_INIT_TRIES; i++) {
 
 		/* reallocate for each attempt, since references
 		 * to the previous one can escape in various ways
@@ -5239,7 +5250,7 @@ loop:
 			break;
 
 		/* When halfway through our retry count, power-cycle the port */
-		if (i == (SET_CONFIG_TRIES / 2) - 1) {
+		if (i == (PORT_INIT_TRIES / 2) - 1) {
 			dev_info(&port_dev->dev, "attempt power cycle\n");
 			usb_hub_set_port_power(hdev, hub, port1, false);
 			msleep(2 * hub_power_on_good_delay(hub));
@@ -5770,7 +5781,7 @@ static int usb_reset_and_verify_device(s
 	bos = udev->bos;
 	udev->bos = NULL;
 
-	for (i = 0; i < SET_CONFIG_TRIES; ++i) {
+	for (i = 0; i < PORT_INIT_TRIES; ++i) {
 
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
Index: usb-devel/drivers/usb/core/Kconfig
===================================================================
--- usb-devel.orig/drivers/usb/core/Kconfig
+++ usb-devel/drivers/usb/core/Kconfig
@@ -32,6 +32,20 @@ config USB_DEFAULT_PERSIST
 	  If you have any questions about this, say Y here, only say N
 	  if you know exactly what you are doing.
 
+config USB_FEW_INIT_RETRIES
+	bool "Limit USB device initialization to only a few retries"
+	help
+	  When a new USB device is detected, the kernel tries very hard
+	  to initialize and enumerate it, with lots of nested retry loops.
+	  This almost always works, but when it fails it can take a long time.
+	  This option tells the kernel to make only a few retry attempts,
+	  so that the total time required for a failed initialization is
+	  no more than 30 seconds (as required by the USB OTG spec).
+
+	  Say N here unless you require new-device enumeration failure to
+	  occur within 30 seconds (as might be needed in an embedded
+	  application).
+
 config USB_DYNAMIC_MINORS
 	bool "Dynamic USB minor allocation"
 	help

