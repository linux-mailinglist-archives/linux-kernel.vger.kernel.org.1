Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF9279501
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgIYXrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgIYXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:36 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE08C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:35 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id m25so1175848oou.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wb0eDwrk9R9is3ZjKYCIgu3qrE0JC+qQH/fE5ZkeT+s=;
        b=XgHk7MoSuWFccIvcxQ2+B9nawqXAuIueBF8vmhOG0iMIEgVSTYFhAOByNucP11eOF0
         wovesBE8OiR73Wshz0WEELIMlBnOQ4kUhYcd1OvqkfuWWGu5yv1ewvJIZL2CtETSEyek
         5iW/fSgxnm4epqYSobYGm/Fv4GzcfcFaBKmqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wb0eDwrk9R9is3ZjKYCIgu3qrE0JC+qQH/fE5ZkeT+s=;
        b=kPRUXmbfi6JJh64egkCB9EI1MgZA5cdnp8gvvY5GoDPNLLNEiZPCGOZrrbUEPpXRRT
         ZgZR2l2C9z6iCCksd98sroXqN1Pc/gEa/1pcn6421Sd6J94qabds4TSgBZwo6I8lW8kG
         V0UQ086sDd5WSktyr39IF58s38eA3V6NfbLYn4sigAYYrIBjAhBNsGQCHE4O1/S8dx9M
         oRA90bmwR21UUfwGHtpLJ/9kopEF+Dd/0ogKA2OJ+j+1cJIzoRhqqYLsBpSiNEbgYATq
         +VWCS9DXr8KhTv0hBNAxuJEBAEd5eAHvFhOeXAHdx9eHb1RTFPAEpWAUx4pTcKQyV6Xn
         qZ3g==
X-Gm-Message-State: AOAM5318x9f6Ho8cZ8xCZ2j79jYfKIgkZSStRwH7fXp9MQcRvPU+Kvqv
        O5RjjyEJpAT8v7Txy395e4fEMw==
X-Google-Smtp-Source: ABdhPJzI3WT0Gw4azV7ypA/duv5IpM8QUZCWkf3tO3AzQz6AV4ENlKESkkiHx/xNwlS6D1I4BO005Q==
X-Received: by 2002:a4a:bc90:: with SMTP id m16mr2552642oop.12.1601077655286;
        Fri, 25 Sep 2020 16:47:35 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:34 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] drivers/base: convert deferred_trigger_count and probe_count to counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:17 -0600
Message-Id: <2b78987b12b8eb214a46bdba0ef5cd4808c102dd.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
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

