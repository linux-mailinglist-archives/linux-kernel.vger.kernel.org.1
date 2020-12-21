Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C862DF99B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLUHxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgLUHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:53:16 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79203C0613D3;
        Sun, 20 Dec 2020 23:52:36 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 81so7998113ioc.13;
        Sun, 20 Dec 2020 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id;
        bh=32DDC0q+uszZ0Ejp9S8Hy8G9jJ+L/tHA6lMXdW+eduo=;
        b=LqVlDOWC8PLdlGTlUWDkzN0bToya11+ZHBm/OIhoGgINAwqW44PynHXf4oYRLYSOMQ
         fqnH7kFI3JWhTiubnL9D3KpY40jo7+/b4ENWGlJg4HDQvWePru/9r4663NUmCeZ1KbXA
         yFfUZ+UkLiDCldnYHJsI9VuSw5qabhruQri4YAKLFhAiC/IrKGj4zKWZSDMM5C+VP5me
         KBrW2ThhqzaBs9uDkrrfJI2liIhgsgkelqFlZ3jbjIwaZ1l5rB3VsSvCPLiJBxCTTpEU
         VPkV/O8dCeXxqEKFYnnOgo27KfRjLL3s4PqgWZ6EQfyZBL08VS69+y9NOg6eekI/n/Z9
         Neqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id;
        bh=32DDC0q+uszZ0Ejp9S8Hy8G9jJ+L/tHA6lMXdW+eduo=;
        b=bX9fdg/MRY/gXi7ouOHHXofqD+X9xmQa2tVsTbPndEryPp1ASI5z8bsiBuUUldd4Ui
         MZZoSmB9HICSLtd6SwE5liVMb/wEEI/Qt+01oE4G132zbOFb7DCvva5y2JIddp8gQw5L
         j7Y3UQDT/FzlIub+MyVz4Q4btFI+BUdqIPNyvZ59eK0I37sNrnSOyiGDyc7EeZT5nsWu
         UVQqx2kDyTK8aEMHGCVLVIO1REOB8Enicg4+oMEmpwpTTnMl6V7LPDncrzLpioK8/lFi
         oxsH46hdTbdK5/oQbfzooqvn5L8HVoOrdLvhhRQ6HLEd4rWo3QlX1JxXSMxhioLXBR1M
         v9tQ==
X-Gm-Message-State: AOAM532spTZvxxi1p3O7c+D2SHmFqs80N34BjSAMWWH/Jpz5crP7Isql
        6dg1TztWAn/dIKhJB2raGMQ=
X-Google-Smtp-Source: ABdhPJxkN0fry11zLBWKVbJ++GCsFX1hFULd/Fz5nuCEDRr2tXYaAJW4IJE1ofGVniTuGNs+y1oVKA==
X-Received: by 2002:a6b:8e92:: with SMTP id q140mr13357104iod.182.1608537155738;
        Sun, 20 Dec 2020 23:52:35 -0800 (PST)
Received: from gmail.com ([62.102.148.68])
        by smtp.gmail.com with ESMTPSA id f3sm12195369ilu.74.2020.12.20.23.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:52:35 -0800 (PST)
Subject: [PATCH] docs: driver-model: bus.rst: Clean up the formatting, expound, modernize
Date:   Mon, 21 Dec 2020 07:52:00 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <3dc7d8abd06941fca5071b0ede9b6088@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* The reStructuredText had some indentation issues.

* The HTML output was not properly formatted in places.

* Some of the details were lacking or needed clarification (especially
  with regard to how a `struct bus_type` object should be defined).

* The sysfs example hierarchy appeared outdated; I've updated it with
  output based on what my own system currently displays.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/driver-api/driver-model/bus.rst | 110 +++++++++++++--------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
index 016b15a6e8ea..68a95389b1eb 100644
--- a/Documentation/driver-api/driver-model/bus.rst
+++ b/Documentation/driver-api/driver-model/bus.rst
@@ -4,34 +4,58 @@ Bus Types
 
 Definition
 ~~~~~~~~~~
-See the kerneldoc for the struct bus_type.
-
-int bus_register(struct bus_type * bus);
+* ``struct bus_type``;
+* ``int bus_register(struct bus_type *bus);``
 
 
 Declaration
 ~~~~~~~~~~~
 
-Each bus type in the kernel (PCI, USB, etc) should declare one static
-object of this type. They must initialize the name field, and may
-optionally initialize the match callback::
+For each bus type (PCI, USB, etc), there should be code that defines
+one object of type ``struct bus_type``:
+
+1. The definition should declare a file-scope identifier that has
+   external linkage.
+
+   * There should be a header that provides a declaration of this
+     identifier.
+
+   * The identifier should be explicitly exported.
+
+2. The definition should initialize the ``name`` member. Other
+   members may also be initialized (such as the ``match`` callback
+   member).
+
+For instance, here is the definition for the PCI bus type::
 
-   struct bus_type pci_bus_type = {
-          .name	= "pci",
-          .match	= pci_bus_match,
-   };
+	struct bus_type pci_bus_type = {
+		.name          = "pci",               // REQUIRED
+		.match         = pci_bus_match,
+		.uevent        = pci_uevent,
+		.probe         = pci_device_probe,
+		.remove        = pci_device_remove,
+		.shutdown      = pci_device_shutdown,
+		.dev_groups    = pci_dev_groups,
+		.bus_groups    = pci_bus_groups,
+		.drv_groups    = pci_drv_groups,
+		.pm            = PCI_PM_OPS_PTR,
+		.num_vf        = pci_bus_num_vf,
+		.dma_configure = pci_dma_configure,
+	};
 
-The structure should be exported to drivers in a header file:
+	EXPORT_SYMBOL(pci_bus_type);
 
-extern struct bus_type pci_bus_type;
+The relevant API header should include the following declaration::
+
+	extern struct bus_type pci_bus_type;
 
 
 Registration
 ~~~~~~~~~~~~
 
-When a bus driver is initialized, it calls bus_register. This
-initializes the rest of the fields in the bus object and inserts it
-into a global list of bus types. Once the bus object is registered,
+During initialization of a bus driver, ``bus_register()`` is called; this
+initializes the rest of the fields in the bus type object and inserts it
+into a global list of bus types. Once the bus type object is registered,
 the fields in it are usable by the bus driver.
 
 
@@ -61,22 +85,25 @@ does not have a driver associated with it.
 Device and Driver Lists
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-The lists of devices and drivers are intended to replace the local
-lists that many buses keep. They are lists of struct devices and
-struct device_drivers, respectively. Bus drivers are free to use the
-lists as they please, but conversion to the bus-specific type may be
-necessary.
+There are generic facilities for keeping lists of devices and drivers:
+
+* There is a list of ``struct device`` objects.
+* There is a list of ``struct device_driver`` objects.
+
+Bus drivers are free to use the lists as they please, but conversion
+to a bus-specific type may be necessary.
 
 The LDM core provides helper functions for iterating over each list::
 
-  int bus_for_each_dev(struct bus_type * bus, struct device * start,
-		       void * data,
-		       int (*fn)(struct device *, void *));
+	int bus_for_each_dev(struct bus_type *bus, struct device *start,
+	                     void *data,
+	                     int (*fn)(struct device *, void *));
 
-  int bus_for_each_drv(struct bus_type * bus, struct device_driver * start,
-		       void * data, int (*fn)(struct device_driver *, void *));
+	int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
+	                     void *data,
+	                     int (*fn)(struct device_driver *, void *));
 
-These helpers iterate over the respective list, and call the callback
+These helpers iterate over the respective list, and call the callback (``fn``)
 for each device or driver in the list. All list accesses are
 synchronized by taking the bus's lock (read currently). The reference
 count on each object in the list is incremented before the callback is
@@ -112,9 +139,9 @@ hierarchy::
 
 	/sys/bus/pci/
 	|-- devices
-	|   |-- 00:00.0 -> ../../../root/pci0/00:00.0
-	|   |-- 00:01.0 -> ../../../root/pci0/00:01.0
-	|   `-- 00:02.0 -> ../../../root/pci0/00:02.0
+	|   |-- 0000:00:00.0 -> ../../../devices/pci0000:00/0000:00:00.0
+	|   |-- 0000:00:02.0 -> ../../../devices/pci0000:00/0000:00:02.0
+	|   `-- 0000:00:14.0 -> ../../../devices/pci0000:00/0000:00:14.0
 	`-- drivers
 
 
@@ -123,23 +150,20 @@ Exporting Attributes
 
 ::
 
-  struct bus_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct bus_type *, char * buf);
-	ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
-  };
-
-Bus drivers can export attributes using the BUS_ATTR_RW macro that works
-similarly to the DEVICE_ATTR_RW macro for devices. For example, a
-definition like this::
-
-	static BUS_ATTR_RW(debug);
+	struct bus_attribute {
+		struct attribute attr;
+		ssize_t (*show)(struct bus_type *, char *buf);
+		ssize_t (*store)(struct bus_type *, const char *buf, size_t count);
+	};
 
-is equivalent to declaring::
+Bus drivers can export attributes using the ``BUS_ATTR_RW()`` macro that works
+similarly to the ``DEVICE_ATTR_RW()`` macro for devices. For example, the
+following are equivalent:
 
-	static bus_attribute bus_attr_debug;
+* ``static BUS_ATTR_RW(debug);``
+* ``static bus_attribute bus_attr_debug;``
 
-This can then be used to add and remove the attribute from the bus's
+This can then be used to add or remove the attribute from the bus's
 sysfs directory using::
 
 	int bus_create_file(struct bus_type *, struct bus_attribute *);
-- 
2.22.0

