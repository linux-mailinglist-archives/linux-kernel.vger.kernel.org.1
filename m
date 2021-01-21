Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62A2FE4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbhAUIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbhAUIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:23:44 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D6EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:22:52 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t17so890291qvv.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=He3ar/MTK5MMTHLPAyc/YOgGj/eE6d07+Lgx6V1wQsY=;
        b=C8XCAguqZ99f5zJfx3/7Ij5ULSa+QZ2Yyw8wJVruImNEpiD6nFB0PnZ2UJE2eb6jxo
         I5wFAeoUGndVQIloVvcTIBV/iWeqXxoOhDH3+6KRWmXxFm6OgQ56Zc+aGPFzAkbVA6HA
         Tot9+SRAU5sWpgb0D8wjP6tWm3aEGK3MyFwFOi4ZiCi56whNwVNKT4Ogx2DYFELwgLAp
         hhUdmQOWUPXOlDTW+4rj5f/4GV5QlZ1ftgHCnBwuqBqCTmZ5PGgbUMygnbOuk378hV/+
         5YAHsGjrgGB8eUWOz50hP61Vt2jhLyr58j0t7u3OA3EVTh3lwZL3ufffBkvRyyNGFcjq
         CCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=He3ar/MTK5MMTHLPAyc/YOgGj/eE6d07+Lgx6V1wQsY=;
        b=kr9ypTIG8OBiPt44sp0TBJVxzt3M4EKvZ3bERmRQzYxhWbJuKGhXYVYN3dhbqOTFAs
         3ktPmS4I+SoKN117gH0bli4ZSVQpF7IKjuBxadOBBNTArCbplNRElmbFHOMhB9MCwJft
         QKuMCChHoCf9cpmJoKOi6gAzJzMumZFTjRCxX9gIcWhIH+3nIUBEJJF5/q5VCTS1WGjt
         kju+/CL7rK9EFhcelkERnIycRRf5xglHrrSMINCNBO/4PThb1TYNdz8QRNq8mZ8PHe8E
         Ix6+cH0x6qOQZ40htKBWxjLnT9uSfoc+tjh6O6ncTfvpLEPuIdoxMcZFOOKlfQ9QzchS
         nU4w==
X-Gm-Message-State: AOAM531iyzqoMDKgV042ddSMWGDtoXL3AToLVMExzIcHWT0NItB64UAD
        sP8d8S/jCeoADy5UOIF9EgDeYJRJa5nB8w0=
X-Google-Smtp-Source: ABdhPJzA68BXbtByMkrhMvj2c8KSwGxuNkyLOcPNTmsTOY+y+vgk2O5oVdgXGhD48pPyTTyz36p8s05OoWK8cJg=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:c211:: with SMTP id
 l17mr13353032qvh.53.1611217371639; Thu, 21 Jan 2021 00:22:51 -0800 (PST)
Date:   Thu, 21 Jan 2021 00:22:47 -0800
In-Reply-To: <20201218031703.3053753-6-saravanak@google.com>
Message-Id: <20210121082248.883253-1-saravanak@google.com>
Mime-Version: 1.0
References: <20201218031703.3053753-6-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [TEST PATCH v1] driver: core: Make fw_devlink=on more forgiving
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for test purposes only and pretty experimental. Code might
not be optimized, clean, formatted properly, etc.

Please review it only for functional bugs like locking bugs, wrong
logic, etc.

It's basically trying to figure out which devices will never probe and
ignore them. Might not always work.

Marek, Geert, Marc,

Can you please try this patch INSTEAD of the other workarounds we found?

Jon, Michael,

I'm explicitly not including you in the "To" because this patch won't
work for your issues.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h |   3 ++
 drivers/base/core.c | 117 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/base/dd.c   |  24 +++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index f5600a83124f..8d5fd95fa147 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -106,6 +106,9 @@ struct device_private {
 #define to_device_private_class(obj)	\
 	container_of(obj, struct device_private, knode_class)
 
+bool fw_devlink_is_permissive(void);
+bool fw_devlink_unblock_probe(struct device *dev);
+
 /* initialisation functions */
 extern int devices_init(void);
 extern int buses_init(void);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e61e62b624ce..8528704bbb40 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -49,7 +49,6 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
-static bool fw_devlink_is_permissive(void);
 
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
@@ -1481,7 +1480,7 @@ u32 fw_devlink_get_flags(void)
 	return fw_devlink_flags;
 }
 
-static bool fw_devlink_is_permissive(void)
+bool fw_devlink_is_permissive(void)
 {
 	return fw_devlink_flags == FW_DEVLINK_FLAGS_PERMISSIVE;
 }
@@ -1552,6 +1551,120 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 	return ret;
 }
 
+static int __device_links_suppliers_available(struct device *dev)
+{
+	struct device_link *link;
+	int ret = 0;
+
+	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
+	    !fw_devlink_is_permissive()) {
+		return -EPROBE_DEFER;
+	}
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (!(link->flags & DL_FLAG_MANAGED))
+			continue;
+
+		if (link->status != DL_STATE_AVAILABLE &&
+		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
+			ret = -EPROBE_DEFER;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+bool fw_devlink_unblock_probe(struct device *dev)
+{
+	struct fwnode_link *link, *tmp;
+	struct device_link *dev_link, *dev_ln;
+	struct fwnode_handle *fwnode = dev->fwnode;
+	bool unblocked = false;
+
+	if (!fw_devlink_get_flags() || fw_devlink_is_permissive())
+		return false;
+
+	if (!fwnode)
+		return false;
+
+	mutex_lock(&fwnode_link_lock);
+
+	/* Delete questionable fwnode links */
+	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
+		struct device *par_dev;
+		struct fwnode_handle *par;
+		bool bound;
+
+		/*
+		 * Walk up fwnode tree of supplier till we find a parent device
+		 * that has been added or a parent fwnode that has fwnode links
+		 * (this is a firmware node that is expected to be added as a
+		 * device in the future).
+		 */
+		par = fwnode_get_parent(link->supplier);
+		while (par && list_empty(&par->suppliers) && !par->dev)
+			par = fwnode_get_next_parent(par);
+
+		/* Supplier is waiting on parent device to be added. */
+		if (par && !par->dev) {
+			fwnode_handle_put(par);
+			continue;
+		}
+
+		if (par && par->dev) {
+			par_dev = get_dev_from_fwnode(fwnode);
+			device_lock(par_dev);
+			bound = device_is_bound(par_dev);
+			device_unlock(par_dev);
+			put_device(par_dev);
+
+			/* Supplier is waiting on parent device to be bound. */
+			if (!bound)
+				continue;
+		}
+
+		/*
+		 * Supplier has no parent or the immediate parent device has
+		 * been bound to a device. It should have been added by now.
+		 * So, this link is spurious. Delete it.
+		 */
+		dev_info(dev, "Deleting fwnode link to %pfwP\n",
+			 link->supplier);
+		list_del(&link->s_hook);
+		list_del(&link->c_hook);
+		kfree(link);
+		unblocked = true;
+	}
+
+	if (IS_ENABLED(CONFIG_MODULES))
+		goto out;
+
+	device_links_write_lock();
+
+	list_for_each_entry_safe(dev_link, dev_ln, &dev->links.suppliers,
+				 c_node) {
+		if (!(dev_link->flags & DL_FLAG_INFERRED) ||
+		    dev_link->flags & DL_FLAG_SYNC_STATE_ONLY ||
+		    dev_link->status != DL_STATE_DORMANT)
+			continue;
+
+		/* This supplier should have probed by now. */
+		if (!__device_links_suppliers_available(dev_link->supplier)) {
+			dev_info(dev, "Deleting dev link to %s\n",
+				 dev_name(dev_link->supplier));
+			device_link_drop_managed(dev_link);
+			unblocked = true;
+		}
+	}
+
+	device_links_write_unlock();
+
+out:
+	mutex_unlock(&fwnode_link_lock);
+	return unblocked;
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con - Consumer device for the device link
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 2f32f38a11ed..d4ccd2a2b6a4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -301,6 +301,25 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
+static bool deferred_probe_fw_devlink_unblock(void)
+{
+	struct device *dev;
+	struct device_private *private;
+	bool unblocked = false;
+
+	if (!fw_devlink_get_flags() || fw_devlink_is_permissive())
+		return false;
+
+	mutex_lock(&deferred_probe_mutex);
+	list_for_each_entry(private, &deferred_probe_pending_list, deferred_probe) {
+		dev = private->device;
+		unblocked |= fw_devlink_unblock_probe(dev);
+	}
+	mutex_unlock(&deferred_probe_mutex);
+
+	return unblocked;
+}
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -317,6 +336,11 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
+
+	while (deferred_probe_fw_devlink_unblock()) {
+		driver_deferred_probe_trigger();
+		flush_work(&deferred_probe_work);
+	}
 	initcalls_done = true;
 
 	/*
-- 
2.30.0.296.g2bfb1c46d8-goog

