Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD9288D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbgJIP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbgJIP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:56:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C069C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:56:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m11so9376456otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8RF+pbFo4v/uhHcMv+xKvHzBJV+hKD4yT0iN+f6Utg=;
        b=AOhYkBuSacNDaLVakF6RqyfBtioFHuFbTQOstl20VQd3J7Pnt4Ui3p/SVaPF7sZHIR
         +VWWOuFaXHypLRqR4D8nUKhQHO+IbjhCBwwkHimxLT9Lw3hvfJSf/sbU4CWwuHmqEgFl
         hLrTFmLX8t2BjJeVlZCwwmSf5chaNTdWYt7is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8RF+pbFo4v/uhHcMv+xKvHzBJV+hKD4yT0iN+f6Utg=;
        b=eLYjoDgP9TQB0XEJJ3OggZ/bYj0rLAFXftcpwWHjpKjrGXSSYEJ5YMyrvN0FTz1bPl
         SEqUx0Zpf+4TxCBIg4bZt+NW3z5Q3QEOKiTcGFo5AUhC8T15dQO8nuIjn5aNZC04Bi7R
         4ne5/O4N2+IQHX8ZnIg+KPKKtcozltHKo6al10qfLG5taAjDNi2wZAw8rA3fhkq851RH
         vO0EgHkYRZdLe5vw70y60dz25nJsONzp3lYSIuAd/RWoma/TkxsPfXPM9krnOFhmkO63
         jEB1cxHF+gP5kll5LkeYRPpWwl5D81JWjGU9DJcCEJT2/AMQcgA/OY3sdFeGK/0DOYzJ
         jUMQ==
X-Gm-Message-State: AOAM532e7RLU29Yk3MkoViMF4xh0FpK7cWUzUI4cgkuEcbDPC1DZkylE
        Ura0/Vp1kbqIslYWP8Z2SzqNPQ==
X-Google-Smtp-Source: ABdhPJwz0ww7flmqVSW7LC2KbkF4cNXhsL394hsA5Xbu1qKhkI+V3oaWX22/NAPgTj+dUx+7//hq3Q==
X-Received: by 2002:a9d:490:: with SMTP id 16mr4128360otm.96.1602258974010;
        Fri, 09 Oct 2020 08:56:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] drivers/base: convert deferred_trigger_count and probe_count to counter_atomic32
Date:   Fri,  9 Oct 2020 09:55:58 -0600
Message-Id: <aaa69bb504ab7c0b94e158c6a7e8cb508c3adb5d.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables wrap around to INT_MIN when it overflows
and should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

deferred_trigger_count gets incremented and read. It doesn't guard
object lifetimes, device usage counts, device open counts, and pm
states. There is very little chance of this counter overflowing.
Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

probe_count gets incremented, decremented, read. It doesn't guard
object lifetimes, device usage counts, device open counts, and pm
states. There is very little chance of this counter overflowing.
This counter controls the wait for known devices to complete their
probing, and probe_count == 0 ends the wait. Other than that it
meets the other criteria to be converted. Convert it to use
counter_atomic32.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/dd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 857b0a928e8d..cdb310aca74f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
+#include <linux/counters.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -54,7 +55,7 @@
 static DEFINE_MUTEX(deferred_probe_mutex);
 static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
-static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
+static struct counter_atomic32 deferred_trigger_count = COUNTER_ATOMIC_INIT(0);
 static struct dentry *deferred_devices;
 static bool initcalls_done;
 
@@ -173,7 +174,7 @@ static void driver_deferred_probe_trigger(void)
 	 * into the active list so they can be retried by the workqueue
 	 */
 	mutex_lock(&deferred_probe_mutex);
-	atomic_inc(&deferred_trigger_count);
+	counter_atomic32_inc(&deferred_trigger_count);
 	list_splice_tail_init(&deferred_probe_pending_list,
 			      &deferred_probe_active_list);
 	mutex_unlock(&deferred_probe_mutex);
@@ -466,7 +467,7 @@ int device_bind_driver(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_bind_driver);
 
-static atomic_t probe_count = ATOMIC_INIT(0);
+static struct counter_atomic32 probe_count = COUNTER_ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
 static void driver_deferred_probe_add_trigger(struct device *dev,
@@ -474,7 +475,7 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
 {
 	driver_deferred_probe_add(dev);
 	/* Did a trigger occur while probing? Need to re-trigger if yes */
-	if (local_trigger_count != atomic_read(&deferred_trigger_count))
+	if (local_trigger_count != counter_atomic32_read(&deferred_trigger_count))
 		driver_deferred_probe_trigger();
 }
 
@@ -493,7 +494,7 @@ static DEVICE_ATTR_RO(state_synced);
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
 	int ret = -EPROBE_DEFER;
-	int local_trigger_count = atomic_read(&deferred_trigger_count);
+	int local_trigger_count = counter_atomic32_read(&deferred_trigger_count);
 	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
 			   !drv->suppress_bind_attrs;
 
@@ -514,7 +515,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		return ret;
 
-	atomic_inc(&probe_count);
+	counter_atomic32_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
 	if (!list_empty(&dev->devres_head)) {
@@ -648,7 +649,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	 */
 	ret = 0;
 done:
-	atomic_dec(&probe_count);
+	counter_atomic32_dec(&probe_count);
 	wake_up_all(&probe_waitqueue);
 	return ret;
 }
@@ -678,7 +679,7 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
  */
 int driver_probe_done(void)
 {
-	int local_probe_count = atomic_read(&probe_count);
+	int local_probe_count = counter_atomic32_read(&probe_count);
 
 	pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
 	if (local_probe_count)
@@ -699,7 +700,7 @@ void wait_for_device_probe(void)
 	flush_work(&deferred_probe_work);
 
 	/* wait for the known devices to complete their probing */
-	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
+	wait_event(probe_waitqueue, counter_atomic32_read(&probe_count) == 0);
 	async_synchronize_full();
 }
 EXPORT_SYMBOL_GPL(wait_for_device_probe);
-- 
2.25.1

