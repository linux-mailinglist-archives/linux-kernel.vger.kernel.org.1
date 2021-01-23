Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697763017FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbhAWTPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 14:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhAWTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 14:15:04 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14771C06178B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 11:14:24 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id x12so5006767wrw.21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 11:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=o1eOFs5oNL2umkEC7rPLLY1ov2RvMZvjKlnj+a/DUFs=;
        b=ALG4zl7njX5XG2rO3sPLf8UrFLkZVZy+Tw+zgwww3YUd0ny0Z7Aw0LxbRB6HRECAC0
         obum1wRs5jsWx/dK8tluHgwhl8MFCeX5lrVvfwO7RQ9LuUe1YXuD7hybdTiWFbxlPm5j
         yOEoMieSX50k3gAQB3zcZnRmrOhRhdOy0Rv6yBNgrFHBxAWTRC+AnSvVOAIzeKR4c/58
         5e1XBKa+byoqas4J4BBHPwqXNgzEX/J9MKtYC4qad0PUibR14dQNWXCTC5Rst6DNjm0o
         RBmkyCleqcgpI5zAdgps6VyUoCtfI9LlZwB8XBmGvwQhf4I60GPx3yRsSHSVVGysI7jc
         fQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o1eOFs5oNL2umkEC7rPLLY1ov2RvMZvjKlnj+a/DUFs=;
        b=HMjorVHuFhJQ3bN8OEX9Xzc0JjusPoU5YhC7UGYyWeB45bnehy2TkSKPwcmYFqV8a+
         PiqaFs0MOKy+vpqEYRRvuCbOGSYI1ADNjBbGwyXSZRif/rbapK68WIrVTGwDjaZvZ92o
         vinuChhX3HrokjQX+eD9DxRpBJYYL0HotYHZtgdG5Ks64zKIUq3RnP0F4pw/2zA8a/G1
         vHFLBXOWDzmQydtTNhIiCyg1DFCeoeIzip4PQ7E1ytTFIe6Esmys3aVuuC/5oDeR31ja
         cl1HnQ4Csol0qeBAf05ecNjFV7EFji+TVafnnoMTk9PMMEzagqFwh4iK7K34q7mpIWW4
         ckPA==
X-Gm-Message-State: AOAM532BG3o9P4wMUOnDGts7Qbm0nUR7sxY1vYGYEAmTTmjjIQQDLVvK
        WgNCNBRxOnwOgAEiSNl6V9DQwcMK+kZ0ms85
X-Google-Smtp-Source: ABdhPJxoSNKnuwqqX8UQzjUWtGe+6lTl5my1nsOVcKE4riBQPh95l6NNxvsY7iAR+9UYwvRY+IIxVWoBvTKifte3
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:258:: with SMTP id
 24mr9099807wmj.161.1611429262381; Sat, 23 Jan 2021 11:14:22 -0800 (PST)
Date:   Sat, 23 Jan 2021 20:14:17 +0100
In-Reply-To: <c8937266c4a5da073ac81cd471b18d869c984dfe.1611429174.git.andreyknvl@google.com>
Message-Id: <f4c650c94ae2b910e38819d51109cd5f0b251a2a.1611429174.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c8937266c4a5da073ac81cd471b18d869c984dfe.1611429174.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/2] usb: raw-gadget: update documentation and Kconfig
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Raw Gadget documentation and Kconfig. Make the description more
precise and clear, fix typos and grammar mistakes, and do other cleanups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/usb/raw-gadget.rst  | 102 ++++++++++++++++--------------
 drivers/usb/gadget/legacy/Kconfig |  13 ++--
 2 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gadget.rst
index 68d879a8009e..818a1648b387 100644
--- a/Documentation/usb/raw-gadget.rst
+++ b/Documentation/usb/raw-gadget.rst
@@ -2,83 +2,93 @@
 USB Raw Gadget
 ==============
 
-USB Raw Gadget is a kernel module that provides a userspace interface for
-the USB Gadget subsystem. Essentially it allows to emulate USB devices
-from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
-currently a strictly debugging feature and shouldn't be used in
-production, use GadgetFS instead.
+USB Raw Gadget is a gadget driver that gives userspace low-level control over
+the gadget's communication process.
+
+Like any other gadget driver, Raw Gadget implements USB devices via the
+USB gadget API. Unlike most gadget drivers, Raw Gadget does not implement
+any concrete USB functions itself but requires userspace to do that.
+
+Raw Gadget is currently a strictly debugging feature and should not be used
+in production. Use GadgetFS instead.
+
+Enabled with CONFIG_USB_RAW_GADGET.
 
 Comparison to GadgetFS
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Raw Gadget is similar to GadgetFS, but provides a more low-level and
-direct access to the USB Gadget layer for the userspace. The key
-differences are:
+Raw Gadget is similar to GadgetFS but provides more direct access to the
+USB gadget layer for userspace. The key differences are:
 
-1. Every USB request is passed to the userspace to get a response, while
+1. Raw Gadget passes every USB request to userspace to get a response, while
    GadgetFS responds to some USB requests internally based on the provided
-   descriptors. However note, that the UDC driver might respond to some
-   requests on its own and never forward them to the Gadget layer.
+   descriptors. Note that the UDC driver might respond to some requests on
+   its own and never forward them to the gadget layer.
 
-2. GadgetFS performs some sanity checks on the provided USB descriptors,
-   while Raw Gadget allows you to provide arbitrary data as responses to
-   USB requests.
+2. Raw Gadget allows providing arbitrary data as responses to USB requests,
+   while GadgetFS performs sanity checks on the provided USB descriptors.
+   This makes Raw Gadget suitable for fuzzing by providing malformed data as
+   responses to USB requests.
 
 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
-   while GadgetFS currently binds to the first available UDC.
+   while GadgetFS currently binds to the first available UDC. This allows
+   having multiple Raw Gadget instances bound to different UDCs.
 
 4. Raw Gadget explicitly exposes information about endpoints addresses and
-   capabilities allowing a user to write UDC-agnostic gadgets.
+   capabilities. This allows the user to write UDC-agnostic gadgets.
 
-5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
+5. Raw Gadget has an ioctl-based interface instead of a filesystem-based
+   one.
 
 Userspace interface
 ~~~~~~~~~~~~~~~~~~~
 
-To create a Raw Gadget instance open /dev/raw-gadget. Multiple raw-gadget
-instances (bound to different UDCs) can be used at the same time. The
-interaction with the opened file happens through the ioctl() calls, see
-comments in include/uapi/linux/usb/raw_gadget.h for details.
+The user can interact with Raw Gadget by opening ``/dev/raw-gadget`` and
+issuing ioctl calls; see the comments in include/uapi/linux/usb/raw_gadget.h
+for details. Multiple Raw Gadget instances (bound to different UDCs) can be
+used at the same time.
 
-The typical usage of Raw Gadget looks like:
+A typical usage scenario of Raw Gadget:
 
-1. Open Raw Gadget instance via /dev/raw-gadget.
-2. Initialize the instance via USB_RAW_IOCTL_INIT.
-3. Launch the instance with USB_RAW_IOCTL_RUN.
-4. In a loop issue USB_RAW_IOCTL_EVENT_FETCH calls to receive events from
-   Raw Gadget and react to those depending on what kind of USB device
-   needs to be emulated.
+1. Create a Raw Gadget instance by opening ``/dev/raw-gadget``.
+2. Initialize the instance via ``USB_RAW_IOCTL_INIT``.
+3. Launch the instance with ``USB_RAW_IOCTL_RUN``.
+4. In a loop issue ``USB_RAW_IOCTL_EVENT_FETCH`` to receive events from
+   Raw Gadget and react to those depending on what kind of USB gadget must
+   be implemented.
 
-Note, that some UDC drivers have fixed addresses assigned to endpoints, and
-therefore arbitrary endpoint addresses can't be used in the descriptors.
-Nevertheles, Raw Gadget provides a UDC-agnostic way to write USB gadgets.
-Once a USB_RAW_EVENT_CONNECT event is received via USB_RAW_IOCTL_EVENT_FETCH,
-the USB_RAW_IOCTL_EPS_INFO ioctl can be used to find out information about
-endpoints that the UDC driver has. Based on that information, the user must
-chose UDC endpoints that will be used for the gadget being emulated, and
-properly assign addresses in endpoint descriptors.
+Note that some UDC drivers have fixed addresses assigned to endpoints, and
+therefore arbitrary endpoint addresses cannot be used in the descriptors.
+Nevertheless, Raw Gadget provides a UDC-agnostic way to write USB gadgets.
+Once ``USB_RAW_EVENT_CONNECT`` is received via ``USB_RAW_IOCTL_EVENT_FETCH``,
+``USB_RAW_IOCTL_EPS_INFO`` can be used to find out information about the
+endpoints that the UDC driver has. Based on that, userspace must choose UDC
+endpoints for the gadget and assign addresses in the endpoint descriptors
+correspondingly.
 
-You can find usage examples (along with a test suite) here:
+Raw Gadget usage examples and a test suite:
 
 https://github.com/xairy/raw-gadget
 
 Internal details
 ~~~~~~~~~~~~~~~~
 
-Currently every endpoint read/write ioctl submits a USB request and waits until
-its completion. This is the desired mode for coverage-guided fuzzing (as we'd
-like all USB request processing happen during the lifetime of a syscall),
-and must be kept in the implementation. (This might be slow for real world
-applications, thus the O_NONBLOCK improvement suggestion below.)
+Every Raw Gadget endpoint read/write ioctl submits a USB request and waits
+until its completion. This is done deliberately to assist with coverage-guided
+fuzzing by having a single syscall fully process a single USB request. This
+feature must be kept in the implementation.
 
 Potential future improvements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- Report more events (suspend, resume, etc.) through USB_RAW_IOCTL_EVENT_FETCH.
+- Report more events (suspend, resume, etc.) through
+  ``USB_RAW_IOCTL_EVENT_FETCH``.
 
-- Support O_NONBLOCK I/O.
+- Support ``O_NONBLOCK`` I/O. This would be another mode of operation, where
+  Raw Gadget would not wait until the completion of each USB request.
 
 - Support USB 3 features (accept SS endpoint companion descriptor when
-  enabling endpoints; allow providing stream_id for bulk transfers).
+  enabling endpoints; allow providing ``stream_id`` for bulk transfers).
 
-- Support ISO transfer features (expose frame_number for completed requests).
+- Support ISO transfer features (expose ``frame_number`` for completed
+  requests).
diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index f02c38b32a2b..11dd6e8adc8a 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -515,10 +515,15 @@ config USB_G_WEBCAM
 config USB_RAW_GADGET
 	tristate "USB Raw Gadget"
 	help
-	  USB Raw Gadget is a kernel module that provides a userspace interface
-	  for the USB Gadget subsystem. Essentially it allows to emulate USB
-	  devices from userspace. See Documentation/usb/raw-gadget.rst for
-	  details.
+	  USB Raw Gadget is a gadget driver that gives userspace low-level
+	  control over the gadget's communication process.
+
+	  Like any other gadget driver, Raw Gadget implements USB devices via
+	  the USB gadget API. Unlike most gadget drivers, Raw Gadget does not
+	  implement any concrete USB functions itself but requires userspace
+	  to do that.
+
+	  See Documentation/usb/raw-gadget.rst for details.
 
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "raw_gadget".
-- 
2.30.0.280.ga3ce27912f-goog

