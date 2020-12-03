Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925312CE0BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbgLCV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgLCV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:28:24 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2EAC08E85F;
        Thu,  3 Dec 2020 13:27:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cm17so3697265edb.4;
        Thu, 03 Dec 2020 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLCjHjb79tzkUaWpyb4lQsmOT4BnlpZhMtyWUEe7gZQ=;
        b=kRheTLNacHsV35wqTgfxJmhtZhv90vNdMhLqzj9sHYgZ9oy/ofm4OLU8epy68HTVCn
         7hfJY/lrTQonN5bkpNKS+Rps9Frp/rT00ONd8wThJbKJK/WDTdBg6TYwlX1E6yPu6xQ6
         ZglJEchalyDz4N6vtUNhruW/y13LSYsvOzCYDaWhfQiF1NyRyudY8NlWWIxZ5ZdOZW8q
         Fn6UDLbVUNaxVm9SRZkAJmdxWjP88E0mvAQyfZbWmSXRwHmmmIegvs9xxmkDuEvvkrqv
         NHphbNhsc0u7/60tx8jsimkj5jdGEnvYPU683a9W0j9CgZePDw7REj8IVWvPboRLQQbR
         WM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLCjHjb79tzkUaWpyb4lQsmOT4BnlpZhMtyWUEe7gZQ=;
        b=h9p4ooQ+g0sHXhpxOsAUndsCLLeFo/H2Gl7coJTAxl8CGnLtvl3stBOmD18C2ZOh6x
         gbCSyxZfk9QzxjxjHhLSR4BjraRIXfXuwH0NFDTYc+rdvuu1IU6xII5OqEZt47jlXk9/
         OMKPCnioEU0hTOLah00aL3UrAylfqZDzdTrrOiDgTn2kfAeHz7QErOBgaGX7czBUMmgo
         JUUJBU1jxiLRfPPV3ByWTVL7nZdzM36T1FGo6oYuLIEi9jBOD0mYbwuO6ir511ZJ8aWQ
         0yan8hk/JyxBxdXpdVdpB2VpnNLBk9sZAH8Qd0Rh9yG02ggqQLAKZUsoaMuYdJxa/xvQ
         6HSg==
X-Gm-Message-State: AOAM532hX9wHEKyEf4ezQ0AZsm8aldYelSizXZ/shoveb0TPLZJQv+uu
        LFZUYnV4jAx+htjPLHXAglFm02JoZ9Y=
X-Google-Smtp-Source: ABdhPJwOksATAU5o8BOpQekpmYJPN2e5Q6hj9KSfvmeV8zuWXn7Kl2a8GujXHUdLSQvo7dy5drUrMg==
X-Received: by 2002:a50:9d4f:: with SMTP id j15mr4754997edk.69.1607030831062;
        Thu, 03 Dec 2020 13:27:11 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:27:09 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 7/9] docs: driver-api: Add Surface Aggregator subsystem documentation
Date:   Thu,  3 Dec 2020 22:26:38 +0100
Message-Id: <20201203212640.663931-8-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the Surface Aggregator subsystem and its client
drivers, giving an overview of the subsystem, its use-cases, its
internal structure and internal API, as well as its external API for
writing client drivers.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v1 (from RFC):
 - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
 - fix typos

Changes in v2:
 - add architectural overview for core driver internals
 - reorder chapters
 - improve wording

---
 Documentation/driver-api/index.rst            |   1 +
 .../surface_aggregator/client-api.rst         |  38 ++
 .../driver-api/surface_aggregator/client.rst  | 393 ++++++++++++
 .../surface_aggregator/clients/index.rst      |  10 +
 .../driver-api/surface_aggregator/index.rst   |  21 +
 .../surface_aggregator/internal-api.rst       |  67 ++
 .../surface_aggregator/internal.rst           | 577 ++++++++++++++++++
 .../surface_aggregator/overview.rst           |  77 +++
 .../driver-api/surface_aggregator/ssh.rst     | 344 +++++++++++
 MAINTAINERS                                   |   1 +
 10 files changed, 1529 insertions(+)
 create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index f357f3eb400c..699dc7cac0fb 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -97,6 +97,7 @@ available subsections can be seen below.
    rfkill
    serial/index
    sm501
+   surface_aggregator/index
    switchtec
    sync_file
    vfio-mediated-device
diff --git a/Documentation/driver-api/surface_aggregator/client-api.rst b/Documentation/driver-api/surface_aggregator/client-api.rst
new file mode 100644
index 000000000000..8e0b000d0e64
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/client-api.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+===============================
+Client Driver API Documentation
+===============================
+
+.. contents::
+    :depth: 2
+
+
+Serial Hub Communication
+========================
+
+.. kernel-doc:: include/linux/surface_aggregator/serial_hub.h
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_packet_layer.c
+    :export:
+
+
+Controller and Core Interface
+=============================
+
+.. kernel-doc:: include/linux/surface_aggregator/controller.h
+
+.. kernel-doc:: drivers/platform/surface/aggregator/controller.c
+    :export:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/core.c
+    :export:
+
+
+Client Bus and Client Device API
+================================
+
+.. kernel-doc:: include/linux/surface_aggregator/device.h
+
+.. kernel-doc:: drivers/platform/surface/aggregator/bus.c
+    :export:
diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
new file mode 100644
index 000000000000..26d13085a117
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -0,0 +1,393 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. |ssam_controller| replace:: :c:type:`struct ssam_controller <ssam_controller>`
+.. |ssam_device| replace:: :c:type:`struct ssam_device <ssam_device>`
+.. |ssam_device_driver| replace:: :c:type:`struct ssam_device_driver <ssam_device_driver>`
+.. |ssam_client_bind| replace:: :c:func:`ssam_client_bind`
+.. |ssam_client_link| replace:: :c:func:`ssam_client_link`
+.. |ssam_get_controller| replace:: :c:func:`ssam_get_controller`
+.. |ssam_controller_get| replace:: :c:func:`ssam_controller_get`
+.. |ssam_controller_put| replace:: :c:func:`ssam_controller_put`
+.. |ssam_device_alloc| replace:: :c:func:`ssam_device_alloc`
+.. |ssam_device_add| replace:: :c:func:`ssam_device_add`
+.. |ssam_device_remove| replace:: :c:func:`ssam_device_remove`
+.. |ssam_device_driver_register| replace:: :c:func:`ssam_device_driver_register`
+.. |ssam_device_driver_unregister| replace:: :c:func:`ssam_device_driver_unregister`
+.. |module_ssam_device_driver| replace:: :c:func:`module_ssam_device_driver`
+.. |SSAM_DEVICE| replace:: :c:func:`SSAM_DEVICE`
+.. |ssam_notifier_register| replace:: :c:func:`ssam_notifier_register`
+.. |ssam_notifier_unregister| replace:: :c:func:`ssam_notifier_unregister`
+.. |ssam_request_sync| replace:: :c:func:`ssam_request_sync`
+.. |ssam_event_mask| replace:: :c:type:`enum ssam_event_mask <ssam_event_mask>`
+
+
+======================
+Writing Client Drivers
+======================
+
+For the API documentation, refer to:
+
+.. toctree::
+   :maxdepth: 2
+
+   client-api
+
+
+Overview
+========
+
+Client drivers can be set up in two main ways, depending on how the
+corresponding device is made available to the system. We specifically
+differentiate between devices that are presented to the system via one of
+the conventional ways, e.g. as platform devices via ACPI, and devices that
+are non-discoverable and instead need to be explicitly provided by some
+other mechanism, as discussed further below.
+
+
+Non-SSAM Client Drivers
+=======================
+
+All communication with the SAM EC is handled via the |ssam_controller|
+representing that EC to the kernel. Drivers targeting a non-SSAM device (and
+thus not being a |ssam_device_driver|) need to explicitly establish a
+connection/relation to that controller. This can be done via the
+|ssam_client_bind| function. Said function returns a reference to the SSAM
+controller, but, more importantly, also establishes a device link between
+client device and controller (this can also be done separate via
+|ssam_client_link|). It is important to do this, as it, first, guarantees
+that the returned controller is valid for use in the client driver for as
+long as this driver is bound to its device, i.e. that the driver gets
+unbound before the controller ever becomes invalid, and, second, as it
+ensures correct suspend/resume ordering. This setup should be done in the
+driver's probe function, and may be used to defer probing in case the SSAM
+subsystem is not ready yet, for example:
+
+.. code-block:: c
+
+   static int client_driver_probe(struct platform_device *pdev)
+   {
+           struct ssam_controller *ctrl;
+
+           ctrl = ssam_client_bind(&pdev->dev);
+           if (IS_ERR(ctrl))
+                   return PTR_ERR(ctrl) == -ENODEV ? -EPROBE_DEFER : PTR_ERR(ctrl);
+
+           // ...
+
+           return 0;
+   }
+
+The controller may be separately obtained via |ssam_get_controller| and its
+lifetime be guaranteed via |ssam_controller_get| and |ssam_controller_put|.
+Note that none of these functions, however, guarantee that the controller
+will not be shut down or suspended. These functions essentially only operate
+on the reference, i.e. only guarantee a bare minimum of accessibility
+without any guarantees at all on practical operability.
+
+
+Adding SSAM Devices
+===================
+
+If a device does not already exist/is not already provided via conventional
+means, it should be provided as |ssam_device| via the SSAM client device
+hub. New devices can be added to this hub by entering their UID into the
+corresponding registry. SSAM devices can also be manually allocated via
+|ssam_device_alloc|, subsequently to which they have to be added via
+|ssam_device_add| and eventually removed via |ssam_device_remove|. By
+default, the parent of the device is set to the controller device provided
+for allocation, however this may be changed before the device is added. Note
+that, when changing the parent device, care must be taken to ensure that the
+controller lifetime and suspend/resume ordering guarantees, in the default
+setup provided through the parent-child relation, are preserved. If
+necessary, by use of |ssam_client_link| as is done for non-SSAM client
+drivers and described in more detail above.
+
+A client device must always be removed by the party which added the
+respective device before the controller shuts down. Such removal can be
+guaranteed by linking the driver providing the SSAM device to the controller
+via |ssam_client_link|, causing it to unbind before the controller driver
+unbinds. Client devices registered with the controller as parent are
+automatically removed when the controller shuts down, but this should not be
+relied upon, especially as this does not extend to client devices with a
+different parent.
+
+
+SSAM Client Drivers
+===================
+
+SSAM client device drivers are, in essence, no different than other device
+driver types. They are represented via |ssam_device_driver| and bind to a
+|ssam_device| via its UID (:c:type:`struct ssam_device.uid <ssam_device>`)
+member and the match table
+(:c:type:`struct ssam_device_driver.match_table <ssam_device_driver>`),
+which should be set when declaring the driver struct instance. Refer to the
+|SSAM_DEVICE| macro documentation for more details on how to define members
+of the driver's match table.
+
+The UID for SSAM client devices consists of a ``domain``, a ``category``,
+a ``target``, an ``instance``, and a ``function``. The ``domain`` is used
+differentiate between physical SAM devices
+(:c:type:`SSAM_DOMAIN_SERIALHUB <ssam_device_domain>`), i.e. devices that can
+be accessed via the Surface Serial Hub, and virtual ones
+(:c:type:`SSAM_DOMAIN_VIRTUAL <ssam_device_domain>`), such as client-device
+hubs, that have no real representation on the SAM EC and are solely used on
+the kernel/driver-side. For physical devices, ``category`` represents the
+target category, ``target`` the target ID, and ``instance`` the instance ID
+used to access the physical SAM device. In addition, ``function`` references
+a specific device functionality, but has no meaning to the SAM EC. The
+(default) name of a client device is generated based on its UID.
+
+A driver instance can be registered via |ssam_device_driver_register| and
+unregistered via |ssam_device_driver_unregister|. For convenience, the
+|module_ssam_device_driver| macro may be used to define module init- and
+exit-functions registering the driver.
+
+The controller associated with a SSAM client device can be found in its
+:c:type:`struct ssam_device.ctrl <ssam_device>` member. This reference is
+guaranteed to be valid for at least as long as the client driver is bound,
+but should also be valid for as long as the client device exists. Note,
+however, that access outside of the bound client driver must ensure that the
+controller device is not suspended while making any requests or
+(un-)registering event notifiers (and thus should generally be avoided). This
+is guaranteed when the controller is accessed from inside the bound client
+driver.
+
+
+Making Synchronous Requests
+===========================
+
+Synchronous requests are (currently) the main form of host-initiated
+communication with the EC. There are a couple of ways to define and execute
+such requests, however, most of them boil down to something similar as shown
+in the example below. This example defines a write-read request, meaning
+that the caller provides an argument to the SAM EC and receives a response.
+The caller needs to know the (maximum) length of the response payload and
+provide a buffer for it.
+
+Care must be taken to ensure that any command payload data passed to the SAM
+EC is provided in little-endian format and, similarly, any response payload
+data received from it is converted from little-endian to host endianness.
+
+.. code-block:: c
+
+   int perform_request(struct ssam_controller *ctrl, u32 arg, u32 *ret)
+   {
+           struct ssam_request rqst;
+           struct ssam_response resp;
+           int status;
+
+           /* Convert request argument to little-endian. */
+           __le32 arg_le = cpu_to_le32(arg);
+           __le32 ret_le = cpu_to_le32(0);
+
+           /*
+            * Initialize request specification. Replace this with your values.
+            * The rqst.payload field may be NULL if rqst.length is zero,
+            * indicating that the request does not have any argument.
+            *
+            * Note: The request parameters used here are not valid, i.e.
+            *       they do not correspond to an actual SAM/EC request.
+            */
+           rqst.target_category = SSAM_SSH_TC_SAM;
+           rqst.target_id = 0x01;
+           rqst.command_id = 0x02;
+           rqst.instance_id = 0x03;
+           rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
+           rqst.length = sizeof(arg_le);
+           rqst.payload = (u8 *)&arg_le;
+
+           /* Initialize request response. */
+           resp.capacity = sizeof(ret_le);
+           resp.length = 0;
+           resp.pointer = (u8 *)&ret_le;
+
+           /*
+            * Perform actual request. The response pointer may be null in case
+            * the request does not have any response. This must be consistent
+            * with the SSAM_REQUEST_HAS_RESPONSE flag set in the specification
+            * above.
+            */
+           status = ssam_request_sync(ctrl, &rqst, &resp);
+
+           /*
+            * Alternatively use
+            *
+            *   ssam_request_sync_onstack(ctrl, &rqst, &resp, sizeof(arg_le));
+            *
+            * to perform the request, allocating the message buffer directly
+            * on the stack as opposed to allocation via kzalloc().
+            */
+
+           /*
+            * Convert request response back to native format. Note that in the
+            * error case, this value is not touched by the SSAM core, i.e.
+            * 'ret_le' will be zero as specified in its initialization.
+            */
+           *ret = le32_to_cpu(ret_le);
+
+           return status;
+   }
+
+Note that |ssam_request_sync| in its essence is a wrapper over lower-level
+request primitives, which may also be used to perform requests. Refer to its
+implementation and documentation for more details.
+
+An arguably more user-friendly way of defining such functions is by using
+one of the generator macros, for example via:
+
+.. code-block:: c
+
+   SSAM_DEFINE_SYNC_REQUEST_W(__ssam_tmp_perf_mode_set, __le32, {
+           .target_category = SSAM_SSH_TC_TMP,
+           .target_id       = 0x01,
+           .command_id      = 0x03,
+           .instance_id     = 0x00,
+   });
+
+This example defines a function
+
+.. code-block:: c
+
+   int __ssam_tmp_perf_mode_set(struct ssam_controller *ctrl, const __le32 *arg);
+
+executing the specified request, with the controller passed in when calling
+said function. In this example, the argument is provided via the ``arg``
+pointer. Note that the generated function allocates the message buffer on
+the stack. Thus, if the argument provided via the request is large, these
+kinds of macros should be avoided. Also note that, in contrast to the
+previous non-macro example, this function does not do any endianness
+conversion, which has to be handled by the caller. Apart from those
+differences the function generated by the macro is similar to the one
+provided in the non-macro example above.
+
+The full list of such function-generating macros is
+
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_N` for requests without return value and
+  without argument.
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_R` for requests with return value but no
+  argument.
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_W` for requests without return value but
+  with argument.
+
+Refer to their respective documentation for more details. For each one of
+these macros, a special variant is provided, which targets request types
+applicable to multiple instances of the same device type:
+
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_MD_N`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_MD_R`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_MD_W`
+
+The difference of those macros to the previously mentioned versions is, that
+the device target and instance IDs are not fixed for the generated function,
+but instead have to be provided by the caller of said function.
+
+Additionally, variants for direct use with client devices, i.e.
+|ssam_device|, are also provided. These can, for example, be used as
+follows:
+
+.. code-block:: c
+
+   SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_sta, __le32, {
+           .target_category = SSAM_SSH_TC_BAT,
+           .command_id      = 0x01,
+   });
+
+This invocation of the macro defines a function
+
+.. code-block:: c
+
+   int ssam_bat_get_sta(struct ssam_device *sdev, __le32 *ret);
+
+executing the specified request, using the device IDs and controller given
+in the client device. The full list of such macros for client devices is:
+
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_CL_N`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_CL_R`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_CL_W`
+
+
+Handling Events
+===============
+
+To receive events from the SAM EC, an event notifier must be registered for
+the desired event via |ssam_notifier_register|. The notifier must be
+unregistered via |ssam_notifier_unregister| once it is not required any
+more.
+
+Event notifiers are registered by providing (at minimum) a callback to call
+in case an event has been received, the registry specifying how the event
+should be enabled, an event ID specifying for which target category and,
+optionally and depending on the registry used, for which instance ID events
+should be enabled, and finally, flags describing how the EC will send these
+events. If the specific registry does not enable events by instance ID, the
+instance ID must be set to zero. Additionally, a priority for the respective
+notifier may be specified, which determines its order in relation to any
+other notifier registered for the same target category.
+
+By default, event notifiers will receive all events for the specific target
+category, regardless of the instance ID specified when registering the
+notifier. The core may be instructed to only call a notifier if the target
+ID or instance ID (or both) of the event match the ones implied by the
+notifier IDs (in case of target ID, the target ID of the registry), by
+providing an event mask (see |ssam_event_mask|).
+
+In general, the target ID of the registry is also the target ID of the
+enabled event (with the notable exception being keyboard input events on the
+Surface Laptop 1 and 2, which are enabled via a registry with target ID 1,
+but provide events with target ID 2).
+
+A full example for registering an event notifier and handling received
+events is provided below:
+
+.. code-block:: c
+
+   u32 notifier_callback(struct ssam_event_notifier *nf,
+                         const struct ssam_event *event)
+   {
+           int status = ...
+
+           /* Handle the event here ... */
+
+           /* Convert return value and indicate that we handled the event. */
+           return ssam_notifier_from_errno(status) | SSAM_NOTIF_HANDLED;
+   }
+
+   int setup_notifier(struct ssam_device *sdev,
+                      struct ssam_event_notifier *nf)
+   {
+           /* Set priority wrt. other handlers of same target category. */
+           nf->base.priority = 1;
+
+           /* Set event/notifier callback. */
+           nf->base.fn = notifier_callback;
+
+           /* Specify event registry, i.e. how events get enabled/disabled. */
+           nf->event.reg = SSAM_EVENT_REGISTRY_KIP;
+
+           /* Specify which event to enable/disable */
+           nf->event.id.target_category = sdev->uid.category;
+           nf->event.id.instance = sdev->uid.instance;
+
+           /*
+            * Specify for which events the notifier callback gets executed.
+            * This essentially tells the core if it can skip notifiers that
+            * don't have target or instance IDs matching those of the event.
+            */
+           nf->event.mask = SSAM_EVENT_MASK_STRICT;
+
+           /* Specify event flags. */
+           nf->event.flags = SSAM_EVENT_SEQUENCED;
+
+           return ssam_notifier_register(sdev->ctrl, nf);
+   }
+
+Multiple event notifiers can be registered for the same event. The event
+handler core takes care of enabling and disabling events when notifiers are
+registered and unregistered, by keeping track of how many notifiers for a
+specific event (combination of registry, event target category, and event
+instance ID) are currently registered. This means that a specific event will
+be enabled when the first notifier for it is being registered and disabled
+when the last notifier for it is being unregistered. Note that the event
+flags are therefore only used on the first registered notifier, however, one
+should take care that notifiers for a specific event are always registered
+with the same flag and it is considered a bug to do otherwise.
diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
new file mode 100644
index 000000000000..31e026d96102
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+===========================
+Client Driver Documentation
+===========================
+
+This is the documentation for client drivers themselves. Refer to
+:doc:`../client` for documentation on how to write client drivers.
+
+.. Place documentation for individual client drivers here.
diff --git a/Documentation/driver-api/surface_aggregator/index.rst b/Documentation/driver-api/surface_aggregator/index.rst
new file mode 100644
index 000000000000..6f3e1094904d
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=======================================
+Surface System Aggregator Module (SSAM)
+=======================================
+
+.. toctree::
+   :maxdepth: 2
+
+   overview
+   client
+   clients/index
+   ssh
+   internal
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/surface_aggregator/internal-api.rst b/Documentation/driver-api/surface_aggregator/internal-api.rst
new file mode 100644
index 000000000000..639a67b5a392
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/internal-api.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==========================
+Internal API Documentation
+==========================
+
+.. contents::
+    :depth: 2
+
+
+Packet Transport Layer
+======================
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_parser.h
+    :internal:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_parser.c
+    :internal:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_msgb.h
+    :internal:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_packet_layer.h
+    :internal:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_packet_layer.c
+    :internal:
+
+
+Request Transport Layer
+=======================
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_request_layer.h
+    :internal:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/ssh_request_layer.c
+    :internal:
+
+
+Controller
+==========
+
+.. kernel-doc:: drivers/platform/surface/aggregator/controller.h
+    :internal:
+
+.. kernel-doc:: drivers/platform/surface/aggregator/controller.c
+    :internal:
+
+
+Client Device Bus
+=================
+
+.. kernel-doc:: drivers/platform/surface/aggregator/bus.c
+    :internal:
+
+
+Core
+====
+
+.. kernel-doc:: drivers/platform/surface/aggregator/core.c
+    :internal:
+
+
+Trace Helpers
+=============
+
+.. kernel-doc:: drivers/platform/surface/aggregator/trace.h
diff --git a/Documentation/driver-api/surface_aggregator/internal.rst b/Documentation/driver-api/surface_aggregator/internal.rst
new file mode 100644
index 000000000000..72704734982a
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/internal.rst
@@ -0,0 +1,577 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. |ssh_ptl| replace:: :c:type:`struct ssh_ptl <ssh_ptl>`
+.. |ssh_ptl_submit| replace:: :c:func:`ssh_ptl_submit`
+.. |ssh_ptl_cancel| replace:: :c:func:`ssh_ptl_cancel`
+.. |ssh_ptl_shutdown| replace:: :c:func:`ssh_ptl_shutdown`
+.. |ssh_ptl_rx_rcvbuf| replace:: :c:func:`ssh_ptl_rx_rcvbuf`
+.. |ssh_rtl| replace:: :c:type:`struct ssh_rtl <ssh_rtl>`
+.. |ssh_rtl_submit| replace:: :c:func:`ssh_rtl_submit`
+.. |ssh_rtl_cancel| replace:: :c:func:`ssh_rtl_cancel`
+.. |ssh_rtl_shutdown| replace:: :c:func:`ssh_rtl_shutdown`
+.. |ssh_packet| replace:: :c:type:`struct ssh_packet <ssh_packet>`
+.. |ssh_packet_get| replace:: :c:func:`ssh_packet_get`
+.. |ssh_packet_put| replace:: :c:func:`ssh_packet_put`
+.. |ssh_packet_ops| replace:: :c:type:`struct ssh_packet_ops <ssh_packet_ops>`
+.. |ssh_packet_base_priority| replace:: :c:type:`enum ssh_packet_base_priority <ssh_packet_base_priority>`
+.. |ssh_packet_flags| replace:: :c:type:`enum ssh_packet_flags <ssh_packet_flags>`
+.. |SSH_PACKET_PRIORITY| replace:: :c:func:`SSH_PACKET_PRIORITY`
+.. |ssh_frame| replace:: :c:type:`struct ssh_frame <ssh_frame>`
+.. |ssh_command| replace:: :c:type:`struct ssh_command <ssh_command>`
+.. |ssh_request| replace:: :c:type:`struct ssh_request <ssh_request>`
+.. |ssh_request_get| replace:: :c:func:`ssh_request_get`
+.. |ssh_request_put| replace:: :c:func:`ssh_request_put`
+.. |ssh_request_ops| replace:: :c:type:`struct ssh_request_ops <ssh_request_ops>`
+.. |ssh_request_init| replace:: :c:func:`ssh_request_init`
+.. |ssh_request_flags| replace:: :c:type:`enum ssh_request_flags <ssh_request_flags>`
+.. |ssam_controller| replace:: :c:type:`struct ssam_controller <ssam_controller>`
+.. |ssam_device| replace:: :c:type:`struct ssam_device <ssam_device>`
+.. |ssam_device_driver| replace:: :c:type:`struct ssam_device_driver <ssam_device_driver>`
+.. |ssam_client_bind| replace:: :c:func:`ssam_client_bind`
+.. |ssam_client_link| replace:: :c:func:`ssam_client_link`
+.. |ssam_request_sync| replace:: :c:type:`struct ssam_request_sync <ssam_request_sync>`
+.. |ssam_event_registry| replace:: :c:type:`struct ssam_event_registry <ssam_event_registry>`
+.. |ssam_event_id| replace:: :c:type:`struct ssam_event_id <ssam_event_id>`
+.. |ssam_nf| replace:: :c:type:`struct ssam_nf <ssam_nf>`
+.. |ssam_nf_refcount_inc| replace:: :c:func:`ssam_nf_refcount_inc`
+.. |ssam_nf_refcount_dec| replace:: :c:func:`ssam_nf_refcount_dec`
+.. |ssam_notifier_register| replace:: :c:func:`ssam_notifier_register`
+.. |ssam_notifier_unregister| replace:: :c:func:`ssam_notifier_unregister`
+.. |ssam_cplt| replace:: :c:type:`struct ssam_cplt <ssam_cplt>`
+.. |ssam_event_queue| replace:: :c:type:`struct ssam_event_queue <ssam_event_queue>`
+.. |ssam_request_sync_submit| replace:: :c:func:`ssam_request_sync_submit`
+
+=====================
+Core Driver Internals
+=====================
+
+Architectural overview of the Surface System Aggregator Module (SSAM) core
+and Surface Serial Hub (SSH) driver. For the API documentation, refer to:
+
+.. toctree::
+   :maxdepth: 2
+
+   internal-api
+
+
+Overview
+========
+
+The SSAM core implementation is structured in layers, somewhat following the
+SSH protocol structure:
+
+Lower-level packet transport is implemented in the *packet transport layer
+(PTL)*, directly building on top of the serial device (serdev)
+infrastructure of the kernel. As the name indicates, this layer deals with
+the packet transport logic and handles things like packet validation, packet
+acknowledgment (ACKing), packet (retransmission) timeouts, and relaying
+packet payloads to higher-level layers.
+
+Above this sits the *request transport layer (RTL)*. This layer is centered
+around command-type packet payloads, i.e. requests (sent from host to EC),
+responses of the EC to those requests, and events (sent from EC to host).
+It, specifically, distinguishes events from request responses, matches
+responses to their corresponding requests, and implements request timeouts.
+
+The *controller* layer is building on top of this and essentially decides
+how request responses and, especially, events are dealt with. It provides an
+event notifier system, handles event activation/deactivation, provides a
+workqueue for event and asynchronous request completion, and also manages
+the message counters required for building command messages (``SEQ``,
+``RQID``). This layer basically provides a fundamental interface to the SAM
+EC for use in other kernel drivers.
+
+While the controller layer already provides an interface for other kernel
+drivers, the client *bus* extends this interface to provide support for
+native SSAM devices, i.e. devices that are not defined in ACPI and not
+implemented as platform devices, via |ssam_device| and |ssam_device_driver|
+simplify management of client devices and client drivers.
+
+Refer to :doc:`client` for documentation regarding the client device/driver
+API and interface options for other kernel drivers. It is recommended to
+familiarize oneself with that chapter and the :doc:`ssh` before continuing
+with the architectural overview below.
+
+
+Packet Transport Layer
+======================
+
+The packet transport layer is represented via |ssh_ptl| and is structured
+around the following key concepts:
+
+Packets
+-------
+
+Packets are the fundamental transmission unit of the SSH protocol. They are
+managed by the packet transport layer, which is essentially the lowest layer
+of the driver and is built upon by other components of the SSAM core.
+Packets to be transmitted by the SSAM core are represented via |ssh_packet|
+(in contrast, packets received by the core do not have any specific
+structure and are managed entirely via the raw |ssh_frame|).
+
+This structure contains the required fields to manage the packet inside the
+transport layer, as well as a reference to the buffer containing the data to
+be transmitted (i.e. the message wrapped in |ssh_frame|). Most notably, it
+contains an internal reference count, which is used for managing its
+lifetime (accessible via |ssh_packet_get| and |ssh_packet_put|). When this
+counter reaches zero, the ``release()`` callback provided to the packet via
+its |ssh_packet_ops| reference is executed, which may then deallocate the
+packet or its enclosing structure (e.g. |ssh_request|).
+
+In addition to the ``release`` callback, the |ssh_packet_ops| reference also
+provides a ``complete()`` callback, which is run once the packet has been
+completed and provides the status of this completion, i.e. zero on success
+or a negative errno value in case of an error. Once the packet has been
+submitted to the packet transport layer, the ``complete()`` callback is
+always guaranteed to be executed before the ``release()`` callback, i.e. the
+packet will always be completed, either successfully, with an error, or due
+to cancellation, before it will be released.
+
+The state of a packet is managed via its ``state`` flags
+(|ssh_packet_flags|), which also contains the packet type. In particular,
+the following bits are noteworthy:
+
+* ``SSH_PACKET_SF_LOCKED_BIT``: This bit is set when completion, either
+  through error or success, is imminent. It indicates that no further
+  references of the packet should be taken and any existing references
+  should be dropped as soon as possible. The process setting this bit is
+  responsible for removing any references to this packet from the packet
+  queue and pending set.
+
+* ``SSH_PACKET_SF_COMPLETED_BIT``: This bit is set by the process running the
+  ``complete()`` callback and is used to ensure that this callback only runs
+  once.
+
+* ``SSH_PACKET_SF_QUEUED_BIT``: This bit is set when the packet is queued on
+  the packet queue and cleared when it is dequeued.
+
+* ``SSH_PACKET_SF_PENDING_BIT``: This bit is set when the packet is added to
+  the pending set and cleared when it is removed from it.
+
+Packet Queue
+------------
+
+The packet queue is the first of the two fundamental collections in the
+packet transport layer. It is a priority queue, with priority of the
+respective packets based on the packet type (major) and number of tries
+(minor). See |SSH_PACKET_PRIORITY| for more details on the priority value.
+
+All packets to be transmitted by the transport layer must be submitted to
+this queue via |ssh_ptl_submit|. Note that this includes control packets
+sent by the transport layer itself. Internally, data packets can be
+re-submitted to this queue due to timeouts or NAK packets sent by the EC.
+
+Pending Set
+-----------
+
+The pending set is the second of the two fundamental collections in the
+packet transport layer. It stores references to packets that have already
+been transmitted, but wait for acknowledgment (e.g. the corresponding ACK
+packet) by the EC.
+
+Note that a packet may both be pending and queued if it has been
+re-submitted due to a packet acknowledgment timeout or NAK. On such a
+re-submission, packets are not removed from the pending set.
+
+Transmitter Thread
+------------------
+
+The transmitter thread is responsible for most of the actual work regarding
+packet transmission. In each iteration, it (waits for and) checks if the
+next packet on the queue (if any) can be transmitted and, if so, removes it
+from the queue and increments its counter for the number of transmission
+attempts, i.e. tries. If the packet is sequenced, i.e. requires an ACK by
+the EC, the packet is added to the pending set. Next, the packet's data is
+submitted to the serdev subsystem. In case of an error or timeout during
+this submission, the packet is completed by the transmitter thread with the
+status value of the callback set accordingly. In case the packet is
+unsequenced, i.e. does not require an ACK by the EC, the packet is completed
+with success on the transmitter thread.
+
+Transmission of sequenced packets is limited by the number of concurrently
+pending packets, i.e. a limit on how many packets may be waiting for an ACK
+from the EC in parallel. This limit is currently set to one (see :doc:`ssh`
+for the reasoning behind this). Control packets (i.e. ACK and NAK) can
+always be transmitted.
+
+Receiver Thread
+---------------
+
+Any data received from the EC is put into a FIFO buffer for further
+processing. This processing happens on the receiver thread. The receiver
+thread parses and validates the received message into its |ssh_frame| and
+corresponding payload. It prepares and submits the necessary ACK (and on
+validation error or invalid data NAK) packets for the received messages.
+
+This thread also handles further processing, such as matching ACK messages
+to the corresponding pending packet (via sequence ID) and completing it, as
+well as initiating re-submission of all currently pending packets on
+receival of a NAK message (re-submission in case of a NAK is similar to
+re-submission due to timeout, see below for more details on that). Note that
+the successful completion of a sequenced packet will always run on the
+receiver thread (whereas any failure-indicating completion will run on the
+process where the failure occurred).
+
+Any payload data is forwarded via a callback to the next upper layer, i.e.
+the request transport layer.
+
+Timeout Reaper
+--------------
+
+The packet acknowledgment timeout is a per-packet timeout for sequenced
+packets, started when the respective packet begins (re-)transmission (i.e.
+this timeout is armed once per transmission attempt on the transmitter
+thread). It is used to trigger re-submission or, when the number of tries
+has been exceeded, cancellation of the packet in question.
+
+This timeout is handled via a dedicated reaper task, which is essentially a
+work item (re-)scheduled to run when the next packet is set to time out. The
+work item then checks the set of pending packets for any packets that have
+exceeded the timeout and, if there are any remaining packets, re-schedules
+itself to the next appropriate point in time.
+
+If a timeout has been detected by the reaper, the packet will either be
+re-submitted if it still has some remaining tries left, or completed with
+``-ETIMEDOUT`` as status if not. Note that re-submission, in this case and
+triggered by receival of a NAK, means that the packet is added to the queue
+with a now incremented number of tries, yielding a higher priority. The
+timeout for the packet will be disabled until the next transmission attempt
+and the packet remains on the pending set.
+
+Note that due to transmission and packet acknowledgment timeouts, the packet
+transport layer is always guaranteed to make progress, if only through
+timing out packets, and will never fully block.
+
+Concurrency and Locking
+-----------------------
+
+There are two main locks in the packet transport layer: One guarding access
+to the packet queue and one guarding access to the pending set. These
+collections may only be accessed and modified under the respective lock. If
+access to both collections is needed, the pending lock must be acquired
+before the queue lock to avoid deadlocks.
+
+In addition to guarding the collections, after initial packet submission
+certain packet fields may only be accessed under one of the locks.
+Specifically, the packet priority must only be accessed while holding the
+queue lock and the packet timestamp must only be accessed while holding the
+pending lock.
+
+Other parts of the packet transport layer are guarded independently. State
+flags are managed by atomic bit operations and, if necessary, memory
+barriers. Modifications to the timeout reaper work item and expiration date
+are guarded by their own lock.
+
+The reference of the packet to the packet transport layer (``ptl``) is
+somewhat special. It is either set when the upper layer request is submitted
+or, if there is none, when the packet is first submitted. After it is set,
+it will not change its value. Functions that may run concurrently with
+submission, i.e. cancellation, can not rely on the ``ptl`` reference to be
+set. Access to it in these functions is guarded by ``READ_ONCE()``, whereas
+setting ``ptl`` is equally guarded with ``WRITE_ONCE()`` for symmetry.
+
+Some packet fields may be read outside of the respective locks guarding
+them, specifically priority and state for tracing. In those cases, proper
+access is ensured by employing ``WRITE_ONCE()`` and ``READ_ONCE()``. Such
+read-only access is only allowed when stale values are not critical.
+
+With respect to the interface for higher layers, packet submission
+(|ssh_ptl_submit|), packet cancellation (|ssh_ptl_cancel|), data receival
+(|ssh_ptl_rx_rcvbuf|), and layer shutdown (|ssh_ptl_shutdown|) may always be
+executed concurrently with respect to each other. Note that packet
+submission may not run concurrently with itself for the same packet.
+Equally, shutdown and data receival may also not run concurrently with
+themselves (but may run concurrently with each other).
+
+
+Request Transport Layer
+=======================
+
+The request transport layer is represented via |ssh_rtl| and builds on top
+of the packet transport layer. It deals with requests, i.e. SSH packets sent
+by the host containing a |ssh_command| as frame payload. This layer
+separates responses to requests from events, which are also sent by the EC
+via a |ssh_command| payload. While responses are handled in this layer,
+events are relayed to the next upper layer, i.e. the controller layer, via
+the corresponding callback. The request transport layer is structured around
+the following key concepts:
+
+Request
+-------
+
+Requests are packets with a command-type payload, sent from host to EC to
+query data from or trigger an action on it (or both simultaneously). They
+are represented by |ssh_request|, wrapping the underlying |ssh_packet|
+storing its message data (i.e. SSH frame with command payload). Note that
+all top-level representations, e.g. |ssam_request_sync| are built upon this
+struct.
+
+As |ssh_request| extends |ssh_packet|, its lifetime is also managed by the
+reference counter inside the packet struct (which can be accessed via
+|ssh_request_get| and |ssh_request_put|). Once the counter reaches zero, the
+``release()`` callback of the |ssh_request_ops| reference of the request is
+called.
+
+Requests can have an optional response that is equally sent via a SSH
+message with command-type payload (from EC to host). The party constructing
+the request must know if a response is expected and mark this in the request
+flags provided to |ssh_request_init|, so that the request transport layer
+can wait for this response.
+
+Similar to |ssh_packet|, |ssh_request| also has a ``complete()`` callback
+provided via its request ops reference and is guaranteed to be completed
+before it is released once it has been submitted to the request transport
+layer via |ssh_rtl_submit|. For a request without a response, successful
+completion will occur once the underlying packet has been successfully
+transmitted by the packet transport layer (i.e. from within the packet
+completion callback). For a request with response, successful completion
+will occur once the response has been received and matched to the request
+via its request ID (which happens on the packet layer's data-received
+callback running on the receiver thread). If the request is completed with
+an error, the status value will be set to the corresponding (negative) errno
+value.
+
+The state of a request is again managed via its ``state`` flags
+(|ssh_request_flags|), which also encode the request type. In particular,
+the following bits are noteworthy:
+
+* ``SSH_REQUEST_SF_LOCKED_BIT``: This bit is set when completion, either
+  through error or success, is imminent. It indicates that no further
+  references of the request should be taken and any existing references
+  should be dropped as soon as possible. The process setting this bit is
+  responsible for removing any references to this request from the request
+  queue and pending set.
+
+* ``SSH_REQUEST_SF_COMPLETED_BIT``: This bit is set by the process running the
+  ``complete()`` callback and is used to ensure that this callback only runs
+  once.
+
+* ``SSH_REQUEST_SF_QUEUED_BIT``: This bit is set when the request is queued on
+  the request queue and cleared when it is dequeued.
+
+* ``SSH_REQUEST_SF_PENDING_BIT``: This bit is set when the request is added to
+  the pending set and cleared when it is removed from it.
+
+Request Queue
+-------------
+
+The request queue is the first of the two fundamental collections in the
+request transport layer. In contrast to the packet queue of the packet
+transport layer, it is not a priority queue and the simple first come first
+serve principle applies.
+
+All requests to be transmitted by the request transport layer must be
+submitted to this queue via |ssh_rtl_submit|. Once submitted, requests may
+not be re-submitted, and will not be re-submitted automatically on timeout.
+Instead, the request is completed with a timeout error. If desired, the
+caller can create and submit a new request for another try, but it must not
+submit the same request again.
+
+Pending Set
+-----------
+
+The pending set is the second of the two fundamental collections in the
+request transport layer. This collection stores references to all pending
+requests, i.e. requests awaiting a response from the EC (similar to what the
+pending set of the packet transport layer does for packets).
+
+Transmitter Task
+----------------
+
+The transmitter task is scheduled when a new request is available for
+transmission. It checks if the next request on the request queue can be
+transmitted and, if so, submits its underlying packet to the packet
+transport layer. This check ensures that only a limited number of
+requests can be pending, i.e. waiting for a response, at the same time. If
+the request requires a response, the request is added to the pending set
+before its packet is submitted.
+
+Packet Completion Callback
+--------------------------
+
+The packet completion callback is executed once the underlying packet of a
+request has been completed. In case of an error completion, the
+corresponding request is completed with the error value provided in this
+callback.
+
+On successful packet completion, further processing depends on the request.
+If the request expects a response, it is marked as transmitted and the
+request timeout is started. If the request does not expect a response, it is
+completed with success.
+
+Data-Received Callback
+----------------------
+
+The data received callback notifies the request transport layer of data
+being received by the underlying packet transport layer via a data-type
+frame. In general, this is expected to be a command-type payload.
+
+If the request ID of the command is one of the request IDs reserved for
+events (one to ``SSH_NUM_EVENTS``, inclusively), it is forwarded to the
+event callback registered in the request transport layer. If the request ID
+indicates a response to a request, the respective request is looked up in
+the pending set and, if found and marked as transmitted, completed with
+success.
+
+Timeout Reaper
+--------------
+
+The request-response-timeout is a per-request timeout for requests expecting
+a response. It is used to ensure that a request does not wait indefinitely
+on a response from the EC and is started after the underlying packet has
+been successfully completed.
+
+This timeout is, similar to the packet acknowledgment timeout on the packet
+transport layer, handled via a dedicated reaper task. This task is
+essentially a work-item (re-)scheduled to run when the next request is set
+to time out. The work item then scans the set of pending requests for any
+requests that have timed out and completes them with ``-ETIMEDOUT`` as
+status. Requests will not be re-submitted automatically. Instead, the issuer
+of the request must construct and submit a new request, if so desired.
+
+Note that this timeout, in combination with packet transmission and
+acknowledgment timeouts, guarantees that the request layer will always make
+progress, even if only through timing out packets, and never fully block.
+
+Concurrency and Locking
+-----------------------
+
+Similar to the packet transport layer, there are two main locks in the
+request transport layer: One guarding access to the request queue and one
+guarding access to the pending set. These collections may only be accessed
+and modified under the respective lock.
+
+Other parts of the request transport layer are guarded independently. State
+flags are (again) managed by atomic bit operations and, if necessary, memory
+barriers. Modifications to the timeout reaper work item and expiration date
+are guarded by their own lock.
+
+Some request fields may be read outside of the respective locks guarding
+them, specifically the state for tracing. In those cases, proper access is
+ensured by employing ``WRITE_ONCE()`` and ``READ_ONCE()``. Such read-only
+access is only allowed when stale values are not critical.
+
+With respect to the interface for higher layers, request submission
+(|ssh_rtl_submit|), request cancellation (|ssh_rtl_cancel|), and layer
+shutdown (|ssh_rtl_shutdown|) may always be executed concurrently with
+respect to each other. Note that request submission may not run concurrently
+with itself for the same request (and also may only be called once per
+request). Equally, shutdown may also not run concurrently with itself.
+
+
+Controller Layer
+================
+
+The controller layer extends on the request transport layer to provide an
+easy-to-use interface for client drivers. It is represented by
+|ssam_controller| and the SSH driver. While the lower level transport layers
+take care of transmitting and handling packets and requests, the controller
+layer takes on more of a management role. Specifically, it handles device
+initialization, power management, and event handling, including event
+delivery and registration via the (event) completion system (|ssam_cplt|).
+
+Event Registration
+------------------
+
+In general, an event (or rather a class of events) has to be explicitly
+requested by the host before the EC will send it (HID input events seem to
+be the exception). This is done via an event-enable request (similarly,
+events should be disabled via an event-disable request once no longer
+desired).
+
+The specific request used to enable (or disable) an event is given via an
+event registry, i.e. the governing authority of this event (so to speak),
+represented by |ssam_event_registry|. As parameters to this request, the
+target category and, depending on the event registry, instance ID of the
+event to be enabled must be provided. This (optional) instance ID must be
+zero if the registry does not use it. Together, target category and instance
+ID form the event ID, represented by |ssam_event_id|. In short, both, event
+registry and event ID, are required to uniquely identify a respective class
+of events.
+
+Note that a further *request ID* parameter must be provided for the
+enable-event request. This parameter does not influence the class of events
+being enabled, but instead is set as the request ID (RQID) on each event of
+this class sent by the EC. It is used to identify events (as a limited
+number of request IDs is reserved for use in events only, specifically one
+to ``SSH_NUM_EVENTS`` inclusively) and also map events to their specific
+class. Currently, the controller always sets this parameter to the target
+category specified in |ssam_event_id|.
+
+As multiple client drivers may rely on the same (or overlapping) classes of
+events and enable/disable calls are strictly binary (i.e. on/off), the
+controller has to manage access to these events. It does so via reference
+counting, storing the counter inside an RB-tree based mapping with event
+registry and ID as key (there is no known list of valid event registry and
+event ID combinations). See |ssam_nf|, |ssam_nf_refcount_inc|, and
+|ssam_nf_refcount_dec| for details.
+
+This management is done together with notifier registration (described in
+the next section) via the top-level |ssam_notifier_register| and
+|ssam_notifier_unregister| functions.
+
+Event Delivery
+--------------
+
+To receive events, a client driver has to register an event notifier via
+|ssam_notifier_register|. This increments the reference counter for that
+specific class of events (as detailed in the previous section), enables the
+class on the EC (if it has not been enabled already), and installs the
+provided notifier callback.
+
+Notifier callbacks are stored in lists, with one (RCU) list per target
+category (provided via the event ID; NB: there is a fixed known number of
+target categories). There is no known association from the combination of
+event registry and event ID to the command data (target ID, target category,
+command ID, and instance ID) that can be provided by an event class, apart
+from target category and instance ID given via the event ID.
+
+Note that due to the way notifiers are (or rather have to be) stored, client
+drivers may receive events that they have not requested and need to account
+for them. Specifically, they will, by default, receive all events from the
+same target category. To simplify dealing with this, filtering of events by
+target ID (provided via the event registry) and instance ID (provided via
+the event ID) can be requested when registering a notifier. This filtering
+is applied when iterating over the notifiers at the time they are executed.
+
+All notifier callbacks are executed on a dedicated workqueue, the so-called
+completion workqueue. After an event has been received via the callback
+installed in the request layer (running on the receiver thread of the packet
+transport layer), it will be put on its respective event queue
+(|ssam_event_queue|). From this event queue the completion work item of that
+queue (running on the completion workqueue) will pick up the event and
+execute the notifier callback. This is done to avoid blocking on the
+receiver thread.
+
+There is one event queue per combination of target ID and target category.
+This is done to ensure that notifier callbacks are executed in sequence for
+events of the same target ID and target category. Callbacks can be executed
+in parallel for events with a different combination of target ID and target
+category.
+
+Concurrency and Locking
+-----------------------
+
+Most of the concurrency related safety guarantees of the controller are
+provided by the lower-level request transport layer. In addition to this,
+event (un-)registration is guarded by its own lock.
+
+Access to the controller state is guarded by the state lock. This lock is a
+read/write semaphore. The reader part can be used to ensure that the state
+does not change while functions depending on the state to stay the same
+(e.g. |ssam_notifier_register|, |ssam_notifier_unregister|,
+|ssam_request_sync_submit|, and derivatives) are executed and this guarantee
+is not already provided otherwise (e.g. through |ssam_client_bind| or
+|ssam_client_link|). The writer part guards any transitions that will change
+the state, i.e. initialization, destruction, suspension, and resumption.
+
+The controller state may be accessed (read-only) outside the state lock for
+smoke-testing against invalid API usage (e.g. in |ssam_request_sync_submit|).
+Note that such checks are not supposed to (and will not) protect against all
+invalid usages, but rather aim to help catch them. In those cases, proper
+variable access is ensured by employing ``WRITE_ONCE()`` and ``READ_ONCE()``.
+
+Assuming any preconditions on the state not changing have been satisfied,
+all non-initialization and non-shutdown functions may run concurrently with
+each other. This includes |ssam_notifier_register|, |ssam_notifier_unregister|,
+|ssam_request_sync_submit|, as well as all functions building on top of those.
diff --git a/Documentation/driver-api/surface_aggregator/overview.rst b/Documentation/driver-api/surface_aggregator/overview.rst
new file mode 100644
index 000000000000..1e9d57e50063
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/overview.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+========
+Overview
+========
+
+The Surface/System Aggregator Module (SAM, SSAM) is an (arguably *the*)
+embedded controller (EC) on Microsoft Surface devices. It has been originally
+introduced on 4th generation devices (Surface Pro 4, Surface Book 1), but
+its responsibilities and feature-set have since been expanded significantly
+with the following generations.
+
+
+Features and Integration
+========================
+
+Not much is currently known about SAM on 4th generation devices (Surface Pro
+4, Surface Book 1), due to the use of a different communication interface
+between host and EC (as detailed below). On 5th (Surface Pro 2017, Surface
+Book 2, Surface Laptop 1) and later generation devices, SAM is responsible
+for providing battery information (both current status and static values,
+such as maximum capacity etc.), as well as an assortment of temperature
+sensors (e.g. skin temperature) and cooling/performance-mode setting to the
+host. On the Surface Book 2, specifically, it additionally provides an
+interface for properly handling clipboard detachment (i.e. separating the
+display part from the keyboard part of the device), on the Surface Laptop 1
+and 2 it is required for keyboard HID input. This HID subsystem has been
+restructured for 7th generation devices and on those, specifically Surface
+Laptop 3 and Surface Book 3, is responsible for all major HID input (i.e.
+keyboard and touchpad).
+
+While features have not changed much on a coarse level since the 5th
+generation, internal interfaces have undergone some rather large changes. On
+5th and 6th generation devices, both battery and temperature information is
+exposed to ACPI via a shim driver (referred to as Surface ACPI Notify, or
+SAN), translating ACPI generic serial bus write-/read-accesses to SAM
+requests. On 7th generation devices, this additional layer is gone and these
+devices require a driver hooking directly into the SAM interface. Equally,
+on newer generations, less devices are declared in ACPI, making them a bit
+harder to discover and requiring us to hard-code a sort of device registry.
+Due to this, a SSAM bus and subsystem with client devices
+(:c:type:`struct ssam_device <ssam_device>`) has been implemented.
+
+
+Communication
+=============
+
+The type of communication interface between host and EC depends on the
+generation of the Surface device. On 4th generation devices, host and EC
+communicate via HID, specifically using a HID-over-I2C device, whereas on
+5th and later generations, communication takes place via a USART serial
+device. In accordance to the drivers found on other operating systems, we
+refer to the serial device and its driver as Surface Serial Hub (SSH). When
+needed, we differentiate between both types of SAM by referring to them as
+SAM-over-SSH and SAM-over-HID.
+
+Currently, this subsystem only supports SAM-over-SSH. The SSH communication
+interface is described in more detail below. The HID interface has not been
+reverse engineered yet and it is, at the moment, unclear how many (and
+which) concepts of the SSH interface detailed below can be transferred to
+it.
+
+Surface Serial Hub
+------------------
+
+As already elaborated above, the Surface Serial Hub (SSH) is the
+communication interface for SAM on 5th- and all later-generation Surface
+devices. On the highest level, communication can be separated into two main
+types: Requests, messages sent from host to EC that may trigger a direct
+response from the EC (explicitly associated with the request), and events
+(sometimes also referred to as notifications), sent from EC to host without
+being a direct response to a previous request. We may also refer to requests
+without response as commands. In general, events need to be enabled via one
+of multiple dedicated requests before they are sent by the EC.
+
+See :doc:`ssh` for a more technical protocol documentation and
+:doc:`internal` for an overview of the internal driver architecture.
diff --git a/Documentation/driver-api/surface_aggregator/ssh.rst b/Documentation/driver-api/surface_aggregator/ssh.rst
new file mode 100644
index 000000000000..bf007d6c9873
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/ssh.rst
@@ -0,0 +1,344 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. |u8| replace:: :c:type:`u8 <u8>`
+.. |u16| replace:: :c:type:`u16 <u16>`
+.. |TYPE| replace:: ``TYPE``
+.. |LEN| replace:: ``LEN``
+.. |SEQ| replace:: ``SEQ``
+.. |SYN| replace:: ``SYN``
+.. |NAK| replace:: ``NAK``
+.. |ACK| replace:: ``ACK``
+.. |DATA| replace:: ``DATA``
+.. |DATA_SEQ| replace:: ``DATA_SEQ``
+.. |DATA_NSQ| replace:: ``DATA_NSQ``
+.. |TC| replace:: ``TC``
+.. |TID| replace:: ``TID``
+.. |IID| replace:: ``IID``
+.. |RQID| replace:: ``RQID``
+.. |CID| replace:: ``CID``
+
+===========================
+Surface Serial Hub Protocol
+===========================
+
+The Surface Serial Hub (SSH) is the central communication interface for the
+embedded Surface Aggregator Module controller (SAM or EC), found on newer
+Surface generations. We will refer to this protocol and interface as
+SAM-over-SSH, as opposed to SAM-over-HID for the older generations.
+
+On Surface devices with SAM-over-SSH, SAM is connected to the host via UART
+and defined in ACPI as device with ID ``MSHW0084``. On these devices,
+significant functionality is provided via SAM, including access to battery
+and power information and events, thermal read-outs and events, and many
+more. For Surface Laptops, keyboard input is handled via HID directed
+through SAM, on the Surface Laptop 3 and Surface Book 3 this also includes
+touchpad input.
+
+Note that the standard disclaimer for this subsystem also applies to this
+document: All of this has been reverse-engineered and may thus be erroneous
+and/or incomplete.
+
+All CRCs used in the following are two-byte ``crc_ccitt_false(0xffff, ...)``.
+All multi-byte values are little-endian, there is no implicit padding between
+values.
+
+
+SSH Packet Protocol: Definitions
+================================
+
+The fundamental communication unit of the SSH protocol is a frame
+(:c:type:`struct ssh_frame <ssh_frame>`). A frame consists of the following
+fields, packed together and in order:
+
+.. flat-table:: SSH Frame
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Field
+     - Type
+     - Description
+
+   * - |TYPE|
+     - |u8|
+     - Type identifier of the frame.
+
+   * - |LEN|
+     - |u16|
+     - Length of the payload associated with the frame.
+
+   * - |SEQ|
+     - |u8|
+     - Sequence ID (see explanation below).
+
+Each frame structure is followed by a CRC over this structure. The CRC over
+the frame structure (|TYPE|, |LEN|, and |SEQ| fields) is placed directly
+after the frame structure and before the payload. The payload is followed by
+its own CRC (over all payload bytes). If the payload is not present (i.e.
+the frame has ``LEN=0``), the CRC of the payload is still present and will
+evaluate to ``0xffff``. The |LEN| field does not include any of the CRCs, it
+equals the number of bytes inbetween the CRC of the frame and the CRC of the
+payload.
+
+Additionally, the following fixed two-byte sequences are used:
+
+.. flat-table:: SSH Byte Sequences
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Name
+     - Value
+     - Description
+
+   * - |SYN|
+     - ``[0xAA, 0x55]``
+     - Synchronization bytes.
+
+A message consists of |SYN|, followed by the frame (|TYPE|, |LEN|, |SEQ| and
+CRC) and, if specified in the frame (i.e. ``LEN > 0``), payload bytes,
+followed finally, regardless if the payload is present, the payload CRC. The
+messages corresponding to an exchange are, in part, identified by having the
+same sequence ID (|SEQ|), stored inside the frame (more on this in the next
+section). The sequence ID is a wrapping counter.
+
+A frame can have the following types
+(:c:type:`enum ssh_frame_type <ssh_frame_type>`):
+
+.. flat-table:: SSH Frame Types
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Name
+     - Value
+     - Short Description
+
+   * - |NAK|
+     - ``0x04``
+     - Sent on error in previously received message.
+
+   * - |ACK|
+     - ``0x40``
+     - Sent to acknowledge receival of |DATA| frame.
+
+   * - |DATA_SEQ|
+     - ``0x80``
+     - Sent to transfer data. Sequenced.
+
+   * - |DATA_NSQ|
+     - ``0x00``
+     - Same as |DATA_SEQ|, but does not need to be ACKed.
+
+Both |NAK|- and |ACK|-type frames are used to control flow of messages and
+thus do not carry a payload. |DATA_SEQ|- and |DATA_NSQ|-type frames on the
+other hand must carry a payload. The flow sequence and interaction of
+different frame types will be described in more depth in the next section.
+
+
+SSH Packet Protocol: Flow Sequence
+==================================
+
+Each exchange begins with |SYN|, followed by a |DATA_SEQ|- or
+|DATA_NSQ|-type frame, followed by its CRC, payload, and payload CRC. In
+case of a |DATA_NSQ|-type frame, the exchange is then finished. In case of a
+|DATA_SEQ|-type frame, the receiving party has to acknowledge receival of
+the frame by responding with a message containing an |ACK|-type frame with
+the same sequence ID of the |DATA| frame. In other words, the sequence ID of
+the |ACK| frame specifies the |DATA| frame to be acknowledged. In case of an
+error, e.g. an invalid CRC, the receiving party responds with a message
+containing an |NAK|-type frame. As the sequence ID of the previous data
+frame, for which an error is indicated via the |NAK| frame, cannot be relied
+upon, the sequence ID of the |NAK| frame should not be used and is set to
+zero. After receival of an |NAK| frame, the sending party should re-send all
+outstanding (non-ACKed) messages.
+
+Sequence IDs are not synchronized between the two parties, meaning that they
+are managed independently for each party. Identifying the messages
+corresponding to a single exchange thus relies on the sequence ID as well as
+the type of the message, and the context. Specifically, the sequence ID is
+used to associate an ``ACK`` with its ``DATA_SEQ``-type frame, but not
+``DATA_SEQ``- or ``DATA_NSQ``-type frames with other ``DATA``- type frames.
+
+An example exchange might look like this:
+
+::
+
+    tx: -- SYN FRAME(D) CRC(F) PAYLOAD CRC(P) -----------------------------
+    rx: ------------------------------------- SYN FRAME(A) CRC(F) CRC(P) --
+
+where both frames have the same sequence ID (``SEQ``). Here, ``FRAME(D)``
+indicates a |DATA_SEQ|-type frame, ``FRAME(A)`` an ``ACK``-type frame,
+``CRC(F)`` the CRC over the previous frame, ``CRC(P)`` the CRC over the
+previous payload. In case of an error, the exchange would look like this:
+
+::
+
+    tx: -- SYN FRAME(D) CRC(F) PAYLOAD CRC(P) -----------------------------
+    rx: ------------------------------------- SYN FRAME(N) CRC(F) CRC(P) --
+
+upon which the sender should re-send the message. ``FRAME(N)`` indicates an
+|NAK|-type frame. Note that the sequence ID of the |NAK|-type frame is fixed
+to zero. For |DATA_NSQ|-type frames, both exchanges are the same:
+
+::
+
+    tx: -- SYN FRAME(DATA_NSQ) CRC(F) PAYLOAD CRC(P) ----------------------
+    rx: -------------------------------------------------------------------
+
+Here, an error can be detected, but not corrected or indicated to the
+sending party. These exchanges are symmetric, i.e. switching ``rx`` and
+``tx`` results again in a valid exchange. Currently, no longer exchanges are
+known.
+
+
+Commands: Requests, Responses, and Events
+=========================================
+
+Commands are sent as payload inside a data frame. Currently, this is the
+only known payload type of |DATA| frames, with a payload-type value of
+``0x80`` (:c:type:`SSH_PLD_TYPE_CMD <ssh_payload_type>`).
+
+The command-type payload (:c:type:`struct ssh_command <ssh_command>`)
+consists of an eight-byte command structure, followed by optional and
+variable length command data. The length of this optional data is derived
+from the frame payload length given in the corresponding frame, i.e. it is
+``frame.len - sizeof(struct ssh_command)``. The command struct contains the
+following fields, packed together and in order:
+
+.. flat-table:: SSH Command
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Field
+     - Type
+     - Description
+
+   * - |TYPE|
+     - |u8|
+     - Type of the payload. For commands always ``0x80``.
+
+   * - |TC|
+     - |u8|
+     - Target category.
+
+   * - |TID| (out)
+     - |u8|
+     - Target ID for outgoing (host to EC) commands.
+
+   * - |TID| (in)
+     - |u8|
+     - Target ID for incoming (EC to host) commands.
+
+   * - |IID|
+     - |u8|
+     - Instance ID.
+
+   * - |RQID|
+     - |u16|
+     - Request ID.
+
+   * - |CID|
+     - |u8|
+     - Command ID.
+
+The command struct and data, in general, does not contain any failure
+detection mechanism (e.g. CRCs), this is solely done on the frame level.
+
+Command-type payloads are used by the host to send commands and requests to
+the EC as well as by the EC to send responses and events back to the host.
+We differentiate between requests (sent by the host), responses (sent by the
+EC in response to a request), and events (sent by the EC without a preceding
+request).
+
+Commands and events are uniquely identified by their target category
+(``TC``) and command ID (``CID``). The target category specifies a general
+category for the command (e.g. system in general, vs. battery and AC, vs.
+temperature, and so on), while the command ID specifies the command inside
+that category. Only the combination of |TC| + |CID| is unique. Additionally,
+commands have an instance ID (``IID``), which is used to differentiate
+between different sub-devices. For example ``TC=3`` ``CID=1`` is a
+request to get the temperature on a thermal sensor, where |IID| specifies
+the respective sensor. If the instance ID is not used, it should be set to
+zero. If instance IDs are used, they, in general, start with a value of one,
+whereas zero may be used for instance independent queries, if applicable. A
+response to a request should have the same target category, command ID, and
+instance ID as the corresponding request.
+
+Responses are matched to their corresponding request via the request ID
+(``RQID``) field. This is a 16 bit wrapping counter similar to the sequence
+ID on the frames. Note that the sequence ID of the frames for a
+request-response pair does not match. Only the request ID has to match.
+Frame-protocol wise these are two separate exchanges, and may even be
+separated, e.g. by an event being sent after the request but before the
+response. Not all commands produce a response, and this is not detectable by
+|TC| + |CID|. It is the responsibility of the issuing party to wait for a
+response (or signal this to the communication framework, as is done in
+SAN/ACPI via the ``SNC`` flag).
+
+Events are identified by unique and reserved request IDs. These IDs should
+not be used by the host when sending a new request. They are used on the
+host to, first, detect events and, second, match them with a registered
+event handler. Request IDs for events are chosen by the host and directed to
+the EC when setting up and enabling an event source (via the
+enable-event-source request). The EC then uses the specified request ID for
+events sent from the respective source. Note that an event should still be
+identified by its target category, command ID, and, if applicable, instance
+ID, as a single event source can send multiple different event types. In
+general, however, a single target category should map to a single reserved
+event request ID.
+
+Furthermore, requests, responses, and events have an associated target ID
+(``TID``). This target ID is split into output (host to EC) and input (EC to
+host) fields, with the respecting other field (e.g. output field on incoming
+messages) set to zero. Two ``TID`` values are known: Primary (``0x01``) and
+secondary (``0x02``). In general, the response to a request should have the
+same ``TID`` value, however, the field (output vs. input) should be used in
+accordance to the direction in which the response is sent (i.e. on the input
+field, as responses are generally sent from the EC to the host).
+
+Note that, even though requests and events should be uniquely identifiable
+by target category and command ID alone, the EC may require specific
+target ID and instance ID values to accept a command. A command that is
+accepted for ``TID=1``, for example, may not be accepted for ``TID=2``
+and vice versa.
+
+
+Limitations and Observations
+============================
+
+The protocol can, in theory, handle up to ``U8_MAX`` frames in parallel,
+with up to ``U16_MAX`` pending requests (neglecting request IDs reserved for
+events). In practice, however, this is more limited. From our testing
+(although via a python and thus a user-space program), it seems that the EC
+can handle up to four requests (mostly) reliably in parallel at a certain
+time. With five or more requests in parallel, consistent discarding of
+commands (ACKed frame but no command response) has been observed. For five
+simultaneous commands, this reproducibly resulted in one command being
+dropped and four commands being handled.
+
+However, it has also been noted that, even with three requests in parallel,
+occasional frame drops happen. Apart from this, with a limit of three
+pending requests, no dropped commands (i.e. command being dropped but frame
+carrying command being ACKed) have been observed. In any case, frames (and
+possibly also commands) should be re-sent by the host if a certain timeout
+is exceeded. This is done by the EC for frames with a timeout of one second,
+up to two re-tries (i.e. three transmissions in total). The limit of
+re-tries also applies to received NAKs, and, in a worst case scenario, can
+lead to entire messages being dropped.
+
+While this also seems to work fine for pending data frames as long as no
+transmission failures occur, implementation and handling of these seems to
+depend on the assumption that there is only one non-acknowledged data frame.
+In particular, the detection of repeated frames relies on the last sequence
+number. This means that, if a frame that has been successfully received by
+the EC is sent again, e.g. due to the host not receiving an |ACK|, the EC
+will only detect this if it has the sequence ID of the last frame received
+by the EC. As an example: Sending two frames with ``SEQ=0`` and ``SEQ=1``
+followed by a repetition of ``SEQ=0`` will not detect the second ``SEQ=0``
+frame as such, and thus execute the command in this frame each time it has
+been received, i.e. twice in this example. Sending ``SEQ=0``, ``SEQ=1`` and
+then repeating ``SEQ=1`` will detect the second ``SEQ=1`` as repetition of
+the first one and ignore it, thus executing the contained command only once.
+
+In conclusion, this suggests a limit of at most one pending un-ACKed frame
+(per party, effectively leading to synchronous communication regarding
+frames) and at most three pending commands. The limit to synchronous frame
+transfers seems to be consistent with behavior observed on Windows.
diff --git a/MAINTAINERS b/MAINTAINERS
index 64730461f4df..ff5d60875cec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11697,6 +11697,7 @@ M:	Maximilian Luz <luzmaximilian@gmail.com>
 S:	Maintained
 W:	https://github.com/linux-surface/surface-aggregator-module
 C:	irc://chat.freenode.net/##linux-surface
+F:	Documentation/driver-api/surface_aggregator/
 F:	drivers/platform/surface/aggregator/
 F:	include/linux/surface_aggregator/

--
2.29.2

