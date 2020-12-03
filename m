Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4F2CE0A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501884AbgLCV1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgLCV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:27:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61FC061A54;
        Thu,  3 Dec 2020 13:27:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lt17so5686390ejb.3;
        Thu, 03 Dec 2020 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAdNWz5RwWyZCboP7xVGzn6pU58fb+AV3gsGOh/QivI=;
        b=P1Rc2UEAuDZAZRjisBrhzbCa8xW9OZT7u4KgAvFoS0bZMS2i5mTCh7fth7RAu2Q9P1
         +zADqT7ZMFXxmI49T3S9uWEZbpqf0y7Qt1KHRsdOB/eDI7i6wjQ8F7oOhc16IdW9W4iQ
         RLBRU6MJSPIbkxAb0TMjsVLBP+QswzEDs4a7hB4a198LfKhFdERspIpP/ptILhA2p0+d
         7+kiOWWBxErpxtMk0mqjakQGLilunq0Md8n/oX56Af5jnhqj/XQmk88Dxwj6VAJhOgmD
         IkRIbYkK39Q+zm0O7lDcucK26mmJ7DAwYQNwnKnySXmkIV2pfF0ty59fOortufnFfHj0
         PsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAdNWz5RwWyZCboP7xVGzn6pU58fb+AV3gsGOh/QivI=;
        b=FvYebCFAsfQUEB5cU/pdf9fGQdTr3KTnFaq2vA+QzEF+fw9acvIo2Xw5q5p0LSQHoE
         BbirQJL4XdNRxODBjdoL9V9J1JD5Yu/She6trhA8uWcgQx3RL6xw1RfjefK7uutdJ/pG
         Nd+FgX13sfxjso8YSyBD0sdnVZT47eJ30xHzLnS2P93z6BDuQSulepzBhQ/Pm2QlkmKS
         eaFUoi8fZHWWbeUZVV7D+8RvYMzHUIMgpS7RCrKxW/6GbIHuxIlxtdd3uctlWuHh4yTH
         6x5CPRtWLMypBbtUiUsKXuRWr3DrFygZIpJ51+0ktO8GALQVF7AQUVlAkpgSurghhYH4
         U0cA==
X-Gm-Message-State: AOAM530nzUvwWBltjRchnAWhiD2PtgiT7dU3K9BvSAwzJWT6FJxagr2e
        x5Sb4L1/PEhVk5DSjHDyF20ClgvudYc=
X-Google-Smtp-Source: ABdhPJzpdWkZrpQHloM1QKRyGukCUJfzfLy/UBNYq8lJ455SLgIuhJbEZXOZRPVR5Q+zb+pKK4NPtA==
X-Received: by 2002:a17:907:3e85:: with SMTP id hs5mr4457841ejc.548.1607030820195;
        Thu, 03 Dec 2020 13:27:00 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:26:58 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/9] platform/surface: Add Surface Aggregator subsystem
Date:   Thu,  3 Dec 2020 22:26:32 +0100
Message-Id: <20201203212640.663931-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Surface System Aggregator Module core and Surface Serial Hub driver,
required for the embedded controller found on Microsoft Surface devices.

The Surface System Aggregator Module (SSAM, SAM or Surface Aggregator)
is an embedded controller (EC) found on 4th and later generation
Microsoft Surface devices, with the exception of the Surface Go series.
This EC provides various functionality, depending on the device in
question. This can include battery status and thermal reporting (5th and
later generations), but also HID keyboard (6th+) and touchpad input
(7th+) on Surface Laptop and Surface Book 3 series devices.

This patch provides the basic necessities for communication with the SAM
EC on 5th and later generation devices. On these devices, the EC
provides an interface that acts as serial device, called the Surface
Serial Hub (SSH). 4th generation devices, on which the EC interface is
provided via an HID-over-I2C device, are not supported by this patch.

Specifically, this patch adds a driver for the SSH device (device HID
MSHW0084 in ACPI), as well as a controller structure and associated API.
This represents the functional core of the Surface Aggregator kernel
subsystem, introduced with this patch, and will be expanded upon in
subsequent commits.

The SSH driver acts as the main attachment point for this subsystem and
sets-up and manages the controller structure. The controller in turn
provides a basic communication interface, allowing to send requests from
host to EC and receiving the corresponding responses, as well as
managing and receiving events, sent from EC to host. It is structured
into multiple layers, with the top layer presenting the API used by
other kernel drivers and the lower layers modeled after the serial
protocol used for communication.

Said other drivers are then responsible for providing the (Surface model
specific) functionality accessible through the EC (e.g. battery status
reporting, thermal information, ...) via said controller structure and
API, and will be added in future commits.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v1 (from RFC):
 - add copyright lines
 - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
 - fix bug in __ssh_ptl_queue_push, potentially leading to a deadlock
   in high-traffic situations
 - remove unnecessary READ_ONCE on multiple occasions
 - add NULL checks for ssh_packet_get, ssh_packet_put
 - add NULL checks for ssh_request_get, ssh_request_put
 - guard dev_pm_ops with CONFIG_PM_SLEEP check
 - mark struct ssam_request pointer as const when possible
 - introduce generic retry macro with defaults
 - retry base controller requests on failure

Changes in v2:
 - add transmission timeout for packets
 - simplify acknowledgment timeout implementation
 - simplify packet ACK handling
 - restructure and simplify transmitter thread function
 - restructure SSH message building
 - switch to explicit RCU list for event notifiers
 - use sysfs_emit for sysfs attributes
 - fix memory leak on event item submission failure
 - fix unaligned length access in parser
 - use printk specifier for hex prefix instead of hard-coding it
 - use numeric limit macros instead of casting around '-1'
 - extract and document magic values
 - try to make return values more consistent
 - spell check comments and strings, fix typos
 - unify comment style
 - run checkpatch --strict, fix these and other style issues
 - improve comments/documentation

---
 MAINTAINERS                                   |    8 +
 drivers/platform/surface/Kconfig              |    2 +
 drivers/platform/surface/Makefile             |    1 +
 drivers/platform/surface/aggregator/Kconfig   |   43 +
 drivers/platform/surface/aggregator/Makefile  |   10 +
 .../platform/surface/aggregator/controller.c  | 2468 +++++++++++++++++
 .../platform/surface/aggregator/controller.h  |  276 ++
 drivers/platform/surface/aggregator/core.c    |  781 ++++++
 .../platform/surface/aggregator/ssh_msgb.h    |  205 ++
 .../surface/aggregator/ssh_packet_layer.c     | 1699 ++++++++++++
 .../surface/aggregator/ssh_packet_layer.h     |  187 ++
 .../platform/surface/aggregator/ssh_parser.c  |  228 ++
 .../platform/surface/aggregator/ssh_parser.h  |  154 +
 .../surface/aggregator/ssh_request_layer.c    | 1203 ++++++++
 .../surface/aggregator/ssh_request_layer.h    |  143 +
 include/linux/surface_aggregator/controller.h |  824 ++++++
 include/linux/surface_aggregator/serial_hub.h |  672 +++++
 17 files changed, 8904 insertions(+)
 create mode 100644 drivers/platform/surface/aggregator/Kconfig
 create mode 100644 drivers/platform/surface/aggregator/Makefile
 create mode 100644 drivers/platform/surface/aggregator/controller.c
 create mode 100644 drivers/platform/surface/aggregator/controller.h
 create mode 100644 drivers/platform/surface/aggregator/core.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
 create mode 100644 include/linux/surface_aggregator/controller.h
 create mode 100644 include/linux/surface_aggregator/serial_hub.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bb4604e64b4a..64730461f4df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11692,6 +11692,14 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/surface/surfacepro3_button.c

+MICROSOFT SURFACE SYSTEM AGGREGATOR SUBSYSTEM
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+S:	Maintained
+W:	https://github.com/linux-surface/surface-aggregator-module
+C:	irc://chat.freenode.net/##linux-surface
+F:	drivers/platform/surface/aggregator/
+F:	include/linux/surface_aggregator/
+
 MICROTEK X6 SCANNER
 M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 33040b0b3b79..5af22f5141ff 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -56,4 +56,6 @@ config SURFACE_PRO3_BUTTON
 	help
 	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.

+source "drivers/platform/surface/aggregator/Kconfig"
+
 endif # SURFACE_PLATFORMS
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index cedfb027ded1..034134fe0264 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -7,5 +7,6 @@
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
+obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
new file mode 100644
index 000000000000..ce34941ef91b
--- /dev/null
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+
+menuconfig SURFACE_AGGREGATOR
+	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
+	depends on SERIAL_DEV_BUS
+	depends on ACPI
+	select CRC_CCITT
+	help
+	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
+	  embedded controller (EC) found on 5th- and later-generation Microsoft
+	  Surface devices (i.e. Surface Pro 5, Surface Book 2, Surface Laptop,
+	  and newer, with exception of Surface Go series devices).
+
+	  Depending on the device in question, this EC provides varying
+	  functionality, including:
+	  - EC access from ACPI via Surface ACPI Notify (5th- and 6th-generation)
+	  - battery status information (all devices)
+	  - thermal sensor access (all devices)
+	  - performance mode / cooling mode control (all devices)
+	  - clipboard detachment system control (Surface Book 2 and 3)
+	  - HID / keyboard input (Surface Laptops, Surface Book 3)
+
+	  This option controls whether the Surface SAM subsystem core will be
+	  built. This includes a driver for the Surface Serial Hub (SSH), which
+	  is the device responsible for the communication with the EC, and a
+	  basic kernel interface exposing the EC functionality to other client
+	  drivers, i.e. allowing them to make requests to the EC and receive
+	  events from it. Selecting this option alone will not provide any
+	  client drivers and therefore no functionality beyond the in-kernel
+	  interface. Said functionality is the responsibility of the respective
+	  client drivers.
+
+	  Note: While 4th-generation Surface devices also make use of a SAM EC,
+	  due to a difference in the communication interface of the controller,
+	  only 5th and later generations are currently supported. Specifically,
+	  devices using SAM-over-SSH are supported, whereas devices using
+	  SAM-over-HID, which is used on the 4th generation, are currently not
+	  supported.
+
+	  Choose m if you want to build the SAM subsystem core and SSH driver as
+	  module, y if you want to build it into the kernel and n if you don't
+	  want it at all.
diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
new file mode 100644
index 000000000000..faad18d4a7f2
--- /dev/null
+++ b/drivers/platform/surface/aggregator/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+
+obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
+
+surface_aggregator-objs := core.o
+surface_aggregator-objs += ssh_parser.o
+surface_aggregator-objs += ssh_packet_layer.o
+surface_aggregator-objs += ssh_request_layer.o
+surface_aggregator-objs += controller.o
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
new file mode 100644
index 000000000000..8d9811cc2943
--- /dev/null
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -0,0 +1,2468 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Main SSAM/SSH controller structure and functionality.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kref.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rculist.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/serial_hub.h>
+
+#include "controller.h"
+#include "ssh_msgb.h"
+#include "ssh_request_layer.h"
+
+
+/* -- Safe counters. -------------------------------------------------------- */
+
+/**
+ * ssh_seq_reset() - Reset/initialize sequence ID counter.
+ * @c: The counter to reset.
+ */
+static void ssh_seq_reset(struct ssh_seq_counter *c)
+{
+	WRITE_ONCE(c->value, 0);
+}
+
+/**
+ * ssh_seq_next() - Get next sequence ID.
+ * @c: The counter providing the sequence IDs.
+ *
+ * Return: Returns the next sequence ID of the counter.
+ */
+static u8 ssh_seq_next(struct ssh_seq_counter *c)
+{
+	u8 old = READ_ONCE(c->value);
+	u8 new = old + 1;
+	u8 ret;
+
+	while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
+		old = ret;
+		new = old + 1;
+	}
+
+	return old;
+}
+
+/**
+ * ssh_rqid_reset() - Reset/initialize request ID counter.
+ * @c: The counter to reset.
+ */
+static void ssh_rqid_reset(struct ssh_rqid_counter *c)
+{
+	WRITE_ONCE(c->value, 0);
+}
+
+/**
+ * ssh_rqid_next() - Get next request ID.
+ * @c: The counter providing the request IDs.
+ *
+ * Return: Returns the next request ID of the counter, skipping any reserved
+ * request IDs.
+ */
+static u16 ssh_rqid_next(struct ssh_rqid_counter *c)
+{
+	u16 old = READ_ONCE(c->value);
+	u16 new = ssh_rqid_next_valid(old);
+	u16 ret;
+
+	while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
+		old = ret;
+		new = ssh_rqid_next_valid(old);
+	}
+
+	return old;
+}
+
+
+/* -- Event notifier/callbacks. --------------------------------------------- */
+/*
+ * The notifier system is based on linux/notifier.h, specifically the SRCU
+ * implementation. The difference to that is, that some bits of the notifier
+ * call return value can be tracked across multiple calls. This is done so
+ * that handling of events can be tracked and a warning can be issued in case
+ * an event goes unhandled. The idea of that warning is that it should help
+ * discover and identify new/currently unimplemented features.
+ */
+
+/**
+ * ssam_event_matches_notifier() - Test if an event matches a notifier.
+ * @n: The event notifier to test against.
+ * @event: The event to test.
+ *
+ * Return: Returns %true iff the given event matches the given notifier
+ * according to the rules set in the notifier's event mask, %false otherwise.
+ */
+static bool ssam_event_matches_notifier(const struct ssam_event_notifier *n,
+					const struct ssam_event *event)
+{
+	bool match = n->event.id.target_category == event->target_category;
+
+	if (n->event.mask & SSAM_EVENT_MASK_TARGET)
+		match &= n->event.reg.target_id == event->target_id;
+
+	if (n->event.mask & SSAM_EVENT_MASK_INSTANCE)
+		match &= n->event.id.instance == event->instance_id;
+
+	return match;
+}
+
+/**
+ * ssam_nfblk_call_chain() - Call event notifier callbacks of the given chain.
+ * @nh:    The notifier head for which the notifier callbacks should be called.
+ * @event: The event data provided to the callbacks.
+ *
+ * Call all registered notifier callbacks in order of their priority until
+ * either no notifier is left or a notifier returns a value with the
+ * %SSAM_NOTIF_STOP bit set. Note that this bit is automatically set via
+ * ssam_notifier_from_errno() on any non-zero error value.
+ *
+ * Return: Returns the notifier status value, which contains the notifier
+ * status bits (%SSAM_NOTIF_HANDLED and %SSAM_NOTIF_STOP) as well as a
+ * potential error value returned from the last executed notifier callback.
+ * Use ssam_notifier_to_errno() to convert this value to the original error
+ * value.
+ */
+static int ssam_nfblk_call_chain(struct ssam_nf_head *nh, struct ssam_event *event)
+{
+	struct ssam_event_notifier *nf;
+	int ret = 0, idx;
+
+	idx = srcu_read_lock(&nh->srcu);
+
+	list_for_each_entry_rcu(nf, &nh->head, base.node) {
+		if (ssam_event_matches_notifier(nf, event)) {
+			ret = (ret & SSAM_NOTIF_STATE_MASK) | nf->base.fn(nf, event);
+			if (ret & SSAM_NOTIF_STOP)
+				break;
+		}
+	}
+
+	srcu_read_unlock(&nh->srcu, idx);
+	return ret;
+}
+
+/**
+ * ssam_nfblk_insert() - Insert a new notifier block into the given notifier
+ * list.
+ * @nh: The notifier head into which the block should be inserted.
+ * @nb: The notifier block to add.
+ *
+ * Note: This function must be synchronized by the caller with respect to other
+ * insert, find, and/or remove calls.
+ *
+ * Return: Returns zero on success, %-EEXIST if the notifier block has already
+ * been registered.
+ */
+static int ssam_nfblk_insert(struct ssam_nf_head *nh, struct ssam_notifier_block *nb)
+{
+	struct ssam_notifier_block *p;
+	struct list_head *h;
+
+	/* Runs under lock, no need for RCU variant. */
+	list_for_each(h, &nh->head) {
+		p = list_entry(h, struct ssam_notifier_block, node);
+
+		if (unlikely(p == nb)) {
+			WARN(1, "double register detected");
+			return -EEXIST;
+		}
+
+		if (nb->priority > p->priority)
+			break;
+	}
+
+	list_add_tail_rcu(&nb->node, h);
+	return 0;
+}
+
+/**
+ * ssam_nfblk_find() - Check if a notifier block is registered on the given
+ * notifier head.
+ * list.
+ * @nh: The notifier head on which to search.
+ * @nb: The notifier block to search for.
+ *
+ * Note: This function must be synchronized by the caller with respect to other
+ * insert, find, and/or remove calls.
+ *
+ * Return: Returns true if the given notifier block is registered on the given
+ * notifier head, false otherwise.
+ */
+static bool ssam_nfblk_find(struct ssam_nf_head *nh, struct ssam_notifier_block *nb)
+{
+	struct ssam_notifier_block *p;
+
+	/* Runs under lock, no need for RCU variant. */
+	list_for_each_entry(p, &nh->head, node) {
+		if (p == nb)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * ssam_nfblk_remove() - Remove a notifier block from its notifier list.
+ * @nb: The notifier block to be removed.
+ *
+ * Note: This function must be synchronized by the caller with respect to
+ * other insert, find and/or remove calls. The caller _must_ ensure SRCU
+ * synchronization by calling synchronize_srcu() with ``nh->srcu`` after
+ * leaving the critical section, to ensure that the removed notifier block is
+ * not in use any more.
+ */
+static void ssam_nfblk_remove(struct ssam_notifier_block *nb)
+{
+	list_del_rcu(&nb->node);
+}
+
+/**
+ * ssam_nf_head_init() - Initialize the given notifier head.
+ * @nh: The notifier head to initialize.
+ */
+static int ssam_nf_head_init(struct ssam_nf_head *nh)
+{
+	int status;
+
+	status = init_srcu_struct(&nh->srcu);
+	if (status)
+		return status;
+
+	INIT_LIST_HEAD(&nh->head);
+	return 0;
+}
+
+/**
+ * ssam_nf_head_destroy() - Deinitialize the given notifier head.
+ * @nh: The notifier head to deinitialize.
+ */
+static void ssam_nf_head_destroy(struct ssam_nf_head *nh)
+{
+	cleanup_srcu_struct(&nh->srcu);
+}
+
+
+/* -- Event/notification registry. ------------------------------------------ */
+
+/**
+ * struct ssam_nf_refcount_key - Key used for event activation reference
+ * counting.
+ * @reg: The registry via which the event is enabled/disabled.
+ * @id:  The ID uniquely describing the event.
+ */
+struct ssam_nf_refcount_key {
+	struct ssam_event_registry reg;
+	struct ssam_event_id id;
+};
+
+/**
+ * struct ssam_nf_refcount_entry - RB-tree entry for reference counting event
+ * activations.
+ * @node:     The node of this entry in the rb-tree.
+ * @key:      The key of the event.
+ * @refcount: The reference-count of the event.
+ * @flags:    The flags used when enabling the event.
+ */
+struct ssam_nf_refcount_entry {
+	struct rb_node node;
+	struct ssam_nf_refcount_key key;
+	int refcount;
+	u8 flags;
+};
+
+/**
+ * ssam_nf_refcount_inc() - Increment reference-/activation-count of the given
+ * event.
+ * @nf:  The notifier system reference.
+ * @reg: The registry used to enable/disable the event.
+ * @id:  The event ID.
+ *
+ * Increments the reference-/activation-count associated with the specified
+ * event type/ID, allocating a new entry for this event ID if necessary. A
+ * newly allocated entry will have a refcount of one.
+ *
+ * Note: Must be synchronized by the caller with regards to other
+ * ssam_nf_refcount_inc() and ssam_nf_refcount_dec() calls, e.g. via
+ * ``nf->lock``. Note that this lock should also be used to ensure the
+ * corresponding EC requests are sent, if necessary.
+ *
+ * Return: Returns the refcount entry on success. Returns an error pointer
+ * with %-ENOSPC if there have already been %INT_MAX events of the specified
+ * ID and type registered, or %-ENOMEM if the entry could not be allocated.
+ */
+static struct ssam_nf_refcount_entry
+*ssam_nf_refcount_inc(struct ssam_nf *nf, struct ssam_event_registry reg,
+		      struct ssam_event_id id)
+{
+	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_refcount_key key;
+	struct rb_node **link = &nf->refcount.rb_node;
+	struct rb_node *parent = NULL;
+	int cmp;
+
+	key.reg = reg;
+	key.id = id;
+
+	while (*link) {
+		entry = rb_entry(*link, struct ssam_nf_refcount_entry, node);
+		parent = *link;
+
+		cmp = memcmp(&key, &entry->key, sizeof(key));
+		if (cmp < 0) {
+			link = &(*link)->rb_left;
+		} else if (cmp > 0) {
+			link = &(*link)->rb_right;
+		} else if (entry->refcount < INT_MAX) {
+			entry->refcount++;
+			return entry;
+		} else {
+			return ERR_PTR(-ENOSPC);
+		}
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->key = key;
+	entry->refcount = 1;
+
+	rb_link_node(&entry->node, parent, link);
+	rb_insert_color(&entry->node, &nf->refcount);
+
+	return entry;
+}
+
+/**
+ * ssam_nf_refcount_dec() - Decrement reference-/activation-count of the given
+ * event.
+ * @nf:  The notifier system reference.
+ * @reg: The registry used to enable/disable the event.
+ * @id:  The event ID.
+ *
+ * Decrements the reference-/activation-count of the specified event,
+ * returning its entry. If the returned entry has a refcount of zero, the
+ * caller is responsible for freeing it using kfree().
+ *
+ * Note: Must be synchronized by the caller with regards to other
+ * ssam_nf_refcount_inc() and ssam_nf_refcount_dec() calls, e.g. via
+ * ``nf->lock``. Note that this lock should also be used to ensure the
+ * corresponding EC requests are sent, if necessary.
+ *
+ * Return: Returns the refcount entry on success or %NULL if the entry has not
+ * been found.
+ */
+static struct ssam_nf_refcount_entry
+*ssam_nf_refcount_dec(struct ssam_nf *nf, struct ssam_event_registry reg,
+		      struct ssam_event_id id)
+{
+	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_refcount_key key;
+	struct rb_node *node = nf->refcount.rb_node;
+	int cmp;
+
+	key.reg = reg;
+	key.id = id;
+
+	while (node) {
+		entry = rb_entry(node, struct ssam_nf_refcount_entry, node);
+
+		cmp = memcmp(&key, &entry->key, sizeof(key));
+		if (cmp < 0) {
+			node = node->rb_left;
+		} else if (cmp > 0) {
+			node = node->rb_right;
+		} else {
+			entry->refcount--;
+			if (entry->refcount == 0)
+				rb_erase(&entry->node, &nf->refcount);
+
+			return entry;
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * ssam_nf_refcount_empty() - Test if the notification system has any
+ * enabled/active events.
+ * @nf: The notification system.
+ */
+static bool ssam_nf_refcount_empty(struct ssam_nf *nf)
+{
+	return RB_EMPTY_ROOT(&nf->refcount);
+}
+
+/**
+ * ssam_nf_call() - Call notification callbacks for the provided event.
+ * @nf:    The notifier system
+ * @dev:   The associated device, only used for logging.
+ * @rqid:  The request ID of the event.
+ * @event: The event provided to the callbacks.
+ *
+ * Execute registered callbacks in order of their priority until either no
+ * callback is left or a callback returns a value with the %SSAM_NOTIF_STOP
+ * bit set. Note that this bit is set automatically when converting non-zero
+ * error values via ssam_notifier_from_errno() to notifier values.
+ *
+ * Also note that any callback that could handle an event should return a value
+ * with bit %SSAM_NOTIF_HANDLED set, indicating that the event does not go
+ * unhandled/ignored. In case no registered callback could handle an event,
+ * this function will emit a warning.
+ *
+ * In case a callback failed, this function will emit an error message.
+ */
+static void ssam_nf_call(struct ssam_nf *nf, struct device *dev, u16 rqid,
+			 struct ssam_event *event)
+{
+	struct ssam_nf_head *nf_head;
+	int status, nf_ret;
+
+	if (!ssh_rqid_is_event(rqid)) {
+		dev_warn(dev, "event: unsupported rqid: %#06x\n", rqid);
+		return;
+	}
+
+	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
+	nf_ret = ssam_nfblk_call_chain(nf_head, event);
+	status = ssam_notifier_to_errno(nf_ret);
+
+	if (status < 0) {
+		dev_err(dev,
+			"event: error handling event: %d (tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
+			status, event->target_category, event->target_id,
+			event->command_id, event->instance_id);
+	}
+
+	if (!(nf_ret & SSAM_NOTIF_HANDLED)) {
+		dev_warn(dev,
+			 "event: unhandled event (rqid: %#04x, tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
+			 rqid, event->target_category, event->target_id,
+			 event->command_id, event->instance_id);
+	}
+}
+
+/**
+ * ssam_nf_init() - Initialize the notifier system.
+ * @nf: The notifier system to initialize.
+ */
+static int ssam_nf_init(struct ssam_nf *nf)
+{
+	int i, status;
+
+	for (i = 0; i < SSH_NUM_EVENTS; i++) {
+		status = ssam_nf_head_init(&nf->head[i]);
+		if (status)
+			break;
+	}
+
+	if (status) {
+		while (i--)
+			ssam_nf_head_destroy(&nf->head[i]);
+
+		return status;
+	}
+
+	mutex_init(&nf->lock);
+	return 0;
+}
+
+/**
+ * ssam_nf_destroy() - Deinitialize the notifier system.
+ * @nf: The notifier system to deinitialize.
+ */
+static void ssam_nf_destroy(struct ssam_nf *nf)
+{
+	int i;
+
+	for (i = 0; i < SSH_NUM_EVENTS; i++)
+		ssam_nf_head_destroy(&nf->head[i]);
+
+	mutex_destroy(&nf->lock);
+}
+
+
+/* -- Event/async request completion system. -------------------------------- */
+
+#define SSAM_CPLT_WQ_NAME	"ssam_cpltq"
+
+/*
+ * SSAM_CPLT_WQ_BATCH - Maximum number of event item completions executed per
+ * work execution. Used to prevent livelocking of the workqueue. Value chosen
+ * via educated guess, may be adjusted.
+ */
+#define SSAM_CPLT_WQ_BATCH	10
+
+/**
+ * ssam_event_item_alloc() - Allocate an event item with the given payload size.
+ * @len:   The event payload length.
+ * @flags: The flags used for allocation.
+ *
+ * Allocate an event item with the given payload size. Sets the item
+ * operations and payload length values. The item free callback (``ops.free``)
+ * should not be overwritten after this call.
+ *
+ * Return: Returns the newly allocated event item.
+ */
+static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
+{
+	struct ssam_event_item *item;
+
+	item = kzalloc(struct_size(item, event.data, len), flags);
+	if (!item)
+		return NULL;
+
+	item->event.length = len;
+	return item;
+}
+
+/**
+ * ssam_event_queue_push() - Push an event item to the event queue.
+ * @q:    The event queue.
+ * @item: The item to add.
+ */
+static void ssam_event_queue_push(struct ssam_event_queue *q,
+				  struct ssam_event_item *item)
+{
+	spin_lock(&q->lock);
+	list_add_tail(&item->node, &q->head);
+	spin_unlock(&q->lock);
+}
+
+/**
+ * ssam_event_queue_pop() - Pop the next event item from the event queue.
+ * @q: The event queue.
+ *
+ * Returns and removes the next event item from the queue. Returns %NULL If
+ * there is no event item left.
+ */
+static struct ssam_event_item *ssam_event_queue_pop(struct ssam_event_queue *q)
+{
+	struct ssam_event_item *item;
+
+	spin_lock(&q->lock);
+	item = list_first_entry_or_null(&q->head, struct ssam_event_item, node);
+	if (item)
+		list_del(&item->node);
+	spin_unlock(&q->lock);
+
+	return item;
+}
+
+/**
+ * ssam_event_queue_is_empty() - Check if the event queue is empty.
+ * @q: The event queue.
+ */
+static bool ssam_event_queue_is_empty(struct ssam_event_queue *q)
+{
+	bool empty;
+
+	spin_lock(&q->lock);
+	empty = list_empty(&q->head);
+	spin_unlock(&q->lock);
+
+	return empty;
+}
+
+/**
+ * ssam_cplt_get_event_queue() - Get the event queue for the given parameters.
+ * @cplt: The completion system on which to look for the queue.
+ * @tid:  The target ID of the queue.
+ * @rqid: The request ID representing the event ID for which to get the queue.
+ *
+ * Return: Returns the event queue corresponding to the event type described
+ * by the given parameters. If the request ID does not represent an event,
+ * this function returns %NULL. If the target ID is not supported, this
+ * function will fall back to the default target ID (``tid = 1``).
+ */
+static
+struct ssam_event_queue *ssam_cplt_get_event_queue(struct ssam_cplt *cplt,
+						   u8 tid, u16 rqid)
+{
+	u16 event = ssh_rqid_to_event(rqid);
+	u16 tidx = ssh_tid_to_index(tid);
+
+	if (!ssh_rqid_is_event(rqid)) {
+		dev_err(cplt->dev, "event: unsupported request ID: %#06x\n", rqid);
+		return NULL;
+	}
+
+	if (!ssh_tid_is_valid(tid)) {
+		dev_warn(cplt->dev, "event: unsupported target ID: %u\n", tid);
+		tidx = 0;
+	}
+
+	return &cplt->event.target[tidx].queue[event];
+}
+
+/**
+ * ssam_cplt_submit() - Submit a work item to the completion system workqueue.
+ * @cplt: The completion system.
+ * @work: The work item to submit.
+ */
+static bool ssam_cplt_submit(struct ssam_cplt *cplt, struct work_struct *work)
+{
+	return queue_work(cplt->wq, work);
+}
+
+/**
+ * ssam_cplt_submit_event() - Submit an event to the completion system.
+ * @cplt: The completion system.
+ * @item: The event item to submit.
+ *
+ * Submits the event to the completion system by queuing it on the event item
+ * queue and queuing the respective event queue work item on the completion
+ * workqueue, which will eventually complete the event.
+ *
+ * Return: Returns zero on success, %-EINVAL if there is no event queue that
+ * can handle the given event item.
+ */
+static int ssam_cplt_submit_event(struct ssam_cplt *cplt,
+				  struct ssam_event_item *item)
+{
+	struct ssam_event_queue *evq;
+
+	evq = ssam_cplt_get_event_queue(cplt, item->event.target_id, item->rqid);
+	if (!evq)
+		return -EINVAL;
+
+	ssam_event_queue_push(evq, item);
+	ssam_cplt_submit(cplt, &evq->work);
+	return 0;
+}
+
+/**
+ * ssam_cplt_flush() - Flush the completion system.
+ * @cplt: The completion system.
+ *
+ * Flush the completion system by waiting until all currently submitted work
+ * items have been completed.
+ *
+ * Note: This function does not guarantee that all events will have been
+ * handled once this call terminates. In case of a larger number of
+ * to-be-completed events, the event queue work function may re-schedule its
+ * work item, which this flush operation will ignore.
+ *
+ * This operation is only intended to, during normal operation prior to
+ * shutdown, try to complete most events and requests to get them out of the
+ * system while the system is still fully operational. It does not aim to
+ * provide any guarantee that all of them have been handled.
+ */
+static void ssam_cplt_flush(struct ssam_cplt *cplt)
+{
+	flush_workqueue(cplt->wq);
+}
+
+static void ssam_event_queue_work_fn(struct work_struct *work)
+{
+	struct ssam_event_queue *queue;
+	struct ssam_event_item *item;
+	struct ssam_nf *nf;
+	struct device *dev;
+	unsigned int iterations = SSAM_CPLT_WQ_BATCH;
+
+	queue = container_of(work, struct ssam_event_queue, work);
+	nf = &queue->cplt->event.notif;
+	dev = queue->cplt->dev;
+
+	/* Limit number of processed events to avoid livelocking. */
+	do {
+		item = ssam_event_queue_pop(queue);
+		if (!item)
+			return;
+
+		ssam_nf_call(nf, dev, item->rqid, &item->event);
+		kfree(item);
+	} while (--iterations);
+
+	if (!ssam_event_queue_is_empty(queue))
+		ssam_cplt_submit(queue->cplt, &queue->work);
+}
+
+/**
+ * ssam_event_queue_init() - Initialize an event queue.
+ * @cplt: The completion system on which the queue resides.
+ * @evq:  The event queue to initialize.
+ */
+static void ssam_event_queue_init(struct ssam_cplt *cplt,
+				  struct ssam_event_queue *evq)
+{
+	evq->cplt = cplt;
+	spin_lock_init(&evq->lock);
+	INIT_LIST_HEAD(&evq->head);
+	INIT_WORK(&evq->work, ssam_event_queue_work_fn);
+}
+
+/**
+ * ssam_cplt_init() - Initialize completion system.
+ * @cplt: The completion system to initialize.
+ * @dev:  The device used for logging.
+ */
+static int ssam_cplt_init(struct ssam_cplt *cplt, struct device *dev)
+{
+	struct ssam_event_target *target;
+	int status, c, i;
+
+	cplt->dev = dev;
+
+	cplt->wq = create_workqueue(SSAM_CPLT_WQ_NAME);
+	if (!cplt->wq)
+		return -ENOMEM;
+
+	for (c = 0; c < ARRAY_SIZE(cplt->event.target); c++) {
+		target = &cplt->event.target[c];
+
+		for (i = 0; i < ARRAY_SIZE(target->queue); i++)
+			ssam_event_queue_init(cplt, &target->queue[i]);
+	}
+
+	status = ssam_nf_init(&cplt->event.notif);
+	if (status)
+		destroy_workqueue(cplt->wq);
+
+	return status;
+}
+
+/**
+ * ssam_cplt_destroy() - Deinitialize the completion system.
+ * @cplt: The completion system to deinitialize.
+ *
+ * Deinitialize the given completion system and ensure that all pending, i.e.
+ * yet-to-be-completed, event items and requests have been handled.
+ */
+static void ssam_cplt_destroy(struct ssam_cplt *cplt)
+{
+	/*
+	 * Note: destroy_workqueue ensures that all currently queued work will
+	 * be fully completed and the workqueue drained. This means that this
+	 * call will inherently also free any queued ssam_event_items, thus we
+	 * don't have to take care of that here explicitly.
+	 */
+	destroy_workqueue(cplt->wq);
+	ssam_nf_destroy(&cplt->event.notif);
+}
+
+
+/* -- Main SSAM device structures. ------------------------------------------ */
+
+/**
+ * ssam_controller_device() - Get the &struct device associated with this
+ * controller.
+ * @c: The controller for which to get the device.
+ *
+ * Return: Returns the &struct device associated with this controller,
+ * providing its lower-level transport.
+ */
+struct device *ssam_controller_device(struct ssam_controller *c)
+{
+	return ssh_rtl_get_device(&c->rtl);
+}
+EXPORT_SYMBOL_GPL(ssam_controller_device);
+
+static void __ssam_controller_release(struct kref *kref)
+{
+	struct ssam_controller *ctrl = to_ssam_controller(kref, kref);
+
+	ssam_controller_destroy(ctrl);
+	kfree(ctrl);
+}
+
+/**
+ * ssam_controller_get() - Increment reference count of controller.
+ * @c: The controller.
+ *
+ * Return: Returns the controller provided as input.
+ */
+struct ssam_controller *ssam_controller_get(struct ssam_controller *c)
+{
+	if (c)
+		kref_get(&c->kref);
+	return c;
+}
+EXPORT_SYMBOL_GPL(ssam_controller_get);
+
+/**
+ * ssam_controller_put() - Decrement reference count of controller.
+ * @c: The controller.
+ */
+void ssam_controller_put(struct ssam_controller *c)
+{
+	if (c)
+		kref_put(&c->kref, __ssam_controller_release);
+}
+EXPORT_SYMBOL_GPL(ssam_controller_put);
+
+/**
+ * ssam_controller_statelock() - Lock the controller against state transitions.
+ * @c: The controller to lock.
+ *
+ * Lock the controller against state transitions. Holding this lock guarantees
+ * that the controller will not transition between states, i.e. if the
+ * controller is in state "started", when this lock has been acquired, it will
+ * remain in this state at least until the lock has been released.
+ *
+ * Multiple clients may concurrently hold this lock. In other words: The
+ * ``statelock`` functions represent the read-lock part of a r/w-semaphore.
+ * Actions causing state transitions of the controller must be executed while
+ * holding the write-part of this r/w-semaphore (see ssam_controller_lock()
+ * and ssam_controller_unlock() for that).
+ *
+ * See ssam_controller_stateunlock() for the corresponding unlock function.
+ */
+void ssam_controller_statelock(struct ssam_controller *c)
+{
+	down_read(&c->lock);
+}
+EXPORT_SYMBOL_GPL(ssam_controller_statelock);
+
+/**
+ * ssam_controller_stateunlock() - Unlock controller state transitions.
+ * @c: The controller to unlock.
+ *
+ * See ssam_controller_statelock() for the corresponding lock function.
+ */
+void ssam_controller_stateunlock(struct ssam_controller *c)
+{
+	up_read(&c->lock);
+}
+EXPORT_SYMBOL_GPL(ssam_controller_stateunlock);
+
+/**
+ * ssam_controller_lock() - Acquire the main controller lock.
+ * @c: The controller to lock.
+ *
+ * This lock must be held for any state transitions, including transition to
+ * suspend/resumed states and during shutdown. See ssam_controller_statelock()
+ * for more details on controller locking.
+ *
+ * See ssam_controller_unlock() for the corresponding unlock function.
+ */
+void ssam_controller_lock(struct ssam_controller *c)
+{
+	down_write(&c->lock);
+}
+
+/*
+ * ssam_controller_unlock() - Release the main controller lock.
+ * @c: The controller to unlock.
+ *
+ * See ssam_controller_lock() for the corresponding lock function.
+ */
+void ssam_controller_unlock(struct ssam_controller *c)
+{
+	up_write(&c->lock);
+}
+
+static void ssam_handle_event(struct ssh_rtl *rtl,
+			      const struct ssh_command *cmd,
+			      const struct ssam_span *data)
+{
+	struct ssam_controller *ctrl = to_ssam_controller(rtl, rtl);
+	struct ssam_event_item *item;
+
+	item = ssam_event_item_alloc(data->len, GFP_KERNEL);
+	if (!item)
+		return;
+
+	item->rqid = get_unaligned_le16(&cmd->rqid);
+	item->event.target_category = cmd->tc;
+	item->event.target_id = cmd->tid_in;
+	item->event.command_id = cmd->cid;
+	item->event.instance_id = cmd->iid;
+	memcpy(&item->event.data[0], data->ptr, data->len);
+
+	if (WARN_ON(ssam_cplt_submit_event(&ctrl->cplt, item)))
+		kfree(item);
+}
+
+static const struct ssh_rtl_ops ssam_rtl_ops = {
+	.handle_event = ssam_handle_event,
+};
+
+static bool ssam_notifier_is_empty(struct ssam_controller *ctrl);
+static void ssam_notifier_unregister_all(struct ssam_controller *ctrl);
+
+#define SSAM_SSH_DSM_REVISION	0
+
+/* d5e383e1-d892-4a76-89fc-f6aaae7ed5b5 */
+static const guid_t SSAM_SSH_DSM_GUID =
+	GUID_INIT(0xd5e383e1, 0xd892, 0x4a76,
+		  0x89, 0xfc, 0xf6, 0xaa, 0xae, 0x7e, 0xd5, 0xb5);
+
+enum ssh_dsm_fn {
+	SSH_DSM_FN_SSH_POWER_PROFILE             = 0x05,
+	SSH_DSM_FN_SCREEN_ON_SLEEP_IDLE_TIMEOUT  = 0x06,
+	SSH_DSM_FN_SCREEN_OFF_SLEEP_IDLE_TIMEOUT = 0x07,
+	SSH_DSM_FN_D3_CLOSES_HANDLE              = 0x08,
+	SSH_DSM_FN_SSH_BUFFER_SIZE               = 0x09,
+};
+
+static int ssam_dsm_get_functions(acpi_handle handle, u64 *funcs)
+{
+	union acpi_object *obj;
+	u64 mask = 0;
+	int i;
+
+	*funcs = 0;
+
+	if (!acpi_has_method(handle, "_DSM"))
+		return 0;
+
+	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
+				      SSAM_SSH_DSM_REVISION, 0, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj)
+		return -EIO;
+
+	for (i = 0; i < obj->buffer.length && i < 8; i++)
+		mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
+
+	if (mask & BIT(0))
+		*funcs = mask;
+
+	ACPI_FREE(obj);
+	return 0;
+}
+
+static int ssam_dsm_load_u32(acpi_handle handle, u64 funcs, u64 func, u32 *ret)
+{
+	union acpi_object *obj;
+	u64 val;
+
+	if (!(funcs & BIT(func)))
+		return 0;
+
+	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
+				      SSAM_SSH_DSM_REVISION, func, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj)
+		return -EIO;
+
+	val = obj->integer.value;
+	ACPI_FREE(obj);
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	*ret = val;
+	return 0;
+}
+
+/**
+ * ssam_controller_caps_load_from_acpi() - Load controller capabilities from
+ * ACPI _DSM.
+ * @handle: The handle of the ACPI controller/SSH device.
+ * @caps:   Where to store the capabilities in.
+ *
+ * Initializes the given controller capabilities with default values, then
+ * checks and, if the respective _DSM functions are available, loads the
+ * actual capabilities from the _DSM.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+static
+int ssam_controller_caps_load_from_acpi(acpi_handle handle,
+					struct ssam_controller_caps *caps)
+{
+	u32 d3_closes_handle = false;
+	u64 funcs;
+	int status;
+
+	/* Set defaults. */
+	caps->ssh_power_profile = U32_MAX;
+	caps->screen_on_sleep_idle_timeout = U32_MAX;
+	caps->screen_off_sleep_idle_timeout = U32_MAX;
+	caps->d3_closes_handle = false;
+	caps->ssh_buffer_size = U32_MAX;
+
+	/* Pre-load supported DSM functions. */
+	status = ssam_dsm_get_functions(handle, &funcs);
+	if (status)
+		return status;
+
+	/* Load actual values from ACPI, if present. */
+	status = ssam_dsm_load_u32(handle, funcs, SSH_DSM_FN_SSH_POWER_PROFILE,
+				   &caps->ssh_power_profile);
+	if (status)
+		return status;
+
+	status = ssam_dsm_load_u32(handle, funcs,
+				   SSH_DSM_FN_SCREEN_ON_SLEEP_IDLE_TIMEOUT,
+				   &caps->screen_on_sleep_idle_timeout);
+	if (status)
+		return status;
+
+	status = ssam_dsm_load_u32(handle, funcs,
+				   SSH_DSM_FN_SCREEN_OFF_SLEEP_IDLE_TIMEOUT,
+				   &caps->screen_off_sleep_idle_timeout);
+	if (status)
+		return status;
+
+	status = ssam_dsm_load_u32(handle, funcs, SSH_DSM_FN_D3_CLOSES_HANDLE,
+				   &d3_closes_handle);
+	if (status)
+		return status;
+
+	caps->d3_closes_handle = !!d3_closes_handle;
+
+	status = ssam_dsm_load_u32(handle, funcs, SSH_DSM_FN_SSH_BUFFER_SIZE,
+				   &caps->ssh_buffer_size);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+/**
+ * ssam_controller_init() - Initialize SSAM controller.
+ * @ctrl:   The controller to initialize.
+ * @serdev: The serial device representing the underlying data transport.
+ *
+ * Initializes the given controller. Does neither start receiver nor
+ * transmitter threads. After this call, the controller has to be hooked up to
+ * the serdev core separately via &struct serdev_device_ops, relaying calls to
+ * ssam_controller_receive_buf() and ssam_controller_write_wakeup(). Once the
+ * controller has been hooked up, transmitter and receiver threads may be
+ * started via ssam_controller_start(). These setup steps need to be completed
+ * before controller can be used for requests.
+ */
+int ssam_controller_init(struct ssam_controller *ctrl,
+			 struct serdev_device *serdev)
+{
+	acpi_handle handle = ACPI_HANDLE(&serdev->dev);
+	int status;
+
+	init_rwsem(&ctrl->lock);
+	kref_init(&ctrl->kref);
+
+	status = ssam_controller_caps_load_from_acpi(handle, &ctrl->caps);
+	if (status)
+		return status;
+
+	dev_dbg(&serdev->dev,
+		"device capabilities:\n"
+		"  ssh_power_profile:             %u\n"
+		"  ssh_buffer_size:               %u\n"
+		"  screen_on_sleep_idle_timeout:  %u\n"
+		"  screen_off_sleep_idle_timeout: %u\n"
+		"  d3_closes_handle:              %u\n",
+		ctrl->caps.ssh_power_profile,
+		ctrl->caps.ssh_buffer_size,
+		ctrl->caps.screen_on_sleep_idle_timeout,
+		ctrl->caps.screen_off_sleep_idle_timeout,
+		ctrl->caps.d3_closes_handle);
+
+	ssh_seq_reset(&ctrl->counter.seq);
+	ssh_rqid_reset(&ctrl->counter.rqid);
+
+	/* Initialize event/request completion system. */
+	status = ssam_cplt_init(&ctrl->cplt, &serdev->dev);
+	if (status)
+		return status;
+
+	/* Initialize request and packet transport layers. */
+	status = ssh_rtl_init(&ctrl->rtl, serdev, &ssam_rtl_ops);
+	if (status) {
+		ssam_cplt_destroy(&ctrl->cplt);
+		return status;
+	}
+
+	/*
+	 * Set state via write_once even though we expect to be in an
+	 * exclusive context, due to smoke-testing in
+	 * ssam_request_sync_submit().
+	 */
+	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_INITIALIZED);
+	return 0;
+}
+
+/**
+ * ssam_controller_start() - Start the receiver and transmitter threads of the
+ * controller.
+ * @ctrl: The controller.
+ *
+ * Note: When this function is called, the controller should be properly
+ * hooked up to the serdev core via &struct serdev_device_ops. Please refer
+ * to ssam_controller_init() for more details on controller initialization.
+ *
+ * This function must be called from an exclusive context with regards to the
+ * state, if necessary, by locking the controller via ssam_controller_lock().
+ */
+int ssam_controller_start(struct ssam_controller *ctrl)
+{
+	int status;
+
+	if (ctrl->state != SSAM_CONTROLLER_INITIALIZED)
+		return -EINVAL;
+
+	status = ssh_rtl_start(&ctrl->rtl);
+	if (status)
+		return status;
+
+	/*
+	 * Set state via write_once even though we expect to be locked/in an
+	 * exclusive context, due to smoke-testing in
+	 * ssam_request_sync_submit().
+	 */
+	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STARTED);
+	return 0;
+}
+
+/*
+ * SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT - Timeout for flushing requests during
+ * shutdown.
+ *
+ * Chosen to be larger than one full request timeout, including packets timing
+ * out. This value should give ample time to complete any outstanding requests
+ * during normal operation and account for the odd package timeout.
+ */
+#define SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT	msecs_to_jiffies(5000)
+
+/**
+ * ssam_controller_shutdown() - Shut down the controller.
+ * @ctrl: The controller.
+ *
+ * Shuts down the controller by flushing all pending requests and stopping the
+ * transmitter and receiver threads. All requests submitted after this call
+ * will fail with %-ESHUTDOWN. While it is discouraged to do so, this function
+ * is safe to use in parallel with ongoing request submission.
+ *
+ * In the course of this shutdown procedure, all currently registered
+ * notifiers will be unregistered. It is, however, strongly recommended to not
+ * rely on this behavior, and instead the party registering the notifier
+ * should unregister it before the controller gets shut down, e.g. via the
+ * SSAM bus which guarantees client devices to be removed before a shutdown.
+ *
+ * Note that events may still be pending after this call, but, due to the
+ * notifiers being unregistered, these events will be dropped when the
+ * controller is subsequently destroyed via ssam_controller_destroy().
+ *
+ * This function must be called from an exclusive context with regards to the
+ * state, if necessary, by locking the controller via ssam_controller_lock().
+ */
+void ssam_controller_shutdown(struct ssam_controller *ctrl)
+{
+	enum ssam_controller_state s = ctrl->state;
+	int status;
+
+	if (s == SSAM_CONTROLLER_UNINITIALIZED || s == SSAM_CONTROLLER_STOPPED)
+		return;
+
+	/*
+	 * Try to flush pending events and requests while everything still
+	 * works. Note: There may still be packets and/or requests in the
+	 * system after this call (e.g. via control packets submitted by the
+	 * packet transport layer or flush timeout / failure, ...). Those will
+	 * be handled with the ssh_rtl_shutdown() call below.
+	 */
+	status = ssh_rtl_flush(&ctrl->rtl, SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT);
+	if (status) {
+		ssam_err(ctrl, "failed to flush request transport layer: %d\n",
+			 status);
+	}
+
+	/* Try to flush all currently completing requests and events. */
+	ssam_cplt_flush(&ctrl->cplt);
+
+	/*
+	 * We expect all notifiers to have been removed by the respective client
+	 * driver that set them up at this point. If this warning occurs, some
+	 * client driver has not done that...
+	 */
+	WARN_ON(!ssam_notifier_is_empty(ctrl));
+
+	/*
+	 * Nevertheless, we should still take care of drivers that don't behave
+	 * well. Thus disable all enabled events, unregister all notifiers.
+	 */
+	ssam_notifier_unregister_all(ctrl);
+
+	/*
+	 * Cancel remaining requests. Ensure no new ones can be queued and stop
+	 * threads.
+	 */
+	ssh_rtl_shutdown(&ctrl->rtl);
+
+	/*
+	 * Set state via write_once even though we expect to be locked/in an
+	 * exclusive context, due to smoke-testing in
+	 * ssam_request_sync_submit().
+	 */
+	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STOPPED);
+	ctrl->rtl.ptl.serdev = NULL;
+}
+
+/**
+ * ssam_controller_destroy() - Destroy the controller and free its resources.
+ * @ctrl: The controller.
+ *
+ * Ensures that all resources associated with the controller get freed. This
+ * function should only be called after the controller has been stopped via
+ * ssam_controller_shutdown(). In general, this function should not be called
+ * directly. The only valid place to call this function directly is during
+ * initialization, before the controller has been fully initialized and passed
+ * to other processes. This function is called automatically when the
+ * reference count of the controller reaches zero.
+ *
+ * Must be called from an exclusive context with regards to the controller
+ * state.
+ */
+void ssam_controller_destroy(struct ssam_controller *ctrl)
+{
+	if (ctrl->state == SSAM_CONTROLLER_UNINITIALIZED)
+		return;
+
+	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED);
+
+	/*
+	 * Note: New events could still have been received after the previous
+	 * flush in ssam_controller_shutdown, before the request transport layer
+	 * has been shut down. At this point, after the shutdown, we can be sure
+	 * that no new events will be queued. The call to ssam_cplt_destroy will
+	 * ensure that those remaining are being completed and freed.
+	 */
+
+	/* Actually free resources. */
+	ssam_cplt_destroy(&ctrl->cplt);
+	ssh_rtl_destroy(&ctrl->rtl);
+
+	/*
+	 * Set state via write_once even though we expect to be locked/in an
+	 * exclusive context, due to smoke-testing in
+	 * ssam_request_sync_submit().
+	 */
+	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_UNINITIALIZED);
+}
+
+/**
+ * ssam_controller_suspend() - Suspend the controller.
+ * @ctrl: The controller to suspend.
+ *
+ * Marks the controller as suspended. Note that display-off and D0-exit
+ * notifications have to be sent manually before transitioning the controller
+ * into the suspended state via this function.
+ *
+ * See ssam_controller_resume() for the corresponding resume function.
+ *
+ * Return: Returns %-EINVAL if the controller is currently not in the
+ * "started" state.
+ */
+int ssam_controller_suspend(struct ssam_controller *ctrl)
+{
+	ssam_controller_lock(ctrl);
+
+	if (ctrl->state != SSAM_CONTROLLER_STARTED) {
+		ssam_controller_unlock(ctrl);
+		return -EINVAL;
+	}
+
+	ssam_dbg(ctrl, "pm: suspending controller\n");
+
+	/*
+	 * Set state via write_once even though we're locked, due to
+	 * smoke-testing in ssam_request_sync_submit().
+	 */
+	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_SUSPENDED);
+
+	ssam_controller_unlock(ctrl);
+	return 0;
+}
+
+/**
+ * ssam_controller_resume() - Resume the controller from suspend.
+ * @ctrl: The controller to resume.
+ *
+ * Resume the controller from the suspended state it was put into via
+ * ssam_controller_suspend(). This function does not issue display-on and
+ * D0-entry notifications. If required, those have to be sent manually after
+ * this call.
+ *
+ * Return: Returns %-EINVAL if the controller is currently not suspended.
+ */
+int ssam_controller_resume(struct ssam_controller *ctrl)
+{
+	ssam_controller_lock(ctrl);
+
+	if (ctrl->state != SSAM_CONTROLLER_SUSPENDED) {
+		ssam_controller_unlock(ctrl);
+		return -EINVAL;
+	}
+
+	ssam_dbg(ctrl, "pm: resuming controller\n");
+
+	/*
+	 * Set state via write_once even though we're locked, due to
+	 * smoke-testing in ssam_request_sync_submit().
+	 */
+	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STARTED);
+
+	ssam_controller_unlock(ctrl);
+	return 0;
+}
+
+
+/* -- Top-level request interface ------------------------------------------- */
+
+/**
+ * ssam_request_write_data() - Construct and write SAM request message to
+ * buffer.
+ * @buf:  The buffer to write the data to.
+ * @ctrl: The controller via which the request will be sent.
+ * @spec: The request data and specification.
+ *
+ * Constructs a SAM/SSH request message and writes it to the provided buffer.
+ * The request and transport counters, specifically RQID and SEQ, will be set
+ * in this call. These counters are obtained from the controller. It is thus
+ * only valid to send the resulting message via the controller specified here.
+ *
+ * For calculation of the required buffer size, refer to the
+ * SSH_COMMAND_MESSAGE_LENGTH() macro.
+ *
+ * Return: Returns the number of bytes used in the buffer on success. Returns
+ * %-EINVAL if the payload length provided in the request specification is too
+ * large (larger than %SSH_COMMAND_MAX_PAYLOAD_SIZE) or if the provided buffer
+ * is too small.
+ */
+ssize_t ssam_request_write_data(struct ssam_span *buf,
+				struct ssam_controller *ctrl,
+				const struct ssam_request *spec)
+{
+	struct msgbuf msgb;
+	u16 rqid;
+	u8 seq;
+
+	if (spec->length > SSH_COMMAND_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	if (SSH_COMMAND_MESSAGE_LENGTH(spec->length) > buf->len)
+		return -EINVAL;
+
+	msgb_init(&msgb, buf->ptr, buf->len);
+	seq = ssh_seq_next(&ctrl->counter.seq);
+	rqid = ssh_rqid_next(&ctrl->counter.rqid);
+	msgb_push_cmd(&msgb, seq, rqid, spec);
+
+	return msgb_bytes_used(&msgb);
+}
+EXPORT_SYMBOL_GPL(ssam_request_write_data);
+
+static void ssam_request_sync_complete(struct ssh_request *rqst,
+				       const struct ssh_command *cmd,
+				       const struct ssam_span *data, int status)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+	struct ssam_request_sync *r;
+
+	r = container_of(rqst, struct ssam_request_sync, base);
+	r->status = status;
+
+	if (r->resp)
+		r->resp->length = 0;
+
+	if (status) {
+		rtl_dbg_cond(rtl, "rsp: request failed: %d\n", status);
+		return;
+	}
+
+	if (!data)	/* Handle requests without a response. */
+		return;
+
+	if (!r->resp || !r->resp->pointer) {
+		if (data->len)
+			rtl_warn(rtl, "rsp: no response buffer provided, dropping data\n");
+		return;
+	}
+
+	if (data->len > r->resp->capacity) {
+		rtl_err(rtl,
+			"rsp: response buffer too small, capacity: %zu bytes, got: %zu bytes\n",
+			r->resp->capacity, data->len);
+		r->status = -ENOSPC;
+		return;
+	}
+
+	r->resp->length = data->len;
+	memcpy(r->resp->pointer, data->ptr, data->len);
+}
+
+static void ssam_request_sync_release(struct ssh_request *rqst)
+{
+	complete_all(&container_of(rqst, struct ssam_request_sync, base)->comp);
+}
+
+static const struct ssh_request_ops ssam_request_sync_ops = {
+	.release = ssam_request_sync_release,
+	.complete = ssam_request_sync_complete,
+};
+
+/**
+ * ssam_request_sync_alloc() - Allocate a synchronous request.
+ * @payload_len: The length of the request payload.
+ * @flags:       Flags used for allocation.
+ * @rqst:        Where to store the pointer to the allocated request.
+ * @buffer:      Where to store the buffer descriptor for the message buffer of
+ *               the request.
+ *
+ * Allocates a synchronous request with corresponding message buffer. The
+ * request still needs to be initialized ssam_request_sync_init() before
+ * it can be submitted, and the message buffer data must still be set to the
+ * returned buffer via ssam_request_sync_set_data() after it has been filled,
+ * if need be with adjusted message length.
+ *
+ * After use, the request and its corresponding message buffer should be freed
+ * via ssam_request_sync_free(). The buffer must not be freed separately.
+ *
+ * Return: Returns zero on success, %-ENOMEM if the request could not be
+ * allocated.
+ */
+int ssam_request_sync_alloc(size_t payload_len, gfp_t flags,
+			    struct ssam_request_sync **rqst,
+			    struct ssam_span *buffer)
+{
+	size_t msglen = SSH_COMMAND_MESSAGE_LENGTH(payload_len);
+
+	*rqst = kzalloc(sizeof(**rqst) + msglen, flags);
+	if (!*rqst)
+		return -ENOMEM;
+
+	buffer->ptr = (u8 *)(*rqst + 1);
+	buffer->len = msglen;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ssam_request_sync_alloc);
+
+/**
+ * ssam_request_sync_free() - Free a synchronous request.
+ * @rqst: The request to be freed.
+ *
+ * Free a synchronous request and its corresponding buffer allocated with
+ * ssam_request_sync_alloc(). Do not use for requests allocated on the stack
+ * or via any other function.
+ *
+ * Warning: The caller must ensure that the request is not in use any more.
+ * I.e. the caller must ensure that it has the only reference to the request
+ * and the request is not currently pending. This means that the caller has
+ * either never submitted the request, request submission has failed, or the
+ * caller has waited until the submitted request has been completed via
+ * ssam_request_sync_wait().
+ */
+void ssam_request_sync_free(struct ssam_request_sync *rqst)
+{
+	kfree(rqst);
+}
+EXPORT_SYMBOL_GPL(ssam_request_sync_free);
+
+/**
+ * ssam_request_sync_init() - Initialize a synchronous request struct.
+ * @rqst:  The request to initialize.
+ * @flags: The request flags.
+ *
+ * Initializes the given request struct. Does not initialize the request
+ * message data. This has to be done explicitly after this call via
+ * ssam_request_sync_set_data() and the actual message data has to be written
+ * via ssam_request_write_data().
+ */
+void ssam_request_sync_init(struct ssam_request_sync *rqst,
+			    enum ssam_request_flags flags)
+{
+	ssh_request_init(&rqst->base, flags, &ssam_request_sync_ops);
+	init_completion(&rqst->comp);
+	rqst->resp = NULL;
+	rqst->status = 0;
+}
+EXPORT_SYMBOL_GPL(ssam_request_sync_init);
+
+/**
+ * ssam_request_sync_submit() - Submit a synchronous request.
+ * @ctrl: The controller with which to submit the request.
+ * @rqst: The request to submit.
+ *
+ * Submit a synchronous request. The request has to be initialized and
+ * properly set up, including response buffer (may be %NULL if no response is
+ * expected) and command message data. This function does not wait for the
+ * request to be completed.
+ *
+ * If this function succeeds, ssam_request_sync_wait() must be used to ensure
+ * that the request has been completed before the response data can be
+ * accessed and/or the request can be freed. On failure, the request may
+ * immediately be freed.
+ *
+ * This function may only be used if the controller is active, i.e. has been
+ * initialized and not suspended.
+ */
+int ssam_request_sync_submit(struct ssam_controller *ctrl,
+			     struct ssam_request_sync *rqst)
+{
+	int status;
+
+	/*
+	 * This is only a superficial check. In general, the caller needs to
+	 * ensure that the controller is initialized and is not (and does not
+	 * get) suspended during use, i.e. until the request has been completed
+	 * (if _absolutely_ necessary, by use of ssam_controller_statelock/
+	 * ssam_controller_stateunlock, but something like ssam_client_link
+	 * should be preferred as this needs to last until the request has been
+	 * completed).
+	 *
+	 * Note that it is actually safe to use this function while the
+	 * controller is in the process of being shut down (as ssh_rtl_submit
+	 * is safe with regards to this), but it is generally discouraged to do
+	 * so.
+	 */
+	if (WARN_ON(READ_ONCE(ctrl->state) != SSAM_CONTROLLER_STARTED)) {
+		ssh_request_put(&rqst->base);
+		return -ENODEV;
+	}
+
+	status = ssh_rtl_submit(&ctrl->rtl, &rqst->base);
+	ssh_request_put(&rqst->base);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(ssam_request_sync_submit);
+
+/**
+ * ssam_request_sync() - Execute a synchronous request.
+ * @ctrl: The controller via which the request will be submitted.
+ * @spec: The request specification and payload.
+ * @rsp:  The response buffer.
+ *
+ * Allocates a synchronous request with its message data buffer on the heap
+ * via ssam_request_sync_alloc(), fully initializes it via the provided
+ * request specification, submits it, and finally waits for its completion
+ * before freeing it and returning its status.
+ *
+ * Return: Returns the status of the request or any failure during setup.
+ */
+int ssam_request_sync(struct ssam_controller *ctrl,
+		      const struct ssam_request *spec,
+		      struct ssam_response *rsp)
+{
+	struct ssam_request_sync *rqst;
+	struct ssam_span buf;
+	ssize_t len;
+	int status;
+
+	status = ssam_request_sync_alloc(spec->length, GFP_KERNEL, &rqst, &buf);
+	if (status)
+		return status;
+
+	ssam_request_sync_init(rqst, spec->flags);
+	ssam_request_sync_set_resp(rqst, rsp);
+
+	len = ssam_request_write_data(&buf, ctrl, spec);
+	if (len < 0) {
+		ssam_request_sync_free(rqst);
+		return len;
+	}
+
+	ssam_request_sync_set_data(rqst, buf.ptr, len);
+
+	status = ssam_request_sync_submit(ctrl, rqst);
+	if (!status)
+		status = ssam_request_sync_wait(rqst);
+
+	ssam_request_sync_free(rqst);
+	return status;
+}
+EXPORT_SYMBOL_GPL(ssam_request_sync);
+
+/**
+ * ssam_request_sync_with_buffer() - Execute a synchronous request with the
+ * provided buffer as back-end for the message buffer.
+ * @ctrl: The controller via which the request will be submitted.
+ * @spec: The request specification and payload.
+ * @rsp:  The response buffer.
+ * @buf:  The buffer for the request message data.
+ *
+ * Allocates a synchronous request struct on the stack, fully initializes it
+ * using the provided buffer as message data buffer, submits it, and then
+ * waits for its completion before returning its status. The
+ * SSH_COMMAND_MESSAGE_LENGTH() macro can be used to compute the required
+ * message buffer size.
+ *
+ * This function does essentially the same as ssam_request_sync(), but instead
+ * of dynamically allocating the request and message data buffer, it uses the
+ * provided message data buffer and stores the (small) request struct on the
+ * heap.
+ *
+ * Return: Returns the status of the request or any failure during setup.
+ */
+int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
+				  const struct ssam_request *spec,
+				  struct ssam_response *rsp,
+				  struct ssam_span *buf)
+{
+	struct ssam_request_sync rqst;
+	ssize_t len;
+	int status;
+
+	ssam_request_sync_init(&rqst, spec->flags);
+	ssam_request_sync_set_resp(&rqst, rsp);
+
+	len = ssam_request_write_data(buf, ctrl, spec);
+	if (len < 0)
+		return len;
+
+	ssam_request_sync_set_data(&rqst, buf->ptr, len);
+
+	status = ssam_request_sync_submit(ctrl, &rqst);
+	if (!status)
+		status = ssam_request_sync_wait(&rqst);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(ssam_request_sync_with_buffer);
+
+
+/* -- Internal SAM requests. ------------------------------------------------ */
+
+static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_get_firmware_version, __le32, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = 0x01,
+	.command_id      = 0x13,
+	.instance_id     = 0x00,
+});
+
+static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_off, u8, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = 0x01,
+	.command_id      = 0x15,
+	.instance_id     = 0x00,
+});
+
+static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_on, u8, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = 0x01,
+	.command_id      = 0x16,
+	.instance_id     = 0x00,
+});
+
+static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_exit, u8, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = 0x01,
+	.command_id      = 0x33,
+	.instance_id     = 0x00,
+});
+
+static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_entry, u8, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = 0x01,
+	.command_id      = 0x34,
+	.instance_id     = 0x00,
+});
+
+/**
+ * struct ssh_notification_params - Command payload to enable/disable SSH
+ * notifications.
+ * @target_category: The target category for which notifications should be
+ *                   enabled/disabled.
+ * @flags:           Flags determining how notifications are being sent.
+ * @request_id:      The request ID that is used to send these notifications.
+ * @instance_id:     The specific instance in the given target category for
+ *                   which notifications should be enabled.
+ */
+struct ssh_notification_params {
+	u8 target_category;
+	u8 flags;
+	__le16 request_id;
+	u8 instance_id;
+} __packed;
+
+static_assert(sizeof(struct ssh_notification_params) == 5);
+
+static int __ssam_ssh_event_request(struct ssam_controller *ctrl,
+				    struct ssam_event_registry reg, u8 cid,
+				    struct ssam_event_id id, u8 flags)
+{
+	struct ssh_notification_params params;
+	struct ssam_request rqst;
+	struct ssam_response result;
+	int status;
+
+	u16 rqid = ssh_tc_to_rqid(id.target_category);
+	u8 buf = 0;
+
+	/* Only allow RQIDs that lie within the event spectrum. */
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	params.target_category = id.target_category;
+	params.instance_id = id.instance;
+	params.flags = flags;
+	put_unaligned_le16(rqid, &params.request_id);
+
+	rqst.target_category = reg.target_category;
+	rqst.target_id = reg.target_id;
+	rqst.command_id = cid;
+	rqst.instance_id = 0x00;
+	rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
+	rqst.length = sizeof(params);
+	rqst.payload = (u8 *)&params;
+
+	result.capacity = sizeof(buf);
+	result.length = 0;
+	result.pointer = &buf;
+
+	status = ssam_retry(ssam_request_sync_onstack, ctrl, &rqst, &result,
+			    sizeof(params));
+
+	return status < 0 ? status : buf;
+}
+
+/**
+ * ssam_ssh_event_enable() - Enable SSH event.
+ * @ctrl:  The controller for which to enable the event.
+ * @reg:   The event registry describing what request to use for enabling and
+ *         disabling the event.
+ * @id:    The event identifier.
+ * @flags: The event flags.
+ *
+ * Enables the specified event on the EC. This function does not manage
+ * reference counting of enabled events and is basically only a wrapper for
+ * the raw EC request. If the specified event is already enabled, the EC will
+ * ignore this request.
+ *
+ * Return: Returns the status of the executed SAM request (zero on success and
+ * negative on direct failure) or %-EPROTO if the request response indicates a
+ * failure.
+ */
+static int ssam_ssh_event_enable(struct ssam_controller *ctrl,
+				 struct ssam_event_registry reg,
+				 struct ssam_event_id id, u8 flags)
+{
+	int status;
+
+	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_enable, id, flags);
+
+	if (status < 0 && status != -EINVAL) {
+		ssam_err(ctrl,
+			 "failed to enable event source (tc: %#04x, iid: %#04x, reg: %#04x)\n",
+			 id.target_category, id.instance, reg.target_category);
+	}
+
+	if (status > 0) {
+		ssam_err(ctrl,
+			 "unexpected result while enabling event source: %#04x (tc: %#04x, iid: %#04x, reg: %#04x)\n",
+			 status, id.target_category, id.instance, reg.target_category);
+		return -EPROTO;
+	}
+
+	return status;
+}
+
+/**
+ * ssam_ssh_event_disable() - Disable SSH event.
+ * @ctrl:  The controller for which to disable the event.
+ * @reg:   The event registry describing what request to use for enabling and
+ *         disabling the event (must be same as used when enabling the event).
+ * @id:    The event identifier.
+ * @flags: The event flags (likely ignored for disabling of events).
+ *
+ * Disables the specified event on the EC. This function does not manage
+ * reference counting of enabled events and is basically only a wrapper for
+ * the raw EC request. If the specified event is already disabled, the EC will
+ * ignore this request.
+ *
+ * Return: Returns the status of the executed SAM request (zero on success and
+ * negative on direct failure) or %-EPROTO if the request response indicates a
+ * failure.
+ */
+static int ssam_ssh_event_disable(struct ssam_controller *ctrl,
+				  struct ssam_event_registry reg,
+				  struct ssam_event_id id, u8 flags)
+{
+	int status;
+
+	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_enable, id, flags);
+
+	if (status < 0 && status != -EINVAL) {
+		ssam_err(ctrl,
+			 "failed to disable event source (tc: %#04x, iid: %#04x, reg: %#04x)\n",
+			 id.target_category, id.instance, reg.target_category);
+	}
+
+	if (status > 0) {
+		ssam_err(ctrl,
+			 "unexpected result while disabling event source: %#04x (tc: %#04x, iid: %#04x, reg: %#04x)\n",
+			 status, id.target_category, id.instance, reg.target_category);
+		return -EPROTO;
+	}
+
+	return status;
+}
+
+
+/* -- Wrappers for internal SAM requests. ----------------------------------- */
+
+/**
+ * ssam_get_firmware_version() - Get the SAM/EC firmware version.
+ * @ctrl:    The controller.
+ * @version: Where to store the version number.
+ *
+ * Return: Returns zero on success or the status of the executed SAM request
+ * if that request failed.
+ */
+int ssam_get_firmware_version(struct ssam_controller *ctrl, u32 *version)
+{
+	__le32 __version;
+	int status;
+
+	status = ssam_retry(ssam_ssh_get_firmware_version, ctrl, &__version);
+	if (status)
+		return status;
+
+	*version = le32_to_cpu(__version);
+	return 0;
+}
+
+/**
+ * ssam_ctrl_notif_display_off() - Notify EC that the display has been turned
+ * off.
+ * @ctrl: The controller.
+ *
+ * Notify the EC that the display has been turned off and the driver may enter
+ * a lower-power state. This will prevent events from being sent directly.
+ * Rather, the EC signals an event by pulling the wakeup GPIO high for as long
+ * as there are pending events. The events then need to be manually released,
+ * one by one, via the GPIO callback request. All pending events accumulated
+ * during this state can also be released by issuing the display-on
+ * notification, e.g. via ssam_ctrl_notif_display_on(), which will also reset
+ * the GPIO.
+ *
+ * On some devices, specifically ones with an integrated keyboard, the keyboard
+ * backlight will be turned off by this call.
+ *
+ * This function will only send the display-off notification command if
+ * display notifications are supported by the EC. Currently all known devices
+ * support these notifications.
+ *
+ * Use ssam_ctrl_notif_display_on() to reverse the effects of this function.
+ *
+ * Return: Returns zero on success or if no request has been executed, the
+ * status of the executed SAM request if that request failed, or %-EPROTO if
+ * an unexpected response has been received.
+ */
+int ssam_ctrl_notif_display_off(struct ssam_controller *ctrl)
+{
+	int status;
+	u8 response;
+
+	ssam_dbg(ctrl, "pm: notifying display off\n");
+
+	status = ssam_retry(ssam_ssh_notif_display_off, ctrl, &response);
+	if (status)
+		return status;
+
+	if (response != 0) {
+		ssam_err(ctrl, "unexpected response from display-off notification: %#04x\n",
+			 response);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+/**
+ * ssam_ctrl_notif_display_on() - Notify EC that the display has been turned on.
+ * @ctrl: The controller.
+ *
+ * Notify the EC that the display has been turned back on and the driver has
+ * exited its lower-power state. This notification is the counterpart to the
+ * display-off notification sent via ssam_ctrl_notif_display_off() and will
+ * reverse its effects, including resetting events to their default behavior.
+ *
+ * This function will only send the display-on notification command if display
+ * notifications are supported by the EC. Currently all known devices support
+ * these notifications.
+ *
+ * See ssam_ctrl_notif_display_off() for more details.
+ *
+ * Return: Returns zero on success or if no request has been executed, the
+ * status of the executed SAM request if that request failed, or %-EPROTO if
+ * an unexpected response has been received.
+ */
+int ssam_ctrl_notif_display_on(struct ssam_controller *ctrl)
+{
+	int status;
+	u8 response;
+
+	ssam_dbg(ctrl, "pm: notifying display on\n");
+
+	status = ssam_retry(ssam_ssh_notif_display_on, ctrl, &response);
+	if (status)
+		return status;
+
+	if (response != 0) {
+		ssam_err(ctrl, "unexpected response from display-on notification: %#04x\n",
+			 response);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+/**
+ * ssam_ctrl_notif_d0_exit() - Notify EC that the driver/device exits the D0
+ * power state.
+ * @ctrl: The controller
+ *
+ * Notifies the EC that the driver prepares to exit the D0 power state in
+ * favor of a lower-power state. Exact effects of this function related to the
+ * EC are currently unknown.
+ *
+ * This function will only send the D0-exit notification command if D0-state
+ * notifications are supported by the EC. Only newer Surface generations
+ * support these notifications.
+ *
+ * Use ssam_ctrl_notif_d0_entry() to reverse the effects of this function.
+ *
+ * Return: Returns zero on success or if no request has been executed, the
+ * status of the executed SAM request if that request failed, or %-EPROTO if
+ * an unexpected response has been received.
+ */
+int ssam_ctrl_notif_d0_exit(struct ssam_controller *ctrl)
+{
+	int status;
+	u8 response;
+
+	if (!ctrl->caps.d3_closes_handle)
+		return 0;
+
+	ssam_dbg(ctrl, "pm: notifying D0 exit\n");
+
+	status = ssam_retry(ssam_ssh_notif_d0_exit, ctrl, &response);
+	if (status)
+		return status;
+
+	if (response != 0) {
+		ssam_err(ctrl, "unexpected response from D0-exit notification: %#04x\n",
+			 response);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+/**
+ * ssam_ctrl_notif_d0_entry() - Notify EC that the driver/device enters the D0
+ * power state.
+ * @ctrl: The controller
+ *
+ * Notifies the EC that the driver has exited a lower-power state and entered
+ * the D0 power state. Exact effects of this function related to the EC are
+ * currently unknown.
+ *
+ * This function will only send the D0-entry notification command if D0-state
+ * notifications are supported by the EC. Only newer Surface generations
+ * support these notifications.
+ *
+ * See ssam_ctrl_notif_d0_exit() for more details.
+ *
+ * Return: Returns zero on success or if no request has been executed, the
+ * status of the executed SAM request if that request failed, or %-EPROTO if
+ * an unexpected response has been received.
+ */
+int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl)
+{
+	int status;
+	u8 response;
+
+	if (!ctrl->caps.d3_closes_handle)
+		return 0;
+
+	ssam_dbg(ctrl, "pm: notifying D0 entry\n");
+
+	status = ssam_retry(ssam_ssh_notif_d0_entry, ctrl, &response);
+	if (status)
+		return status;
+
+	if (response != 0) {
+		ssam_err(ctrl, "unexpected response from D0-entry notification: %#04x\n",
+			 response);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+
+/* -- Top-level event registry interface. ----------------------------------- */
+
+/**
+ * ssam_notifier_register() - Register an event notifier.
+ * @ctrl: The controller to register the notifier on.
+ * @n:    The event notifier to register.
+ *
+ * Register an event notifier and increment the usage counter of the
+ * associated SAM event. If the event was previously not enabled, it will be
+ * enabled during this call.
+ *
+ * Return: Returns zero on success, %-ENOSPC if there have already been
+ * %INT_MAX notifiers for the event ID/type associated with the notifier block
+ * registered, %-ENOMEM if the corresponding event entry could not be
+ * allocated. If this is the first time that a notifier block is registered
+ * for the specific associated event, returns the status of the event-enable
+ * EC-command.
+ */
+int ssam_notifier_register(struct ssam_controller *ctrl,
+			   struct ssam_event_notifier *n)
+{
+	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
+	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_head *nf_head;
+	struct ssam_nf *nf;
+	int status;
+
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	nf = &ctrl->cplt.event.notif;
+	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
+
+	mutex_lock(&nf->lock);
+
+	entry = ssam_nf_refcount_inc(nf, n->event.reg, n->event.id);
+	if (IS_ERR(entry)) {
+		mutex_unlock(&nf->lock);
+		return PTR_ERR(entry);
+	}
+
+	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 n->event.reg.target_category, n->event.id.target_category,
+		 n->event.id.instance, entry->refcount);
+
+	status = ssam_nfblk_insert(nf_head, &n->base);
+	if (status) {
+		entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
+		if (entry->refcount == 0)
+			kfree(entry);
+
+		mutex_unlock(&nf->lock);
+		return status;
+	}
+
+	if (entry->refcount == 1) {
+		status = ssam_ssh_event_enable(ctrl, n->event.reg, n->event.id,
+					       n->event.flags);
+		if (status) {
+			ssam_nfblk_remove(&n->base);
+			kfree(ssam_nf_refcount_dec(nf, n->event.reg, n->event.id));
+			mutex_unlock(&nf->lock);
+			synchronize_srcu(&nf_head->srcu);
+			return status;
+		}
+
+		entry->flags = n->event.flags;
+
+	} else if (entry->flags != n->event.flags) {
+		ssam_warn(ctrl,
+			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
+			  n->event.flags, entry->flags, n->event.reg.target_category,
+			  n->event.id.target_category, n->event.id.instance);
+	}
+
+	mutex_unlock(&nf->lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ssam_notifier_register);
+
+/**
+ * ssam_notifier_unregister() - Unregister an event notifier.
+ * @ctrl: The controller the notifier has been registered on.
+ * @n:    The event notifier to unregister.
+ *
+ * Unregister an event notifier and decrement the usage counter of the
+ * associated SAM event. If the usage counter reaches zero, the event will be
+ * disabled.
+ *
+ * Return: Returns zero on success, %-ENOENT if the given notifier block has
+ * not been registered on the controller. If the given notifier block was the
+ * last one associated with its specific event, returns the status of the
+ * event-disable EC-command.
+ */
+int ssam_notifier_unregister(struct ssam_controller *ctrl,
+			     struct ssam_event_notifier *n)
+{
+	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
+	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_head *nf_head;
+	struct ssam_nf *nf;
+	int status = 0;
+
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	nf = &ctrl->cplt.event.notif;
+	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
+
+	mutex_lock(&nf->lock);
+
+	if (!ssam_nfblk_find(nf_head, &n->base)) {
+		mutex_unlock(&nf->lock);
+		return -ENOENT;
+	}
+
+	entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
+	if (WARN_ON(!entry)) {
+		/*
+		 * If this does not return an entry, there's a logic error
+		 * somewhere: The notifier block is registered, but the event
+		 * refcount entry is not there. Remove the notifier block
+		 * anyways.
+		 */
+		status = -ENOENT;
+		goto remove;
+	}
+
+	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 n->event.reg.target_category, n->event.id.target_category,
+		 n->event.id.instance, entry->refcount);
+
+	if (entry->flags != n->event.flags) {
+		ssam_warn(ctrl,
+			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
+			  n->event.flags, entry->flags, n->event.reg.target_category,
+			  n->event.id.target_category, n->event.id.instance);
+	}
+
+	if (entry->refcount == 0) {
+		status = ssam_ssh_event_disable(ctrl, n->event.reg, n->event.id,
+						n->event.flags);
+		kfree(entry);
+	}
+
+remove:
+	ssam_nfblk_remove(&n->base);
+	mutex_unlock(&nf->lock);
+	synchronize_srcu(&nf_head->srcu);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(ssam_notifier_unregister);
+
+/**
+ * ssam_notifier_disable_registered() - Disable events for all registered
+ * notifiers.
+ * @ctrl: The controller for which to disable the notifiers/events.
+ *
+ * Disables events for all currently registered notifiers. In case of an error
+ * (EC command failing), all previously disabled events will be restored and
+ * the error code returned.
+ *
+ * This function is intended to disable all events prior to hibernation entry.
+ * See ssam_notifier_restore_registered() to restore/re-enable all events
+ * disabled with this function.
+ *
+ * Note that this function will not disable events for notifiers registered
+ * after calling this function. It should thus be made sure that no new
+ * notifiers are going to be added after this call and before the corresponding
+ * call to ssam_notifier_restore_registered().
+ *
+ * Return: Returns zero on success. In case of failure returns the error code
+ * returned by the failed EC command to disable an event.
+ */
+int ssam_notifier_disable_registered(struct ssam_controller *ctrl)
+{
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	struct rb_node *n;
+	int status;
+
+	mutex_lock(&nf->lock);
+	for (n = rb_first(&nf->refcount); n; n = rb_next(n)) {
+		struct ssam_nf_refcount_entry *e;
+
+		e = rb_entry(n, struct ssam_nf_refcount_entry, node);
+		status = ssam_ssh_event_disable(ctrl, e->key.reg,
+						e->key.id, e->flags);
+		if (status)
+			goto err;
+	}
+	mutex_unlock(&nf->lock);
+
+	return 0;
+
+err:
+	for (n = rb_prev(n); n; n = rb_prev(n)) {
+		struct ssam_nf_refcount_entry *e;
+
+		e = rb_entry(n, struct ssam_nf_refcount_entry, node);
+		ssam_ssh_event_enable(ctrl, e->key.reg, e->key.id, e->flags);
+	}
+	mutex_unlock(&nf->lock);
+
+	return status;
+}
+
+/**
+ * ssam_notifier_restore_registered() - Restore/re-enable events for all
+ * registered notifiers.
+ * @ctrl: The controller for which to restore the notifiers/events.
+ *
+ * Restores/re-enables all events for which notifiers have been registered on
+ * the given controller. In case of a failure, the error is logged and the
+ * function continues to try and enable the remaining events.
+ *
+ * This function is intended to restore/re-enable all registered events after
+ * hibernation. See ssam_notifier_disable_registered() for the counter part
+ * disabling the events and more details.
+ */
+void ssam_notifier_restore_registered(struct ssam_controller *ctrl)
+{
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	struct rb_node *n;
+
+	mutex_lock(&nf->lock);
+	for (n = rb_first(&nf->refcount); n; n = rb_next(n)) {
+		struct ssam_nf_refcount_entry *e;
+
+		e = rb_entry(n, struct ssam_nf_refcount_entry, node);
+
+		/* Ignore errors, will get logged in call. */
+		ssam_ssh_event_enable(ctrl, e->key.reg, e->key.id, e->flags);
+	}
+	mutex_unlock(&nf->lock);
+}
+
+/**
+ * ssam_notifier_is_empty() - Check if there are any registered notifiers.
+ * @ctrl: The controller to check on.
+ *
+ * Return: Returns %true if there are currently no notifiers registered on the
+ * controller, %false otherwise.
+ */
+static bool ssam_notifier_is_empty(struct ssam_controller *ctrl)
+{
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	bool result;
+
+	mutex_lock(&nf->lock);
+	result = ssam_nf_refcount_empty(nf);
+	mutex_unlock(&nf->lock);
+
+	return result;
+}
+
+/**
+ * ssam_notifier_unregister_all() - Unregister all currently registered
+ * notifiers.
+ * @ctrl: The controller to unregister the notifiers on.
+ *
+ * Unregisters all currently registered notifiers. This function is used to
+ * ensure that all notifiers will be unregistered and associated
+ * entries/resources freed when the controller is being shut down.
+ */
+static void ssam_notifier_unregister_all(struct ssam_controller *ctrl)
+{
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	struct ssam_nf_refcount_entry *e, *n;
+
+	mutex_lock(&nf->lock);
+	rbtree_postorder_for_each_entry_safe(e, n, &nf->refcount, node) {
+		/* Ignore errors, will get logged in call. */
+		ssam_ssh_event_disable(ctrl, e->key.reg, e->key.id, e->flags);
+		kfree(e);
+	}
+	nf->refcount = RB_ROOT;
+	mutex_unlock(&nf->lock);
+}
+
+
+/* -- Wakeup IRQ. ----------------------------------------------------------- */
+
+static irqreturn_t ssam_irq_handle(int irq, void *dev_id)
+{
+	struct ssam_controller *ctrl = dev_id;
+
+	ssam_dbg(ctrl, "pm: wake irq triggered\n");
+
+	/*
+	 * Note: Proper wakeup detection is currently unimplemented.
+	 *       When the EC is in display-off or any other non-D0 state, it
+	 *       does not send events/notifications to the host. Instead it
+	 *       signals that there are events available via the wakeup IRQ.
+	 *       This driver is responsible for calling back to the EC to
+	 *       release these events one-by-one.
+	 *
+	 *       This IRQ should not cause a full system resume by its own.
+	 *       Instead, events should be handled by their respective subsystem
+	 *       drivers, which in turn should signal whether a full system
+	 *       resume should be performed.
+	 *
+	 * TODO: Send GPIO callback command repeatedly to EC until callback
+	 *       returns 0x00. Return flag of callback is "has more events".
+	 *       Each time the command is sent, one event is "released". Once
+	 *       all events have been released (return = 0x00), the GPIO is
+	 *       re-armed. Detect wakeup events during this process, go back to
+	 *       sleep if no wakeup event has been received.
+	 */
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ssam_irq_setup() - Set up SAM EC wakeup-GPIO interrupt.
+ * @ctrl: The controller for which the IRQ should be set up.
+ *
+ * Set up an IRQ for the wakeup-GPIO pin of the SAM EC. This IRQ can be used
+ * to wake the device from a low power state.
+ *
+ * Note that this IRQ can only be triggered while the EC is in the display-off
+ * state. In this state, events are not sent to the host in the usual way.
+ * Instead the wakeup-GPIO gets pulled to "high" as long as there are pending
+ * events and these events need to be released one-by-one via the GPIO
+ * callback request, either until there are no events left and the GPIO is
+ * reset, or all at once by transitioning the EC out of the display-off state,
+ * which will also clear the GPIO.
+ *
+ * Not all events, however, should trigger a full system wakeup. Instead the
+ * driver should, if necessary, inspect and forward each event to the
+ * corresponding subsystem, which in turn should decide if the system needs to
+ * be woken up. This logic has not been implemented yet, thus wakeup by this
+ * IRQ should be disabled by default to avoid spurious wake-ups, caused, for
+ * example, by the remaining battery percentage changing. Refer to comments in
+ * this function and comments in the corresponding IRQ handler for more
+ * details on how this should be implemented.
+ *
+ * See also ssam_ctrl_notif_display_off() and ssam_ctrl_notif_display_off()
+ * for functions to transition the EC into and out of the display-off state as
+ * well as more details on it.
+ *
+ * The IRQ is disabled by default and has to be enabled before it can wake up
+ * the device from suspend via ssam_irq_arm_for_wakeup(). On teardown, the IRQ
+ * should be freed via ssam_irq_free().
+ */
+int ssam_irq_setup(struct ssam_controller *ctrl)
+{
+	struct device *dev = ssam_controller_device(ctrl);
+	struct gpio_desc *gpiod;
+	int irq;
+	int status;
+
+	/*
+	 * The actual GPIO interrupt is declared in ACPI as TRIGGER_HIGH.
+	 * However, the GPIO line only gets reset by sending the GPIO callback
+	 * command to SAM (or alternatively the display-on notification). As
+	 * proper handling for this interrupt is not implemented yet, leaving
+	 * the IRQ at TRIGGER_HIGH would cause an IRQ storm (as the callback
+	 * never gets sent and thus the line never gets reset). To avoid this,
+	 * mark the IRQ as TRIGGER_RISING for now, only creating a single
+	 * interrupt, and let the SAM resume callback during the controller
+	 * resume process clear it.
+	 */
+	const int irqf = IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_RISING;
+
+	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+
+	irq = gpiod_to_irq(gpiod);
+	gpiod_put(gpiod);
+
+	if (irq < 0)
+		return irq;
+
+	status = request_threaded_irq(irq, NULL, ssam_irq_handle, irqf,
+				      "ssam_wakeup", ctrl);
+	if (status)
+		return status;
+
+	ctrl->irq.num = irq;
+	disable_irq(ctrl->irq.num);
+	return 0;
+}
+
+/**
+ * ssam_irq_free() - Free SAM EC wakeup-GPIO interrupt.
+ * @ctrl: The controller for which the IRQ should be freed.
+ *
+ * Free the wakeup-GPIO IRQ previously set-up via ssam_irq_setup().
+ */
+void ssam_irq_free(struct ssam_controller *ctrl)
+{
+	free_irq(ctrl->irq.num, ctrl);
+	ctrl->irq.num = -1;
+}
+
+/**
+ * ssam_irq_arm_for_wakeup() - Arm the EC IRQ for wakeup, if enabled.
+ * @ctrl: The controller for which the IRQ should be armed.
+ *
+ * Sets up the IRQ so that it can be used to wake the device. Specifically,
+ * this function enables the irq and then, if the device is allowed to wake up
+ * the system, calls enable_irq_wake(). See ssam_irq_disarm_wakeup() for the
+ * corresponding function to disable the IRQ.
+ *
+ * This function is intended to arm the IRQ before entering S2idle suspend.
+ *
+ * Note: calls to ssam_irq_arm_for_wakeup() and ssam_irq_disarm_wakeup() must
+ * be balanced.
+ */
+int ssam_irq_arm_for_wakeup(struct ssam_controller *ctrl)
+{
+	struct device *dev = ssam_controller_device(ctrl);
+	int status;
+
+	enable_irq(ctrl->irq.num);
+	if (device_may_wakeup(dev)) {
+		status = enable_irq_wake(ctrl->irq.num);
+		if (status) {
+			ssam_err(ctrl, "failed to enable wake IRQ: %d\n", status);
+			disable_irq(ctrl->irq.num);
+			return status;
+		}
+
+		ctrl->irq.wakeup_enabled = true;
+	} else {
+		ctrl->irq.wakeup_enabled = false;
+	}
+
+	return 0;
+}
+
+/**
+ * ssam_irq_disarm_wakeup() - Disarm the wakeup IRQ.
+ * @ctrl: The controller for which the IRQ should be disarmed.
+ *
+ * Disarm the IRQ previously set up for wake via ssam_irq_arm_for_wakeup().
+ *
+ * This function is intended to disarm the IRQ after exiting S2idle suspend.
+ *
+ * Note: calls to ssam_irq_arm_for_wakeup() and ssam_irq_disarm_wakeup() must
+ * be balanced.
+ */
+void ssam_irq_disarm_wakeup(struct ssam_controller *ctrl)
+{
+	int status;
+
+	if (ctrl->irq.wakeup_enabled) {
+		status = disable_irq_wake(ctrl->irq.num);
+		if (status)
+			ssam_err(ctrl, "failed to disable wake IRQ: %d\n", status);
+
+		ctrl->irq.wakeup_enabled = false;
+	}
+	disable_irq(ctrl->irq.num);
+}
diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
new file mode 100644
index 000000000000..5ee9e966f1d7
--- /dev/null
+++ b/drivers/platform/surface/aggregator/controller.h
@@ -0,0 +1,276 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Main SSAM/SSH controller structure and functionality.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _SURFACE_AGGREGATOR_CONTROLLER_H
+#define _SURFACE_AGGREGATOR_CONTROLLER_H
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/serdev.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/serial_hub.h>
+
+#include "ssh_request_layer.h"
+
+
+/* -- Safe counters. -------------------------------------------------------- */
+
+/**
+ * struct ssh_seq_counter - Safe counter for SSH sequence IDs.
+ * @value: The current counter value.
+ */
+struct ssh_seq_counter {
+	u8 value;
+};
+
+/**
+ * struct ssh_rqid_counter - Safe counter for SSH request IDs.
+ * @value: The current counter value.
+ */
+struct ssh_rqid_counter {
+	u16 value;
+};
+
+
+/* -- Event/notification system. -------------------------------------------- */
+
+/**
+ * struct ssam_nf_head - Notifier head for SSAM events.
+ * @srcu: The SRCU struct for synchronization.
+ * @head: List-head for notifier blocks registered under this head.
+ */
+struct ssam_nf_head {
+	struct srcu_struct srcu;
+	struct list_head head;
+};
+
+/**
+ * struct ssam_nf - Notifier callback- and activation-registry for SSAM events.
+ * @lock:     Lock guarding (de-)registration of notifier blocks. Note: This
+ *            lock does not need to be held for notifier calls, only
+ *            registration and deregistration.
+ * @refcount: The root of the RB-tree used for reference-counting enabled
+ *            events/notifications.
+ * @head:     The list of notifier heads for event/notification callbacks.
+ */
+struct ssam_nf {
+	struct mutex lock;
+	struct rb_root refcount;
+	struct ssam_nf_head head[SSH_NUM_EVENTS];
+};
+
+
+/* -- Event/async request completion system. -------------------------------- */
+
+struct ssam_cplt;
+
+/**
+ * struct ssam_event_item - Struct for event queuing and completion.
+ * @node:     The node in the queue.
+ * @rqid:     The request ID of the event.
+ * @event:    Actual event data.
+ */
+struct ssam_event_item {
+	struct list_head node;
+	u16 rqid;
+
+	struct ssam_event event;	/* must be last */
+};
+
+/**
+ * struct ssam_event_queue - Queue for completing received events.
+ * @cplt: Reference to the completion system on which this queue is active.
+ * @lock: The lock for any operation on the queue.
+ * @head: The list-head of the queue.
+ * @work: The &struct work_struct performing completion work for this queue.
+ */
+struct ssam_event_queue {
+	struct ssam_cplt *cplt;
+
+	spinlock_t lock;
+	struct list_head head;
+	struct work_struct work;
+};
+
+/**
+ * struct ssam_event_target - Set of queues for a single SSH target ID.
+ * @queue: The array of queues, one queue per event ID.
+ */
+struct ssam_event_target {
+	struct ssam_event_queue queue[SSH_NUM_EVENTS];
+};
+
+/**
+ * struct ssam_cplt - SSAM event/async request completion system.
+ * @dev:          The device with which this system is associated. Only used
+ *                for logging.
+ * @wq:           The &struct workqueue_struct on which all completion work
+ *                items are queued.
+ * @event:        Event completion management.
+ * @event.target: Array of &struct ssam_event_target, one for each target.
+ * @event.notif:  Notifier callbacks and event activation reference counting.
+ */
+struct ssam_cplt {
+	struct device *dev;
+	struct workqueue_struct *wq;
+
+	struct {
+		struct ssam_event_target target[SSH_NUM_TARGETS];
+		struct ssam_nf notif;
+	} event;
+};
+
+
+/* -- Main SSAM device structures. ------------------------------------------ */
+
+/**
+ * enum ssam_controller_state - State values for &struct ssam_controller.
+ * @SSAM_CONTROLLER_UNINITIALIZED:
+ *	The controller has not been initialized yet or has been deinitialized.
+ * @SSAM_CONTROLLER_INITIALIZED:
+ *	The controller is initialized, but has not been started yet.
+ * @SSAM_CONTROLLER_STARTED:
+ *	The controller has been started and is ready to use.
+ * @SSAM_CONTROLLER_STOPPED:
+ *	The controller has been stopped.
+ * @SSAM_CONTROLLER_SUSPENDED:
+ *	The controller has been suspended.
+ */
+enum ssam_controller_state {
+	SSAM_CONTROLLER_UNINITIALIZED,
+	SSAM_CONTROLLER_INITIALIZED,
+	SSAM_CONTROLLER_STARTED,
+	SSAM_CONTROLLER_STOPPED,
+	SSAM_CONTROLLER_SUSPENDED,
+};
+
+/**
+ * struct ssam_controller_caps - Controller device capabilities.
+ * @ssh_power_profile:             SSH power profile.
+ * @ssh_buffer_size:               SSH driver UART buffer size.
+ * @screen_on_sleep_idle_timeout:  SAM UART screen-on sleep idle timeout.
+ * @screen_off_sleep_idle_timeout: SAM UART screen-off sleep idle timeout.
+ * @d3_closes_handle:              SAM closes UART handle in D3.
+ *
+ * Controller and SSH device capabilities found in ACPI.
+ */
+struct ssam_controller_caps {
+	u32 ssh_power_profile;
+	u32 ssh_buffer_size;
+	u32 screen_on_sleep_idle_timeout;
+	u32 screen_off_sleep_idle_timeout;
+	u32 d3_closes_handle:1;
+};
+
+/**
+ * struct ssam_controller - SSAM controller device.
+ * @kref:  Reference count of the controller.
+ * @lock:  Main lock for the controller, used to guard state changes.
+ * @state: Controller state.
+ * @rtl:   Request transport layer for SSH I/O.
+ * @cplt:  Completion system for SSH/SSAM events and asynchronous requests.
+ * @counter:      Safe SSH message ID counters.
+ * @counter.seq:  Sequence ID counter.
+ * @counter.rqid: Request ID counter.
+ * @irq:          Wakeup IRQ resources.
+ * @irq.num:      The wakeup IRQ number.
+ * @irq.wakeup_enabled: Whether wakeup by IRQ is enabled during suspend.
+ * @caps: The controller device capabilities.
+ */
+struct ssam_controller {
+	struct kref kref;
+
+	struct rw_semaphore lock;
+	enum ssam_controller_state state;
+
+	struct ssh_rtl rtl;
+	struct ssam_cplt cplt;
+
+	struct {
+		struct ssh_seq_counter seq;
+		struct ssh_rqid_counter rqid;
+	} counter;
+
+	struct {
+		int num;
+		bool wakeup_enabled;
+	} irq;
+
+	struct ssam_controller_caps caps;
+};
+
+#define to_ssam_controller(ptr, member) \
+	container_of(ptr, struct ssam_controller, member)
+
+#define ssam_dbg(ctrl, fmt, ...)  rtl_dbg(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
+#define ssam_info(ctrl, fmt, ...) rtl_info(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
+#define ssam_warn(ctrl, fmt, ...) rtl_warn(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
+#define ssam_err(ctrl, fmt, ...)  rtl_err(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
+
+/**
+ * ssam_controller_receive_buf() - Provide input-data to the controller.
+ * @ctrl: The controller.
+ * @buf:  The input buffer.
+ * @n:    The number of bytes in the input buffer.
+ *
+ * Provide input data to be evaluated by the controller, which has been
+ * received via the lower-level transport.
+ *
+ * Return: Returns the number of bytes consumed, or, if the packet transport
+ * layer of the controller has been shut down, %-ESHUTDOWN.
+ */
+static inline
+int ssam_controller_receive_buf(struct ssam_controller *ctrl,
+				const unsigned char *buf, size_t n)
+{
+	return ssh_ptl_rx_rcvbuf(&ctrl->rtl.ptl, buf, n);
+}
+
+/**
+ * ssam_controller_write_wakeup() - Notify the controller that the underlying
+ * device has space available for data to be written.
+ * @ctrl: The controller.
+ */
+static inline void ssam_controller_write_wakeup(struct ssam_controller *ctrl)
+{
+	ssh_ptl_tx_wakeup_transfer(&ctrl->rtl.ptl);
+}
+
+int ssam_controller_init(struct ssam_controller *ctrl, struct serdev_device *s);
+int ssam_controller_start(struct ssam_controller *ctrl);
+void ssam_controller_shutdown(struct ssam_controller *ctrl);
+void ssam_controller_destroy(struct ssam_controller *ctrl);
+
+int ssam_notifier_disable_registered(struct ssam_controller *ctrl);
+void ssam_notifier_restore_registered(struct ssam_controller *ctrl);
+
+int ssam_irq_setup(struct ssam_controller *ctrl);
+void ssam_irq_free(struct ssam_controller *ctrl);
+int ssam_irq_arm_for_wakeup(struct ssam_controller *ctrl);
+void ssam_irq_disarm_wakeup(struct ssam_controller *ctrl);
+
+void ssam_controller_lock(struct ssam_controller *c);
+void ssam_controller_unlock(struct ssam_controller *c);
+
+int ssam_get_firmware_version(struct ssam_controller *ctrl, u32 *version);
+int ssam_ctrl_notif_display_off(struct ssam_controller *ctrl);
+int ssam_ctrl_notif_display_on(struct ssam_controller *ctrl);
+int ssam_ctrl_notif_d0_exit(struct ssam_controller *ctrl);
+int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl);
+
+int ssam_controller_suspend(struct ssam_controller *ctrl);
+int ssam_controller_resume(struct ssam_controller *ctrl);
+
+#endif /* _SURFACE_AGGREGATOR_CONTROLLER_H */
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
new file mode 100644
index 000000000000..ec6c7f40ad36
--- /dev/null
+++ b/drivers/platform/surface/aggregator/core.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Surface Serial Hub (SSH) driver for communication with the Surface/System
+ * Aggregator Module (SSAM/SAM).
+ *
+ * Provides access to a SAM-over-SSH connected EC via a controller device.
+ * Handles communication via requests as well as enabling, disabling, and
+ * relaying of events.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/serdev.h>
+#include <linux/sysfs.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include "controller.h"
+
+
+/* -- Static controller reference. ------------------------------------------ */
+
+/*
+ * Main controller reference. The corresponding lock must be held while
+ * accessing (reading/writing) the reference.
+ */
+static struct ssam_controller *__ssam_controller;
+static DEFINE_SPINLOCK(__ssam_controller_lock);
+
+/**
+ * ssam_get_controller() - Get reference to SSAM controller.
+ *
+ * Returns a reference to the SSAM controller of the system or %NULL if there
+ * is none, it hasn't been set up yet, or it has already been unregistered.
+ * This function automatically increments the reference count of the
+ * controller, thus the calling party must ensure that ssam_controller_put()
+ * is called when it doesn't need the controller any more.
+ */
+struct ssam_controller *ssam_get_controller(void)
+{
+	struct ssam_controller *ctrl;
+
+	spin_lock(&__ssam_controller_lock);
+
+	ctrl = __ssam_controller;
+	if (!ctrl)
+		goto out;
+
+	if (WARN_ON(!kref_get_unless_zero(&ctrl->kref)))
+		ctrl = NULL;
+
+out:
+	spin_unlock(&__ssam_controller_lock);
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(ssam_get_controller);
+
+/**
+ * ssam_try_set_controller() - Try to set the main controller reference.
+ * @ctrl: The controller to which the reference should point.
+ *
+ * Set the main controller reference to the given pointer if the reference
+ * hasn't been set already.
+ *
+ * Return: Returns zero on success or %-EEXIST if the reference has already
+ * been set.
+ */
+static int ssam_try_set_controller(struct ssam_controller *ctrl)
+{
+	int status = 0;
+
+	spin_lock(&__ssam_controller_lock);
+	if (!__ssam_controller)
+		__ssam_controller = ctrl;
+	else
+		status = -EEXIST;
+	spin_unlock(&__ssam_controller_lock);
+
+	return status;
+}
+
+/**
+ * ssam_clear_controller() - Remove/clear the main controller reference.
+ *
+ * Clears the main controller reference, i.e. sets it to %NULL. This function
+ * should be called before the controller is shut down.
+ */
+static void ssam_clear_controller(void)
+{
+	spin_lock(&__ssam_controller_lock);
+	__ssam_controller = NULL;
+	spin_unlock(&__ssam_controller_lock);
+}
+
+/**
+ * ssam_client_link() - Link an arbitrary client device to the controller.
+ * @c: The controller to link to.
+ * @client: The client device.
+ *
+ * Link an arbitrary client device to the controller by creating a device link
+ * between it as consumer and the controller device as provider. This function
+ * can be used for non-SSAM devices (or SSAM devices not registered as child
+ * under the controller) to guarantee that the controller is valid for as long
+ * as the driver of the client device is bound, and that proper suspend and
+ * resume ordering is guaranteed.
+ *
+ * The device link does not have to be destructed manually. It is removed
+ * automatically once the driver of the client device unbinds.
+ *
+ * Return: Returns zero on success, %-ENODEV if the controller is not ready or
+ * going to be removed soon, or %-ENOMEM if the device link could not be
+ * created for other reasons.
+ */
+int ssam_client_link(struct ssam_controller *c, struct device *client)
+{
+	const u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
+	struct device_link *link;
+	struct device *ctrldev;
+
+	ssam_controller_statelock(c);
+
+	if (c->state != SSAM_CONTROLLER_STARTED) {
+		ssam_controller_stateunlock(c);
+		return -ENODEV;
+	}
+
+	ctrldev = ssam_controller_device(c);
+	if (!ctrldev) {
+		ssam_controller_stateunlock(c);
+		return -ENODEV;
+	}
+
+	link = device_link_add(client, ctrldev, flags);
+	if (!link) {
+		ssam_controller_stateunlock(c);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Return -ENODEV if supplier driver is on its way to be removed. In
+	 * this case, the controller won't be around for much longer and the
+	 * device link is not going to save us any more, as unbinding is
+	 * already in progress.
+	 */
+	if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND) {
+		ssam_controller_stateunlock(c);
+		return -ENODEV;
+	}
+
+	ssam_controller_stateunlock(c);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ssam_client_link);
+
+/**
+ * ssam_client_bind() - Bind an arbitrary client device to the controller.
+ * @client: The client device.
+ *
+ * Link an arbitrary client device to the controller by creating a device link
+ * between it as consumer and the main controller device as provider. This
+ * function can be used for non-SSAM devices to guarantee that the controller
+ * returned by this function is valid for as long as the driver of the client
+ * device is bound, and that proper suspend and resume ordering is guaranteed.
+ *
+ * This function does essentially the same as ssam_client_link(), except that
+ * it first fetches the main controller reference, then creates the link, and
+ * finally returns this reference. Note that this function does not increment
+ * the reference counter of the controller, as, due to the link, the
+ * controller lifetime is assured as long as the driver of the client device
+ * is bound.
+ *
+ * It is not valid to use the controller reference obtained by this method
+ * outside of the driver bound to the client device at the time of calling
+ * this function, without first incrementing the reference count of the
+ * controller via ssam_controller_get(). Even after doing this, care must be
+ * taken that requests are only submitted and notifiers are only
+ * (un-)registered when the controller is active and not suspended. In other
+ * words: The device link only lives as long as the client driver is bound and
+ * any guarantees enforced by this link (e.g. active controller state) can
+ * only be relied upon as long as this link exists and may need to be enforced
+ * in other ways afterwards.
+ *
+ * The created device link does not have to be destructed manually. It is
+ * removed automatically once the driver of the client device unbinds.
+ *
+ * Return: Returns the controller on success, an error pointer with %-ENODEV
+ * if the controller is not present, not ready or going to be removed soon, or
+ * %-ENOMEM if the device link could not be created for other reasons.
+ */
+struct ssam_controller *ssam_client_bind(struct device *client)
+{
+	struct ssam_controller *c;
+	int status;
+
+	c = ssam_get_controller();
+	if (!c)
+		return ERR_PTR(-ENODEV);
+
+	status = ssam_client_link(c, client);
+
+	/*
+	 * Note that we can drop our controller reference in both success and
+	 * failure cases: On success, we have bound the controller lifetime
+	 * inherently to the client driver lifetime, i.e. it the controller is
+	 * now guaranteed to outlive the client driver. On failure, we're not
+	 * going to use the controller any more.
+	 */
+	ssam_controller_put(c);
+
+	return status >= 0 ? c : ERR_PTR(status);
+}
+EXPORT_SYMBOL_GPL(ssam_client_bind);
+
+
+/* -- Glue layer (serdev_device -> ssam_controller). ------------------------ */
+
+static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
+			    size_t n)
+{
+	struct ssam_controller *ctrl;
+
+	ctrl = serdev_device_get_drvdata(dev);
+	return ssam_controller_receive_buf(ctrl, buf, n);
+}
+
+static void ssam_write_wakeup(struct serdev_device *dev)
+{
+	ssam_controller_write_wakeup(serdev_device_get_drvdata(dev));
+}
+
+static const struct serdev_device_ops ssam_serdev_ops = {
+	.receive_buf = ssam_receive_buf,
+	.write_wakeup = ssam_write_wakeup,
+};
+
+
+/* -- SysFS and misc. ------------------------------------------------------- */
+
+static int ssam_log_firmware_version(struct ssam_controller *ctrl)
+{
+	u32 version, a, b, c;
+	int status;
+
+	status = ssam_get_firmware_version(ctrl, &version);
+	if (status)
+		return status;
+
+	a = (version >> 24) & 0xff;
+	b = ((version >> 8) & 0xffff);
+	c = version & 0xff;
+
+	ssam_info(ctrl, "SAM firmware version: %u.%u.%u\n", a, b, c);
+	return 0;
+}
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ssam_controller *ctrl = dev_get_drvdata(dev);
+	u32 version, a, b, c;
+	int status;
+
+	status = ssam_get_firmware_version(ctrl, &version);
+	if (status < 0)
+		return status;
+
+	a = (version >> 24) & 0xff;
+	b = ((version >> 8) & 0xffff);
+	c = version & 0xff;
+
+	return sysfs_emit(buf, "%u.%u.%u\n", a, b, c);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static struct attribute *ssam_sam_attrs[] = {
+	&dev_attr_firmware_version.attr,
+	NULL
+};
+
+static const struct attribute_group ssam_sam_group = {
+	.name = "sam",
+	.attrs = ssam_sam_attrs,
+};
+
+
+/* -- ACPI based device setup. ---------------------------------------------- */
+
+static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
+						  void *ctx)
+{
+	struct serdev_device *serdev = ctx;
+	struct acpi_resource_common_serialbus *serial;
+	struct acpi_resource_uart_serialbus *uart;
+	bool flow_control;
+	int status = 0;
+
+	if (rsc->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
+
+	serial = &rsc->data.common_serial_bus;
+	if (serial->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
+		return AE_OK;
+
+	uart = &rsc->data.uart_serial_bus;
+
+	/* Set up serdev device. */
+	serdev_device_set_baudrate(serdev, uart->default_baud_rate);
+
+	/* serdev currently only supports RTSCTS flow control. */
+	if (uart->flow_control & (~((u8)ACPI_UART_FLOW_CONTROL_HW))) {
+		dev_warn(&serdev->dev, "setup: unsupported flow control (value: %#04x)\n",
+			 uart->flow_control);
+	}
+
+	/* Set RTSCTS flow control. */
+	flow_control = uart->flow_control & ACPI_UART_FLOW_CONTROL_HW;
+	serdev_device_set_flow_control(serdev, flow_control);
+
+	/* serdev currently only supports EVEN/ODD parity. */
+	switch (uart->parity) {
+	case ACPI_UART_PARITY_NONE:
+		status = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+		break;
+	case ACPI_UART_PARITY_EVEN:
+		status = serdev_device_set_parity(serdev, SERDEV_PARITY_EVEN);
+		break;
+	case ACPI_UART_PARITY_ODD:
+		status = serdev_device_set_parity(serdev, SERDEV_PARITY_ODD);
+		break;
+	default:
+		dev_warn(&serdev->dev, "setup: unsupported parity (value: %#04x)\n",
+			 uart->parity);
+		break;
+	}
+
+	if (status) {
+		dev_err(&serdev->dev, "setup: failed to set parity (value: %#04x, error: %d)\n",
+			uart->parity, status);
+		return AE_ERROR;
+	}
+
+	/* We've found the resource and are done. */
+	return AE_CTRL_TERMINATE;
+}
+
+static acpi_status ssam_serdev_setup_via_acpi(acpi_handle handle,
+					      struct serdev_device *serdev)
+{
+	return acpi_walk_resources(handle, METHOD_NAME__CRS,
+				   ssam_serdev_setup_via_acpi_crs, serdev);
+}
+
+
+/* -- Power management. ----------------------------------------------------- */
+
+static void ssam_serial_hub_shutdown(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * Try to disable notifiers, signal display-off and D0-exit, ignore any
+	 * errors.
+	 *
+	 * Note: It has not been established yet if this is actually
+	 * necessary/useful for shutdown.
+	 */
+
+	status = ssam_notifier_disable_registered(c);
+	if (status) {
+		ssam_err(c, "pm: failed to disable notifiers for shutdown: %d\n",
+			 status);
+	}
+
+	status = ssam_ctrl_notif_display_off(c);
+	if (status)
+		ssam_err(c, "pm: display-off notification failed: %d\n", status);
+
+	status = ssam_ctrl_notif_d0_exit(c);
+	if (status)
+		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int ssam_serial_hub_pm_prepare(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * Try to signal display-off, This will quiesce events.
+	 *
+	 * Note: Signaling display-off/display-on should normally be done from
+	 * some sort of display state notifier. As that is not available,
+	 * signal it here.
+	 */
+
+	status = ssam_ctrl_notif_display_off(c);
+	if (status)
+		ssam_err(c, "pm: display-off notification failed: %d\n", status);
+
+	return status;
+}
+
+static void ssam_serial_hub_pm_complete(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * Try to signal display-on. This will restore events.
+	 *
+	 * Note: Signaling display-off/display-on should normally be done from
+	 * some sort of display state notifier. As that is not available,
+	 * signal it here.
+	 */
+
+	status = ssam_ctrl_notif_display_on(c);
+	if (status)
+		ssam_err(c, "pm: display-on notification failed: %d\n", status);
+}
+
+static int ssam_serial_hub_pm_suspend(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * Try to signal D0-exit, enable IRQ wakeup if specified. Abort on
+	 * error.
+	 */
+
+	status = ssam_ctrl_notif_d0_exit(c);
+	if (status) {
+		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
+		goto err_notif;
+	}
+
+	status = ssam_irq_arm_for_wakeup(c);
+	if (status)
+		goto err_irq;
+
+	WARN_ON(ssam_controller_suspend(c));
+	return 0;
+
+err_irq:
+	ssam_ctrl_notif_d0_entry(c);
+err_notif:
+	ssam_ctrl_notif_display_on(c);
+	return status;
+}
+
+static int ssam_serial_hub_pm_resume(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	WARN_ON(ssam_controller_resume(c));
+
+	/*
+	 * Try to disable IRQ wakeup (if specified) and signal D0-entry. In
+	 * case of errors, log them and try to restore normal operation state
+	 * as far as possible.
+	 *
+	 * Note: Signaling display-off/display-on should normally be done from
+	 * some sort of display state notifier. As that is not available,
+	 * signal it here.
+	 */
+
+	ssam_irq_disarm_wakeup(c);
+
+	status = ssam_ctrl_notif_d0_entry(c);
+	if (status)
+		ssam_err(c, "pm: D0-entry notification failed: %d\n", status);
+
+	return 0;
+}
+
+static int ssam_serial_hub_pm_freeze(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * During hibernation image creation, we only have to ensure that the
+	 * EC doesn't send us any events. This is done via the display-off
+	 * and D0-exit notifications. Note that this sets up the wakeup IRQ
+	 * on the EC side, however, we have disabled it by default on our side
+	 * and won't enable it here.
+	 *
+	 * See ssam_serial_hub_poweroff() for more details on the hibernation
+	 * process.
+	 */
+
+	status = ssam_ctrl_notif_d0_exit(c);
+	if (status) {
+		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
+		ssam_ctrl_notif_display_on(c);
+		return status;
+	}
+
+	WARN_ON(ssam_controller_suspend(c));
+	return 0;
+}
+
+static int ssam_serial_hub_pm_thaw(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	WARN_ON(ssam_controller_resume(c));
+
+	status = ssam_ctrl_notif_d0_entry(c);
+	if (status)
+		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
+
+	return status;
+}
+
+static int ssam_serial_hub_pm_poweroff(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * When entering hibernation and powering off the system, the EC, at
+	 * least on some models, may disable events. Without us taking care of
+	 * that, this leads to events not being enabled/restored when the
+	 * system resumes from hibernation, resulting SAM-HID subsystem devices
+	 * (i.e. keyboard, touchpad) not working, AC-plug/AC-unplug events being
+	 * gone, etc.
+	 *
+	 * To avoid these issues, we disable all registered events here (this is
+	 * likely not actually required) and restore them during the drivers PM
+	 * restore callback.
+	 *
+	 * Wakeup from the EC interrupt is not supported during hibernation,
+	 * so don't arm the IRQ here.
+	 */
+
+	status = ssam_notifier_disable_registered(c);
+	if (status) {
+		ssam_err(c, "pm: failed to disable notifiers for hibernation: %d\n",
+			 status);
+		return status;
+	}
+
+	status = ssam_ctrl_notif_d0_exit(c);
+	if (status) {
+		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
+		ssam_notifier_restore_registered(c);
+		return status;
+	}
+
+	WARN_ON(ssam_controller_suspend(c));
+	return 0;
+}
+
+static int ssam_serial_hub_pm_restore(struct device *dev)
+{
+	struct ssam_controller *c = dev_get_drvdata(dev);
+	int status;
+
+	/*
+	 * Ignore but log errors, try to restore state as much as possible in
+	 * case of failures. See ssam_serial_hub_poweroff() for more details on
+	 * the hibernation process.
+	 */
+
+	WARN_ON(ssam_controller_resume(c));
+
+	status = ssam_ctrl_notif_d0_entry(c);
+	if (status)
+		ssam_err(c, "pm: D0-entry notification failed: %d\n", status);
+
+	ssam_notifier_restore_registered(c);
+	return 0;
+}
+
+static const struct dev_pm_ops ssam_serial_hub_pm_ops = {
+	.prepare  = ssam_serial_hub_pm_prepare,
+	.complete = ssam_serial_hub_pm_complete,
+	.suspend  = ssam_serial_hub_pm_suspend,
+	.resume   = ssam_serial_hub_pm_resume,
+	.freeze   = ssam_serial_hub_pm_freeze,
+	.thaw     = ssam_serial_hub_pm_thaw,
+	.poweroff = ssam_serial_hub_pm_poweroff,
+	.restore  = ssam_serial_hub_pm_restore,
+};
+
+#else /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ssam_serial_hub_pm_ops = { };
+
+#endif /* CONFIG_PM_SLEEP */
+
+
+/* -- Device/driver setup. -------------------------------------------------- */
+
+static const struct acpi_gpio_params gpio_ssam_wakeup_int = { 0, 0, false };
+static const struct acpi_gpio_params gpio_ssam_wakeup     = { 1, 0, false };
+
+static const struct acpi_gpio_mapping ssam_acpi_gpios[] = {
+	{ "ssam_wakeup-int-gpio", &gpio_ssam_wakeup_int, 1 },
+	{ "ssam_wakeup-gpio",     &gpio_ssam_wakeup,     1 },
+	{ },
+};
+
+static int ssam_serial_hub_probe(struct serdev_device *serdev)
+{
+	struct ssam_controller *ctrl;
+	acpi_handle *ssh = ACPI_HANDLE(&serdev->dev);
+	acpi_status astatus;
+	int status;
+
+	if (gpiod_count(&serdev->dev, NULL) < 0)
+		return -ENODEV;
+
+	status = devm_acpi_dev_add_driver_gpios(&serdev->dev, ssam_acpi_gpios);
+	if (status)
+		return status;
+
+	/* Allocate controller. */
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	/* Initialize controller. */
+	status = ssam_controller_init(ctrl, serdev);
+	if (status)
+		goto err_ctrl_init;
+
+	/* Set up serdev device. */
+	serdev_device_set_drvdata(serdev, ctrl);
+	serdev_device_set_client_ops(serdev, &ssam_serdev_ops);
+	status = serdev_device_open(serdev);
+	if (status)
+		goto err_devopen;
+
+	astatus = ssam_serdev_setup_via_acpi(ssh, serdev);
+	if (ACPI_FAILURE(astatus)) {
+		status = -ENXIO;
+		goto err_devinit;
+	}
+
+	/* Start controller. */
+	status = ssam_controller_start(ctrl);
+	if (status)
+		goto err_devinit;
+
+	/*
+	 * Initial SAM requests: Log version and notify default/init power
+	 * states.
+	 */
+	status = ssam_log_firmware_version(ctrl);
+	if (status)
+		goto err_initrq;
+
+	status = ssam_ctrl_notif_d0_entry(ctrl);
+	if (status)
+		goto err_initrq;
+
+	status = ssam_ctrl_notif_display_on(ctrl);
+	if (status)
+		goto err_initrq;
+
+	status = sysfs_create_group(&serdev->dev.kobj, &ssam_sam_group);
+	if (status)
+		goto err_initrq;
+
+	/* Set up IRQ. */
+	status = ssam_irq_setup(ctrl);
+	if (status)
+		goto err_irq;
+
+	/* Finally, set main controller reference. */
+	status = ssam_try_set_controller(ctrl);
+	if (WARN_ON(status))	/* Currently, we're the only provider. */
+		goto err_mainref;
+
+	/*
+	 * TODO: The EC can wake up the system via the associated GPIO interrupt
+	 *       in multiple situations. One of which is the remaining battery
+	 *       capacity falling below a certain threshold. Normally, we should
+	 *       use the device_init_wakeup function, however, the EC also seems
+	 *       to have other reasons for waking up the system and it seems
+	 *       that Windows has additional checks whether the system should be
+	 *       resumed. In short, this causes some spurious unwanted wake-ups.
+	 *       For now let's thus default power/wakeup to false.
+	 */
+	device_set_wakeup_capable(&serdev->dev, true);
+	acpi_walk_dep_device_list(ssh);
+
+	return 0;
+
+err_mainref:
+	ssam_irq_free(ctrl);
+err_irq:
+	sysfs_remove_group(&serdev->dev.kobj, &ssam_sam_group);
+err_initrq:
+	ssam_controller_shutdown(ctrl);
+err_devinit:
+	serdev_device_close(serdev);
+err_devopen:
+	ssam_controller_destroy(ctrl);
+err_ctrl_init:
+	kfree(ctrl);
+	return status;
+}
+
+static void ssam_serial_hub_remove(struct serdev_device *serdev)
+{
+	struct ssam_controller *ctrl = serdev_device_get_drvdata(serdev);
+	int status;
+
+	/* Clear static reference so that no one else can get a new one. */
+	ssam_clear_controller();
+
+	/* Disable and free IRQ. */
+	ssam_irq_free(ctrl);
+
+	sysfs_remove_group(&serdev->dev.kobj, &ssam_sam_group);
+	ssam_controller_lock(ctrl);
+
+	/* Act as if suspending to silence events. */
+	status = ssam_ctrl_notif_display_off(ctrl);
+	if (status) {
+		dev_err(&serdev->dev, "display-off notification failed: %d\n",
+			status);
+	}
+
+	status = ssam_ctrl_notif_d0_exit(ctrl);
+	if (status) {
+		dev_err(&serdev->dev, "D0-exit notification failed: %d\n",
+			status);
+	}
+
+	/* Shut down controller and remove serdev device reference from it. */
+	ssam_controller_shutdown(ctrl);
+
+	/* Shut down actual transport. */
+	serdev_device_wait_until_sent(serdev, 0);
+	serdev_device_close(serdev);
+
+	/* Drop our controller reference. */
+	ssam_controller_unlock(ctrl);
+	ssam_controller_put(ctrl);
+
+	device_set_wakeup_capable(&serdev->dev, false);
+}
+
+static const struct acpi_device_id ssam_serial_hub_match[] = {
+	{ "MSHW0084", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_match);
+
+static struct serdev_device_driver ssam_serial_hub = {
+	.probe = ssam_serial_hub_probe,
+	.remove = ssam_serial_hub_remove,
+	.driver = {
+		.name = "surface_serial_hub",
+		.acpi_match_table = ssam_serial_hub_match,
+		.pm = &ssam_serial_hub_pm_ops,
+		.shutdown = ssam_serial_hub_shutdown,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_serdev_device_driver(ssam_serial_hub);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Subsystem and Surface Serial Hub driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/surface/aggregator/ssh_msgb.h b/drivers/platform/surface/aggregator/ssh_msgb.h
new file mode 100644
index 000000000000..1221f642dda1
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_msgb.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SSH message builder functions.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _SURFACE_AGGREGATOR_SSH_MSGB_H
+#define _SURFACE_AGGREGATOR_SSH_MSGB_H
+
+#include <asm/unaligned.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/serial_hub.h>
+
+/**
+ * struct msgbuf - Buffer struct to construct SSH messages.
+ * @begin: Pointer to the beginning of the allocated buffer space.
+ * @end:   Pointer to the end (one past last element) of the allocated buffer
+ *         space.
+ * @ptr:   Pointer to the first free element in the buffer.
+ */
+struct msgbuf {
+	u8 *begin;
+	u8 *end;
+	u8 *ptr;
+};
+
+/**
+ * msgb_init() - Initialize the given message buffer struct.
+ * @msgb: The buffer struct to initialize
+ * @ptr:  Pointer to the underlying memory by which the buffer will be backed.
+ * @cap:  Size of the underlying memory.
+ *
+ * Initialize the given message buffer struct using the provided memory as
+ * backing.
+ */
+static inline void msgb_init(struct msgbuf *msgb, u8 *ptr, size_t cap)
+{
+	msgb->begin = ptr;
+	msgb->end = ptr + cap;
+	msgb->ptr = ptr;
+}
+
+/**
+ * msgb_bytes_used() - Return the current number of bytes used in the buffer.
+ * @msgb: The message buffer.
+ */
+static inline size_t msgb_bytes_used(const struct msgbuf *msgb)
+{
+	return msgb->ptr - msgb->begin;
+}
+
+static inline void __msgb_push_u8(struct msgbuf *msgb, u8 value)
+{
+	*msgb->ptr = value;
+	msgb->ptr += sizeof(u8);
+}
+
+static inline void __msgb_push_u16(struct msgbuf *msgb, u16 value)
+{
+	put_unaligned_le16(value, msgb->ptr);
+	msgb->ptr += sizeof(u16);
+}
+
+/**
+ * msgb_push_u16() - Push a u16 value to the buffer.
+ * @msgb:  The message buffer.
+ * @value: The value to push to the buffer.
+ */
+static inline void msgb_push_u16(struct msgbuf *msgb, u16 value)
+{
+	if (WARN_ON(msgb->ptr + sizeof(u16) > msgb->end))
+		return;
+
+	__msgb_push_u16(msgb, value);
+}
+
+/**
+ * msgb_push_syn() - Push SSH SYN bytes to the buffer.
+ * @msgb: The message buffer.
+ */
+static inline void msgb_push_syn(struct msgbuf *msgb)
+{
+	msgb_push_u16(msgb, SSH_MSG_SYN);
+}
+
+/**
+ * msgb_push_buf() - Push raw data to the buffer.
+ * @msgb: The message buffer.
+ * @buf:  The data to push to the buffer.
+ * @len:  The length of the data to push to the buffer.
+ */
+static inline void msgb_push_buf(struct msgbuf *msgb, const u8 *buf, size_t len)
+{
+	msgb->ptr = memcpy(msgb->ptr, buf, len) + len;
+}
+
+/**
+ * msgb_push_crc() - Compute CRC and push it to the buffer.
+ * @msgb: The message buffer.
+ * @buf:  The data for which the CRC should be computed.
+ * @len:  The length of the data for which the CRC should be computed.
+ */
+static inline void msgb_push_crc(struct msgbuf *msgb, const u8 *buf, size_t len)
+{
+	msgb_push_u16(msgb, ssh_crc(buf, len));
+}
+
+/**
+ * msgb_push_frame() - Push a SSH message frame header to the buffer.
+ * @msgb: The message buffer
+ * @ty:   The type of the frame.
+ * @len:  The length of the payload of the frame.
+ * @seq:  The sequence ID of the frame/packet.
+ */
+static inline void msgb_push_frame(struct msgbuf *msgb, u8 ty, u16 len, u8 seq)
+{
+	u8 *const begin = msgb->ptr;
+
+	if (WARN_ON(msgb->ptr + sizeof(struct ssh_frame) > msgb->end))
+		return;
+
+	__msgb_push_u8(msgb, ty);	/* Frame type. */
+	__msgb_push_u16(msgb, len);	/* Frame payload length. */
+	__msgb_push_u8(msgb, seq);	/* Frame sequence ID. */
+
+	msgb_push_crc(msgb, begin, msgb->ptr - begin);
+}
+
+/**
+ * msgb_push_ack() - Push a SSH ACK frame to the buffer.
+ * @msgb: The message buffer
+ * @seq:  The sequence ID of the frame/packet to be ACKed.
+ */
+static inline void msgb_push_ack(struct msgbuf *msgb, u8 seq)
+{
+	/* SYN. */
+	msgb_push_syn(msgb);
+
+	/* ACK-type frame + CRC. */
+	msgb_push_frame(msgb, SSH_FRAME_TYPE_ACK, 0x00, seq);
+
+	/* Payload CRC (ACK-type frames do not have a payload). */
+	msgb_push_crc(msgb, msgb->ptr, 0);
+}
+
+/**
+ * msgb_push_nak() - Push a SSH NAK frame to the buffer.
+ * @msgb: The message buffer
+ */
+static inline void msgb_push_nak(struct msgbuf *msgb)
+{
+	/* SYN. */
+	msgb_push_syn(msgb);
+
+	/* NAK-type frame + CRC. */
+	msgb_push_frame(msgb, SSH_FRAME_TYPE_NAK, 0x00, 0x00);
+
+	/* Payload CRC (ACK-type frames do not have a payload). */
+	msgb_push_crc(msgb, msgb->ptr, 0);
+}
+
+/**
+ * msgb_push_cmd() - Push a SSH command frame with payload to the buffer.
+ * @msgb: The message buffer.
+ * @seq:  The sequence ID (SEQ) of the frame/packet.
+ * @rqid: The request ID (RQID) of the request contained in the frame.
+ * @rqst: The request to wrap in the frame.
+ */
+static inline void msgb_push_cmd(struct msgbuf *msgb, u8 seq, u16 rqid,
+				 const struct ssam_request *rqst)
+{
+	const u8 type = SSH_FRAME_TYPE_DATA_SEQ;
+	u8 *cmd;
+
+	/* SYN. */
+	msgb_push_syn(msgb);
+
+	/* Command frame + CRC. */
+	msgb_push_frame(msgb, type, sizeof(struct ssh_command) + rqst->length, seq);
+
+	/* Frame payload: Command struct + payload. */
+	if (WARN_ON(msgb->ptr + sizeof(struct ssh_command) > msgb->end))
+		return;
+
+	cmd = msgb->ptr;
+
+	__msgb_push_u8(msgb, SSH_PLD_TYPE_CMD);		/* Payload type. */
+	__msgb_push_u8(msgb, rqst->target_category);	/* Target category. */
+	__msgb_push_u8(msgb, rqst->target_id);		/* Target ID (out). */
+	__msgb_push_u8(msgb, 0x00);			/* Target ID (in). */
+	__msgb_push_u8(msgb, rqst->instance_id);	/* Instance ID. */
+	__msgb_push_u16(msgb, rqid);			/* Request ID. */
+	__msgb_push_u8(msgb, rqst->command_id);		/* Command ID. */
+
+	/* Command payload. */
+	msgb_push_buf(msgb, rqst->payload, rqst->length);
+
+	/* CRC for command struct + payload. */
+	msgb_push_crc(msgb, cmd, msgb->ptr - cmd);
+}
+
+#endif /* _SURFACE_AGGREGATOR_SSH_MSGB_H */
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
new file mode 100644
index 000000000000..237d28c90e4b
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -0,0 +1,1699 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SSH packet transport layer.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/atomic.h>
+#include <linux/jiffies.h>
+#include <linux/kfifo.h>
+#include <linux/kref.h>
+#include <linux/kthread.h>
+#include <linux/ktime.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+
+#include "ssh_msgb.h"
+#include "ssh_packet_layer.h"
+#include "ssh_parser.h"
+
+/*
+ * To simplify reasoning about the code below, we define a few concepts. The
+ * system below is similar to a state-machine for packets, however, there are
+ * too many states to explicitly write them down. To (somewhat) manage the
+ * states and packets we rely on flags, reference counting, and some simple
+ * concepts. State transitions are triggered by actions.
+ *
+ * >> Actions <<
+ *
+ * - submit
+ * - transmission start (process next item in queue)
+ * - transmission finished (guaranteed to never be parallel to transmission
+ *   start)
+ * - ACK received
+ * - NAK received (this is equivalent to issuing re-submit for all pending
+ *   packets)
+ * - timeout (this is equivalent to re-issuing a submit or canceling)
+ * - cancel (non-pending and pending)
+ *
+ * >> Data Structures, Packet Ownership, General Overview <<
+ *
+ * The code below employs two main data structures: The packet queue,
+ * containing all packets scheduled for transmission, and the set of pending
+ * packets, containing all packets awaiting an ACK.
+ *
+ * Shared ownership of a packet is controlled via reference counting. Inside
+ * the transport system are a total of five packet owners:
+ *
+ * - the packet queue,
+ * - the pending set,
+ * - the transmitter thread,
+ * - the receiver thread (via ACKing), and
+ * - the timeout work item.
+ *
+ * Normal operation is as follows: The initial reference of the packet is
+ * obtained by submitting the packet and queuing it. The receiver thread takes
+ * packets from the queue. By doing this, it does not increment the refcount
+ * but takes over the reference (removing it from the queue). If the packet is
+ * sequenced (i.e. needs to be ACKed by the client), the transmitter thread
+ * sets-up the timeout and adds the packet to the pending set before starting
+ * to transmit it. As the timeout is handled by a reaper task, no additional
+ * reference for it is needed. After the transmit is done, the reference held
+ * by the transmitter thread is dropped. If the packet is unsequenced (i.e.
+ * does not need an ACK), the packet is completed by the transmitter thread
+ * before dropping that reference.
+ *
+ * On receival of an ACK, the receiver thread removes and obtains the
+ * reference to the packet from the pending set. The receiver thread will then
+ * complete the packet and drop its reference.
+ *
+ * On receival of a NAK, the receiver thread re-submits all currently pending
+ * packets.
+ *
+ * Packet timeouts are detected by the timeout reaper. This is a task,
+ * scheduled depending on the earliest packet timeout expiration date,
+ * checking all currently pending packets if their timeout has expired. If the
+ * timeout of a packet has expired, it is re-submitted and the number of tries
+ * of this packet is incremented. If this number reaches its limit, the packet
+ * will be completed with a failure.
+ *
+ * On transmission failure (such as repeated packet timeouts), the completion
+ * callback is immediately run by on thread on which the error was detected.
+ *
+ * To ensure that a packet eventually leaves the system it is marked as
+ * "locked" directly before it is going to be completed or when it is
+ * canceled. Marking a packet as "locked" has the effect that passing and
+ * creating new references of the packet is disallowed. This means that the
+ * packet cannot be added to the queue, the pending set, and the timeout, or
+ * be picked up by the transmitter thread or receiver thread. To remove a
+ * packet from the system it has to be marked as locked and subsequently all
+ * references from the data structures (queue, pending) have to be removed.
+ * References held by threads will eventually be dropped automatically as
+ * their execution progresses.
+ *
+ * Note that the packet completion callback is, in case of success and for a
+ * sequenced packet, guaranteed to run on the receiver thread, thus providing
+ * a way to reliably identify responses to the packet. The packet completion
+ * callback is only run once and it does not indicate that the packet has
+ * fully left the system (for this, one should rely on the release method,
+ * triggered when the reference count of the packet reaches zero). In case of
+ * re-submission (and with somewhat unlikely timing), it may be possible that
+ * the packet is being re-transmitted while the completion callback runs.
+ * Completion will occur both on success and internal error, as well as when
+ * the packet is canceled.
+ *
+ * >> Flags <<
+ *
+ * Flags are used to indicate the state and progression of a packet. Some flags
+ * have stricter guarantees than other:
+ *
+ * - locked
+ *   Indicates if the packet is locked. If the packet is locked, passing and/or
+ *   creating additional references to the packet is forbidden. The packet thus
+ *   may not be queued, dequeued, or removed or added to the pending set. Note
+ *   that the packet state flags may still change (e.g. it may be marked as
+ *   ACKed, transmitted, ...).
+ *
+ * - completed
+ *   Indicates if the packet completion callback has been executed or is about
+ *   to be executed. This flag is used to ensure that the packet completion
+ *   callback is only run once.
+ *
+ * - queued
+ *   Indicates if a packet is present in the submission queue or not. This flag
+ *   must only be modified with the queue lock held, and must be coherent to the
+ *   presence of the packet in the queue.
+ *
+ * - pending
+ *   Indicates if a packet is present in the set of pending packets or not.
+ *   This flag must only be modified with the pending lock held, and must be
+ *   coherent to the presence of the packet in the pending set.
+ *
+ * - transmitting
+ *   Indicates if the packet is currently transmitting. In case of
+ *   re-transmissions, it is only safe to wait on the "transmitted" completion
+ *   after this flag has been set. The completion will be set both in success
+ *   and error case.
+ *
+ * - transmitted
+ *   Indicates if the packet has been transmitted. This flag is not cleared by
+ *   the system, thus it indicates the first transmission only.
+ *
+ * - acked
+ *   Indicates if the packet has been acknowledged by the client. There are no
+ *   other guarantees given. For example, the packet may still be canceled
+ *   and/or the completion may be triggered an error even though this bit is
+ *   set. Rely on the status provided to the completion callback instead.
+ *
+ * - canceled
+ *   Indicates if the packet has been canceled from the outside. There are no
+ *   other guarantees given. Specifically, the packet may be completed by
+ *   another part of the system before the cancellation attempts to complete it.
+ *
+ * >> General Notes <<
+ *
+ * - To avoid deadlocks, if both queue and pending locks are required, the
+ *   pending lock must be acquired before the queue lock.
+ *
+ * - The packet priority must be accessed only while holding the queue lock.
+ *
+ * - The packet timestamp must be accessed only while holding the pending
+ *   lock.
+ */
+
+/*
+ * SSH_PTL_MAX_PACKET_TRIES - Maximum transmission attempts for packet.
+ *
+ * Maximum number of transmission attempts per sequenced packet in case of
+ * time-outs. Must be smaller than 16. If the packet times out after this
+ * amount of tries, the packet will be completed with %-ETIMEDOUT as status
+ * code.
+ */
+#define SSH_PTL_MAX_PACKET_TRIES		3
+
+/*
+ * SSH_PTL_TX_TIMEOUT - Packet transmission timeout.
+ *
+ * Timeout in jiffies for packet transmission via the underlying serial
+ * device. If transmitting the packet takes longer than this timeout, the
+ * packet will be completed with -ETIMEDOUT. It will not be re-submitted.
+ */
+#define SSH_PTL_TX_TIMEOUT			HZ
+
+/*
+ * SSH_PTL_PACKET_TIMEOUT - Packet response timeout.
+ *
+ * Timeout as ktime_t delta for ACKs. If we have not received an ACK in this
+ * time-frame after starting transmission, the packet will be re-submitted.
+ */
+#define SSH_PTL_PACKET_TIMEOUT			ms_to_ktime(1000)
+
+/*
+ * SSH_PTL_PACKET_TIMEOUT_RESOLUTION - Packet timeout granularity.
+ *
+ * Time-resolution for timeouts. Should be larger than one jiffy to avoid
+ * direct re-scheduling of reaper work_struct.
+ */
+#define SSH_PTL_PACKET_TIMEOUT_RESOLUTION	ms_to_ktime(max(2000 / HZ, 50))
+
+/*
+ * SSH_PTL_MAX_PENDING - Maximum number of pending packets.
+ *
+ * Maximum number of sequenced packets concurrently waiting for an ACK.
+ * Packets marked as blocking will not be transmitted while this limit is
+ * reached.
+ */
+#define SSH_PTL_MAX_PENDING			1
+
+/*
+ * SSH_PTL_RX_BUF_LEN - Evaluation-buffer size in bytes.
+ */
+#define SSH_PTL_RX_BUF_LEN			4096
+
+/*
+ * SSH_PTL_RX_FIFO_LEN - Fifo input-buffer size in bytes.
+ */
+#define SSH_PTL_RX_FIFO_LEN			4096
+
+static void __ssh_ptl_packet_release(struct kref *kref)
+{
+	struct ssh_packet *p = container_of(kref, struct ssh_packet, refcnt);
+
+	ptl_dbg_cond(p->ptl, "ptl: releasing packet %p\n", p);
+	p->ops->release(p);
+}
+
+/**
+ * ssh_packet_get() - Increment reference count of packet.
+ * @packet: The packet to increment the reference count of.
+ *
+ * Increments the reference count of the given packet. See ssh_packet_put()
+ * for the counter-part of this function.
+ *
+ * Return: Returns the packet provided as input.
+ */
+struct ssh_packet *ssh_packet_get(struct ssh_packet *packet)
+{
+	if (packet)
+		kref_get(&packet->refcnt);
+	return packet;
+}
+EXPORT_SYMBOL_GPL(ssh_packet_get);
+
+/**
+ * ssh_packet_put() - Decrement reference count of packet.
+ * @packet: The packet to decrement the reference count of.
+ *
+ * If the reference count reaches zero, the ``release`` callback specified in
+ * the packet's &struct ssh_packet_ops, i.e. ``packet->ops->release``, will be
+ * called.
+ *
+ * See ssh_packet_get() for the counter-part of this function.
+ */
+void ssh_packet_put(struct ssh_packet *packet)
+{
+	if (packet)
+		kref_put(&packet->refcnt, __ssh_ptl_packet_release);
+}
+EXPORT_SYMBOL_GPL(ssh_packet_put);
+
+static u8 ssh_packet_get_seq(struct ssh_packet *packet)
+{
+	return packet->data.ptr[SSH_MSGOFFSET_FRAME(seq)];
+}
+
+/**
+ * ssh_packet_init() - Initialize SSH packet.
+ * @packet:   The packet to initialize.
+ * @type:     Type-flags of the packet.
+ * @priority: Priority of the packet. See SSH_PACKET_PRIORITY() for details.
+ * @ops:      Packet operations.
+ *
+ * Initializes the given SSH packet. Sets the transmission buffer pointer to
+ * %NULL and the transmission buffer length to zero. For data-type packets,
+ * this buffer has to be set separately via ssh_packet_set_data() before
+ * submission, and must contain a valid SSH message, i.e. frame with optional
+ * payload of any type.
+ */
+void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
+		     u8 priority, const struct ssh_packet_ops *ops)
+{
+	kref_init(&packet->refcnt);
+
+	packet->ptl = NULL;
+	INIT_LIST_HEAD(&packet->queue_node);
+	INIT_LIST_HEAD(&packet->pending_node);
+
+	packet->state = type & SSH_PACKET_FLAGS_TY_MASK;
+	packet->priority = priority;
+	packet->timestamp = KTIME_MAX;
+
+	packet->data.ptr = NULL;
+	packet->data.len = 0;
+
+	packet->ops = ops;
+}
+
+/**
+ * ssh_ctrl_packet_alloc() - Allocate control packet.
+ * @packet: Where the pointer to the newly allocated packet should be stored.
+ * @buffer: The buffer corresponding to this packet.
+ * @flags:  Flags used for allocation.
+ *
+ * Allocates a packet and corresponding transport buffer. Sets the packet's
+ * buffer reference to the allocated buffer. The packet must be freed via
+ * ssh_ctrl_packet_free(), which will also free the corresponding buffer. The
+ * corresponding buffer must not be freed separately. Intended to be used with
+ * %ssh_ptl_ctrl_packet_ops as packet operations.
+ *
+ * Return: Returns zero on success, %-ENOMEM if the allocation failed.
+ */
+static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
+				 struct ssam_span *buffer, gfp_t flags)
+{
+	*packet = kzalloc(sizeof(**packet) + SSH_MSG_LEN_CTRL, flags);
+	if (!*packet)
+		return -ENOMEM;
+
+	buffer->ptr = (u8 *)(*packet + 1);
+	buffer->len = SSH_MSG_LEN_CTRL;
+
+	return 0;
+}
+
+/**
+ * ssh_ctrl_packet_free() - Free control packet.
+ * @p: The packet to free.
+ */
+static void ssh_ctrl_packet_free(struct ssh_packet *p)
+{
+	kfree(p);
+}
+
+static const struct ssh_packet_ops ssh_ptl_ctrl_packet_ops = {
+	.complete = NULL,
+	.release = ssh_ctrl_packet_free,
+};
+
+static void ssh_ptl_timeout_reaper_mod(struct ssh_ptl *ptl, ktime_t now,
+				       ktime_t expires)
+{
+	unsigned long delta = msecs_to_jiffies(ktime_ms_delta(expires, now));
+	ktime_t aexp = ktime_add(expires, SSH_PTL_PACKET_TIMEOUT_RESOLUTION);
+
+	spin_lock(&ptl->rtx_timeout.lock);
+
+	/* Re-adjust / schedule reaper only if it is above resolution delta. */
+	if (ktime_before(aexp, ptl->rtx_timeout.expires)) {
+		ptl->rtx_timeout.expires = expires;
+		mod_delayed_work(system_wq, &ptl->rtx_timeout.reaper, delta);
+	}
+
+	spin_unlock(&ptl->rtx_timeout.lock);
+}
+
+/* Must be called with queue lock held. */
+static void ssh_packet_next_try(struct ssh_packet *p)
+{
+	u8 base = ssh_packet_priority_get_base(p->priority);
+	u8 try = ssh_packet_priority_get_try(p->priority);
+
+	p->priority = __SSH_PACKET_PRIORITY(base, try + 1);
+}
+
+/* Must be called with queue lock held. */
+static struct list_head *__ssh_ptl_queue_find_entrypoint(struct ssh_packet *p)
+{
+	struct list_head *head;
+	struct ssh_packet *q;
+
+	/*
+	 * We generally assume that there are less control (ACK/NAK) packets
+	 * and re-submitted data packets as there are normal data packets (at
+	 * least in situations in which many packets are queued; if there
+	 * aren't many packets queued the decision on how to iterate should be
+	 * basically irrelevant; the number of control/data packets is more or
+	 * less limited via the maximum number of pending packets). Thus, when
+	 * inserting a control or re-submitted data packet, (determined by
+	 * their priority), we search from front to back. Normal data packets
+	 * are, usually queued directly at the tail of the queue, so for those
+	 * search from back to front.
+	 */
+
+	if (p->priority > SSH_PACKET_PRIORITY(DATA, 0)) {
+		list_for_each(head, &p->ptl->queue.head) {
+			q = list_entry(head, struct ssh_packet, queue_node);
+
+			if (q->priority < p->priority)
+				break;
+		}
+	} else {
+		list_for_each_prev(head, &p->ptl->queue.head) {
+			q = list_entry(head, struct ssh_packet, queue_node);
+
+			if (q->priority >= p->priority) {
+				head = head->next;
+				break;
+			}
+		}
+	}
+
+	return head;
+}
+
+/* Must be called with queue lock held. */
+static int __ssh_ptl_queue_push(struct ssh_packet *packet)
+{
+	struct ssh_ptl *ptl = packet->ptl;
+	struct list_head *head;
+
+	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
+		return -ESHUTDOWN;
+
+	/* Avoid further transitions when canceling/completing. */
+	if (test_bit(SSH_PACKET_SF_LOCKED_BIT, &packet->state))
+		return -EINVAL;
+
+	/* If this packet has already been queued, do not add it. */
+	if (test_and_set_bit(SSH_PACKET_SF_QUEUED_BIT, &packet->state))
+		return -EALREADY;
+
+	head = __ssh_ptl_queue_find_entrypoint(packet);
+
+	list_add_tail(&ssh_packet_get(packet)->queue_node, head);
+	return 0;
+}
+
+static int ssh_ptl_queue_push(struct ssh_packet *packet)
+{
+	int status;
+
+	spin_lock(&packet->ptl->queue.lock);
+	status = __ssh_ptl_queue_push(packet);
+	spin_unlock(&packet->ptl->queue.lock);
+
+	return status;
+}
+
+static void ssh_ptl_queue_remove(struct ssh_packet *packet)
+{
+	struct ssh_ptl *ptl = packet->ptl;
+
+	spin_lock(&ptl->queue.lock);
+
+	if (!test_and_clear_bit(SSH_PACKET_SF_QUEUED_BIT, &packet->state)) {
+		spin_unlock(&ptl->queue.lock);
+		return;
+	}
+
+	list_del(&packet->queue_node);
+
+	spin_unlock(&ptl->queue.lock);
+	ssh_packet_put(packet);
+}
+
+static void ssh_ptl_pending_push(struct ssh_packet *p)
+{
+	struct ssh_ptl *ptl = p->ptl;
+	const ktime_t timestamp = ktime_get_coarse_boottime();
+	const ktime_t timeout = ptl->rtx_timeout.timeout;
+
+	/*
+	 * Note: We can get the time for the timestamp before acquiring the
+	 * lock as this is the only place we're setting it and this function
+	 * is called only from the transmitter thread. Thus it is not possible
+	 * to overwrite the timestamp with an outdated value below.
+	 */
+
+	spin_lock(&ptl->pending.lock);
+
+	/* If we are canceling/completing this packet, do not add it. */
+	if (test_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state)) {
+		spin_unlock(&ptl->pending.lock);
+		return;
+	}
+
+	/*
+	 * On re-submission, the packet has already been added the pending
+	 * set. We still need to update the timestamp as the packet timeout is
+	 * reset for each (re-)submission.
+	 */
+	p->timestamp = timestamp;
+
+	/* In case it is already pending (e.g. re-submission), do not add it. */
+	if (!test_and_set_bit(SSH_PACKET_SF_PENDING_BIT, &p->state)) {
+		atomic_inc(&ptl->pending.count);
+		list_add_tail(&ssh_packet_get(p)->pending_node, &ptl->pending.head);
+	}
+
+	spin_unlock(&ptl->pending.lock);
+
+	/* Arm/update timeout reaper. */
+	ssh_ptl_timeout_reaper_mod(ptl, timestamp, timestamp + timeout);
+}
+
+static void ssh_ptl_pending_remove(struct ssh_packet *packet)
+{
+	struct ssh_ptl *ptl = packet->ptl;
+
+	spin_lock(&ptl->pending.lock);
+
+	if (!test_and_clear_bit(SSH_PACKET_SF_PENDING_BIT, &packet->state)) {
+		spin_unlock(&ptl->pending.lock);
+		return;
+	}
+
+	list_del(&packet->pending_node);
+	atomic_dec(&ptl->pending.count);
+
+	spin_unlock(&ptl->pending.lock);
+
+	ssh_packet_put(packet);
+}
+
+/* Warning: Does not check/set "completed" bit. */
+static void __ssh_ptl_complete(struct ssh_packet *p, int status)
+{
+	struct ssh_ptl *ptl = READ_ONCE(p->ptl);
+
+	ptl_dbg_cond(ptl, "ptl: completing packet %p (status: %d)\n", p, status);
+
+	if (p->ops->complete)
+		p->ops->complete(p, status);
+}
+
+static void ssh_ptl_remove_and_complete(struct ssh_packet *p, int status)
+{
+	/*
+	 * A call to this function should in general be preceded by
+	 * set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->flags) to avoid re-adding the
+	 * packet to the structures it's going to be removed from.
+	 *
+	 * The set_bit call does not need explicit memory barriers as the
+	 * implicit barrier of the test_and_set_bit() call below ensure that the
+	 * flag is visible before we actually attempt to remove the packet.
+	 */
+
+	if (test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
+		return;
+
+	ssh_ptl_queue_remove(p);
+	ssh_ptl_pending_remove(p);
+
+	__ssh_ptl_complete(p, status);
+}
+
+static bool ssh_ptl_tx_can_process(struct ssh_packet *packet)
+{
+	struct ssh_ptl *ptl = packet->ptl;
+
+	if (test_bit(SSH_PACKET_TY_FLUSH_BIT, &packet->state))
+		return !atomic_read(&ptl->pending.count);
+
+	/* We can always process non-blocking packets. */
+	if (!test_bit(SSH_PACKET_TY_BLOCKING_BIT, &packet->state))
+		return true;
+
+	/* If we are already waiting for this packet, send it again. */
+	if (test_bit(SSH_PACKET_SF_PENDING_BIT, &packet->state))
+		return true;
+
+	/* Otherwise: Check if we have the capacity to send. */
+	return atomic_read(&ptl->pending.count) < SSH_PTL_MAX_PENDING;
+}
+
+static struct ssh_packet *ssh_ptl_tx_pop(struct ssh_ptl *ptl)
+{
+	struct ssh_packet *packet = ERR_PTR(-ENOENT);
+	struct ssh_packet *p, *n;
+
+	spin_lock(&ptl->queue.lock);
+	list_for_each_entry_safe(p, n, &ptl->queue.head, queue_node) {
+		/*
+		 * If we are canceling or completing this packet, ignore it.
+		 * It's going to be removed from this queue shortly.
+		 */
+		if (test_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))
+			continue;
+
+		/*
+		 * Packets should be ordered non-blocking/to-be-resent first.
+		 * If we cannot process this packet, assume that we can't
+		 * process any following packet either and abort.
+		 */
+		if (!ssh_ptl_tx_can_process(p)) {
+			packet = ERR_PTR(-EBUSY);
+			break;
+		}
+
+		/*
+		 * We are allowed to change the state now. Remove it from the
+		 * queue and mark it as being transmitted.
+		 */
+
+		list_del(&p->queue_node);
+
+		set_bit(SSH_PACKET_SF_TRANSMITTING_BIT, &p->state);
+		/* Ensure that state never gets zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_PACKET_SF_QUEUED_BIT, &p->state);
+
+		/*
+		 * Update number of tries. This directly influences the
+		 * priority in case the packet is re-submitted (e.g. via
+		 * timeout/NAK). Note that all reads and writes to the
+		 * priority after the first submission are guarded by the
+		 * queue lock.
+		 */
+		ssh_packet_next_try(p);
+
+		packet = p;
+		break;
+	}
+	spin_unlock(&ptl->queue.lock);
+
+	return packet;
+}
+
+static struct ssh_packet *ssh_ptl_tx_next(struct ssh_ptl *ptl)
+{
+	struct ssh_packet *p;
+
+	p = ssh_ptl_tx_pop(ptl);
+	if (IS_ERR(p))
+		return p;
+
+	if (test_bit(SSH_PACKET_TY_SEQUENCED_BIT, &p->state)) {
+		ptl_dbg(ptl, "ptl: transmitting sequenced packet %p\n", p);
+		ssh_ptl_pending_push(p);
+	} else {
+		ptl_dbg(ptl, "ptl: transmitting non-sequenced packet %p\n", p);
+	}
+
+	return p;
+}
+
+static void ssh_ptl_tx_compl_success(struct ssh_packet *packet)
+{
+	struct ssh_ptl *ptl = packet->ptl;
+
+	ptl_dbg(ptl, "ptl: successfully transmitted packet %p\n", packet);
+
+	/* Transition state to "transmitted". */
+	set_bit(SSH_PACKET_SF_TRANSMITTED_BIT, &packet->state);
+	/* Ensure that state never gets zero. */
+	smp_mb__before_atomic();
+	clear_bit(SSH_PACKET_SF_TRANSMITTING_BIT, &packet->state);
+
+	/* If the packet is unsequenced, we're done: Lock and complete. */
+	if (!test_bit(SSH_PACKET_TY_SEQUENCED_BIT, &packet->state)) {
+		set_bit(SSH_PACKET_SF_LOCKED_BIT, &packet->state);
+		ssh_ptl_remove_and_complete(packet, 0);
+	}
+
+	/*
+	 * Notify that a packet transmission has finished. In general we're only
+	 * waiting for one packet (if any), so wake_up_all should be fine.
+	 */
+	wake_up_all(&ptl->tx.packet_wq);
+}
+
+static void ssh_ptl_tx_compl_error(struct ssh_packet *packet, int status)
+{
+	/* Transmission failure: Lock the packet and try to complete it. */
+	set_bit(SSH_PACKET_SF_LOCKED_BIT, &packet->state);
+	/* Ensure that state never gets zero. */
+	smp_mb__before_atomic();
+	clear_bit(SSH_PACKET_SF_TRANSMITTING_BIT, &packet->state);
+
+	ptl_err(packet->ptl, "ptl: transmission error: %d\n", status);
+	ptl_dbg(packet->ptl, "ptl: failed to transmit packet: %p\n", packet);
+
+	ssh_ptl_remove_and_complete(packet, status);
+
+	/*
+	 * Notify that a packet transmission has finished. In general we're only
+	 * waiting for one packet (if any), so wake_up_all should be fine.
+	 */
+	wake_up_all(&packet->ptl->tx.packet_wq);
+}
+
+static long ssh_ptl_tx_wait_packet(struct ssh_ptl *ptl)
+{
+	int status;
+
+	status = wait_for_completion_interruptible(&ptl->tx.thread_cplt_pkt);
+	reinit_completion(&ptl->tx.thread_cplt_pkt);
+
+	/*
+	 * Ensure completion is cleared before continuing to avoid lost update
+	 * problems.
+	 */
+	smp_mb__after_atomic();
+
+	return status;
+}
+
+static long ssh_ptl_tx_wait_transfer(struct ssh_ptl *ptl, long timeout)
+{
+	long status;
+
+	status = wait_for_completion_interruptible_timeout(&ptl->tx.thread_cplt_tx,
+							   timeout);
+	reinit_completion(&ptl->tx.thread_cplt_tx);
+
+	/*
+	 * Ensure completion is cleared before continuing to avoid lost update
+	 * problems.
+	 */
+	smp_mb__after_atomic();
+
+	return status;
+}
+
+static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
+{
+	long timeout = SSH_PTL_TX_TIMEOUT;
+	size_t offset = 0;
+
+	/* Note: Flush-packets don't have any data. */
+	if (unlikely(!packet->data.ptr))
+		return 0;
+
+	ptl_dbg(ptl, "tx: sending data (length: %zu)\n", packet->data.len);
+	print_hex_dump_debug("tx: ", DUMP_PREFIX_OFFSET, 16, 1,
+			     packet->data.ptr, packet->data.len, false);
+
+	do {
+		ssize_t status, len;
+		u8 *buf;
+
+		buf = packet->data.ptr + offset;
+		len = packet->data.len - offset;
+
+		status = serdev_device_write_buf(ptl->serdev, buf, len);
+		if (status < 0)
+			return status;
+
+		if (status == len)
+			return 0;
+
+		offset += status;
+
+		timeout = ssh_ptl_tx_wait_transfer(ptl, timeout);
+		if (kthread_should_stop() || !atomic_read(&ptl->tx.running))
+			return -ESHUTDOWN;
+
+		if (timeout < 0)
+			return -EINTR;
+
+		if (timeout == 0)
+			return -ETIMEDOUT;
+	} while (true);
+}
+
+static int ssh_ptl_tx_threadfn(void *data)
+{
+	struct ssh_ptl *ptl = data;
+
+	while (!kthread_should_stop() && atomic_read(&ptl->tx.running)) {
+		struct ssh_packet *packet;
+		int status;
+
+		/* Try to get the next packet. */
+		packet = ssh_ptl_tx_next(ptl);
+
+		/* If no packet can be processed, we are done. */
+		if (IS_ERR(packet)) {
+			ssh_ptl_tx_wait_packet(ptl);
+			continue;
+		}
+
+		/* Transfer and complete packet. */
+		status = ssh_ptl_tx_packet(ptl, packet);
+		if (status)
+			ssh_ptl_tx_compl_error(packet, status);
+		else
+			ssh_ptl_tx_compl_success(packet);
+
+		ssh_packet_put(packet);
+	}
+
+	return 0;
+}
+
+/**
+ * ssh_ptl_tx_wakeup_packet() - Wake up packet transmitter thread for new
+ * packet.
+ * @ptl: The packet transport layer.
+ *
+ * Wakes up the packet transmitter thread, notifying it that a new packet has
+ * arrived and is ready for transfer. If the packet transport layer has been
+ * shut down, calls to this function will be ignored.
+ */
+static void ssh_ptl_tx_wakeup_packet(struct ssh_ptl *ptl)
+{
+	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
+		return;
+
+	complete(&ptl->tx.thread_cplt_pkt);
+}
+
+/**
+ * ssh_ptl_tx_start() - Start packet transmitter thread.
+ * @ptl: The packet transport layer.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+int ssh_ptl_tx_start(struct ssh_ptl *ptl)
+{
+	atomic_set_release(&ptl->tx.running, 1);
+
+	ptl->tx.thread = kthread_run(ssh_ptl_tx_threadfn, ptl, "ssam_serial_hub-tx");
+	if (IS_ERR(ptl->tx.thread))
+		return PTR_ERR(ptl->tx.thread);
+
+	return 0;
+}
+
+/**
+ * ssh_ptl_tx_stop() - Stop packet transmitter thread.
+ * @ptl: The packet transport layer.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+int ssh_ptl_tx_stop(struct ssh_ptl *ptl)
+{
+	int status = 0;
+
+	if (!IS_ERR_OR_NULL(ptl->tx.thread)) {
+		/* Tell thread to stop. */
+		atomic_set_release(&ptl->tx.running, 0);
+
+		/*
+		 * Wake up thread in case it is paused. Do not use wakeup
+		 * helpers as this may be called when the shutdown bit has
+		 * already been set.
+		 */
+		complete(&ptl->tx.thread_cplt_pkt);
+		complete(&ptl->tx.thread_cplt_tx);
+
+		/* Finally, wait for thread to stop. */
+		status = kthread_stop(ptl->tx.thread);
+		ptl->tx.thread = NULL;
+	}
+
+	return status;
+}
+
+static struct ssh_packet *ssh_ptl_ack_pop(struct ssh_ptl *ptl, u8 seq_id)
+{
+	struct ssh_packet *packet = ERR_PTR(-ENOENT);
+	struct ssh_packet *p, *n;
+
+	spin_lock(&ptl->pending.lock);
+	list_for_each_entry_safe(p, n, &ptl->pending.head, pending_node) {
+		/*
+		 * We generally expect packets to be in order, so first packet
+		 * to be added to pending is first to be sent, is first to be
+		 * ACKed.
+		 */
+		if (unlikely(ssh_packet_get_seq(p) != seq_id))
+			continue;
+
+		/*
+		 * In case we receive an ACK while handling a transmission
+		 * error completion. The packet will be removed shortly.
+		 */
+		if (unlikely(test_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))) {
+			packet = ERR_PTR(-EPERM);
+			break;
+		}
+
+		/*
+		 * Mark the packet as ACKed and remove it from pending by
+		 * removing its node and decrementing the pending counter.
+		 */
+		set_bit(SSH_PACKET_SF_ACKED_BIT, &p->state);
+		/* Ensure that state never gets zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
+
+		atomic_dec(&ptl->pending.count);
+		list_del(&p->pending_node);
+		packet = p;
+
+		break;
+	}
+	spin_unlock(&ptl->pending.lock);
+
+	return packet;
+}
+
+static void ssh_ptl_wait_until_transmitted(struct ssh_packet *packet)
+{
+	wait_event(packet->ptl->tx.packet_wq,
+		   test_bit(SSH_PACKET_SF_TRANSMITTED_BIT, &packet->state) ||
+		   test_bit(SSH_PACKET_SF_LOCKED_BIT, &packet->state));
+}
+
+static void ssh_ptl_acknowledge(struct ssh_ptl *ptl, u8 seq)
+{
+	struct ssh_packet *p;
+
+	p = ssh_ptl_ack_pop(ptl, seq);
+	if (IS_ERR(p)) {
+		if (PTR_ERR(p) == -ENOENT) {
+			/*
+			 * The packet has not been found in the set of pending
+			 * packets.
+			 */
+			ptl_warn(ptl, "ptl: received ACK for non-pending packet\n");
+		} else {
+			/*
+			 * The packet is pending, but we are not allowed to take
+			 * it because it has been locked.
+			 */
+			WARN_ON(PTR_ERR(p) != -EPERM);
+		}
+		return;
+	}
+
+	ptl_dbg(ptl, "ptl: received ACK for packet %p\n", p);
+
+	/*
+	 * It is possible that the packet has been transmitted, but the state
+	 * has not been updated from "transmitting" to "transmitted" yet.
+	 * In that case, we need to wait for this transition to occur in order
+	 * to determine between success or failure.
+	 *
+	 * On transmission failure, the packet will be locked after this call.
+	 * On success, the transmitted bit will be set.
+	 */
+	ssh_ptl_wait_until_transmitted(p);
+
+	/*
+	 * The packet will already be locked in case of a transmission error or
+	 * cancellation. Let the transmitter or cancellation issuer complete the
+	 * packet.
+	 */
+	if (unlikely(test_and_set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))) {
+		if (unlikely(!test_bit(SSH_PACKET_SF_TRANSMITTED_BIT, &p->state)))
+			ptl_err(ptl, "ptl: received ACK before packet had been fully transmitted\n");
+
+		ssh_packet_put(p);
+		return;
+	}
+
+	ssh_ptl_remove_and_complete(p, 0);
+	ssh_packet_put(p);
+
+	if (atomic_read(&ptl->pending.count) < SSH_PTL_MAX_PENDING)
+		ssh_ptl_tx_wakeup_packet(ptl);
+}
+
+/**
+ * ssh_ptl_submit() - Submit a packet to the transport layer.
+ * @ptl: The packet transport layer to submit the packet to.
+ * @p:   The packet to submit.
+ *
+ * Submits a new packet to the transport layer, queuing it to be sent. This
+ * function should not be used for re-submission.
+ *
+ * Return: Returns zero on success, %-EINVAL if a packet field is invalid or
+ * the packet has been canceled prior to submission, %-EALREADY if the packet
+ * has already been submitted, or %-ESHUTDOWN if the packet transport layer
+ * has been shut down.
+ */
+int ssh_ptl_submit(struct ssh_ptl *ptl, struct ssh_packet *p)
+{
+	struct ssh_ptl *ptl_old;
+	int status;
+
+	/* Validate packet fields. */
+	if (test_bit(SSH_PACKET_TY_FLUSH_BIT, &p->state)) {
+		if (p->data.ptr || test_bit(SSH_PACKET_TY_SEQUENCED_BIT, &p->state))
+			return -EINVAL;
+	} else if (!p->data.ptr) {
+		return -EINVAL;
+	}
+
+	/*
+	 * The ptl reference only gets set on or before the first submission.
+	 * After the first submission, it has to be read-only.
+	 *
+	 * Note that ptl may already be set from upper-layer request
+	 * submission, thus we cannot expect it to be NULL.
+	 */
+	ptl_old = READ_ONCE(p->ptl);
+	if (!ptl_old)
+		WRITE_ONCE(p->ptl, ptl);
+	else if (WARN_ON(ptl_old != ptl))
+		return -EALREADY;	/* Submitted on different PTL. */
+
+	status = ssh_ptl_queue_push(p);
+	if (status)
+		return status;
+
+	if (!test_bit(SSH_PACKET_TY_BLOCKING_BIT, &p->state) ||
+	    (atomic_read(&ptl->pending.count) < SSH_PTL_MAX_PENDING))
+		ssh_ptl_tx_wakeup_packet(ptl);
+
+	return 0;
+}
+
+/*
+ * __ssh_ptl_resubmit() - Re-submit a packet to the transport layer.
+ * @packet: The packet to re-submit.
+ *
+ * Re-submits the given packet: Checks if it can be re-submitted and queues it
+ * if it can, resetting the packet timestamp in the process. Must be called
+ * with the pending lock held.
+ *
+ * Return: Returns %-ECANCELED if the packet has exceeded its number of tries,
+ * %-EINVAL if the packet has been locked, %-EALREADY if the packet is already
+ * on the queue, and %-ESHUTDOWN if the transmission layer has been shut down.
+ */
+static int __ssh_ptl_resubmit(struct ssh_packet *packet)
+{
+	int status;
+	u8 try;
+
+	spin_lock(&packet->ptl->queue.lock);
+
+	/* Check if the packet is out of tries. */
+	try = ssh_packet_priority_get_try(packet->priority);
+	if (try >= SSH_PTL_MAX_PACKET_TRIES) {
+		spin_unlock(&packet->ptl->queue.lock);
+		return -ECANCELED;
+	}
+
+	status = __ssh_ptl_queue_push(packet);
+	if (status) {
+		/*
+		 * An error here indicates that the packet has either already
+		 * been queued, been locked, or the transport layer is being
+		 * shut down. In all cases: Ignore the error.
+		 */
+		spin_unlock(&packet->ptl->queue.lock);
+		return status;
+	}
+
+	packet->timestamp = KTIME_MAX;
+
+	spin_unlock(&packet->ptl->queue.lock);
+	return 0;
+}
+
+static void ssh_ptl_resubmit_pending(struct ssh_ptl *ptl)
+{
+	struct ssh_packet *p;
+	bool resub = false;
+
+	/*
+	 * Note: We deliberately do not remove/attempt to cancel and complete
+	 * packets that are out of tires in this function. The packet will be
+	 * eventually canceled and completed by the timeout. Removing the packet
+	 * here could lead to overly eager cancellation if the packet has not
+	 * been re-transmitted yet but the tries-counter already updated (i.e
+	 * ssh_ptl_tx_next() removed the packet from the queue and updated the
+	 * counter, but re-transmission for the last try has not actually
+	 * started yet).
+	 */
+
+	spin_lock(&ptl->pending.lock);
+
+	/* Re-queue all pending packets. */
+	list_for_each_entry(p, &ptl->pending.head, pending_node) {
+		/*
+		 * Re-submission fails if the packet is out of tries, has been
+		 * locked, is already queued, or the layer is being shut down.
+		 * No need to re-schedule tx-thread in those cases.
+		 */
+		if (!__ssh_ptl_resubmit(p))
+			resub = true;
+	}
+
+	spin_unlock(&ptl->pending.lock);
+
+	if (resub)
+		ssh_ptl_tx_wakeup_packet(ptl);
+}
+
+/**
+ * ssh_ptl_cancel() - Cancel a packet.
+ * @p: The packet to cancel.
+ *
+ * Cancels a packet. There are no guarantees on when completion and release
+ * callbacks will be called. This may occur during execution of this function
+ * or may occur at any point later.
+ *
+ * Note that it is not guaranteed that the packet will actually be canceled if
+ * the packet is concurrently completed by another process. The only guarantee
+ * of this function is that the packet will be completed (with success,
+ * failure, or cancellation) and released from the transport layer in a
+ * reasonable time-frame.
+ *
+ * May be called before the packet has been submitted, in which case any later
+ * packet submission fails.
+ */
+void ssh_ptl_cancel(struct ssh_packet *p)
+{
+	if (test_and_set_bit(SSH_PACKET_SF_CANCELED_BIT, &p->state))
+		return;
+
+	/*
+	 * Lock packet and commit with memory barrier. If this packet has
+	 * already been locked, it's going to be removed and completed by
+	 * another party, which should have precedence.
+	 */
+	if (test_and_set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))
+		return;
+
+	/*
+	 * By marking the packet as locked and employing the implicit memory
+	 * barrier of test_and_set_bit, we have guaranteed that, at this point,
+	 * the packet cannot be added to the queue any more.
+	 *
+	 * In case the packet has never been submitted, packet->ptl is NULL. If
+	 * the packet is currently being submitted, packet->ptl may be NULL or
+	 * non-NULL. Due marking the packet as locked above and committing with
+	 * the memory barrier, we have guaranteed that, if packet->ptl is NULL,
+	 * the packet will never be added to the queue. If packet->ptl is
+	 * non-NULL, we don't have any guarantees.
+	 */
+
+	if (READ_ONCE(p->ptl)) {
+		ssh_ptl_remove_and_complete(p, -ECANCELED);
+
+		if (atomic_read(&p->ptl->pending.count) < SSH_PTL_MAX_PENDING)
+			ssh_ptl_tx_wakeup_packet(p->ptl);
+
+	} else if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state)) {
+		__ssh_ptl_complete(p, -ECANCELED);
+	}
+}
+
+/* must be called with pending lock held */
+static ktime_t ssh_packet_get_expiration(struct ssh_packet *p, ktime_t timeout)
+{
+	if (p->timestamp != KTIME_MAX)
+		return ktime_add(p->timestamp, timeout);
+	else
+		return KTIME_MAX;
+}
+
+static void ssh_ptl_timeout_reap(struct work_struct *work)
+{
+	struct ssh_ptl *ptl = to_ssh_ptl(work, rtx_timeout.reaper.work);
+	struct ssh_packet *p, *n;
+	LIST_HEAD(claimed);
+	ktime_t now = ktime_get_coarse_boottime();
+	ktime_t timeout = ptl->rtx_timeout.timeout;
+	ktime_t next = KTIME_MAX;
+	bool resub = false;
+	int status;
+
+	/*
+	 * Mark reaper as "not pending". This is done before checking any
+	 * packets to avoid lost-update type problems.
+	 */
+	spin_lock(&ptl->rtx_timeout.lock);
+	ptl->rtx_timeout.expires = KTIME_MAX;
+	spin_unlock(&ptl->rtx_timeout.lock);
+
+	spin_lock(&ptl->pending.lock);
+
+	list_for_each_entry_safe(p, n, &ptl->pending.head, pending_node) {
+		ktime_t expires = ssh_packet_get_expiration(p, timeout);
+
+		/*
+		 * Check if the timeout hasn't expired yet. Find out next
+		 * expiration date to be handled after this run.
+		 */
+		if (ktime_after(expires, now)) {
+			next = ktime_before(expires, next) ? expires : next;
+			continue;
+		}
+
+		status = __ssh_ptl_resubmit(p);
+
+		/*
+		 * Re-submission fails if the packet is out of tries, has been
+		 * locked, is already queued, or the layer is being shut down.
+		 * No need to re-schedule tx-thread in those cases.
+		 */
+		if (!status)
+			resub = true;
+
+		/* Go to next packet if this packet is not out of tries. */
+		if (status != -ECANCELED)
+			continue;
+
+		/* No more tries left: Cancel the packet. */
+
+		/*
+		 * If someone else has locked the packet already, don't use it
+		 * and let the other party complete it.
+		 */
+		if (test_and_set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))
+			continue;
+
+		/*
+		 * We have now marked the packet as locked. Thus it cannot be
+		 * added to the pending list again after we've removed it here.
+		 * We can therefore re-use the pending_node of this packet
+		 * temporarily.
+		 */
+
+		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
+
+		atomic_dec(&ptl->pending.count);
+		list_del(&p->pending_node);
+
+		list_add_tail(&p->pending_node, &claimed);
+	}
+
+	spin_unlock(&ptl->pending.lock);
+
+	/* Cancel and complete the packet. */
+	list_for_each_entry_safe(p, n, &claimed, pending_node) {
+		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state)) {
+			ssh_ptl_queue_remove(p);
+			__ssh_ptl_complete(p, -ETIMEDOUT);
+		}
+
+		/*
+		 * Drop the reference we've obtained by removing it from
+		 * the pending set.
+		 */
+		list_del(&p->pending_node);
+		ssh_packet_put(p);
+	}
+
+	/* Ensure that reaper doesn't run again immediately. */
+	next = max(next, ktime_add(now, SSH_PTL_PACKET_TIMEOUT_RESOLUTION));
+	if (next != KTIME_MAX)
+		ssh_ptl_timeout_reaper_mod(ptl, now, next);
+
+	if (resub)
+		ssh_ptl_tx_wakeup_packet(ptl);
+}
+
+static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, u8 seq)
+{
+	int i;
+
+	/*
+	 * Check if SEQ has been seen recently (i.e. packet was
+	 * re-transmitted and we should ignore it).
+	 */
+	for (i = 0; i < ARRAY_SIZE(ptl->rx.blocked.seqs); i++) {
+		if (likely(ptl->rx.blocked.seqs[i] != seq))
+			continue;
+
+		ptl_dbg(ptl, "ptl: ignoring repeated data packet\n");
+		return true;
+	}
+
+	/* Update list of blocked sequence IDs. */
+	ptl->rx.blocked.seqs[ptl->rx.blocked.offset] = seq;
+	ptl->rx.blocked.offset = (ptl->rx.blocked.offset + 1)
+				  % ARRAY_SIZE(ptl->rx.blocked.seqs);
+
+	return false;
+}
+
+static void ssh_ptl_rx_dataframe(struct ssh_ptl *ptl,
+				 const struct ssh_frame *frame,
+				 const struct ssam_span *payload)
+{
+	if (ssh_ptl_rx_retransmit_check(ptl, frame->seq))
+		return;
+
+	ptl->ops.data_received(ptl, payload);
+}
+
+static void ssh_ptl_send_ack(struct ssh_ptl *ptl, u8 seq)
+{
+	struct ssh_packet *packet;
+	struct ssam_span buf;
+	struct msgbuf msgb;
+	int status;
+
+	status = ssh_ctrl_packet_alloc(&packet, &buf, GFP_KERNEL);
+	if (status) {
+		ptl_err(ptl, "ptl: failed to allocate ACK packet\n");
+		return;
+	}
+
+	ssh_packet_init(packet, 0, SSH_PACKET_PRIORITY(ACK, 0),
+			&ssh_ptl_ctrl_packet_ops);
+
+	msgb_init(&msgb, buf.ptr, buf.len);
+	msgb_push_ack(&msgb, seq);
+	ssh_packet_set_data(packet, msgb.begin, msgb_bytes_used(&msgb));
+
+	ssh_ptl_submit(ptl, packet);
+	ssh_packet_put(packet);
+}
+
+static void ssh_ptl_send_nak(struct ssh_ptl *ptl)
+{
+	struct ssh_packet *packet;
+	struct ssam_span buf;
+	struct msgbuf msgb;
+	int status;
+
+	status = ssh_ctrl_packet_alloc(&packet, &buf, GFP_KERNEL);
+	if (status) {
+		ptl_err(ptl, "ptl: failed to allocate NAK packet\n");
+		return;
+	}
+
+	ssh_packet_init(packet, 0, SSH_PACKET_PRIORITY(NAK, 0),
+			&ssh_ptl_ctrl_packet_ops);
+
+	msgb_init(&msgb, buf.ptr, buf.len);
+	msgb_push_nak(&msgb);
+	ssh_packet_set_data(packet, msgb.begin, msgb_bytes_used(&msgb));
+
+	ssh_ptl_submit(ptl, packet);
+	ssh_packet_put(packet);
+}
+
+static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
+{
+	struct ssh_frame *frame;
+	struct ssam_span payload;
+	struct ssam_span aligned;
+	bool syn_found;
+	int status;
+
+	/* Find SYN. */
+	syn_found = sshp_find_syn(source, &aligned);
+
+	if (unlikely(aligned.ptr - source->ptr) > 0) {
+		ptl_warn(ptl, "rx: parser: invalid start of frame, skipping\n");
+
+		/*
+		 * Notes:
+		 * - This might send multiple NAKs in case the communication
+		 *   starts with an invalid SYN and is broken down into multiple
+		 *   pieces. This should generally be handled fine, we just
+		 *   might receive duplicate data in this case, which is
+		 *   detected when handling data frames.
+		 * - This path will also be executed on invalid CRCs: When an
+		 *   invalid CRC is encountered, the code below will skip data
+		 *   until directly after the SYN. This causes the search for
+		 *   the next SYN, which is generally not placed directly after
+		 *   the last one.
+		 *
+		 *   Open question: Should we send this in case of invalid
+		 *   payload CRCs if the frame-type is non-sequential (current
+		 *   implementation) or should we drop that frame without
+		 *   telling the EC?
+		 */
+		ssh_ptl_send_nak(ptl);
+	}
+
+	if (unlikely(!syn_found))
+		return aligned.ptr - source->ptr;
+
+	/* Parse and validate frame. */
+	status = sshp_parse_frame(&ptl->serdev->dev, &aligned, &frame, &payload,
+				  SSH_PTL_RX_BUF_LEN);
+	if (status)	/* Invalid frame: skip to next SYN. */
+		return aligned.ptr - source->ptr + sizeof(u16);
+	if (!frame)	/* Not enough data. */
+		return aligned.ptr - source->ptr;
+
+	switch (frame->type) {
+	case SSH_FRAME_TYPE_ACK:
+		ssh_ptl_acknowledge(ptl, frame->seq);
+		break;
+
+	case SSH_FRAME_TYPE_NAK:
+		ssh_ptl_resubmit_pending(ptl);
+		break;
+
+	case SSH_FRAME_TYPE_DATA_SEQ:
+		ssh_ptl_send_ack(ptl, frame->seq);
+		fallthrough;
+
+	case SSH_FRAME_TYPE_DATA_NSQ:
+		ssh_ptl_rx_dataframe(ptl, frame, &payload);
+		break;
+
+	default:
+		ptl_warn(ptl, "ptl: received frame with unknown type %#04x\n",
+			 frame->type);
+		break;
+	}
+
+	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(frame->len);
+}
+
+static int ssh_ptl_rx_threadfn(void *data)
+{
+	struct ssh_ptl *ptl = data;
+
+	while (true) {
+		struct ssam_span span;
+		size_t offs = 0;
+		size_t n;
+
+		wait_event_interruptible(ptl->rx.wq,
+					 !kfifo_is_empty(&ptl->rx.fifo) ||
+					 kthread_should_stop());
+		if (kthread_should_stop())
+			break;
+
+		/* Copy from fifo to evaluation buffer. */
+		n = sshp_buf_read_from_fifo(&ptl->rx.buf, &ptl->rx.fifo);
+
+		ptl_dbg(ptl, "rx: received data (size: %zu)\n", n);
+		print_hex_dump_debug("rx: ", DUMP_PREFIX_OFFSET, 16, 1,
+				     ptl->rx.buf.ptr + ptl->rx.buf.len - n,
+				     n, false);
+
+		/* Parse until we need more bytes or buffer is empty. */
+		while (offs < ptl->rx.buf.len) {
+			sshp_buf_span_from(&ptl->rx.buf, offs, &span);
+			n = ssh_ptl_rx_eval(ptl, &span);
+			if (n == 0)
+				break;	/* Need more bytes. */
+
+			offs += n;
+		}
+
+		/* Throw away the evaluated parts. */
+		sshp_buf_drop(&ptl->rx.buf, offs);
+	}
+
+	return 0;
+}
+
+static void ssh_ptl_rx_wakeup(struct ssh_ptl *ptl)
+{
+	wake_up(&ptl->rx.wq);
+}
+
+/**
+ * ssh_ptl_rx_start() - Start packet transport layer receiver thread.
+ * @ptl: The packet transport layer.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+int ssh_ptl_rx_start(struct ssh_ptl *ptl)
+{
+	if (ptl->rx.thread)
+		return 0;
+
+	ptl->rx.thread = kthread_run(ssh_ptl_rx_threadfn, ptl,
+				     "ssam_serial_hub-rx");
+	if (IS_ERR(ptl->rx.thread))
+		return PTR_ERR(ptl->rx.thread);
+
+	return 0;
+}
+
+/**
+ * ssh_ptl_rx_stop() - Stop packet transport layer receiver thread.
+ * @ptl: The packet transport layer.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+int ssh_ptl_rx_stop(struct ssh_ptl *ptl)
+{
+	int status = 0;
+
+	if (ptl->rx.thread) {
+		status = kthread_stop(ptl->rx.thread);
+		ptl->rx.thread = NULL;
+	}
+
+	return status;
+}
+
+/**
+ * ssh_ptl_rx_rcvbuf() - Push data from lower-layer transport to the packet
+ * layer.
+ * @ptl: The packet transport layer.
+ * @buf: Pointer to the data to push to the layer.
+ * @n:   Size of the data to push to the layer, in bytes.
+ *
+ * Pushes data from a lower-layer transport to the receiver fifo buffer of the
+ * packet layer and notifies the receiver thread. Calls to this function are
+ * ignored once the packet layer has been shut down.
+ *
+ * Return: Returns the number of bytes transferred (positive or zero) on
+ * success. Returns %-ESHUTDOWN if the packet layer has been shut down.
+ */
+int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n)
+{
+	int used;
+
+	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
+		return -ESHUTDOWN;
+
+	used = kfifo_in(&ptl->rx.fifo, buf, n);
+	if (used)
+		ssh_ptl_rx_wakeup(ptl);
+
+	return used;
+}
+
+/**
+ * ssh_ptl_shutdown() - Shut down the packet transport layer.
+ * @ptl: The packet transport layer.
+ *
+ * Shuts down the packet transport layer, removing and canceling all queued
+ * and pending packets. Packets canceled by this operation will be completed
+ * with %-ESHUTDOWN as status. Receiver and transmitter threads will be
+ * stopped.
+ *
+ * As a result of this function, the transport layer will be marked as shut
+ * down. Submission of packets after the transport layer has been shut down
+ * will fail with %-ESHUTDOWN.
+ */
+void ssh_ptl_shutdown(struct ssh_ptl *ptl)
+{
+	LIST_HEAD(complete_q);
+	LIST_HEAD(complete_p);
+	struct ssh_packet *p, *n;
+	int status;
+
+	/* Ensure that no new packets (including ACK/NAK) can be submitted. */
+	set_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state);
+	/*
+	 * Ensure that the layer gets marked as shut-down before actually
+	 * stopping it. In combination with the check in ssh_ptl_queue_push(),
+	 * this guarantees that no new packets can be added and all already
+	 * queued packets are properly canceled. In combination with the check
+	 * in ssh_ptl_rx_rcvbuf(), this guarantees that received data is
+	 * properly cut off.
+	 */
+	smp_mb__after_atomic();
+
+	status = ssh_ptl_rx_stop(ptl);
+	if (status)
+		ptl_err(ptl, "ptl: failed to stop receiver thread\n");
+
+	status = ssh_ptl_tx_stop(ptl);
+	if (status)
+		ptl_err(ptl, "ptl: failed to stop transmitter thread\n");
+
+	cancel_delayed_work_sync(&ptl->rtx_timeout.reaper);
+
+	/*
+	 * At this point, all threads have been stopped. This means that the
+	 * only references to packets from inside the system are in the queue
+	 * and pending set.
+	 *
+	 * Note: We still need locks here because someone could still be
+	 * canceling packets.
+	 *
+	 * Note 2: We can re-use queue_node (or pending_node) if we mark the
+	 * packet as locked an then remove it from the queue (or pending set
+	 * respectively). Marking the packet as locked avoids re-queuing
+	 * (which should already be prevented by having stopped the treads...)
+	 * and not setting QUEUED_BIT (or PENDING_BIT) prevents removal from a
+	 * new list via other threads (e.g. cancellation).
+	 *
+	 * Note 3: There may be overlap between complete_p and complete_q.
+	 * This is handled via test_and_set_bit() on the "completed" flag
+	 * (also handles cancellation).
+	 */
+
+	/* Mark queued packets as locked and move them to complete_q. */
+	spin_lock(&ptl->queue.lock);
+	list_for_each_entry_safe(p, n, &ptl->queue.head, queue_node) {
+		set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state);
+		/* Ensure that state does not get zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_PACKET_SF_QUEUED_BIT, &p->state);
+
+		list_del(&p->queue_node);
+		list_add_tail(&p->queue_node, &complete_q);
+	}
+	spin_unlock(&ptl->queue.lock);
+
+	/* Mark pending packets as locked and move them to complete_p. */
+	spin_lock(&ptl->pending.lock);
+	list_for_each_entry_safe(p, n, &ptl->pending.head, pending_node) {
+		set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state);
+		/* Ensure that state does not get zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
+
+		list_del(&p->pending_node);
+		list_add_tail(&p->pending_node, &complete_q);
+	}
+	atomic_set(&ptl->pending.count, 0);
+	spin_unlock(&ptl->pending.lock);
+
+	/* Complete and drop packets on complete_q. */
+	list_for_each_entry(p, &complete_q, queue_node) {
+		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
+			__ssh_ptl_complete(p, -ESHUTDOWN);
+
+		ssh_packet_put(p);
+	}
+
+	/* Complete and drop packets on complete_p. */
+	list_for_each_entry(p, &complete_p, pending_node) {
+		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
+			__ssh_ptl_complete(p, -ESHUTDOWN);
+
+		ssh_packet_put(p);
+	}
+
+	/*
+	 * At this point we have guaranteed that the system doesn't reference
+	 * any packets any more.
+	 */
+}
+
+/**
+ * ssh_ptl_init() - Initialize packet transport layer.
+ * @ptl:    The packet transport layer to initialize.
+ * @serdev: The underlying serial device, i.e. the lower-level transport.
+ * @ops:    Packet layer operations.
+ *
+ * Initializes the given packet transport layer. Transmitter and receiver
+ * threads must be started separately via ssh_ptl_tx_start() and
+ * ssh_ptl_rx_start(), after the packet-layer has been initialized and the
+ * lower-level transport layer has been set up.
+ *
+ * Return: Returns zero on success and a nonzero error code on failure.
+ */
+int ssh_ptl_init(struct ssh_ptl *ptl, struct serdev_device *serdev,
+		 struct ssh_ptl_ops *ops)
+{
+	int i, status;
+
+	ptl->serdev = serdev;
+	ptl->state = 0;
+
+	spin_lock_init(&ptl->queue.lock);
+	INIT_LIST_HEAD(&ptl->queue.head);
+
+	spin_lock_init(&ptl->pending.lock);
+	INIT_LIST_HEAD(&ptl->pending.head);
+	atomic_set_release(&ptl->pending.count, 0);
+
+	ptl->tx.thread = NULL;
+	atomic_set(&ptl->tx.running, 0);
+	init_completion(&ptl->tx.thread_cplt_pkt);
+	init_completion(&ptl->tx.thread_cplt_tx);
+	init_waitqueue_head(&ptl->tx.packet_wq);
+
+	ptl->rx.thread = NULL;
+	init_waitqueue_head(&ptl->rx.wq);
+
+	spin_lock_init(&ptl->rtx_timeout.lock);
+	ptl->rtx_timeout.timeout = SSH_PTL_PACKET_TIMEOUT;
+	ptl->rtx_timeout.expires = KTIME_MAX;
+	INIT_DELAYED_WORK(&ptl->rtx_timeout.reaper, ssh_ptl_timeout_reap);
+
+	ptl->ops = *ops;
+
+	/* Initialize list of recent/blocked SEQs with invalid sequence IDs. */
+	for (i = 0; i < ARRAY_SIZE(ptl->rx.blocked.seqs); i++)
+		ptl->rx.blocked.seqs[i] = U16_MAX;
+	ptl->rx.blocked.offset = 0;
+
+	status = kfifo_alloc(&ptl->rx.fifo, SSH_PTL_RX_FIFO_LEN, GFP_KERNEL);
+	if (status)
+		return status;
+
+	status = sshp_buf_alloc(&ptl->rx.buf, SSH_PTL_RX_BUF_LEN, GFP_KERNEL);
+	if (status)
+		kfifo_free(&ptl->rx.fifo);
+
+	return status;
+}
+
+/**
+ * ssh_ptl_destroy() - Deinitialize packet transport layer.
+ * @ptl: The packet transport layer to deinitialize.
+ *
+ * Deinitializes the given packet transport layer and frees resources
+ * associated with it. If receiver and/or transmitter threads have been
+ * started, the layer must first be shut down via ssh_ptl_shutdown() before
+ * this function can be called.
+ */
+void ssh_ptl_destroy(struct ssh_ptl *ptl)
+{
+	kfifo_free(&ptl->rx.fifo);
+	sshp_buf_free(&ptl->rx.buf);
+}
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.h b/drivers/platform/surface/aggregator/ssh_packet_layer.h
new file mode 100644
index 000000000000..058f111292ca
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SSH packet transport layer.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H
+#define _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H
+
+#include <linux/atomic.h>
+#include <linux/kfifo.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/serdev.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+#include "ssh_parser.h"
+
+/**
+ * enum ssh_ptl_state_flags - State-flags for &struct ssh_ptl.
+ *
+ * @SSH_PTL_SF_SHUTDOWN_BIT:
+ *	Indicates that the packet transport layer has been shut down or is
+ *	being shut down and should not accept any new packets/data.
+ */
+enum ssh_ptl_state_flags {
+	SSH_PTL_SF_SHUTDOWN_BIT,
+};
+
+/**
+ * struct ssh_ptl_ops - Callback operations for packet transport layer.
+ * @data_received: Function called when a data-packet has been received. Both,
+ *                 the packet layer on which the packet has been received and
+ *                 the packet's payload data are provided to this function.
+ */
+struct ssh_ptl_ops {
+	void (*data_received)(struct ssh_ptl *p, const struct ssam_span *data);
+};
+
+/**
+ * struct ssh_ptl - SSH packet transport layer.
+ * @serdev:        Serial device providing the underlying data transport.
+ * @state:         State(-flags) of the transport layer.
+ * @queue:         Packet submission queue.
+ * @queue.lock:    Lock for modifying the packet submission queue.
+ * @queue.head:    List-head of the packet submission queue.
+ * @pending:       Set/list of pending packets.
+ * @pending.lock:  Lock for modifying the pending set.
+ * @pending.head:  List-head of the pending set/list.
+ * @pending.count: Number of currently pending packets.
+ * @tx:            Transmitter subsystem.
+ * @tx.running:    Flag indicating (desired) transmitter thread state.
+ * @tx.thread:     Transmitter thread.
+ * @tx.thread_cplt_tx:  Completion for transmitter thread waiting on transfer.
+ * @tx.thread_cplt_pkt: Completion for transmitter thread waiting on packets.
+ * @tx.packet_wq:  Waitqueue-head for packet transmit completion.
+ * @rx:            Receiver subsystem.
+ * @rx.thread:     Receiver thread.
+ * @rx.wq:         Waitqueue-head for receiver thread.
+ * @rx.fifo:       Buffer for receiving data/pushing data to receiver thread.
+ * @rx.buf:        Buffer for evaluating data on receiver thread.
+ * @rx.blocked:    List of recent/blocked sequence IDs to detect retransmission.
+ * @rx.blocked.seqs:   Array of blocked sequence IDs.
+ * @rx.blocked.offset: Offset indicating where a new ID should be inserted.
+ * @rtx_timeout:   Retransmission timeout subsystem.
+ * @rtx_timeout.lock:    Lock for modifying the retransmission timeout reaper.
+ * @rtx_timeout.timeout: Timeout interval for retransmission.
+ * @rtx_timeout.expires: Time specifying when the reaper work is next scheduled.
+ * @rtx_timeout.reaper:  Work performing timeout checks and subsequent actions.
+ * @ops:           Packet layer operations.
+ */
+struct ssh_ptl {
+	struct serdev_device *serdev;
+	unsigned long state;
+
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+	} queue;
+
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+		atomic_t count;
+	} pending;
+
+	struct {
+		atomic_t running;
+		struct task_struct *thread;
+		struct completion thread_cplt_tx;
+		struct completion thread_cplt_pkt;
+		struct wait_queue_head packet_wq;
+	} tx;
+
+	struct {
+		struct task_struct *thread;
+		struct wait_queue_head wq;
+		struct kfifo fifo;
+		struct sshp_buf buf;
+
+		struct {
+			u16 seqs[8];
+			u16 offset;
+		} blocked;
+	} rx;
+
+	struct {
+		spinlock_t lock;
+		ktime_t timeout;
+		ktime_t expires;
+		struct delayed_work reaper;
+	} rtx_timeout;
+
+	struct ssh_ptl_ops ops;
+};
+
+#define __ssam_prcond(func, p, fmt, ...)		\
+	do {						\
+		typeof(p) __p = (p);			\
+							\
+		if (__p)				\
+			func(__p, fmt, ##__VA_ARGS__);	\
+	} while (0)
+
+#define ptl_dbg(p, fmt, ...)  dev_dbg(&(p)->serdev->dev, fmt, ##__VA_ARGS__)
+#define ptl_info(p, fmt, ...) dev_info(&(p)->serdev->dev, fmt, ##__VA_ARGS__)
+#define ptl_warn(p, fmt, ...) dev_warn(&(p)->serdev->dev, fmt, ##__VA_ARGS__)
+#define ptl_err(p, fmt, ...)  dev_err(&(p)->serdev->dev, fmt, ##__VA_ARGS__)
+#define ptl_dbg_cond(p, fmt, ...) __ssam_prcond(ptl_dbg, p, fmt, ##__VA_ARGS__)
+
+#define to_ssh_ptl(ptr, member) \
+	container_of(ptr, struct ssh_ptl, member)
+
+int ssh_ptl_init(struct ssh_ptl *ptl, struct serdev_device *serdev,
+		 struct ssh_ptl_ops *ops);
+
+void ssh_ptl_destroy(struct ssh_ptl *ptl);
+
+/**
+ * ssh_ptl_get_device() - Get device associated with packet transport layer.
+ * @ptl: The packet transport layer.
+ *
+ * Return: Returns the device on which the given packet transport layer builds
+ * upon.
+ */
+static inline struct device *ssh_ptl_get_device(struct ssh_ptl *ptl)
+{
+	return ptl->serdev ? &ptl->serdev->dev : NULL;
+}
+
+int ssh_ptl_tx_start(struct ssh_ptl *ptl);
+int ssh_ptl_tx_stop(struct ssh_ptl *ptl);
+int ssh_ptl_rx_start(struct ssh_ptl *ptl);
+int ssh_ptl_rx_stop(struct ssh_ptl *ptl);
+void ssh_ptl_shutdown(struct ssh_ptl *ptl);
+
+int ssh_ptl_submit(struct ssh_ptl *ptl, struct ssh_packet *p);
+void ssh_ptl_cancel(struct ssh_packet *p);
+
+int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n);
+
+/**
+ * ssh_ptl_tx_wakeup_transfer() - Wake up packet transmitter thread for
+ * transfer.
+ * @ptl: The packet transport layer.
+ *
+ * Wakes up the packet transmitter thread, notifying it that the underlying
+ * transport has more space for data to be transmitted. If the packet
+ * transport layer has been shut down, calls to this function will be ignored.
+ */
+static inline void ssh_ptl_tx_wakeup_transfer(struct ssh_ptl *ptl)
+{
+	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
+		return;
+
+	complete(&ptl->tx.thread_cplt_tx);
+}
+
+void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
+		     u8 priority, const struct ssh_packet_ops *ops);
+
+#endif /* _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H */
diff --git a/drivers/platform/surface/aggregator/ssh_parser.c b/drivers/platform/surface/aggregator/ssh_parser.c
new file mode 100644
index 000000000000..703b0b99b8e4
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_parser.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SSH message parser.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+#include "ssh_parser.h"
+
+/**
+ * sshp_validate_crc() - Validate a CRC in raw message data.
+ * @src: The span of data over which the CRC should be computed.
+ * @crc: The pointer to the expected u16 CRC value.
+ *
+ * Computes the CRC of the provided data span (@src), compares it to the CRC
+ * stored at the given address (@crc), and returns the result of this
+ * comparison, i.e. %true iff equal. This function is intended to run on raw
+ * input/message data.
+ *
+ * Return: Returns %true iff the computed CRC matches the stored CRC, %false
+ * otherwise.
+ */
+static bool sshp_validate_crc(const struct ssam_span *src, const u8 *crc)
+{
+	u16 actual = ssh_crc(src->ptr, src->len);
+	u16 expected = get_unaligned_le16(crc);
+
+	return actual == expected;
+}
+
+/**
+ * sshp_starts_with_syn() - Check if the given data starts with SSH SYN bytes.
+ * @src: The data span to check the start of.
+ */
+static bool sshp_starts_with_syn(const struct ssam_span *src)
+{
+	return src->len >= 2 && get_unaligned_le16(src->ptr) == SSH_MSG_SYN;
+}
+
+/**
+ * sshp_find_syn() - Find SSH SYN bytes in the given data span.
+ * @src: The data span to search in.
+ * @rem: The span (output) indicating the remaining data, starting with SSH
+ *       SYN bytes, if found.
+ *
+ * Search for SSH SYN bytes in the given source span. If found, set the @rem
+ * span to the remaining data, starting with the first SYN bytes and capped by
+ * the source span length, and return %true. This function does not copy any
+ * data, but rather only sets pointers to the respective start addresses and
+ * length values.
+ *
+ * If no SSH SYN bytes could be found, set the @rem span to the zero-length
+ * span at the end of the source span and return %false.
+ *
+ * If partial SSH SYN bytes could be found at the end of the source span, set
+ * the @rem span to cover these partial SYN bytes, capped by the end of the
+ * source span, and return %false. This function should then be re-run once
+ * more data is available.
+ *
+ * Return: Returns %true iff a complete SSH SYN sequence could be found,
+ * %false otherwise.
+ */
+bool sshp_find_syn(const struct ssam_span *src, struct ssam_span *rem)
+{
+	size_t i;
+
+	for (i = 0; i < src->len - 1; i++) {
+		if (likely(get_unaligned_le16(src->ptr + i) == SSH_MSG_SYN)) {
+			rem->ptr = src->ptr + i;
+			rem->len = src->len - i;
+			return true;
+		}
+	}
+
+	if (unlikely(src->ptr[src->len - 1] == (SSH_MSG_SYN & 0xff))) {
+		rem->ptr = src->ptr + src->len - 1;
+		rem->len = 1;
+		return false;
+	}
+
+	rem->ptr = src->ptr + src->len;
+	rem->len = 0;
+	return false;
+}
+
+/**
+ * sshp_parse_frame() - Parse SSH frame.
+ * @dev: The device used for logging.
+ * @source: The source to parse from.
+ * @frame: The parsed frame (output).
+ * @payload: The parsed payload (output).
+ * @maxlen: The maximum supported message length.
+ *
+ * Parses and validates a SSH frame, including its payload, from the given
+ * source. Sets the provided @frame pointer to the start of the frame and
+ * writes the limits of the frame payload to the provided @payload span
+ * pointer.
+ *
+ * This function does not copy any data, but rather only validates the message
+ * data and sets pointers (and length values) to indicate the respective parts.
+ *
+ * If no complete SSH frame could be found, the frame pointer will be set to
+ * the %NULL pointer and the payload span will be set to the null span (start
+ * pointer %NULL, size zero).
+ *
+ * Return: Returns zero on success or if the frame is incomplete, %-ENOMSG if
+ * the start of the message is invalid, %-EBADMSG if any (frame-header or
+ * payload) CRC is invalid, or %-EMSGSIZE if the SSH message is bigger than
+ * the maximum message length specified in the @maxlen parameter.
+ */
+int sshp_parse_frame(const struct device *dev, const struct ssam_span *source,
+		     struct ssh_frame **frame, struct ssam_span *payload,
+		     size_t maxlen)
+{
+	struct ssam_span sf;
+	struct ssam_span sp;
+
+	/* Initialize output. */
+	*frame = NULL;
+	payload->ptr = NULL;
+	payload->len = 0;
+
+	if (!sshp_starts_with_syn(source)) {
+		dev_warn(dev, "rx: parser: invalid start of frame\n");
+		return -ENOMSG;
+	}
+
+	/* Check for minimum packet length. */
+	if (unlikely(source->len < SSH_MESSAGE_LENGTH(0))) {
+		dev_dbg(dev, "rx: parser: not enough data for frame\n");
+		return 0;
+	}
+
+	/* Pin down frame. */
+	sf.ptr = source->ptr + sizeof(u16);
+	sf.len = sizeof(struct ssh_frame);
+
+	/* Validate frame CRC. */
+	if (unlikely(!sshp_validate_crc(&sf, sf.ptr + sf.len))) {
+		dev_warn(dev, "rx: parser: invalid frame CRC\n");
+		return -EBADMSG;
+	}
+
+	/* Ensure packet does not exceed maximum length. */
+	sp.len = get_unaligned_le16(&((struct ssh_frame *)sf.ptr)->len);
+	if (unlikely(SSH_MESSAGE_LENGTH(sp.len) > maxlen)) {
+		dev_warn(dev, "rx: parser: frame too large: %llu bytes\n",
+			 SSH_MESSAGE_LENGTH(sp.len));
+		return -EMSGSIZE;
+	}
+
+	/* Pin down payload. */
+	sp.ptr = sf.ptr + sf.len + sizeof(u16);
+
+	/* Check for frame + payload length. */
+	if (source->len < SSH_MESSAGE_LENGTH(sp.len)) {
+		dev_dbg(dev, "rx: parser: not enough data for payload\n");
+		return 0;
+	}
+
+	/* Validate payload CRC. */
+	if (unlikely(!sshp_validate_crc(&sp, sp.ptr + sp.len))) {
+		dev_warn(dev, "rx: parser: invalid payload CRC\n");
+		return -EBADMSG;
+	}
+
+	*frame = (struct ssh_frame *)sf.ptr;
+	*payload = sp;
+
+	dev_dbg(dev, "rx: parser: valid frame found (type: %#04x, len: %u)\n",
+		(*frame)->type, (*frame)->len);
+
+	return 0;
+}
+
+/**
+ * sshp_parse_command() - Parse SSH command frame payload.
+ * @dev: The device used for logging.
+ * @source: The source to parse from.
+ * @command: The parsed command (output).
+ * @command_data: The parsed command data/payload (output).
+ *
+ * Parses and validates a SSH command frame payload. Sets the @command pointer
+ * to the command header and the @command_data span to the command data (i.e.
+ * payload of the command). This will result in a zero-length span if the
+ * command does not have any associated data/payload. This function does not
+ * check the frame-payload-type field, which should be checked by the caller
+ * before calling this function.
+ *
+ * The @source parameter should be the complete frame payload, e.g. returned
+ * by the sshp_parse_frame() command.
+ *
+ * This function does not copy any data, but rather only validates the frame
+ * payload data and sets pointers (and length values) to indicate the
+ * respective parts.
+ *
+ * Return: Returns zero on success or %-ENOMSG if @source does not represent a
+ * valid command-type frame payload, i.e. is too short.
+ */
+int sshp_parse_command(const struct device *dev, const struct ssam_span *source,
+		       struct ssh_command **command,
+		       struct ssam_span *command_data)
+{
+	/* Check for minimum length. */
+	if (unlikely(source->len < sizeof(struct ssh_command))) {
+		*command = NULL;
+		command_data->ptr = NULL;
+		command_data->len = 0;
+
+		dev_err(dev, "rx: parser: command payload is too short\n");
+		return -ENOMSG;
+	}
+
+	*command = (struct ssh_command *)source->ptr;
+	command_data->ptr = source->ptr + sizeof(struct ssh_command);
+	command_data->len = source->len - sizeof(struct ssh_command);
+
+	dev_dbg(dev, "rx: parser: valid command found (tc: %#04x, cid: %#04x)\n",
+		(*command)->tc, (*command)->cid);
+
+	return 0;
+}
diff --git a/drivers/platform/surface/aggregator/ssh_parser.h b/drivers/platform/surface/aggregator/ssh_parser.h
new file mode 100644
index 000000000000..63c38d350988
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_parser.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SSH message parser.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _SURFACE_AGGREGATOR_SSH_PARSER_H
+#define _SURFACE_AGGREGATOR_SSH_PARSER_H
+
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+
+/**
+ * struct sshp_buf - Parser buffer for SSH messages.
+ * @ptr: Pointer to the beginning of the buffer.
+ * @len: Number of bytes used in the buffer.
+ * @cap: Maximum capacity of the buffer.
+ */
+struct sshp_buf {
+	u8    *ptr;
+	size_t len;
+	size_t cap;
+};
+
+/**
+ * sshp_buf_init() - Initialize a SSH parser buffer.
+ * @buf: The buffer to initialize.
+ * @ptr: The memory backing the buffer.
+ * @cap: The length of the memory backing the buffer, i.e. its capacity.
+ *
+ * Initializes the buffer with the given memory as backing and set its used
+ * length to zero.
+ */
+static inline void sshp_buf_init(struct sshp_buf *buf, u8 *ptr, size_t cap)
+{
+	buf->ptr = ptr;
+	buf->len = 0;
+	buf->cap = cap;
+}
+
+/**
+ * sshp_buf_alloc() - Allocate and initialize a SSH parser buffer.
+ * @buf:   The buffer to initialize/allocate to.
+ * @cap:   The desired capacity of the buffer.
+ * @flags: The flags used for allocating the memory.
+ *
+ * Allocates @cap bytes and initializes the provided buffer struct with the
+ * allocated memory.
+ *
+ * Return: Returns zero on success and %-ENOMEM if allocation failed.
+ */
+static inline int sshp_buf_alloc(struct sshp_buf *buf, size_t cap, gfp_t flags)
+{
+	u8 *ptr;
+
+	ptr = kzalloc(cap, flags);
+	if (!ptr)
+		return -ENOMEM;
+
+	sshp_buf_init(buf, ptr, cap);
+	return 0;
+}
+
+/**
+ * sshp_buf_free() - Free a SSH parser buffer.
+ * @buf: The buffer to free.
+ *
+ * Frees a SSH parser buffer by freeing the memory backing it and then
+ * resetting its pointer to %NULL and length and capacity to zero. Intended to
+ * free a buffer previously allocated with sshp_buf_alloc().
+ */
+static inline void sshp_buf_free(struct sshp_buf *buf)
+{
+	kfree(buf->ptr);
+	buf->ptr = NULL;
+	buf->len = 0;
+	buf->cap = 0;
+}
+
+/**
+ * sshp_buf_drop() - Drop data from the beginning of the buffer.
+ * @buf: The buffer to drop data from.
+ * @n:   The number of bytes to drop.
+ *
+ * Drops the first @n bytes from the buffer. Re-aligns any remaining data to
+ * the beginning of the buffer.
+ */
+static inline void sshp_buf_drop(struct sshp_buf *buf, size_t n)
+{
+	memmove(buf->ptr, buf->ptr + n, buf->len - n);
+	buf->len -= n;
+}
+
+/**
+ * sshp_buf_read_from_fifo() - Transfer data from a fifo to the buffer.
+ * @buf:  The buffer to write the data into.
+ * @fifo: The fifo to read the data from.
+ *
+ * Transfers the data contained in the fifo to the buffer, removing it from
+ * the fifo. This function will try to transfer as much data as possible,
+ * limited either by the remaining space in the buffer or by the number of
+ * bytes available in the fifo.
+ *
+ * Return: Returns the number of bytes transferred.
+ */
+static inline size_t sshp_buf_read_from_fifo(struct sshp_buf *buf,
+					     struct kfifo *fifo)
+{
+	size_t n;
+
+	n =  kfifo_out(fifo, buf->ptr + buf->len, buf->cap - buf->len);
+	buf->len += n;
+
+	return n;
+}
+
+/**
+ * sshp_buf_span_from() - Initialize a span from the given buffer and offset.
+ * @buf:    The buffer to create the span from.
+ * @offset: The offset in the buffer at which the span should start.
+ * @span:   The span to initialize (output).
+ *
+ * Initializes the provided span to point to the memory at the given offset in
+ * the buffer, with the length of the span being capped by the number of bytes
+ * used in the buffer after the offset (i.e. bytes remaining after the
+ * offset).
+ *
+ * Warning: This function does not validate that @offset is less than or equal
+ * to the number of bytes used in the buffer or the buffer capacity. This must
+ * be guaranteed by the caller.
+ */
+static inline void sshp_buf_span_from(struct sshp_buf *buf, size_t offset,
+				      struct ssam_span *span)
+{
+	span->ptr = buf->ptr + offset;
+	span->len = buf->len - offset;
+}
+
+bool sshp_find_syn(const struct ssam_span *src, struct ssam_span *rem);
+
+int sshp_parse_frame(const struct device *dev, const struct ssam_span *source,
+		     struct ssh_frame **frame, struct ssam_span *payload,
+		     size_t maxlen);
+
+int sshp_parse_command(const struct device *dev, const struct ssam_span *source,
+		       struct ssh_command **command,
+		       struct ssam_span *command_data);
+
+#endif /* _SURFACE_AGGREGATOR_SSH_PARSER_h */
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
new file mode 100644
index 000000000000..80bea8e781d3
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -0,0 +1,1203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SSH request transport layer.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/ktime.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+#include <linux/surface_aggregator/controller.h>
+
+#include "ssh_packet_layer.h"
+#include "ssh_request_layer.h"
+
+/*
+ * SSH_RTL_REQUEST_TIMEOUT - Request timeout.
+ *
+ * Timeout as ktime_t delta for request responses. If we have not received a
+ * response in this time-frame after finishing the underlying packet
+ * transmission, the request will be completed with %-ETIMEDOUT as status
+ * code.
+ */
+#define SSH_RTL_REQUEST_TIMEOUT			ms_to_ktime(3000)
+
+/*
+ * SSH_RTL_REQUEST_TIMEOUT_RESOLUTION - Request timeout granularity.
+ *
+ * Time-resolution for timeouts. Should be larger than one jiffy to avoid
+ * direct re-scheduling of reaper work_struct.
+ */
+#define SSH_RTL_REQUEST_TIMEOUT_RESOLUTION	ms_to_ktime(max(2000 / HZ, 50))
+
+/*
+ * SSH_RTL_MAX_PENDING - Maximum number of pending requests.
+ *
+ * Maximum number of requests concurrently waiting to be completed (i.e.
+ * waiting for the corresponding packet transmission to finish if they don't
+ * have a response or waiting for a response if they have one).
+ */
+#define SSH_RTL_MAX_PENDING		3
+
+/*
+ * SSH_RTL_TX_BATCH - Maximum number of requests processed per work execution.
+ * Used to prevent livelocking of the workqueue. Value chosen via educated
+ * guess, may be adjusted.
+ */
+#define SSH_RTL_TX_BATCH		10
+
+static u16 ssh_request_get_rqid(struct ssh_request *rqst)
+{
+	return get_unaligned_le16(rqst->packet.data.ptr
+				  + SSH_MSGOFFSET_COMMAND(rqid));
+}
+
+static u32 ssh_request_get_rqid_safe(struct ssh_request *rqst)
+{
+	if (!rqst->packet.data.ptr)
+		return U32_MAX;
+
+	return ssh_request_get_rqid(rqst);
+}
+
+static void ssh_rtl_queue_remove(struct ssh_request *rqst)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+
+	spin_lock(&rtl->queue.lock);
+
+	if (!test_and_clear_bit(SSH_REQUEST_SF_QUEUED_BIT, &rqst->state)) {
+		spin_unlock(&rtl->queue.lock);
+		return;
+	}
+
+	list_del(&rqst->node);
+
+	spin_unlock(&rtl->queue.lock);
+	ssh_request_put(rqst);
+}
+
+static bool ssh_rtl_queue_empty(struct ssh_rtl *rtl)
+{
+	bool empty;
+
+	spin_lock(&rtl->queue.lock);
+	empty = list_empty(&rtl->queue.head);
+	spin_unlock(&rtl->queue.lock);
+
+	return empty;
+}
+
+static void ssh_rtl_pending_remove(struct ssh_request *rqst)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+
+	spin_lock(&rtl->pending.lock);
+
+	if (!test_and_clear_bit(SSH_REQUEST_SF_PENDING_BIT, &rqst->state)) {
+		spin_unlock(&rtl->pending.lock);
+		return;
+	}
+
+	atomic_dec(&rtl->pending.count);
+	list_del(&rqst->node);
+
+	spin_unlock(&rtl->pending.lock);
+
+	ssh_request_put(rqst);
+}
+
+static int ssh_rtl_tx_pending_push(struct ssh_request *rqst)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+
+	spin_lock(&rtl->pending.lock);
+
+	if (test_bit(SSH_REQUEST_SF_LOCKED_BIT, &rqst->state)) {
+		spin_unlock(&rtl->pending.lock);
+		return -EINVAL;
+	}
+
+	if (test_and_set_bit(SSH_REQUEST_SF_PENDING_BIT, &rqst->state)) {
+		spin_unlock(&rtl->pending.lock);
+		return -EALREADY;
+	}
+
+	atomic_inc(&rtl->pending.count);
+	list_add_tail(&ssh_request_get(rqst)->node, &rtl->pending.head);
+
+	spin_unlock(&rtl->pending.lock);
+	return 0;
+}
+
+static void ssh_rtl_complete_with_status(struct ssh_request *rqst, int status)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+
+	/* rtl/ptl may not be set if we're canceling before submitting. */
+	rtl_dbg_cond(rtl, "rtl: completing request (rqid: %#06x, status: %d)\n",
+		     ssh_request_get_rqid_safe(rqst), status);
+
+	rqst->ops->complete(rqst, NULL, NULL, status);
+}
+
+static void ssh_rtl_complete_with_rsp(struct ssh_request *rqst,
+				      const struct ssh_command *cmd,
+				      const struct ssam_span *data)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+
+	rtl_dbg(rtl, "rtl: completing request with response (rqid: %#06x)\n",
+		ssh_request_get_rqid(rqst));
+
+	rqst->ops->complete(rqst, cmd, data, 0);
+}
+
+static bool ssh_rtl_tx_can_process(struct ssh_request *rqst)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+
+	if (test_bit(SSH_REQUEST_TY_FLUSH_BIT, &rqst->state))
+		return !atomic_read(&rtl->pending.count);
+
+	return atomic_read(&rtl->pending.count) < SSH_RTL_MAX_PENDING;
+}
+
+static struct ssh_request *ssh_rtl_tx_next(struct ssh_rtl *rtl)
+{
+	struct ssh_request *rqst = ERR_PTR(-ENOENT);
+	struct ssh_request *p, *n;
+
+	spin_lock(&rtl->queue.lock);
+
+	/* Find first non-locked request and remove it. */
+	list_for_each_entry_safe(p, n, &rtl->queue.head, node) {
+		if (unlikely(test_bit(SSH_REQUEST_SF_LOCKED_BIT, &p->state)))
+			continue;
+
+		if (!ssh_rtl_tx_can_process(p)) {
+			rqst = ERR_PTR(-EBUSY);
+			break;
+		}
+
+		/* Remove from queue and mark as transmitting. */
+		set_bit(SSH_REQUEST_SF_TRANSMITTING_BIT, &p->state);
+		/* Ensure state never gets zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_REQUEST_SF_QUEUED_BIT, &p->state);
+
+		list_del(&p->node);
+
+		rqst = p;
+		break;
+	}
+
+	spin_unlock(&rtl->queue.lock);
+	return rqst;
+}
+
+static int ssh_rtl_tx_try_process_one(struct ssh_rtl *rtl)
+{
+	struct ssh_request *rqst;
+	int status;
+
+	/* Get and prepare next request for transmit. */
+	rqst = ssh_rtl_tx_next(rtl);
+	if (IS_ERR(rqst))
+		return PTR_ERR(rqst);
+
+	/* Add it to/mark it as pending. */
+	status = ssh_rtl_tx_pending_push(rqst);
+	if (status) {
+		ssh_request_put(rqst);
+		return -EAGAIN;
+	}
+
+	/* Submit packet. */
+	status = ssh_ptl_submit(&rtl->ptl, &rqst->packet);
+	if (status == -ESHUTDOWN) {
+		/*
+		 * Packet has been refused due to the packet layer shutting
+		 * down. Complete it here.
+		 */
+		set_bit(SSH_REQUEST_SF_LOCKED_BIT, &rqst->state);
+		/*
+		 * Note: A barrier is not required here, as there are only two
+		 * references in the system at this point: The one that we have,
+		 * and the other one that belongs to the pending set. Due to the
+		 * request being marked as "transmitting", our process is the
+		 * only one allowed to remove the pending node and change the
+		 * state. Normally, the task would fall to the packet callback,
+		 * but as this is a path where submission failed, this callback
+		 * will never be executed.
+		 */
+
+		ssh_rtl_pending_remove(rqst);
+		ssh_rtl_complete_with_status(rqst, -ESHUTDOWN);
+
+		ssh_request_put(rqst);
+		return -ESHUTDOWN;
+
+	} else if (status) {
+		/*
+		 * If submitting the packet failed and the packet layer isn't
+		 * shutting down, the packet has either been submitted/queued
+		 * before (-EALREADY, which cannot happen as we have
+		 * guaranteed that requests cannot be re-submitted), or the
+		 * packet was marked as locked (-EINVAL). To mark the packet
+		 * locked at this stage, the request, and thus the packets
+		 * itself, had to have been canceled. Simply drop the
+		 * reference. Cancellation itself will remove it from the set
+		 * of pending requests.
+		 */
+
+		WARN_ON(status != -EINVAL);
+
+		ssh_request_put(rqst);
+		return -EAGAIN;
+	}
+
+	ssh_request_put(rqst);
+	return 0;
+}
+
+static bool ssh_rtl_tx_schedule(struct ssh_rtl *rtl)
+{
+	if (atomic_read(&rtl->pending.count) >= SSH_RTL_MAX_PENDING)
+		return false;
+
+	if (ssh_rtl_queue_empty(rtl))
+		return false;
+
+	return schedule_work(&rtl->tx.work);
+}
+
+static void ssh_rtl_tx_work_fn(struct work_struct *work)
+{
+	struct ssh_rtl *rtl = to_ssh_rtl(work, tx.work);
+	unsigned int iterations = SSH_RTL_TX_BATCH;
+	int status;
+
+	/*
+	 * Try to be nice and not block/live-lock the workqueue: Run a maximum
+	 * of 10 tries, then re-submit if necessary. This should not be
+	 * necessary for normal execution, but guarantee it anyway.
+	 */
+	do {
+		status = ssh_rtl_tx_try_process_one(rtl);
+		if (status == -ENOENT || status == -EBUSY)
+			return;		/* No more requests to process. */
+
+		if (status == -ESHUTDOWN) {
+			/*
+			 * Packet system shutting down. No new packets can be
+			 * transmitted. Return silently, the party initiating
+			 * the shutdown should handle the rest.
+			 */
+			return;
+		}
+
+		WARN_ON(status != 0 && status != -EAGAIN);
+	} while (--iterations);
+
+	/* Out of tries, reschedule. */
+	ssh_rtl_tx_schedule(rtl);
+}
+
+/**
+ * ssh_rtl_submit() - Submit a request to the transport layer.
+ * @rtl:  The request transport layer.
+ * @rqst: The request to submit.
+ *
+ * Submits a request to the transport layer. A single request may not be
+ * submitted multiple times without reinitializing it.
+ *
+ * Return: Returns zero on success, %-EINVAL if the request type is invalid or
+ * the request has been canceled prior to submission, %-EALREADY if the
+ * request has already been submitted, or %-ESHUTDOWN in case the request
+ * transport layer has been shut down.
+ */
+int ssh_rtl_submit(struct ssh_rtl *rtl, struct ssh_request *rqst)
+{
+	/*
+	 * Ensure that requests expecting a response are sequenced. If this
+	 * invariant ever changes, see the comment in ssh_rtl_complete() on what
+	 * is required to be changed in the code.
+	 */
+	if (test_bit(SSH_REQUEST_TY_HAS_RESPONSE_BIT, &rqst->state))
+		if (!test_bit(SSH_PACKET_TY_SEQUENCED_BIT, &rqst->packet.state))
+			return -EINVAL;
+
+	spin_lock(&rtl->queue.lock);
+
+	/*
+	 * Try to set ptl and check if this request has already been submitted.
+	 *
+	 * Must be inside lock as we might run into a lost update problem
+	 * otherwise: If this were outside of the lock, cancellation in
+	 * ssh_rtl_cancel_nonpending() may run after we've set the ptl
+	 * reference but before we enter the lock. In that case, we'd detect
+	 * that the request is being added to the queue and would try to remove
+	 * it from that, but removal might fail because it hasn't actually been
+	 * added yet. By putting this cmpxchg in the critical section, we
+	 * ensure that the queuing detection only triggers when we are already
+	 * in the critical section and the remove process will wait until the
+	 * push operation has been completed (via lock) due to that. Only then,
+	 * we can safely try to remove it.
+	 */
+	if (cmpxchg(&rqst->packet.ptl, NULL, &rtl->ptl)) {
+		spin_unlock(&rtl->queue.lock);
+		return -EALREADY;
+	}
+
+	/*
+	 * Ensure that we set ptl reference before we continue modifying state.
+	 * This is required for non-pending cancellation. This barrier is paired
+	 * with the one in ssh_rtl_cancel_nonpending().
+	 *
+	 * By setting the ptl reference before we test for "locked", we can
+	 * check if the "locked" test may have already run. See comments in
+	 * ssh_rtl_cancel_nonpending() for more detail.
+	 */
+	smp_mb__after_atomic();
+
+	if (test_bit(SSH_RTL_SF_SHUTDOWN_BIT, &rtl->state)) {
+		spin_unlock(&rtl->queue.lock);
+		return -ESHUTDOWN;
+	}
+
+	if (test_bit(SSH_REQUEST_SF_LOCKED_BIT, &rqst->state)) {
+		spin_unlock(&rtl->queue.lock);
+		return -EINVAL;
+	}
+
+	set_bit(SSH_REQUEST_SF_QUEUED_BIT, &rqst->state);
+	list_add_tail(&ssh_request_get(rqst)->node, &rtl->queue.head);
+
+	spin_unlock(&rtl->queue.lock);
+
+	ssh_rtl_tx_schedule(rtl);
+	return 0;
+}
+
+static void ssh_rtl_timeout_reaper_mod(struct ssh_rtl *rtl, ktime_t now,
+				       ktime_t expires)
+{
+	unsigned long delta = msecs_to_jiffies(ktime_ms_delta(expires, now));
+	ktime_t aexp = ktime_add(expires, SSH_RTL_REQUEST_TIMEOUT_RESOLUTION);
+
+	spin_lock(&rtl->rtx_timeout.lock);
+
+	/* Re-adjust / schedule reaper only if it is above resolution delta. */
+	if (ktime_before(aexp, rtl->rtx_timeout.expires)) {
+		rtl->rtx_timeout.expires = expires;
+		mod_delayed_work(system_wq, &rtl->rtx_timeout.reaper, delta);
+	}
+
+	spin_unlock(&rtl->rtx_timeout.lock);
+}
+
+static void ssh_rtl_timeout_start(struct ssh_request *rqst)
+{
+	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
+	ktime_t timestamp = ktime_get_coarse_boottime();
+	ktime_t timeout = rtl->rtx_timeout.timeout;
+
+	if (test_bit(SSH_REQUEST_SF_LOCKED_BIT, &rqst->state))
+		return;
+
+	/*
+	 * Note: The timestamp gets set only once. This happens on the packet
+	 * callback. All other access to it is read-only.
+	 */
+	WRITE_ONCE(rqst->timestamp, timestamp);
+	/*
+	 * Ensure timestamp is set before starting the reaper. Paired with
+	 * implicit barrier following check on ssh_request_get_expiration() in
+	 * ssh_rtl_timeout_reap.
+	 */
+	smp_mb__after_atomic();
+
+	ssh_rtl_timeout_reaper_mod(rtl, timestamp, timestamp + timeout);
+}
+
+static void ssh_rtl_complete(struct ssh_rtl *rtl,
+			     const struct ssh_command *command,
+			     const struct ssam_span *command_data)
+{
+	struct ssh_request *r = NULL;
+	struct ssh_request *p, *n;
+	u16 rqid = get_unaligned_le16(&command->rqid);
+
+	/*
+	 * Get request from pending based on request ID and mark it as response
+	 * received and locked.
+	 */
+	spin_lock(&rtl->pending.lock);
+	list_for_each_entry_safe(p, n, &rtl->pending.head, node) {
+		/* We generally expect requests to be processed in order. */
+		if (unlikely(ssh_request_get_rqid(p) != rqid))
+			continue;
+
+		/*
+		 * Mark as "response received" and "locked" as we're going to
+		 * complete it.
+		 */
+		set_bit(SSH_REQUEST_SF_LOCKED_BIT, &p->state);
+		set_bit(SSH_REQUEST_SF_RSPRCVD_BIT, &p->state);
+		/* Ensure state never gets zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_REQUEST_SF_PENDING_BIT, &p->state);
+
+		atomic_dec(&rtl->pending.count);
+		list_del(&p->node);
+
+		r = p;
+		break;
+	}
+	spin_unlock(&rtl->pending.lock);
+
+	if (!r) {
+		rtl_warn(rtl, "rtl: dropping unexpected command message (rqid = %#06x)\n",
+			 rqid);
+		return;
+	}
+
+	/* If the request hasn't been completed yet, we will do this now. */
+	if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state)) {
+		ssh_request_put(r);
+		ssh_rtl_tx_schedule(rtl);
+		return;
+	}
+
+	/*
+	 * Make sure the request has been transmitted. In case of a sequenced
+	 * request, we are guaranteed that the completion callback will run on
+	 * the receiver thread directly when the ACK for the packet has been
+	 * received. Similarly, this function is guaranteed to run on the
+	 * receiver thread. Thus we are guaranteed that if the packet has been
+	 * successfully transmitted and received an ACK, the transmitted flag
+	 * has been set and is visible here.
+	 *
+	 * We are currently not handling unsequenced packets here, as those
+	 * should never expect a response as ensured in ssh_rtl_submit. If this
+	 * ever changes, one would have to test for
+	 *
+	 *	(r->state & (transmitting | transmitted))
+	 *
+	 * on unsequenced packets to determine if they could have been
+	 * transmitted. There are no synchronization guarantees as in the
+	 * sequenced case, since, in this case, the callback function will not
+	 * run on the same thread. Thus an exact determination is impossible.
+	 */
+	if (!test_bit(SSH_REQUEST_SF_TRANSMITTED_BIT, &r->state)) {
+		rtl_err(rtl, "rtl: received response before ACK for request (rqid = %#06x)\n",
+			rqid);
+
+		/*
+		 * NB: Timeout has already been canceled, request already been
+		 * removed from pending and marked as locked and completed. As
+		 * we receive a "false" response, the packet might still be
+		 * queued though.
+		 */
+		ssh_rtl_queue_remove(r);
+
+		ssh_rtl_complete_with_status(r, -EREMOTEIO);
+		ssh_request_put(r);
+
+		ssh_rtl_tx_schedule(rtl);
+		return;
+	}
+
+	/*
+	 * NB: Timeout has already been canceled, request already been
+	 * removed from pending and marked as locked and completed. The request
+	 * can also not be queued any more, as it has been marked as
+	 * transmitting and later transmitted. Thus no need to remove it from
+	 * anywhere.
+	 */
+
+	ssh_rtl_complete_with_rsp(r, command, command_data);
+	ssh_request_put(r);
+
+	ssh_rtl_tx_schedule(rtl);
+}
+
+static bool ssh_rtl_cancel_nonpending(struct ssh_request *r)
+{
+	struct ssh_rtl *rtl;
+	unsigned long flags, fixed;
+	bool remove;
+
+	/*
+	 * Handle unsubmitted request: Try to mark the packet as locked,
+	 * expecting the state to be zero (i.e. unsubmitted). Note that, if
+	 * setting the state worked, we might still be adding the packet to the
+	 * queue in a currently executing submit call. In that case, however,
+	 * ptl reference must have been set previously, as locked is checked
+	 * after setting ptl. Furthermore, when the ptl reference is set, the
+	 * submission process is guaranteed to have entered the critical
+	 * section. Thus only if we successfully locked this request and ptl is
+	 * NULL, we have successfully removed the request, i.e. we are
+	 * guaranteed that, due to the "locked" check in ssh_rtl_submit(), the
+	 * packet will never be added. Otherwise, we need to try and grab it
+	 * from the queue, where we are now guaranteed that the packet is or has
+	 * been due to the critical section.
+	 *
+	 * Note that if the cmpxchg() fails, we are guaranteed that ptl has
+	 * been set and is non-NULL, as states can only be nonzero after this
+	 * has been set. Also note that we need to fetch the static (type)
+	 * flags to ensure that they don't cause the cmpxchg() to fail.
+	 */
+	fixed = READ_ONCE(r->state) & SSH_REQUEST_FLAGS_TY_MASK;
+	flags = cmpxchg(&r->state, fixed, SSH_REQUEST_SF_LOCKED_BIT);
+
+	/*
+	 * Force correct ordering with regards to state and ptl reference access
+	 * to safe-guard cancellation to concurrent submission against a
+	 * lost-update problem. First try to exchange state, then also check
+	 * ptl if that worked. This barrier is paired with the
+	 * one in ssh_rtl_submit().
+	 */
+	smp_mb__after_atomic();
+
+	if (flags == fixed && !READ_ONCE(r->packet.ptl)) {
+		if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+			return true;
+
+		ssh_rtl_complete_with_status(r, -ECANCELED);
+		return true;
+	}
+
+	rtl = ssh_request_rtl(r);
+	spin_lock(&rtl->queue.lock);
+
+	/*
+	 * Note: 1) Requests cannot be re-submitted. 2) If a request is
+	 * queued, it cannot be "transmitting"/"pending" yet. Thus, if we
+	 * successfully remove the request here, we have removed all its
+	 * occurrences in the system.
+	 */
+
+	remove = test_and_clear_bit(SSH_REQUEST_SF_QUEUED_BIT, &r->state);
+	if (!remove) {
+		spin_unlock(&rtl->queue.lock);
+		return false;
+	}
+
+	set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state);
+	list_del(&r->node);
+
+	spin_unlock(&rtl->queue.lock);
+
+	ssh_request_put(r);	/* Drop reference obtained from queue. */
+
+	if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+		return true;
+
+	ssh_rtl_complete_with_status(r, -ECANCELED);
+	return true;
+}
+
+static bool ssh_rtl_cancel_pending(struct ssh_request *r)
+{
+	/* If the packet is already locked, it's going to be removed shortly. */
+	if (test_and_set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state))
+		return true;
+
+	/*
+	 * Now that we have locked the packet, we have guaranteed that it can't
+	 * be added to the system any more. If ptl is NULL, the locked
+	 * check in ssh_rtl_submit() has not been run and any submission,
+	 * currently in progress or called later, won't add the packet. Thus we
+	 * can directly complete it.
+	 *
+	 * The implicit memory barrier of test_and_set_bit() should be enough
+	 * to ensure that the correct order (first lock, then check ptl) is
+	 * ensured. This is paired with the barrier in ssh_rtl_submit().
+	 */
+	if (!READ_ONCE(r->packet.ptl)) {
+		if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+			return true;
+
+		ssh_rtl_complete_with_status(r, -ECANCELED);
+		return true;
+	}
+
+	/*
+	 * Try to cancel the packet. If the packet has not been completed yet,
+	 * this will subsequently (and synchronously) call the completion
+	 * callback of the packet, which will complete the request.
+	 */
+	ssh_ptl_cancel(&r->packet);
+
+	/*
+	 * If the packet has been completed with success, i.e. has not been
+	 * canceled by the above call, the request may not have been completed
+	 * yet (may be waiting for a response). Check if we need to do this
+	 * here.
+	 */
+	if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+		return true;
+
+	ssh_rtl_queue_remove(r);
+	ssh_rtl_pending_remove(r);
+	ssh_rtl_complete_with_status(r, -ECANCELED);
+
+	return true;
+}
+
+/**
+ * ssh_rtl_cancel() - Cancel request.
+ * @rqst:    The request to cancel.
+ * @pending: Whether to also cancel pending requests.
+ *
+ * Cancels the given request. If @pending is %false, this will not cancel
+ * pending requests, i.e. requests that have already been submitted to the
+ * packet layer but not been completed yet. If @pending is %true, this will
+ * cancel the given request regardless of the state it is in.
+ *
+ * If the request has been canceled by calling this function, both completion
+ * and release callbacks of the request will be executed in a reasonable
+ * time-frame. This may happen during execution of this function, however,
+ * there is no guarantee for this. For example, a request currently
+ * transmitting will be canceled/completed only after transmission has
+ * completed, and the respective callbacks will be executed on the transmitter
+ * thread, which may happen during, but also some time after execution of the
+ * cancel function.
+ *
+ * Return: Returns %true iff the given request has been canceled or completed,
+ * either by this function or prior to calling this function, %false
+ * otherwise. If @pending is %true, this function will always return %true.
+ */
+bool ssh_rtl_cancel(struct ssh_request *rqst, bool pending)
+{
+	struct ssh_rtl *rtl;
+	bool canceled;
+
+	if (test_and_set_bit(SSH_REQUEST_SF_CANCELED_BIT, &rqst->state))
+		return true;
+
+	if (pending)
+		canceled = ssh_rtl_cancel_pending(rqst);
+	else
+		canceled = ssh_rtl_cancel_nonpending(rqst);
+
+	/* Note: rtl may be NULL if request has not been submitted yet. */
+	rtl = ssh_request_rtl(rqst);
+	if (canceled && rtl)
+		ssh_rtl_tx_schedule(rtl);
+
+	return canceled;
+}
+
+static void ssh_rtl_packet_callback(struct ssh_packet *p, int status)
+{
+	struct ssh_request *r = to_ssh_request(p);
+
+	if (unlikely(status)) {
+		set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state);
+
+		if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+			return;
+
+		/*
+		 * The packet may get canceled even though it has not been
+		 * submitted yet. The request may still be queued. Check the
+		 * queue and remove it if necessary. As the timeout would have
+		 * been started in this function on success, there's no need
+		 * to cancel it here.
+		 */
+		ssh_rtl_queue_remove(r);
+		ssh_rtl_pending_remove(r);
+		ssh_rtl_complete_with_status(r, status);
+
+		ssh_rtl_tx_schedule(ssh_request_rtl(r));
+		return;
+	}
+
+	/* Update state: Mark as transmitted and clear transmitting. */
+	set_bit(SSH_REQUEST_SF_TRANSMITTED_BIT, &r->state);
+	/* Ensure state never gets zero. */
+	smp_mb__before_atomic();
+	clear_bit(SSH_REQUEST_SF_TRANSMITTING_BIT, &r->state);
+
+	/* If we expect a response, we just need to start the timeout. */
+	if (test_bit(SSH_REQUEST_TY_HAS_RESPONSE_BIT, &r->state)) {
+		/*
+		 * Note: This is the only place where the timestamp gets set,
+		 * all other access to it is read-only.
+		 */
+		ssh_rtl_timeout_start(r);
+		return;
+	}
+
+	/*
+	 * If we don't expect a response, lock, remove, and complete the
+	 * request. Note that, at this point, the request is guaranteed to have
+	 * left the queue and no timeout has been started. Thus we only need to
+	 * remove it from pending. If the request has already been completed (it
+	 * may have been canceled) return.
+	 */
+
+	set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state);
+	if (test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+		return;
+
+	ssh_rtl_pending_remove(r);
+	ssh_rtl_complete_with_status(r, 0);
+
+	ssh_rtl_tx_schedule(ssh_request_rtl(r));
+}
+
+static ktime_t ssh_request_get_expiration(struct ssh_request *r, ktime_t timeout)
+{
+	ktime_t timestamp = READ_ONCE(r->timestamp);
+
+	if (timestamp != KTIME_MAX)
+		return ktime_add(timestamp, timeout);
+	else
+		return KTIME_MAX;
+}
+
+static void ssh_rtl_timeout_reap(struct work_struct *work)
+{
+	struct ssh_rtl *rtl = to_ssh_rtl(work, rtx_timeout.reaper.work);
+	struct ssh_request *r, *n;
+	LIST_HEAD(claimed);
+	ktime_t now = ktime_get_coarse_boottime();
+	ktime_t timeout = rtl->rtx_timeout.timeout;
+	ktime_t next = KTIME_MAX;
+
+	/*
+	 * Mark reaper as "not pending". This is done before checking any
+	 * requests to avoid lost-update type problems.
+	 */
+	spin_lock(&rtl->rtx_timeout.lock);
+	rtl->rtx_timeout.expires = KTIME_MAX;
+	spin_unlock(&rtl->rtx_timeout.lock);
+
+	spin_lock(&rtl->pending.lock);
+	list_for_each_entry_safe(r, n, &rtl->pending.head, node) {
+		ktime_t expires = ssh_request_get_expiration(r, timeout);
+
+		/*
+		 * Check if the timeout hasn't expired yet. Find out next
+		 * expiration date to be handled after this run.
+		 */
+		if (ktime_after(expires, now)) {
+			next = ktime_before(expires, next) ? expires : next;
+			continue;
+		}
+
+		/* Avoid further transitions if locked. */
+		if (test_and_set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state))
+			continue;
+
+		/*
+		 * We have now marked the packet as locked. Thus it cannot be
+		 * added to the pending or queued lists again after we've
+		 * removed it here. We can therefore re-use the node of this
+		 * packet temporarily.
+		 */
+
+		clear_bit(SSH_REQUEST_SF_PENDING_BIT, &r->state);
+
+		atomic_dec(&rtl->pending.count);
+		list_del(&r->node);
+
+		list_add_tail(&r->node, &claimed);
+	}
+	spin_unlock(&rtl->pending.lock);
+
+	/* Cancel and complete the request. */
+	list_for_each_entry_safe(r, n, &claimed, node) {
+		/*
+		 * At this point we've removed the packet from pending. This
+		 * means that we've obtained the last (only) reference of the
+		 * system to it. Thus we can just complete it.
+		 */
+		if (!test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+			ssh_rtl_complete_with_status(r, -ETIMEDOUT);
+
+		/*
+		 * Drop the reference we've obtained by removing it from the
+		 * pending set.
+		 */
+		list_del(&r->node);
+		ssh_request_put(r);
+	}
+
+	/* Ensure that the reaper doesn't run again immediately. */
+	next = max(next, ktime_add(now, SSH_RTL_REQUEST_TIMEOUT_RESOLUTION));
+	if (next != KTIME_MAX)
+		ssh_rtl_timeout_reaper_mod(rtl, now, next);
+
+	ssh_rtl_tx_schedule(rtl);
+}
+
+static void ssh_rtl_rx_event(struct ssh_rtl *rtl, const struct ssh_command *cmd,
+			     const struct ssam_span *data)
+{
+	rtl_dbg(rtl, "rtl: handling event (rqid: %#06x)\n",
+		get_unaligned_le16(&cmd->rqid));
+
+	rtl->ops.handle_event(rtl, cmd, data);
+}
+
+static void ssh_rtl_rx_command(struct ssh_ptl *p, const struct ssam_span *data)
+{
+	struct ssh_rtl *rtl = to_ssh_rtl(p, ptl);
+	struct device *dev = &p->serdev->dev;
+	struct ssh_command *command;
+	struct ssam_span command_data;
+
+	if (sshp_parse_command(dev, data, &command, &command_data))
+		return;
+
+	if (ssh_rqid_is_event(get_unaligned_le16(&command->rqid)))
+		ssh_rtl_rx_event(rtl, command, &command_data);
+	else
+		ssh_rtl_complete(rtl, command, &command_data);
+}
+
+static void ssh_rtl_rx_data(struct ssh_ptl *p, const struct ssam_span *data)
+{
+	if (!data->len) {
+		ptl_err(p, "rtl: rx: no data frame payload\n");
+		return;
+	}
+
+	switch (data->ptr[0]) {
+	case SSH_PLD_TYPE_CMD:
+		ssh_rtl_rx_command(p, data);
+		break;
+
+	default:
+		ptl_err(p, "rtl: rx: unknown frame payload type (type: %#04x)\n",
+			data->ptr[0]);
+		break;
+	}
+}
+
+static void ssh_rtl_packet_release(struct ssh_packet *p)
+{
+	struct ssh_request *rqst;
+
+	rqst = to_ssh_request(p);
+	rqst->ops->release(rqst);
+}
+
+static const struct ssh_packet_ops ssh_rtl_packet_ops = {
+	.complete = ssh_rtl_packet_callback,
+	.release = ssh_rtl_packet_release,
+};
+
+/**
+ * ssh_request_init() - Initialize SSH request.
+ * @rqst:  The request to initialize.
+ * @flags: Request flags, determining the type of the request.
+ * @ops:   Request operations.
+ *
+ * Initializes the given SSH request and underlying packet. Sets the message
+ * buffer pointer to %NULL and the message buffer length to zero. This buffer
+ * has to be set separately via ssh_request_set_data() before submission and
+ * must contain a valid SSH request message.
+ */
+void ssh_request_init(struct ssh_request *rqst, enum ssam_request_flags flags,
+		      const struct ssh_request_ops *ops)
+{
+	unsigned long type = BIT(SSH_PACKET_TY_BLOCKING_BIT);
+
+	if (!(flags & SSAM_REQUEST_UNSEQUENCED))
+		type |= BIT(SSH_PACKET_TY_SEQUENCED_BIT);
+
+	ssh_packet_init(&rqst->packet, type, SSH_PACKET_PRIORITY(DATA, 0),
+			&ssh_rtl_packet_ops);
+
+	INIT_LIST_HEAD(&rqst->node);
+
+	rqst->state = 0;
+	if (flags & SSAM_REQUEST_HAS_RESPONSE)
+		rqst->state |= BIT(SSH_REQUEST_TY_HAS_RESPONSE_BIT);
+
+	rqst->timestamp = KTIME_MAX;
+	rqst->ops = ops;
+}
+
+/**
+ * ssh_rtl_init() - Initialize request transport layer.
+ * @rtl:    The request transport layer to initialize.
+ * @serdev: The underlying serial device, i.e. the lower-level transport.
+ * @ops:    Request transport layer operations.
+ *
+ * Initializes the given request transport layer and associated packet
+ * transport layer. Transmitter and receiver threads must be started
+ * separately via ssh_rtl_tx_start() and ssh_rtl_rx_start(), after the
+ * request-layer has been initialized and the lower-level serial device layer
+ * has been set up.
+ *
+ * Return: Returns zero on success and a nonzero error code on failure.
+ */
+int ssh_rtl_init(struct ssh_rtl *rtl, struct serdev_device *serdev,
+		 const struct ssh_rtl_ops *ops)
+{
+	struct ssh_ptl_ops ptl_ops;
+	int status;
+
+	ptl_ops.data_received = ssh_rtl_rx_data;
+
+	status = ssh_ptl_init(&rtl->ptl, serdev, &ptl_ops);
+	if (status)
+		return status;
+
+	spin_lock_init(&rtl->queue.lock);
+	INIT_LIST_HEAD(&rtl->queue.head);
+
+	spin_lock_init(&rtl->pending.lock);
+	INIT_LIST_HEAD(&rtl->pending.head);
+	atomic_set_release(&rtl->pending.count, 0);
+
+	INIT_WORK(&rtl->tx.work, ssh_rtl_tx_work_fn);
+
+	spin_lock_init(&rtl->rtx_timeout.lock);
+	rtl->rtx_timeout.timeout = SSH_RTL_REQUEST_TIMEOUT;
+	rtl->rtx_timeout.expires = KTIME_MAX;
+	INIT_DELAYED_WORK(&rtl->rtx_timeout.reaper, ssh_rtl_timeout_reap);
+
+	rtl->ops = *ops;
+
+	return 0;
+}
+
+/**
+ * ssh_rtl_destroy() - Deinitialize request transport layer.
+ * @rtl: The request transport layer to deinitialize.
+ *
+ * Deinitializes the given request transport layer and frees resources
+ * associated with it. If receiver and/or transmitter threads have been
+ * started, the layer must first be shut down via ssh_rtl_shutdown() before
+ * this function can be called.
+ */
+void ssh_rtl_destroy(struct ssh_rtl *rtl)
+{
+	ssh_ptl_destroy(&rtl->ptl);
+}
+
+/**
+ * ssh_rtl_tx_start() - Start request transmitter and receiver.
+ * @rtl: The request transport layer.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+int ssh_rtl_start(struct ssh_rtl *rtl)
+{
+	int status;
+
+	status = ssh_ptl_tx_start(&rtl->ptl);
+	if (status)
+		return status;
+
+	ssh_rtl_tx_schedule(rtl);
+
+	status = ssh_ptl_rx_start(&rtl->ptl);
+	if (status) {
+		ssh_rtl_flush(rtl, msecs_to_jiffies(5000));
+		ssh_ptl_tx_stop(&rtl->ptl);
+		return status;
+	}
+
+	return 0;
+}
+
+struct ssh_flush_request {
+	struct ssh_request base;
+	struct completion completion;
+	int status;
+};
+
+static void ssh_rtl_flush_request_complete(struct ssh_request *r,
+					   const struct ssh_command *cmd,
+					   const struct ssam_span *data,
+					   int status)
+{
+	struct ssh_flush_request *rqst;
+
+	rqst = container_of(r, struct ssh_flush_request, base);
+	rqst->status = status;
+}
+
+static void ssh_rtl_flush_request_release(struct ssh_request *r)
+{
+	struct ssh_flush_request *rqst;
+
+	rqst = container_of(r, struct ssh_flush_request, base);
+	complete_all(&rqst->completion);
+}
+
+static const struct ssh_request_ops ssh_rtl_flush_request_ops = {
+	.complete = ssh_rtl_flush_request_complete,
+	.release = ssh_rtl_flush_request_release,
+};
+
+/**
+ * ssh_rtl_flush() - Flush the request transport layer.
+ * @rtl:     request transport layer
+ * @timeout: timeout for the flush operation in jiffies
+ *
+ * Queue a special flush request and wait for its completion. This request
+ * will be completed after all other currently queued and pending requests
+ * have been completed. Instead of a normal data packet, this request submits
+ * a special flush packet, meaning that upon completion, also the underlying
+ * packet transport layer has been flushed.
+ *
+ * Flushing the request layer guarantees that all previously submitted
+ * requests have been fully completed before this call returns. Additionally,
+ * flushing blocks execution of all later submitted requests until the flush
+ * has been completed.
+ *
+ * If the caller ensures that no new requests are submitted after a call to
+ * this function, the request transport layer is guaranteed to have no
+ * remaining requests when this call returns. The same guarantee does not hold
+ * for the packet layer, on which control packets may still be queued after
+ * this call.
+ *
+ * Return: Returns zero on success, %-ETIMEDOUT if the flush timed out and has
+ * been canceled as a result of the timeout, or %-ESHUTDOWN if the packet
+ * and/or request transport layer has been shut down before this call. May
+ * also return %-EINTR if the underlying packet transmission has been
+ * interrupted.
+ */
+int ssh_rtl_flush(struct ssh_rtl *rtl, unsigned long timeout)
+{
+	const unsigned int init_flags = SSAM_REQUEST_UNSEQUENCED;
+	struct ssh_flush_request rqst;
+	int status;
+
+	ssh_request_init(&rqst.base, init_flags, &ssh_rtl_flush_request_ops);
+	rqst.base.packet.state |= BIT(SSH_PACKET_TY_FLUSH_BIT);
+	rqst.base.packet.priority = SSH_PACKET_PRIORITY(FLUSH, 0);
+	rqst.base.state |= BIT(SSH_REQUEST_TY_FLUSH_BIT);
+
+	init_completion(&rqst.completion);
+
+	status = ssh_rtl_submit(rtl, &rqst.base);
+	if (status)
+		return status;
+
+	ssh_request_put(&rqst.base);
+
+	if (!wait_for_completion_timeout(&rqst.completion, timeout)) {
+		ssh_rtl_cancel(&rqst.base, true);
+		wait_for_completion(&rqst.completion);
+	}
+
+	WARN_ON(rqst.status != 0 && rqst.status != -ECANCELED &&
+		rqst.status != -ESHUTDOWN && rqst.status != -EINTR);
+
+	return rqst.status == -ECANCELED ? -ETIMEDOUT : rqst.status;
+}
+
+/**
+ * ssh_rtl_shutdown() - Shut down request transport layer.
+ * @rtl: The request transport layer.
+ *
+ * Shuts down the request transport layer, removing and canceling all queued
+ * and pending requests. Requests canceled by this operation will be completed
+ * with %-ESHUTDOWN as status. Receiver and transmitter threads will be
+ * stopped, the lower-level packet layer will be shutdown.
+ *
+ * As a result of this function, the transport layer will be marked as shut
+ * down. Submission of requests after the transport layer has been shut down
+ * will fail with %-ESHUTDOWN.
+ */
+void ssh_rtl_shutdown(struct ssh_rtl *rtl)
+{
+	struct ssh_request *r, *n;
+	LIST_HEAD(claimed);
+	int pending;
+
+	set_bit(SSH_RTL_SF_SHUTDOWN_BIT, &rtl->state);
+	/*
+	 * Ensure that the layer gets marked as shut-down before actually
+	 * stopping it. In combination with the check in ssh_rtl_submit(),
+	 * this guarantees that no new requests can be added and all already
+	 * queued requests are properly canceled.
+	 */
+	smp_mb__after_atomic();
+
+	/* Remove requests from queue. */
+	spin_lock(&rtl->queue.lock);
+	list_for_each_entry_safe(r, n, &rtl->queue.head, node) {
+		set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state);
+		/* Ensure state never gets zero. */
+		smp_mb__before_atomic();
+		clear_bit(SSH_REQUEST_SF_QUEUED_BIT, &r->state);
+
+		list_del(&r->node);
+		list_add_tail(&r->node, &claimed);
+	}
+	spin_unlock(&rtl->queue.lock);
+
+	/*
+	 * We have now guaranteed that the queue is empty and no more new
+	 * requests can be submitted (i.e. it will stay empty). This means that
+	 * calling ssh_rtl_tx_schedule() will not schedule tx.work any more. So
+	 * we can simply call cancel_work_sync() on tx.work here and when that
+	 * returns, we've locked it down. This also means that after this call,
+	 * we don't submit any more packets to the underlying packet layer, so
+	 * we can also shut that down.
+	 */
+
+	cancel_work_sync(&rtl->tx.work);
+	ssh_ptl_shutdown(&rtl->ptl);
+	cancel_delayed_work_sync(&rtl->rtx_timeout.reaper);
+
+	/*
+	 * Shutting down the packet layer should also have canceled all
+	 * requests. Thus the pending set should be empty. Attempt to handle
+	 * this gracefully anyways, even though this should be dead code.
+	 */
+
+	pending = atomic_read(&rtl->pending.count);
+	if (WARN_ON(pending)) {
+		spin_lock(&rtl->pending.lock);
+		list_for_each_entry_safe(r, n, &rtl->pending.head, node) {
+			set_bit(SSH_REQUEST_SF_LOCKED_BIT, &r->state);
+			/* Ensure state never gets zero. */
+			smp_mb__before_atomic();
+			clear_bit(SSH_REQUEST_SF_PENDING_BIT, &r->state);
+
+			list_del(&r->node);
+			list_add_tail(&r->node, &claimed);
+		}
+		spin_unlock(&rtl->pending.lock);
+	}
+
+	/* Finally, cancel and complete the requests we claimed before. */
+	list_for_each_entry_safe(r, n, &claimed, node) {
+		/*
+		 * We need test_and_set() because we still might compete with
+		 * cancellation.
+		 */
+		if (!test_and_set_bit(SSH_REQUEST_SF_COMPLETED_BIT, &r->state))
+			ssh_rtl_complete_with_status(r, -ESHUTDOWN);
+
+		/*
+		 * Drop the reference we've obtained by removing it from the
+		 * lists.
+		 */
+		list_del(&r->node);
+		ssh_request_put(r);
+	}
+}
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.h b/drivers/platform/surface/aggregator/ssh_request_layer.h
new file mode 100644
index 000000000000..9c2efdd8ae70
--- /dev/null
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SSH request transport layer.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _SURFACE_AGGREGATOR_SSH_REQUEST_LAYER_H
+#define _SURFACE_AGGREGATOR_SSH_REQUEST_LAYER_H
+
+#include <linux/atomic.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+#include <linux/surface_aggregator/controller.h>
+
+#include "ssh_packet_layer.h"
+
+/**
+ * enum ssh_rtl_state_flags - State-flags for &struct ssh_rtl.
+ *
+ * @SSH_RTL_SF_SHUTDOWN_BIT:
+ *	Indicates that the request transport layer has been shut down or is
+ *	being shut down and should not accept any new requests.
+ */
+enum ssh_rtl_state_flags {
+	SSH_RTL_SF_SHUTDOWN_BIT,
+};
+
+/**
+ * struct ssh_rtl_ops - Callback operations for request transport layer.
+ * @handle_event: Function called when a SSH event has been received. The
+ *                specified function takes the request layer, received command
+ *                struct, and corresponding payload as arguments. If the event
+ *                has no payload, the payload span is empty (not %NULL).
+ */
+struct ssh_rtl_ops {
+	void (*handle_event)(struct ssh_rtl *rtl, const struct ssh_command *cmd,
+			     const struct ssam_span *data);
+};
+
+/**
+ * struct ssh_rtl - SSH request transport layer.
+ * @ptl:           Underlying packet transport layer.
+ * @state:         State(-flags) of the transport layer.
+ * @queue:         Request submission queue.
+ * @queue.lock:    Lock for modifying the request submission queue.
+ * @queue.head:    List-head of the request submission queue.
+ * @pending:       Set/list of pending requests.
+ * @pending.lock:  Lock for modifying the request set.
+ * @pending.head:  List-head of the pending set/list.
+ * @pending.count: Number of currently pending requests.
+ * @tx:            Transmitter subsystem.
+ * @tx.work:       Transmitter work item.
+ * @rtx_timeout:   Retransmission timeout subsystem.
+ * @rtx_timeout.lock:    Lock for modifying the retransmission timeout reaper.
+ * @rtx_timeout.timeout: Timeout interval for retransmission.
+ * @rtx_timeout.expires: Time specifying when the reaper work is next scheduled.
+ * @rtx_timeout.reaper:  Work performing timeout checks and subsequent actions.
+ * @ops:           Request layer operations.
+ */
+struct ssh_rtl {
+	struct ssh_ptl ptl;
+	unsigned long state;
+
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+	} queue;
+
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+		atomic_t count;
+	} pending;
+
+	struct {
+		struct work_struct work;
+	} tx;
+
+	struct {
+		spinlock_t lock;
+		ktime_t timeout;
+		ktime_t expires;
+		struct delayed_work reaper;
+	} rtx_timeout;
+
+	struct ssh_rtl_ops ops;
+};
+
+#define rtl_dbg(r, fmt, ...)  ptl_dbg(&(r)->ptl, fmt, ##__VA_ARGS__)
+#define rtl_info(p, fmt, ...) ptl_info(&(p)->ptl, fmt, ##__VA_ARGS__)
+#define rtl_warn(r, fmt, ...) ptl_warn(&(r)->ptl, fmt, ##__VA_ARGS__)
+#define rtl_err(r, fmt, ...)  ptl_err(&(r)->ptl, fmt, ##__VA_ARGS__)
+#define rtl_dbg_cond(r, fmt, ...) __ssam_prcond(rtl_dbg, r, fmt, ##__VA_ARGS__)
+
+#define to_ssh_rtl(ptr, member) \
+	container_of(ptr, struct ssh_rtl, member)
+
+/**
+ * ssh_rtl_get_device() - Get device associated with request transport layer.
+ * @rtl: The request transport layer.
+ *
+ * Return: Returns the device on which the given request transport layer
+ * builds upon.
+ */
+static inline struct device *ssh_rtl_get_device(struct ssh_rtl *rtl)
+{
+	return ssh_ptl_get_device(&rtl->ptl);
+}
+
+/**
+ * ssh_request_rtl() - Get request transport layer associated with request.
+ * @rqst: The request to get the request transport layer reference for.
+ *
+ * Return: Returns the &struct ssh_rtl associated with the given SSH request.
+ */
+static inline struct ssh_rtl *ssh_request_rtl(struct ssh_request *rqst)
+{
+	struct ssh_ptl *ptl;
+
+	ptl = READ_ONCE(rqst->packet.ptl);
+	return likely(ptl) ? to_ssh_rtl(ptl, ptl) : NULL;
+}
+
+int ssh_rtl_submit(struct ssh_rtl *rtl, struct ssh_request *rqst);
+bool ssh_rtl_cancel(struct ssh_request *rqst, bool pending);
+
+int ssh_rtl_init(struct ssh_rtl *rtl, struct serdev_device *serdev,
+		 const struct ssh_rtl_ops *ops);
+
+int ssh_rtl_start(struct ssh_rtl *rtl);
+int ssh_rtl_flush(struct ssh_rtl *rtl, unsigned long timeout);
+void ssh_rtl_shutdown(struct ssh_rtl *rtl);
+void ssh_rtl_destroy(struct ssh_rtl *rtl);
+
+void ssh_request_init(struct ssh_request *rqst, enum ssam_request_flags flags,
+		      const struct ssh_request_ops *ops);
+
+#endif /* _SURFACE_AGGREGATOR_SSH_REQUEST_LAYER_H */
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
new file mode 100644
index 000000000000..107a53617c02
--- /dev/null
+++ b/include/linux/surface_aggregator/controller.h
@@ -0,0 +1,824 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Surface System Aggregator Module (SSAM) controller interface.
+ *
+ * Main communication interface for the SSAM EC. Provides a controller
+ * managing access and communication to and from the SSAM EC, as well as main
+ * communication structures and definitions.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
+#define _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/serial_hub.h>
+
+
+/* -- Main data types and definitions --------------------------------------- */
+
+/**
+ * enum ssam_event_flags - Flags for enabling/disabling SAM events
+ * @SSAM_EVENT_SEQUENCED: The event will be sent via a sequenced data frame.
+ */
+enum ssam_event_flags {
+	SSAM_EVENT_SEQUENCED = BIT(0),
+};
+
+/**
+ * struct ssam_event - SAM event sent from the EC to the host.
+ * @target_category: Target category of the event source. See &enum ssam_ssh_tc.
+ * @target_id:       Target ID of the event source.
+ * @command_id:      Command ID of the event.
+ * @instance_id:     Instance ID of the event source.
+ * @length:          Length of the event payload in bytes.
+ * @data:            Event payload data.
+ */
+struct ssam_event {
+	u8 target_category;
+	u8 target_id;
+	u8 command_id;
+	u8 instance_id;
+	u16 length;
+	u8 data[];
+};
+
+/**
+ * enum ssam_request_flags - Flags for SAM requests.
+ *
+ * @SSAM_REQUEST_HAS_RESPONSE:
+ *	Specifies that the request expects a response. If not set, the request
+ *	will be directly completed after its underlying packet has been
+ *	transmitted. If set, the request transport system waits for a response
+ *	of the request.
+ *
+ * @SSAM_REQUEST_UNSEQUENCED:
+ *	Specifies that the request should be transmitted via an unsequenced
+ *	packet. If set, the request must not have a response, meaning that this
+ *	flag and the %SSAM_REQUEST_HAS_RESPONSE flag are mutually exclusive.
+ */
+enum ssam_request_flags {
+	SSAM_REQUEST_HAS_RESPONSE = BIT(0),
+	SSAM_REQUEST_UNSEQUENCED  = BIT(1),
+};
+
+/**
+ * struct ssam_request - SAM request description.
+ * @target_category: Category of the request's target. See &enum ssam_ssh_tc.
+ * @target_id:       ID of the request's target.
+ * @command_id:      Command ID of the request.
+ * @instance_id:     Instance ID of the request's target.
+ * @flags:           Flags for the request. See &enum ssam_request_flags.
+ * @length:          Length of the request payload in bytes.
+ * @payload:         Request payload data.
+ *
+ * This struct fully describes a SAM request with payload. It is intended to
+ * help set up the actual transport struct, e.g. &struct ssam_request_sync,
+ * and specifically its raw message data via ssam_request_write_data().
+ */
+struct ssam_request {
+	u8 target_category;
+	u8 target_id;
+	u8 command_id;
+	u8 instance_id;
+	u16 flags;
+	u16 length;
+	const u8 *payload;
+};
+
+/**
+ * struct ssam_response - Response buffer for SAM request.
+ * @capacity: Capacity of the buffer, in bytes.
+ * @length:   Length of the actual data stored in the memory pointed to by
+ *            @pointer, in bytes. Set by the transport system.
+ * @pointer:  Pointer to the buffer's memory, storing the response payload data.
+ */
+struct ssam_response {
+	size_t capacity;
+	size_t length;
+	u8 *pointer;
+};
+
+struct ssam_controller;
+
+struct ssam_controller *ssam_get_controller(void);
+struct ssam_controller *ssam_client_bind(struct device *client);
+int ssam_client_link(struct ssam_controller *ctrl, struct device *client);
+
+struct device *ssam_controller_device(struct ssam_controller *c);
+
+struct ssam_controller *ssam_controller_get(struct ssam_controller *c);
+void ssam_controller_put(struct ssam_controller *c);
+
+void ssam_controller_statelock(struct ssam_controller *c);
+void ssam_controller_stateunlock(struct ssam_controller *c);
+
+ssize_t ssam_request_write_data(struct ssam_span *buf,
+				struct ssam_controller *ctrl,
+				const struct ssam_request *spec);
+
+
+/* -- Synchronous request interface. ---------------------------------------- */
+
+/**
+ * struct ssam_request_sync - Synchronous SAM request struct.
+ * @base:   Underlying SSH request.
+ * @comp:   Completion used to signal full completion of the request. After the
+ *          request has been submitted, this struct may only be modified or
+ *          deallocated after the completion has been signaled.
+ *          request has been submitted,
+ * @resp:   Buffer to store the response.
+ * @status: Status of the request, set after the base request has been
+ *          completed or has failed.
+ */
+struct ssam_request_sync {
+	struct ssh_request base;
+	struct completion comp;
+	struct ssam_response *resp;
+	int status;
+};
+
+int ssam_request_sync_alloc(size_t payload_len, gfp_t flags,
+			    struct ssam_request_sync **rqst,
+			    struct ssam_span *buffer);
+
+void ssam_request_sync_free(struct ssam_request_sync *rqst);
+
+void ssam_request_sync_init(struct ssam_request_sync *rqst,
+			    enum ssam_request_flags flags);
+
+/**
+ * ssam_request_sync_set_data - Set message data of a synchronous request.
+ * @rqst: The request.
+ * @ptr:  Pointer to the request message data.
+ * @len:  Length of the request message data.
+ *
+ * Set the request message data of a synchronous request. The provided buffer
+ * needs to live until the request has been completed.
+ */
+static inline void ssam_request_sync_set_data(struct ssam_request_sync *rqst,
+					      u8 *ptr, size_t len)
+{
+	ssh_request_set_data(&rqst->base, ptr, len);
+}
+
+/**
+ * ssam_request_sync_set_resp - Set response buffer of a synchronous request.
+ * @rqst: The request.
+ * @resp: The response buffer.
+ *
+ * Sets the response buffer of a synchronous request. This buffer will store
+ * the response of the request after it has been completed. May be %NULL if no
+ * response is expected.
+ */
+static inline void ssam_request_sync_set_resp(struct ssam_request_sync *rqst,
+					      struct ssam_response *resp)
+{
+	rqst->resp = resp;
+}
+
+int ssam_request_sync_submit(struct ssam_controller *ctrl,
+			     struct ssam_request_sync *rqst);
+
+/**
+ * ssam_request_sync_wait - Wait for completion of a synchronous request.
+ * @rqst: The request to wait for.
+ *
+ * Wait for completion and release of a synchronous request. After this
+ * function terminates, the request is guaranteed to have left the transport
+ * system. After successful submission of a request, this function must be
+ * called before accessing the response of the request, freeing the request,
+ * or freeing any of the buffers associated with the request.
+ *
+ * This function must not be called if the request has not been submitted yet
+ * and may lead to a deadlock/infinite wait if a subsequent request submission
+ * fails in that case, due to the completion never triggering.
+ *
+ * Return: Returns the status of the given request, which is set on completion
+ * of the packet. This value is zero on success and negative on failure.
+ */
+static inline int ssam_request_sync_wait(struct ssam_request_sync *rqst)
+{
+	wait_for_completion(&rqst->comp);
+	return rqst->status;
+}
+
+int ssam_request_sync(struct ssam_controller *ctrl,
+		      const struct ssam_request *spec,
+		      struct ssam_response *rsp);
+
+int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
+				  const struct ssam_request *spec,
+				  struct ssam_response *rsp,
+				  struct ssam_span *buf);
+
+/**
+ * ssam_request_sync_onstack - Execute a synchronous request on the stack.
+ * @ctrl: The controller via which the request is submitted.
+ * @rqst: The request specification.
+ * @rsp:  The response buffer.
+ * @payload_len: The (maximum) request payload length.
+ *
+ * Allocates a synchronous request with specified payload length on the stack,
+ * fully initializes it via the provided request specification, submits it,
+ * and finally waits for its completion before returning its status. This
+ * helper macro essentially allocates the request message buffer on the stack
+ * and then calls ssam_request_sync_with_buffer().
+ *
+ * Note: The @payload_len parameter specifies the maximum payload length, used
+ * for buffer allocation. The actual payload length may be smaller.
+ *
+ * Return: Returns the status of the request or any failure during setup, i.e.
+ * zero on success and a negative value on failure.
+ */
+#define ssam_request_sync_onstack(ctrl, rqst, rsp, payload_len)			\
+	({									\
+		u8 __data[SSH_COMMAND_MESSAGE_LENGTH(payload_len)];		\
+		struct ssam_span __buf = { &__data[0], ARRAY_SIZE(__data) };	\
+										\
+		ssam_request_sync_with_buffer(ctrl, rqst, rsp, &__buf);		\
+	})
+
+/**
+ * __ssam_retry - Retry request in case of I/O errors or timeouts.
+ * @request: The request function to execute. Must return an integer.
+ * @n:       Number of tries.
+ * @args:    Arguments for the request function.
+ *
+ * Executes the given request function, i.e. calls @request. In case the
+ * request returns %-EREMOTEIO (indicates I/O error) or %-ETIMEDOUT (request
+ * or underlying packet timed out), @request will be re-executed again, up to
+ * @n times in total.
+ *
+ * Return: Returns the return value of the last execution of @request.
+ */
+#define __ssam_retry(request, n, args...)				\
+	({								\
+		int __i, __s = 0;					\
+									\
+		for (__i = (n); __i > 0; __i--) {			\
+			__s = request(args);				\
+			if (__s != -ETIMEDOUT && __s != -EREMOTEIO)	\
+				break;					\
+		}							\
+		__s;							\
+	})
+
+/**
+ * ssam_retry - Retry request in case of I/O errors or timeouts up to three
+ * times in total.
+ * @request: The request function to execute. Must return an integer.
+ * @args:    Arguments for the request function.
+ *
+ * Executes the given request function, i.e. calls @request. In case the
+ * request returns %-EREMOTEIO (indicates I/O error) or -%ETIMEDOUT (request
+ * or underlying packet timed out), @request will be re-executed again, up to
+ * three times in total.
+ *
+ * See __ssam_retry() for a more generic macro for this purpose.
+ *
+ * Return: Returns the return value of the last execution of @request.
+ */
+#define ssam_retry(request, args...) \
+	__ssam_retry(request, 3, args)
+
+/**
+ * struct ssam_request_spec - Blue-print specification of SAM request.
+ * @target_category: Category of the request's target. See &enum ssam_ssh_tc.
+ * @target_id:       ID of the request's target.
+ * @command_id:      Command ID of the request.
+ * @instance_id:     Instance ID of the request's target.
+ * @flags:           Flags for the request. See &enum ssam_request_flags.
+ *
+ * Blue-print specification for a SAM request. This struct describes the
+ * unique static parameters of a request (i.e. type) without specifying any of
+ * its instance-specific data (e.g. payload). It is intended to be used as base
+ * for defining simple request functions via the
+ * ``SSAM_DEFINE_SYNC_REQUEST_x()`` family of macros.
+ */
+struct ssam_request_spec {
+	u8 target_category;
+	u8 target_id;
+	u8 command_id;
+	u8 instance_id;
+	u8 flags;
+};
+
+/**
+ * struct ssam_request_spec_md - Blue-print specification for multi-device SAM
+ * request.
+ * @target_category: Category of the request's target. See &enum ssam_ssh_tc.
+ * @command_id:      Command ID of the request.
+ * @flags:           Flags for the request. See &enum ssam_request_flags.
+ *
+ * Blue-print specification for a multi-device SAM request, i.e. a request
+ * that is applicable to multiple device instances, described by their
+ * individual target and instance IDs. This struct describes the unique static
+ * parameters of a request (i.e. type) without specifying any of its
+ * instance-specific data (e.g. payload) and without specifying any of its
+ * device specific IDs (i.e. target and instance ID). It is intended to be
+ * used as base for defining simple multi-device request functions via the
+ * ``SSAM_DEFINE_SYNC_REQUEST_MD_x()`` and ``SSAM_DEFINE_SYNC_REQUEST_CL_x()``
+ * families of macros.
+ */
+struct ssam_request_spec_md {
+	u8 target_category;
+	u8 command_id;
+	u8 flags;
+};
+
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_N() - Define synchronous SAM request function
+ * with neither argument nor return value.
+ * @name: Name of the generated function.
+ * @spec: Specification (&struct ssam_request_spec) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by
+ * @spec, with the request having neither argument nor return value. The
+ * generated function takes care of setting up the request struct and buffer
+ * allocation, as well as execution of the request itself, returning once the
+ * request has been fully completed. The required transport buffer will be
+ * allocated on the stack.
+ *
+ * The generated function is defined as ``int name(struct ssam_controller
+ * *ctrl)``, returning the status of the request, which is zero on success and
+ * negative on failure. The ``ctrl`` parameter is the controller via which the
+ * request is being sent.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_N(name, spec...)				\
+	int name(struct ssam_controller *ctrl)					\
+	{									\
+		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
+		struct ssam_request rqst;					\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = s.target_id;					\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = s.instance_id;				\
+		rqst.flags = s.flags;						\
+		rqst.length = 0;						\
+		rqst.payload = NULL;						\
+										\
+		return ssam_request_sync_onstack(ctrl, &rqst, NULL, 0);		\
+	}
+
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_W() - Define synchronous SAM request function with
+ * argument.
+ * @name:  Name of the generated function.
+ * @atype: Type of the request's argument.
+ * @spec:  Specification (&struct ssam_request_spec) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by
+ * @spec, with the request taking an argument of type @atype and having no
+ * return value. The generated function takes care of setting up the request
+ * struct, buffer allocation, as well as execution of the request itself,
+ * returning once the request has been fully completed. The required transport
+ * buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``int name(struct ssam_controller
+ * *ctrl, const atype *arg)``, returning the status of the request, which is
+ * zero on success and negative on failure. The ``ctrl`` parameter is the
+ * controller via which the request is sent. The request argument is specified
+ * via the ``arg`` pointer.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_W(name, atype, spec...)			\
+	int name(struct ssam_controller *ctrl, const atype *arg)		\
+	{									\
+		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
+		struct ssam_request rqst;					\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = s.target_id;					\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = s.instance_id;				\
+		rqst.flags = s.flags;						\
+		rqst.length = sizeof(atype);					\
+		rqst.payload = (u8 *)arg;					\
+										\
+		return ssam_request_sync_onstack(ctrl, &rqst, NULL,		\
+						 sizeof(atype));		\
+	}
+
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_R() - Define synchronous SAM request function with
+ * return value.
+ * @name:  Name of the generated function.
+ * @rtype: Type of the request's return value.
+ * @spec:  Specification (&struct ssam_request_spec) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by
+ * @spec, with the request taking no argument but having a return value of
+ * type @rtype. The generated function takes care of setting up the request
+ * and response structs, buffer allocation, as well as execution of the
+ * request itself, returning once the request has been fully completed. The
+ * required transport buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``int name(struct ssam_controller
+ * *ctrl, rtype *ret)``, returning the status of the request, which is zero on
+ * success and negative on failure. The ``ctrl`` parameter is the controller
+ * via which the request is sent. The request's return value is written to the
+ * memory pointed to by the ``ret`` parameter.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_R(name, rtype, spec...)			\
+	int name(struct ssam_controller *ctrl, rtype *ret)			\
+	{									\
+		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
+		struct ssam_request rqst;					\
+		struct ssam_response rsp;					\
+		int status;							\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = s.target_id;					\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = s.instance_id;				\
+		rqst.flags = s.flags | SSAM_REQUEST_HAS_RESPONSE;		\
+		rqst.length = 0;						\
+		rqst.payload = NULL;						\
+										\
+		rsp.capacity = sizeof(rtype);					\
+		rsp.length = 0;							\
+		rsp.pointer = (u8 *)ret;					\
+										\
+		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, 0);	\
+		if (status)							\
+			return status;						\
+										\
+		if (rsp.length != sizeof(rtype)) {				\
+			struct device *dev = ssam_controller_device(ctrl);	\
+			dev_err(dev,						\
+				"rqst: invalid response length, expected %zu, got %zu (tc: %#04x, cid: %#04x)", \
+				sizeof(rtype), rsp.length, rqst.target_category,\
+				rqst.command_id);				\
+			return -EIO;						\
+		}								\
+										\
+		return 0;							\
+	}
+
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_MD_N() - Define synchronous multi-device SAM
+ * request function with neither argument nor return value.
+ * @name: Name of the generated function.
+ * @spec: Specification (&struct ssam_request_spec_md) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by
+ * @spec, with the request having neither argument nor return value. Device
+ * specifying parameters are not hard-coded, but instead must be provided to
+ * the function. The generated function takes care of setting up the request
+ * struct, buffer allocation, as well as execution of the request itself,
+ * returning once the request has been fully completed. The required transport
+ * buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``int name(struct ssam_controller
+ * *ctrl, u8 tid, u8 iid)``, returning the status of the request, which is
+ * zero on success and negative on failure. The ``ctrl`` parameter is the
+ * controller via which the request is sent, ``tid`` the target ID for the
+ * request, and ``iid`` the instance ID.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_MD_N(name, spec...)				\
+	int name(struct ssam_controller *ctrl, u8 tid, u8 iid)			\
+	{									\
+		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
+		struct ssam_request rqst;					\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = tid;						\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = iid;						\
+		rqst.flags = s.flags;						\
+		rqst.length = 0;						\
+		rqst.payload = NULL;						\
+										\
+		return ssam_request_sync_onstack(ctrl, &rqst, NULL, 0);		\
+	}
+
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_MD_W() - Define synchronous multi-device SAM
+ * request function with argument.
+ * @name:  Name of the generated function.
+ * @atype: Type of the request's argument.
+ * @spec:  Specification (&struct ssam_request_spec_md) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by
+ * @spec, with the request taking an argument of type @atype and having no
+ * return value. Device specifying parameters are not hard-coded, but instead
+ * must be provided to the function. The generated function takes care of
+ * setting up the request struct, buffer allocation, as well as execution of
+ * the request itself, returning once the request has been fully completed.
+ * The required transport buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``int name(struct ssam_controller
+ * *ctrl, u8 tid, u8 iid, const atype *arg)``, returning the status of the
+ * request, which is zero on success and negative on failure. The ``ctrl``
+ * parameter is the controller via which the request is sent, ``tid`` the
+ * target ID for the request, and ``iid`` the instance ID. The request argument
+ * is specified via the ``arg`` pointer.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_MD_W(name, atype, spec...)			\
+	int name(struct ssam_controller *ctrl, u8 tid, u8 iid, const atype *arg)\
+	{									\
+		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
+		struct ssam_request rqst;					\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = tid;						\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = iid;						\
+		rqst.flags = s.flags;						\
+		rqst.length = sizeof(atype);					\
+		rqst.payload = (u8 *)arg;					\
+										\
+		return ssam_request_sync_onstack(ctrl, &rqst, NULL,		\
+						 sizeof(atype));		\
+	}
+
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_MD_R() - Define synchronous multi-device SAM
+ * request function with return value.
+ * @name:  Name of the generated function.
+ * @rtype: Type of the request's return value.
+ * @spec:  Specification (&struct ssam_request_spec_md) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by
+ * @spec, with the request taking no argument but having a return value of
+ * type @rtype. Device specifying parameters are not hard-coded, but instead
+ * must be provided to the function. The generated function takes care of
+ * setting up the request and response structs, buffer allocation, as well as
+ * execution of the request itself, returning once the request has been fully
+ * completed. The required transport buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``int name(struct ssam_controller
+ * *ctrl, u8 tid, u8 iid, rtype *ret)``, returning the status of the request,
+ * which is zero on success and negative on failure. The ``ctrl`` parameter is
+ * the controller via which the request is sent, ``tid`` the target ID for the
+ * request, and ``iid`` the instance ID. The request's return value is written
+ * to the memory pointed to by the ``ret`` parameter.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_MD_R(name, rtype, spec...)			\
+	int name(struct ssam_controller *ctrl, u8 tid, u8 iid, rtype *ret)	\
+	{									\
+		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
+		struct ssam_request rqst;					\
+		struct ssam_response rsp;					\
+		int status;							\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = tid;						\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = iid;						\
+		rqst.flags = s.flags | SSAM_REQUEST_HAS_RESPONSE;		\
+		rqst.length = 0;						\
+		rqst.payload = NULL;						\
+										\
+		rsp.capacity = sizeof(rtype);					\
+		rsp.length = 0;							\
+		rsp.pointer = (u8 *)ret;					\
+										\
+		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, 0);	\
+		if (status)							\
+			return status;						\
+										\
+		if (rsp.length != sizeof(rtype)) {				\
+			struct device *dev = ssam_controller_device(ctrl);	\
+			dev_err(dev,						\
+				"rqst: invalid response length, expected %zu, got %zu (tc: %#04x, cid: %#04x)", \
+				sizeof(rtype), rsp.length, rqst.target_category,\
+				rqst.command_id);				\
+			return -EIO;						\
+		}								\
+										\
+		return 0;							\
+	}
+
+
+/* -- Event notifier/callbacks. --------------------------------------------- */
+
+#define SSAM_NOTIF_STATE_SHIFT		2
+#define SSAM_NOTIF_STATE_MASK		((1 << SSAM_NOTIF_STATE_SHIFT) - 1)
+
+/**
+ * enum ssam_notif_flags - Flags used in return values from SSAM notifier
+ * callback functions.
+ *
+ * @SSAM_NOTIF_HANDLED:
+ *	Indicates that the notification has been handled. This flag should be
+ *	set by the handler if the handler can act/has acted upon the event
+ *	provided to it. This flag should not be set if the handler is not a
+ *	primary handler intended for the provided event.
+ *
+ *	If this flag has not been set by any handler after the notifier chain
+ *	has been traversed, a warning will be emitted, stating that the event
+ *	has not been handled.
+ *
+ * @SSAM_NOTIF_STOP:
+ *	Indicates that the notifier traversal should stop. If this flag is
+ *	returned from a notifier callback, notifier chain traversal will
+ *	immediately stop and any remaining notifiers will not be called. This
+ *	flag is automatically set when ssam_notifier_from_errno() is called
+ *	with a negative error value.
+ */
+enum ssam_notif_flags {
+	SSAM_NOTIF_HANDLED = BIT(0),
+	SSAM_NOTIF_STOP    = BIT(1),
+};
+
+struct ssam_event_notifier;
+
+typedef u32 (*ssam_notifier_fn_t)(struct ssam_event_notifier *nf,
+				  const struct ssam_event *event);
+
+/**
+ * struct ssam_notifier_block - Base notifier block for SSAM event
+ * notifications.
+ * @node:     The node for the list of notifiers.
+ * @fn:       The callback function of this notifier. This function takes the
+ *            respective notifier block and event as input and should return
+ *            a notifier value, which can either be obtained from the flags
+ *            provided in &enum ssam_notif_flags, converted from a standard
+ *            error value via ssam_notifier_from_errno(), or a combination of
+ *            both (e.g. ``ssam_notifier_from_errno(e) | SSAM_NOTIF_HANDLED``).
+ * @priority: Priority value determining the order in which notifier callbacks
+ *            will be called. A higher value means higher priority, i.e. the
+ *            associated callback will be executed earlier than other (lower
+ *            priority) callbacks.
+ */
+struct ssam_notifier_block {
+	struct list_head node;
+	ssam_notifier_fn_t fn;
+	int priority;
+};
+
+/**
+ * ssam_notifier_from_errno() - Convert standard error value to notifier
+ * return code.
+ * @err: The error code to convert, must be negative (in case of failure) or
+ *       zero (in case of success).
+ *
+ * Return: Returns the notifier return value obtained by converting the
+ * specified @err value. In case @err is negative, the %SSAM_NOTIF_STOP flag
+ * will be set, causing notifier call chain traversal to abort.
+ */
+static inline u32 ssam_notifier_from_errno(int err)
+{
+	if (WARN_ON(err > 0) || err == 0)
+		return 0;
+	else
+		return ((-err) << SSAM_NOTIF_STATE_SHIFT) | SSAM_NOTIF_STOP;
+}
+
+/**
+ * ssam_notifier_to_errno() - Convert notifier return code to standard error
+ * value.
+ * @ret: The notifier return value to convert.
+ *
+ * Return: Returns the negative error value encoded in @ret or zero if @ret
+ * indicates success.
+ */
+static inline int ssam_notifier_to_errno(u32 ret)
+{
+	return -(ret >> SSAM_NOTIF_STATE_SHIFT);
+}
+
+
+/* -- Event/notification registry. ------------------------------------------ */
+
+/**
+ * struct ssam_event_registry - Registry specification used for enabling events.
+ * @target_category: Target category for the event registry requests.
+ * @target_id:       Target ID for the event registry requests.
+ * @cid_enable:      Command ID for the event-enable request.
+ * @cid_disable:     Command ID for the event-disable request.
+ *
+ * This struct describes a SAM event registry via the minimal collection of
+ * SAM IDs specifying the requests to use for enabling and disabling an event.
+ * The individual event to be enabled/disabled itself is specified via &struct
+ * ssam_event_id.
+ */
+struct ssam_event_registry {
+	u8 target_category;
+	u8 target_id;
+	u8 cid_enable;
+	u8 cid_disable;
+};
+
+/**
+ * struct ssam_event_id - Unique event ID used for enabling events.
+ * @target_category: Target category of the event source.
+ * @instance:        Instance ID of the event source.
+ *
+ * This struct specifies the event to be enabled/disabled via an externally
+ * provided registry. It does not specify the registry to be used itself, this
+ * is done via &struct ssam_event_registry.
+ */
+struct ssam_event_id {
+	u8 target_category;
+	u8 instance;
+};
+
+/**
+ * enum ssam_event_mask - Flags specifying how events are matched to notifiers.
+ *
+ * @SSAM_EVENT_MASK_NONE:
+ *	Run the callback for any event with matching target category. Do not
+ *	do any additional filtering.
+ *
+ * @SSAM_EVENT_MASK_TARGET:
+ *	In addition to filtering by target category, only execute the notifier
+ *	callback for events with a target ID matching to the one of the
+ *	registry used for enabling/disabling the event.
+ *
+ * @SSAM_EVENT_MASK_INSTANCE:
+ *	In addition to filtering by target category, only execute the notifier
+ *	callback for events with an instance ID matching to the instance ID
+ *	used when enabling the event.
+ *
+ * @SSAM_EVENT_MASK_STRICT:
+ *	Do all the filtering above.
+ */
+enum ssam_event_mask {
+	SSAM_EVENT_MASK_TARGET   = BIT(0),
+	SSAM_EVENT_MASK_INSTANCE = BIT(1),
+
+	SSAM_EVENT_MASK_NONE = 0,
+	SSAM_EVENT_MASK_STRICT =
+		  SSAM_EVENT_MASK_TARGET
+		| SSAM_EVENT_MASK_INSTANCE,
+};
+
+/**
+ * SSAM_EVENT_REGISTRY() - Define a new event registry.
+ * @tc:      Target category for the event registry requests.
+ * @tid:     Target ID for the event registry requests.
+ * @cid_en:  Command ID for the event-enable request.
+ * @cid_dis: Command ID for the event-disable request.
+ *
+ * Return: Returns the &struct ssam_event_registry specified by the given
+ * parameters.
+ */
+#define SSAM_EVENT_REGISTRY(tc, tid, cid_en, cid_dis)	\
+	((struct ssam_event_registry) {			\
+		.target_category = (tc),		\
+		.target_id = (tid),			\
+		.cid_enable = (cid_en),			\
+		.cid_disable = (cid_dis),		\
+	})
+
+#define SSAM_EVENT_REGISTRY_SAM	\
+	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_SAM, 0x01, 0x0b, 0x0c)
+
+#define SSAM_EVENT_REGISTRY_KIP	\
+	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_KIP, 0x02, 0x27, 0x28)
+
+#define SSAM_EVENT_REGISTRY_REG \
+	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_REG, 0x02, 0x01, 0x02)
+
+/**
+ * struct ssam_event_notifier - Notifier block for SSAM events.
+ * @base:        The base notifier block with callback function and priority.
+ * @event:       The event for which this block will receive notifications.
+ * @event.reg:   Registry via which the event will be enabled/disabled.
+ * @event.id:    ID specifying the event.
+ * @event.mask:  Flags determining how events are matched to the notifier.
+ * @event.flags: Flags used for enabling the event.
+ */
+struct ssam_event_notifier {
+	struct ssam_notifier_block base;
+
+	struct {
+		struct ssam_event_registry reg;
+		struct ssam_event_id id;
+		enum ssam_event_mask mask;
+		u8 flags;
+	} event;
+};
+
+int ssam_notifier_register(struct ssam_controller *ctrl,
+			   struct ssam_event_notifier *n);
+
+int ssam_notifier_unregister(struct ssam_controller *ctrl,
+			     struct ssam_event_notifier *n);
+
+#endif /* _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H */
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
new file mode 100644
index 000000000000..64276fbfa1d5
--- /dev/null
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -0,0 +1,672 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Surface Serial Hub (SSH) protocol and communication interface.
+ *
+ * Lower-level communication layers and SSH protocol definitions for the
+ * Surface System Aggregator Module (SSAM). Provides the interface for basic
+ * packet- and request-based communication with the SSAM EC via SSH.
+ *
+ * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H
+#define _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H
+
+#include <linux/crc-ccitt.h>
+#include <linux/kref.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+
+/* -- Data structures for SAM-over-SSH communication. ----------------------- */
+
+/**
+ * enum ssh_frame_type - Frame types for SSH frames.
+ *
+ * @SSH_FRAME_TYPE_DATA_SEQ:
+ *	Indicates a data frame, followed by a payload with the length specified
+ *	in the ``struct ssh_frame.len`` field. This frame is sequenced, meaning
+ *	that an ACK is required.
+ *
+ * @SSH_FRAME_TYPE_DATA_NSQ:
+ *	Same as %SSH_FRAME_TYPE_DATA_SEQ, but unsequenced, meaning that the
+ *	message does not have to be ACKed.
+ *
+ * @SSH_FRAME_TYPE_ACK:
+ *	Indicates an ACK message.
+ *
+ * @SSH_FRAME_TYPE_NAK:
+ *	Indicates an error response for previously sent frame. In general, this
+ *	means that the frame and/or payload is malformed, e.g. a CRC is wrong.
+ *	For command-type payloads, this can also mean that the command is
+ *	invalid.
+ */
+enum ssh_frame_type {
+	SSH_FRAME_TYPE_DATA_SEQ = 0x80,
+	SSH_FRAME_TYPE_DATA_NSQ = 0x00,
+	SSH_FRAME_TYPE_ACK      = 0x40,
+	SSH_FRAME_TYPE_NAK      = 0x04,
+};
+
+/**
+ * struct ssh_frame - SSH communication frame.
+ * @type: The type of the frame. See &enum ssh_frame_type.
+ * @len:  The length of the frame payload directly following the CRC for this
+ *        frame. Does not include the final CRC for that payload.
+ * @seq:  The sequence number for this message/exchange.
+ */
+struct ssh_frame {
+	u8 type;
+	__le16 len;
+	u8 seq;
+} __packed;
+
+static_assert(sizeof(struct ssh_frame) == 4);
+
+/*
+ * SSH_FRAME_MAX_PAYLOAD_SIZE - Maximum SSH frame payload length in bytes.
+ *
+ * This is the physical maximum length of the protocol. Implementations may
+ * set a more constrained limit.
+ */
+#define SSH_FRAME_MAX_PAYLOAD_SIZE	U16_MAX
+
+/**
+ * enum ssh_payload_type - Type indicator for the SSH payload.
+ * @SSH_PLD_TYPE_CMD: The payload is a command structure with optional command
+ *                    payload.
+ */
+enum ssh_payload_type {
+	SSH_PLD_TYPE_CMD = 0x80,
+};
+
+/**
+ * struct ssh_command - Payload of a command-type frame.
+ * @type:    The type of the payload. See &enum ssh_payload_type. Should be
+ *           SSH_PLD_TYPE_CMD for this struct.
+ * @tc:      Command target category.
+ * @tid_out: Output target ID. Should be zero if this an incoming (EC to host)
+ *           message.
+ * @tid_in:  Input target ID. Should be zero if this is an outgoing (host to
+ *           EC) message.
+ * @iid:     Instance ID.
+ * @rqid:    Request ID. Used to match requests with responses and differentiate
+ *           between responses and events.
+ * @cid:     Command ID.
+ */
+struct ssh_command {
+	u8 type;
+	u8 tc;
+	u8 tid_out;
+	u8 tid_in;
+	u8 iid;
+	__le16 rqid;
+	u8 cid;
+} __packed;
+
+static_assert(sizeof(struct ssh_command) == 8);
+
+/*
+ * SSH_COMMAND_MAX_PAYLOAD_SIZE - Maximum SSH command payload length in bytes.
+ *
+ * This is the physical maximum length of the protocol. Implementations may
+ * set a more constrained limit.
+ */
+#define SSH_COMMAND_MAX_PAYLOAD_SIZE \
+	(SSH_FRAME_MAX_PAYLOAD_SIZE - sizeof(struct ssh_command))
+
+/*
+ * SSH_MSG_LEN_BASE - Base-length of a SSH message.
+ *
+ * This is the minimum number of bytes required to form a message. The actual
+ * message length is SSH_MSG_LEN_BASE plus the length of the frame payload.
+ */
+#define SSH_MSG_LEN_BASE	(sizeof(struct ssh_frame) + 3ull * sizeof(u16))
+
+/*
+ * SSH_MSG_LEN_CTRL - Length of a SSH control message.
+ *
+ * This is the length of a SSH control message, which is equal to a SSH
+ * message without any payload.
+ */
+#define SSH_MSG_LEN_CTRL	SSH_MSG_LEN_BASE
+
+/**
+ * SSH_MESSAGE_LENGTH() - Compute length of SSH message.
+ * @payload_size: Length of the payload inside the SSH frame.
+ *
+ * Return: Returns the length of a SSH message with payload of specified size.
+ */
+#define SSH_MESSAGE_LENGTH(payload_size) (SSH_MSG_LEN_BASE + (payload_size))
+
+/**
+ * SSH_COMMAND_MESSAGE_LENGTH() - Compute length of SSH command message.
+ * @payload_size: Length of the command payload.
+ *
+ * Return: Returns the length of a SSH command message with command payload of
+ * specified size.
+ */
+#define SSH_COMMAND_MESSAGE_LENGTH(payload_size) \
+	SSH_MESSAGE_LENGTH(sizeof(struct ssh_command) + (payload_size))
+
+/**
+ * SSH_MSGOFFSET_FRAME() - Compute offset in SSH message to specified field in
+ * frame.
+ * @field: The field for which the offset should be computed.
+ *
+ * Return: Returns the offset of the specified &struct ssh_frame field in the
+ * raw SSH message data as. Takes SYN bytes (u16) preceding the frame into
+ * account.
+ */
+#define SSH_MSGOFFSET_FRAME(field) \
+	(sizeof(u16) + offsetof(struct ssh_frame, field))
+
+/**
+ * SSH_MSGOFFSET_COMMAND() - Compute offset in SSH message to specified field
+ * in command.
+ * @field: The field for which the offset should be computed.
+ *
+ * Return: Returns the offset of the specified &struct ssh_command field in
+ * the raw SSH message data. Takes SYN bytes (u16) preceding the frame and the
+ * frame CRC (u16) between frame and command into account.
+ */
+#define SSH_MSGOFFSET_COMMAND(field) \
+	(2ull * sizeof(u16) + sizeof(struct ssh_frame) \
+		+ offsetof(struct ssh_command, field))
+
+/*
+ * SSH_MSG_SYN - SSH message synchronization (SYN) bytes as u16.
+ */
+#define SSH_MSG_SYN		((u16)0x55aa)
+
+/**
+ * ssh_crc() - Compute CRC for SSH messages.
+ * @buf: The pointer pointing to the data for which the CRC should be computed.
+ * @len: The length of the data for which the CRC should be computed.
+ *
+ * Return: Returns the CRC computed on the provided data, as used for SSH
+ * messages.
+ */
+static inline u16 ssh_crc(const u8 *buf, size_t len)
+{
+	return crc_ccitt_false(0xffff, buf, len);
+}
+
+/*
+ * SSH_NUM_EVENTS - The number of reserved event IDs.
+ *
+ * The number of reserved event IDs, used for registering an SSH event
+ * handler. Valid event IDs are numbers below or equal to this value, with
+ * exception of zero, which is not an event ID. Thus, this is also the
+ * absolute maximum number of event handlers that can be registered.
+ */
+#define SSH_NUM_EVENTS		34
+
+/*
+ * SSH_NUM_TARGETS - The number of communication targets used in the protocol.
+ */
+#define SSH_NUM_TARGETS		2
+
+/**
+ * ssh_rqid_next_valid() - Return the next valid request ID.
+ * @rqid: The current request ID.
+ *
+ * Return: Returns the next valid request ID, following the current request ID
+ * provided to this function. This function skips any request IDs reserved for
+ * events.
+ */
+static inline u16 ssh_rqid_next_valid(u16 rqid)
+{
+	return rqid > 0 ? rqid + 1u : rqid + SSH_NUM_EVENTS + 1u;
+}
+
+/**
+ * ssh_rqid_to_event() - Convert request ID to its corresponding event ID.
+ * @rqid: The request ID to convert.
+ */
+static inline u16 ssh_rqid_to_event(u16 rqid)
+{
+	return rqid - 1u;
+}
+
+/**
+ * ssh_rqid_is_event() - Check if given request ID is a valid event ID.
+ * @rqid: The request ID to check.
+ */
+static inline bool ssh_rqid_is_event(u16 rqid)
+{
+	return ssh_rqid_to_event(rqid) < SSH_NUM_EVENTS;
+}
+
+/**
+ * ssh_tc_to_rqid() - Convert target category to its corresponding request ID.
+ * @tc: The target category to convert.
+ */
+static inline u16 ssh_tc_to_rqid(u8 tc)
+{
+	return tc;
+}
+
+/**
+ * ssh_tid_to_index() - Convert target ID to its corresponding target index.
+ * @tid: The target ID to convert.
+ */
+static inline u8 ssh_tid_to_index(u8 tid)
+{
+	return tid - 1u;
+}
+
+/**
+ * ssh_tid_is_valid() - Check if target ID is valid/supported.
+ * @tid: The target ID to check.
+ */
+static inline bool ssh_tid_is_valid(u8 tid)
+{
+	return ssh_tid_to_index(tid) < SSH_NUM_TARGETS;
+}
+
+/**
+ * struct ssam_span - Reference to a buffer region.
+ * @ptr: Pointer to the buffer region.
+ * @len: Length of the buffer region.
+ *
+ * A reference to a (non-owned) buffer segment, consisting of pointer and
+ * length. Use of this struct indicates non-owned data, i.e. data of which the
+ * life-time is managed (i.e. it is allocated/freed) via another pointer.
+ */
+struct ssam_span {
+	u8    *ptr;
+	size_t len;
+};
+
+/*
+ * Known SSH/EC target categories.
+ *
+ * List of currently known target category values; "Known" as in we know they
+ * exist and are valid on at least some device/model. Detailed functionality
+ * or the full category name is only known for some of these categories and
+ * is detailed in the respective comment below.
+ *
+ * These values and abbreviations have been extracted from strings inside the
+ * Windows driver.
+ */
+enum ssam_ssh_tc {
+				/* Category 0x00 is invalid for EC use. */
+	SSAM_SSH_TC_SAM = 0x01,	/* Generic system functionality, real-time clock. */
+	SSAM_SSH_TC_BAT = 0x02,	/* Battery/power subsystem. */
+	SSAM_SSH_TC_TMP = 0x03,	/* Thermal subsystem. */
+	SSAM_SSH_TC_PMC = 0x04,
+	SSAM_SSH_TC_FAN = 0x05,
+	SSAM_SSH_TC_PoM = 0x06,
+	SSAM_SSH_TC_DBG = 0x07,
+	SSAM_SSH_TC_KBD = 0x08,	/* Legacy keyboard (Laptop 1/2). */
+	SSAM_SSH_TC_FWU = 0x09,
+	SSAM_SSH_TC_UNI = 0x0a,
+	SSAM_SSH_TC_LPC = 0x0b,
+	SSAM_SSH_TC_TCL = 0x0c,
+	SSAM_SSH_TC_SFL = 0x0d,
+	SSAM_SSH_TC_KIP = 0x0e,
+	SSAM_SSH_TC_EXT = 0x0f,
+	SSAM_SSH_TC_BLD = 0x10,
+	SSAM_SSH_TC_BAS = 0x11,	/* Detachment system (Surface Book 2/3). */
+	SSAM_SSH_TC_SEN = 0x12,
+	SSAM_SSH_TC_SRQ = 0x13,
+	SSAM_SSH_TC_MCU = 0x14,
+	SSAM_SSH_TC_HID = 0x15,	/* Generic HID input subsystem. */
+	SSAM_SSH_TC_TCH = 0x16,
+	SSAM_SSH_TC_BKL = 0x17,
+	SSAM_SSH_TC_TAM = 0x18,
+	SSAM_SSH_TC_ACC = 0x19,
+	SSAM_SSH_TC_UFI = 0x1a,
+	SSAM_SSH_TC_USC = 0x1b,
+	SSAM_SSH_TC_PEN = 0x1c,
+	SSAM_SSH_TC_VID = 0x1d,
+	SSAM_SSH_TC_AUD = 0x1e,
+	SSAM_SSH_TC_SMC = 0x1f,
+	SSAM_SSH_TC_KPD = 0x20,
+	SSAM_SSH_TC_REG = 0x21,	/* Extended event registry. */
+};
+
+
+/* -- Packet transport layer (ptl). ----------------------------------------- */
+
+/**
+ * enum ssh_packet_base_priority - Base priorities for &struct ssh_packet.
+ * @SSH_PACKET_PRIORITY_FLUSH: Base priority for flush packets.
+ * @SSH_PACKET_PRIORITY_DATA:  Base priority for normal data packets.
+ * @SSH_PACKET_PRIORITY_NAK:   Base priority for NAK packets.
+ * @SSH_PACKET_PRIORITY_ACK:   Base priority for ACK packets.
+ */
+enum ssh_packet_base_priority {
+	SSH_PACKET_PRIORITY_FLUSH = 0,	/* same as DATA to sequence flush */
+	SSH_PACKET_PRIORITY_DATA  = 0,
+	SSH_PACKET_PRIORITY_NAK   = 1,
+	SSH_PACKET_PRIORITY_ACK   = 2,
+};
+
+/*
+ * Same as SSH_PACKET_PRIORITY() below, only with actual values.
+ */
+#define __SSH_PACKET_PRIORITY(base, try) \
+	(((base) << 4) | ((try) & 0x0f))
+
+/**
+ * SSH_PACKET_PRIORITY() - Compute packet priority from base priority and
+ * number of tries.
+ * @base: The base priority as suffix of &enum ssh_packet_base_priority, e.g.
+ *        ``FLUSH``, ``DATA``, ``ACK``, or ``NAK``.
+ * @try:  The number of tries (must be less than 16).
+ *
+ * Compute the combined packet priority. The combined priority is dominated by
+ * the base priority, whereas the number of (re-)tries decides the precedence
+ * of packets with the same base priority, giving higher priority to packets
+ * that already have more tries.
+ *
+ * Return: Returns the computed priority as value fitting inside a &u8. A
+ * higher number means a higher priority.
+ */
+#define SSH_PACKET_PRIORITY(base, try) \
+	__SSH_PACKET_PRIORITY(SSH_PACKET_PRIORITY_##base, (try))
+
+/**
+ * ssh_packet_priority_get_try() - Get number of tries from packet priority.
+ * @priority: The packet priority.
+ *
+ * Return: Returns the number of tries encoded in the specified packet
+ * priority.
+ */
+static inline u8 ssh_packet_priority_get_try(u8 priority)
+{
+	return priority & 0x0f;
+}
+
+/**
+ * ssh_packet_priority_get_base - Get base priority from packet priority.
+ * @priority: The packet priority.
+ *
+ * Return: Returns the base priority encoded in the given packet priority.
+ */
+static inline u8 ssh_packet_priority_get_base(u8 priority)
+{
+	return (priority & 0xf0) >> 4;
+}
+
+enum ssh_packet_flags {
+	/* state flags */
+	SSH_PACKET_SF_LOCKED_BIT,
+	SSH_PACKET_SF_QUEUED_BIT,
+	SSH_PACKET_SF_PENDING_BIT,
+	SSH_PACKET_SF_TRANSMITTING_BIT,
+	SSH_PACKET_SF_TRANSMITTED_BIT,
+	SSH_PACKET_SF_ACKED_BIT,
+	SSH_PACKET_SF_CANCELED_BIT,
+	SSH_PACKET_SF_COMPLETED_BIT,
+
+	/* type flags */
+	SSH_PACKET_TY_FLUSH_BIT,
+	SSH_PACKET_TY_SEQUENCED_BIT,
+	SSH_PACKET_TY_BLOCKING_BIT,
+
+	/* mask for state flags */
+	SSH_PACKET_FLAGS_SF_MASK =
+		  BIT(SSH_PACKET_SF_LOCKED_BIT)
+		| BIT(SSH_PACKET_SF_QUEUED_BIT)
+		| BIT(SSH_PACKET_SF_PENDING_BIT)
+		| BIT(SSH_PACKET_SF_TRANSMITTING_BIT)
+		| BIT(SSH_PACKET_SF_TRANSMITTED_BIT)
+		| BIT(SSH_PACKET_SF_ACKED_BIT)
+		| BIT(SSH_PACKET_SF_CANCELED_BIT)
+		| BIT(SSH_PACKET_SF_COMPLETED_BIT),
+
+	/* mask for type flags */
+	SSH_PACKET_FLAGS_TY_MASK =
+		  BIT(SSH_PACKET_TY_FLUSH_BIT)
+		| BIT(SSH_PACKET_TY_SEQUENCED_BIT)
+		| BIT(SSH_PACKET_TY_BLOCKING_BIT),
+};
+
+struct ssh_ptl;
+struct ssh_packet;
+
+/**
+ * struct ssh_packet_ops - Callback operations for a SSH packet.
+ * @release:  Function called when the packet reference count reaches zero.
+ *            This callback must be relied upon to ensure that the packet has
+ *            left the transport system(s).
+ * @complete: Function called when the packet is completed, either with
+ *            success or failure. In case of failure, the reason for the
+ *            failure is indicated by the value of the provided status code
+ *            argument. This value will be zero in case of success. Note that
+ *            a call to this callback does not guarantee that the packet is
+ *            not in use by the transport system any more.
+ */
+struct ssh_packet_ops {
+	void (*release)(struct ssh_packet *p);
+	void (*complete)(struct ssh_packet *p, int status);
+};
+
+/**
+ * struct ssh_packet - SSH transport packet.
+ * @ptl:      Pointer to the packet transport layer. May be %NULL if the packet
+ *            (or enclosing request) has not been submitted yet.
+ * @refcnt:   Reference count of the packet.
+ * @priority: Priority of the packet. Must be computed via
+ *            SSH_PACKET_PRIORITY(). Must only be accessed while holding the
+ *            queue lock after first submission.
+ * @data:     Raw message data.
+ * @data.len: Length of the raw message data.
+ * @data.ptr: Pointer to the raw message data buffer.
+ * @state:    State and type flags describing current packet state (dynamic)
+ *            and type (static). See &enum ssh_packet_flags for possible
+ *            options.
+ * @timestamp: Timestamp specifying when the latest transmission of a
+ *            currently pending packet has been started. May be %KTIME_MAX
+ *            before or in-between transmission attempts. Used for the packet
+ *            timeout implementation. Must only be accessed while holding the
+ *            pending lock after first submission.
+ * @queue_node:	The list node for the packet queue.
+ * @pending_node: The list node for the set of pending packets.
+ * @ops:      Packet operations.
+ */
+struct ssh_packet {
+	struct ssh_ptl *ptl;
+	struct kref refcnt;
+
+	u8 priority;
+
+	struct {
+		size_t len;
+		u8 *ptr;
+	} data;
+
+	unsigned long state;
+	ktime_t timestamp;
+
+	struct list_head queue_node;
+	struct list_head pending_node;
+
+	const struct ssh_packet_ops *ops;
+};
+
+struct ssh_packet *ssh_packet_get(struct ssh_packet *p);
+void ssh_packet_put(struct ssh_packet *p);
+
+/**
+ * ssh_packet_set_data() - Set raw message data of packet.
+ * @p:   The packet for which the message data should be set.
+ * @ptr: Pointer to the memory holding the message data.
+ * @len: Length of the message data.
+ *
+ * Sets the raw message data buffer of the packet to the provided memory. The
+ * memory is not copied. Instead, the caller is responsible for management
+ * (i.e. allocation and deallocation) of the memory. The caller must ensure
+ * that the provided memory is valid and contains a valid SSH message,
+ * starting from the time of submission of the packet until the ``release``
+ * callback has been called. During this time, the memory may not be altered
+ * in any way.
+ */
+static inline void ssh_packet_set_data(struct ssh_packet *p, u8 *ptr, size_t len)
+{
+	p->data.ptr = ptr;
+	p->data.len = len;
+}
+
+
+/* -- Request transport layer (rtl). ---------------------------------------- */
+
+enum ssh_request_flags {
+	/* state flags */
+	SSH_REQUEST_SF_LOCKED_BIT,
+	SSH_REQUEST_SF_QUEUED_BIT,
+	SSH_REQUEST_SF_PENDING_BIT,
+	SSH_REQUEST_SF_TRANSMITTING_BIT,
+	SSH_REQUEST_SF_TRANSMITTED_BIT,
+	SSH_REQUEST_SF_RSPRCVD_BIT,
+	SSH_REQUEST_SF_CANCELED_BIT,
+	SSH_REQUEST_SF_COMPLETED_BIT,
+
+	/* type flags */
+	SSH_REQUEST_TY_FLUSH_BIT,
+	SSH_REQUEST_TY_HAS_RESPONSE_BIT,
+
+	/* mask for state flags */
+	SSH_REQUEST_FLAGS_SF_MASK =
+		  BIT(SSH_REQUEST_SF_LOCKED_BIT)
+		| BIT(SSH_REQUEST_SF_QUEUED_BIT)
+		| BIT(SSH_REQUEST_SF_PENDING_BIT)
+		| BIT(SSH_REQUEST_SF_TRANSMITTING_BIT)
+		| BIT(SSH_REQUEST_SF_TRANSMITTED_BIT)
+		| BIT(SSH_REQUEST_SF_RSPRCVD_BIT)
+		| BIT(SSH_REQUEST_SF_CANCELED_BIT)
+		| BIT(SSH_REQUEST_SF_COMPLETED_BIT),
+
+	/* mask for type flags */
+	SSH_REQUEST_FLAGS_TY_MASK =
+		  BIT(SSH_REQUEST_TY_FLUSH_BIT)
+		| BIT(SSH_REQUEST_TY_HAS_RESPONSE_BIT),
+};
+
+struct ssh_rtl;
+struct ssh_request;
+
+/**
+ * struct ssh_request_ops - Callback operations for a SSH request.
+ * @release:  Function called when the request's reference count reaches zero.
+ *            This callback must be relied upon to ensure that the request has
+ *            left the transport systems (both, packet an request systems).
+ * @complete: Function called when the request is completed, either with
+ *            success or failure. The command data for the request response
+ *            is provided via the &struct ssh_command parameter (``cmd``),
+ *            the command payload of the request response via the &struct
+ *            ssh_span parameter (``data``).
+ *
+ *            If the request does not have any response or has not been
+ *            completed with success, both ``cmd`` and ``data`` parameters will
+ *            be NULL. If the request response does not have any command
+ *            payload, the ``data`` span will be an empty (zero-length) span.
+ *
+ *            In case of failure, the reason for the failure is indicated by
+ *            the value of the provided status code argument (``status``). This
+ *            value will be zero in case of success and a regular errno
+ *            otherwise.
+ *
+ *            Note that a call to this callback does not guarantee that the
+ *            request is not in use by the transport systems any more.
+ */
+struct ssh_request_ops {
+	void (*release)(struct ssh_request *rqst);
+	void (*complete)(struct ssh_request *rqst,
+			 const struct ssh_command *cmd,
+			 const struct ssam_span *data, int status);
+};
+
+/**
+ * struct ssh_request - SSH transport request.
+ * @packet: The underlying SSH transport packet.
+ * @node:   List node for the request queue and pending set.
+ * @state:  State and type flags describing current request state (dynamic)
+ *          and type (static). See &enum ssh_request_flags for possible
+ *          options.
+ * @timestamp: Timestamp specifying when we start waiting on the response of
+ *          the request. This is set once the underlying packet has been
+ *          completed and may be %KTIME_MAX before that, or when the request
+ *          does not expect a response. Used for the request timeout
+ *          implementation.
+ * @ops:    Request Operations.
+ */
+struct ssh_request {
+	struct ssh_packet packet;
+	struct list_head node;
+
+	unsigned long state;
+	ktime_t timestamp;
+
+	const struct ssh_request_ops *ops;
+};
+
+/**
+ * to_ssh_request() - Cast a SSH packet to its enclosing SSH request.
+ * @p: The packet to cast.
+ *
+ * Casts the given &struct ssh_packet to its enclosing &struct ssh_request.
+ * The caller is responsible for making sure that the packet is actually
+ * wrapped in a &struct ssh_request.
+ *
+ * Return: Returns the &struct ssh_request wrapping the provided packet.
+ */
+static inline struct ssh_request *to_ssh_request(struct ssh_packet *p)
+{
+	return container_of(p, struct ssh_request, packet);
+}
+
+/**
+ * ssh_request_get() - Increment reference count of request.
+ * @r: The request to increment the reference count of.
+ *
+ * Increments the reference count of the given request by incrementing the
+ * reference count of the underlying &struct ssh_packet, enclosed in it.
+ *
+ * See also ssh_request_put(), ssh_packet_get().
+ *
+ * Return: Returns the request provided as input.
+ */
+static inline struct ssh_request *ssh_request_get(struct ssh_request *r)
+{
+	return r ? to_ssh_request(ssh_packet_get(&r->packet)) : NULL;
+}
+
+/**
+ * ssh_request_put() - Decrement reference count of request.
+ * @r: The request to decrement the reference count of.
+ *
+ * Decrements the reference count of the given request by decrementing the
+ * reference count of the underlying &struct ssh_packet, enclosed in it. If
+ * the reference count reaches zero, the ``release`` callback specified in the
+ * request's &struct ssh_request_ops, i.e. ``r->ops->release``, will be
+ * called.
+ *
+ * See also ssh_request_get(), ssh_packet_put().
+ */
+static inline void ssh_request_put(struct ssh_request *r)
+{
+	if (r)
+		ssh_packet_put(&r->packet);
+}
+
+/**
+ * ssh_request_set_data() - Set raw message data of request.
+ * @r:   The request for which the message data should be set.
+ * @ptr: Pointer to the memory holding the message data.
+ * @len: Length of the message data.
+ *
+ * Sets the raw message data buffer of the underlying packet to the specified
+ * buffer. Does not copy the actual message data, just sets the buffer pointer
+ * and length. Refer to ssh_packet_set_data() for more details.
+ */
+static inline void ssh_request_set_data(struct ssh_request *r, u8 *ptr, size_t len)
+{
+	ssh_packet_set_data(&r->packet, ptr, len);
+}
+
+#endif /* _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H */
--
2.29.2

