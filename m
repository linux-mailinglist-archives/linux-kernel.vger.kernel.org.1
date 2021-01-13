Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25EB2F43FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAMFf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbhAMFf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:35:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E8C061575;
        Tue, 12 Jan 2021 21:35:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r5so540566eda.12;
        Tue, 12 Jan 2021 21:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=+tHov+ldUPE+pcoRYd4a8sxaOI1/2CRBGC1q++RDxYo=;
        b=rGZoYuRdGgVPhd+NMbxrOHemxgcIcLPUTDeuQshz/5qNyKckkiayl9tk8Tu6+aqvbB
         xG5EBQOzs/JzNcSBiCtrhdCJvgts0gtRRnNeMVcjm8pniIKGv7W56pgpsz5PxN9CeUWr
         yJQgd6pAGhH1B4bHvp3RFKOJMdNf2V/pF11aEdMigxUryZlWuVaTPqF9pvtOM7jopUyB
         RpeE6wukH+8WPsmu9f6lsy+/+YtEOnMtka7lh2TD3YkinKOER7zLso+SrjcVm31LepWf
         wDHZvp46cUYoW77kcZGSTAL723ANZeCIqGxyiPGJrKhLvpz/i5IYlCXBC8uI8I6Sheqs
         hJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=+tHov+ldUPE+pcoRYd4a8sxaOI1/2CRBGC1q++RDxYo=;
        b=nnfc+3VbyjK3R3m9PG537VOpaU7ryWKOHVaDv7EVOCg+hRq+7KHRzxMY8O0IQd80BO
         TxSeT5ALJNclrVxuJl36zdsmtK6sE6IQ2ZHLbOap5V83ryN+53fWuK08d4+I71m5IIzm
         hxuiOG3x/mUaaYB0yIPMJu11IrtpPh6AZacYVGfhh/Pzlr+VqSKn4SxG5Gj1e9izZp0L
         bUcl1/pGnPiC40HwnVo34cra1AA+XScQm2kI/TspGyI05gqJxmvldDoCUWhI+uS9Xj+z
         LOIxjPkH1e3VWqScfZ8z435GpKTAx+BoJgp9ph8Xd4FAyoVaRuPYRDlePAKpSXJh0w+D
         GVYQ==
X-Gm-Message-State: AOAM531ePnC3mS36u8gKvZJFCsvPVdWzgJJcL0q1nMHVlXm635o/E5Wn
        6v5TbA0L/CuLKFQbPkQzwqS5+9lX6nPg0Q==
X-Google-Smtp-Source: ABdhPJx3/tEdBAPXaw//jEk6tUZbOX1ReXpYc+2YpcDwmoglPU1J7mMuSh5YhQsoLRJGD0Ir8D9lZg==
X-Received: by 2002:aa7:c0d6:: with SMTP id j22mr415336edp.31.1610516116007;
        Tue, 12 Jan 2021 21:35:16 -0800 (PST)
Received: from gmail.com (tor-exit-relay-5.anonymizing-proxy.digitalcourage.de. [185.220.102.251])
        by smtp.gmail.com with ESMTPSA id u17sm333856edr.0.2021.01.12.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 21:35:15 -0800 (PST)
Subject: [PATCH v2] docs: driver-model: bus.rst: Clean up the formatting, expound, modernize
Date:   Wed, 13 Jan 2021 05:35:00 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <bca1170d131b4b46905f030232da3339@gmail.com>
In-Reply-To: <20210111133158.34923b4c@lwn.net>
References: <3dc7d8abd06941fca5071b0ede9b6088@gmail.com>
  <20210111133158.34923b4c@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your guidance.

  * Save this patch to:

      /path/to/email

    Then apply it with:

      git am --scissors /path/to/email

  * Here are the changes from the last patch:

       Definition
       ~~~~~~~~~~
      -* ``struct bus_type``;
      -* ``int bus_register(struct bus_type *bus);``
      +
      +::
      +
      +	struct bus_type;
      +	int bus_register(struct bus_type *bus);


       Declaration
       ~~~~~~~~~~~

       For each bus type (PCI, USB, etc), there should be code that defines
      -one object of type ``struct bus_type``:
      +one object of type struct bus_type:

       1. The definition should declare a file-scope identifier that has
          external linkage.
      @@ -53,7 +56,7 @@ The relevant API header should include the following declaration::
       Registration
       ~~~~~~~~~~~~

      -During initialization of a bus driver, ``bus_register()`` is called; this
      +During initialization of a bus driver, bus_register() is called; this
       initializes the rest of the fields in the bus type object and inserts it
       into a global list of bus types. Once the bus type object is registered,
       the fields in it are usable by the bus driver.
      @@ -77,8 +80,8 @@ particular device, without sacrificing bus-specific functionality or
       type-safety.

       When a driver is registered with the bus, the bus's list of devices is
      -iterated over, and the match callback is called for each device that
      -does not have a driver associated with it.
      +iterated over, and the ``match`` callback is called for each device that
      +does not already have a driver associated with it.



      @@ -87,8 +90,8 @@ Device and Driver Lists

       There are generic facilities for keeping lists of devices and drivers:

      -* There is a list of ``struct device`` objects.
      -* There is a list of ``struct device_driver`` objects.
      +* There is a list of struct device objects.
      +* There is a list of struct device_driver objects.

       Bus drivers are free to use the lists as they please, but conversion
       to a bus-specific type may be necessary.
      @@ -156,12 +159,21 @@ Exporting Attributes
       		ssize_t (*store)(struct bus_type *, const char *buf, size_t count);
       	};

      -Bus drivers can export attributes using the ``BUS_ATTR_RW()`` macro that works
      -similarly to the ``DEVICE_ATTR_RW()`` macro for devices. For example, the
      +Bus drivers can export attributes using the BUS_ATTR_RW() macro that works
      +similarly to the DEVICE_ATTR_RW() macro for devices. For example, the
       following are equivalent:

      -* ``static BUS_ATTR_RW(debug);``
      -* ``static bus_attribute bus_attr_debug;``
      +* ::
      +
      +	static BUS_ATTR_RW(something);
      +
      +* ::
      +
      +	static struct bus_attribute bus_attr_something = {
      +		.attr  = { .name = "something", .mode = 0644 },
      +		.show  = something_show,   // These functions must be
      +		.store = something_store   // defined or declared already.
      +	};

       This can then be used to add or remove the attribute from the bus's
       sysfs directory using::

Sincerely,
Michael Witten

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

* The reStructuredText had some indentation issues (I only fixed the
  areas I touched).

* The HTML output was not properly formatted in places.

* Some of the details were lacking or needed clarification (especially
  with regard to how a `struct bus_type` object should be defined).

* The sysfs example hierarchy appeared outdated; I've updated it with
  output based on what my own system currently displays.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/driver-api/driver-model/bus.rst | 120 ++++++++++++------
 1 file changed, 78 insertions(+), 42 deletions(-)

diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
index 016b15a6e8ea..9a4cf15df8b9 100644
--- a/Documentation/driver-api/driver-model/bus.rst
+++ b/Documentation/driver-api/driver-model/bus.rst
@@ -4,34 +4,61 @@ Bus Types
 
 Definition
 ~~~~~~~~~~
-See the kerneldoc for the struct bus_type.
 
-int bus_register(struct bus_type * bus);
+::
+
+	struct bus_type;
+	int bus_register(struct bus_type *bus);
 
 
 Declaration
 ~~~~~~~~~~~
 
-Each bus type in the kernel (PCI, USB, etc) should declare one static
-object of this type. They must initialize the name field, and may
-optionally initialize the match callback::
+For each bus type (PCI, USB, etc), there should be code that defines
+one object of type struct bus_type:
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
 
-   struct bus_type pci_bus_type = {
-          .name	= "pci",
-          .match	= pci_bus_match,
-   };
+For instance, here is the definition for the PCI bus type::
 
-The structure should be exported to drivers in a header file:
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
 
-extern struct bus_type pci_bus_type;
+	EXPORT_SYMBOL(pci_bus_type);
+
+The relevant API header should include the following declaration::
+
+	extern struct bus_type pci_bus_type;
 
 
 Registration
 ~~~~~~~~~~~~
 
-When a bus driver is initialized, it calls bus_register. This
-initializes the rest of the fields in the bus object and inserts it
-into a global list of bus types. Once the bus object is registered,
+During initialization of a bus driver, bus_register() is called; this
+initializes the rest of the fields in the bus type object and inserts it
+into a global list of bus types. Once the bus type object is registered,
 the fields in it are usable by the bus driver.
 
 
@@ -53,30 +80,33 @@ particular device, without sacrificing bus-specific functionality or
 type-safety.
 
 When a driver is registered with the bus, the bus's list of devices is
-iterated over, and the match callback is called for each device that
-does not have a driver associated with it.
+iterated over, and the ``match`` callback is called for each device that
+does not already have a driver associated with it.
 
 
 
 Device and Driver Lists
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-The lists of devices and drivers are intended to replace the local
-lists that many buses keep. They are lists of struct devices and
-struct device_drivers, respectively. Bus drivers are free to use the
-lists as they please, but conversion to the bus-specific type may be
-necessary.
+There are generic facilities for keeping lists of devices and drivers:
+
+* There is a list of struct device objects.
+* There is a list of struct device_driver objects.
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
@@ -112,9 +142,9 @@ hierarchy::
 
 	/sys/bus/pci/
 	|-- devices
-	|   |-- 00:00.0 -> ../../../root/pci0/00:00.0
-	|   |-- 00:01.0 -> ../../../root/pci0/00:01.0
-	|   `-- 00:02.0 -> ../../../root/pci0/00:02.0
+	|   |-- 0000:00:00.0 -> ../../../devices/pci0000:00/0000:00:00.0
+	|   |-- 0000:00:02.0 -> ../../../devices/pci0000:00/0000:00:02.0
+	|   `-- 0000:00:14.0 -> ../../../devices/pci0000:00/0000:00:14.0
 	`-- drivers
 
 
@@ -123,23 +153,29 @@ Exporting Attributes
 
 ::
 
-  struct bus_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct bus_type *, char * buf);
-	ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
-  };
+	struct bus_attribute {
+		struct attribute attr;
+		ssize_t (*show)(struct bus_type *, char *buf);
+		ssize_t (*store)(struct bus_type *, const char *buf, size_t count);
+	};
+
+Bus drivers can export attributes using the BUS_ATTR_RW() macro that works
+similarly to the DEVICE_ATTR_RW() macro for devices. For example, the
+following are equivalent:
 
-Bus drivers can export attributes using the BUS_ATTR_RW macro that works
-similarly to the DEVICE_ATTR_RW macro for devices. For example, a
-definition like this::
+* ::
 
-	static BUS_ATTR_RW(debug);
+	static BUS_ATTR_RW(something);
 
-is equivalent to declaring::
+* ::
 
-	static bus_attribute bus_attr_debug;
+	static struct bus_attribute bus_attr_something = {
+		.attr  = { .name = "something", .mode = 0644 },
+		.show  = something_show,   // These functions must be
+		.store = something_store   // defined or declared already.
+	};
 
-This can then be used to add and remove the attribute from the bus's
+This can then be used to add or remove the attribute from the bus's
 sysfs directory using::
 
 	int bus_create_file(struct bus_type *, struct bus_attribute *);
-- 
2.22.0

