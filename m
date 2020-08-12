Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC3242E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHLRqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:46:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58213C061383;
        Wed, 12 Aug 2020 10:46:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so1500452pjx.5;
        Wed, 12 Aug 2020 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IuzAjW4iKvUxBLY8x56IhZif1QbkoJsOqN2MFy5m4l0=;
        b=gWypLrOM5T6mYQAwyRTiMMZewfKrHEsWMAWduQqo1gX4T7FfZhkIjCKyTJ0u4VIDg0
         Dvvlk6EHVappqYQgvv9qOvryAHchLPZ8DRFCk0dCnNoUQq1kqDPUZ4iZFT/3plIvesbl
         fX+C7xadt3nbC6PPC6nqAVRXLrXsH6CnTO0IIrwQ2IBhnhk4cZsN1O27DOe1NvUOTYDM
         UijQmKSoRWeBTLKOFKKzugq2Jz0vCdnmOiAU6f9PneTPF8jHwiUOTsEEUGXC+/XZ8w0G
         THRlVyp03iXHX47jIffu+IhicGx/Nmx9Jpv8WjHqKcG2el+3Opbe7YmP5WbuVhT8YPv7
         Wl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IuzAjW4iKvUxBLY8x56IhZif1QbkoJsOqN2MFy5m4l0=;
        b=S1E2/skmikvuCHt6mMg7dO4LkDYJJGxWY9+Njk938flSyNpZTpr43CRC3/p7f9NMCZ
         NkwBRJjUf+xWl9nye6C2AdQP84mCOQ4/yJVRJaJ8SrjJaq2HTBFxd0IGb4buQnwbGIrd
         pmiZndHTT55ee5vs2ZXmUWOWK27yZYxaCdp9zIJOx84atN2a2mRK2qnFzgjoF1Le/70e
         vxFeMAPXlbzDYyJHURCJviBYT8d/EEqO6SKA30xrmjSEzdHhm4MSWnvOosu06wQu1g4e
         /FNNlXEPdnK3aYlxIDrvLw2RAtUxS+8ep8+5tQv1UlLaZNv5hNHa7Ltwl9G8bmCLYo7L
         S6rA==
X-Gm-Message-State: AOAM533t/LJVrm76cMj789lic4h7qeasgCFvkH5STb/Ji/XjwIZrM/wc
        A4uqocsHMXuF1ZURlrJQl9c=
X-Google-Smtp-Source: ABdhPJwtVo58m4lD0N34u8UfQvwsUmq9F1IrsQkYZEoirNxr+nQ0a1pl5jcJcjIX9dkAto6LK8p6Pw==
X-Received: by 2002:a17:90a:fa92:: with SMTP id cu18mr1086668pjb.215.1597254379683;
        Wed, 12 Aug 2020 10:46:19 -0700 (PDT)
Received: from localhost.localdomain ([124.253.105.122])
        by smtp.googlemail.com with ESMTPSA id lk16sm2829852pjb.13.2020.08.12.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 10:46:18 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: Documentation: Replace deprecated :c:func: Usage
Date:   Wed, 12 Aug 2020 23:16:11 +0530
Message-Id: <20200812174611.18580-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with func() as the previous usage is deprecated.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/driver-api/iio/core.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/iio/core.rst b/Documentation/driver-api/iio/core.rst
index b0bc0c028cc5..51b21e002396 100644
--- a/Documentation/driver-api/iio/core.rst
+++ b/Documentation/driver-api/iio/core.rst
@@ -11,10 +11,10 @@ Industrial I/O Devices
 ----------------------
 
 * struct :c:type:`iio_dev` - industrial I/O device
-* :c:func:`iio_device_alloc()` - allocate an :c:type:`iio_dev` from a driver
-* :c:func:`iio_device_free()` - free an :c:type:`iio_dev` from a driver
-* :c:func:`iio_device_register()` - register a device with the IIO subsystem
-* :c:func:`iio_device_unregister()` - unregister a device from the IIO
+* iio_device_alloc() - allocate an :c:type:`iio_dev` from a driver
+* iio_device_free() - free an :c:type:`iio_dev` from a driver
+* iio_device_register() - register a device with the IIO subsystem
+* iio_device_unregister() - unregister a device from the IIO
   subsystem
 
 An IIO device usually corresponds to a single hardware sensor and it
@@ -34,17 +34,17 @@ A typical IIO driver will register itself as an :doc:`I2C <../i2c>` or
 
 At probe:
 
-1. Call :c:func:`iio_device_alloc()`, which allocates memory for an IIO device.
+1. Call iio_device_alloc(), which allocates memory for an IIO device.
 2. Initialize IIO device fields with driver specific information (e.g.
    device name, device channels).
-3. Call :c:func:`iio_device_register()`, this registers the device with the
+3. Call iio_device_register(), this registers the device with the
    IIO core. After this call the device is ready to accept requests from user
    space applications.
 
 At remove, we free the resources allocated in probe in reverse order:
 
-1. :c:func:`iio_device_unregister()`, unregister the device from the IIO core.
-2. :c:func:`iio_device_free()`, free the memory allocated for the IIO device.
+1. iio_device_unregister(), unregister the device from the IIO core.
+2. iio_device_free(), free the memory allocated for the IIO device.
 
 IIO device sysfs interface
 ==========================
-- 
2.27.0

