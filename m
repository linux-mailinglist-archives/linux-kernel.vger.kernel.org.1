Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A462A7194
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbgKDXYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbgKDXYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:24:37 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A2C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:24:35 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id d18so6555061qvp.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CtjcYrzA5RtYrJvudSEyD3+ygKoSrCng1EqXjVEeKbw=;
        b=CB/buzwsAYrYrPBNNbrJt+bW3eujurmsbJ8Lzzzu5idDTCYeTx65NU4AKLQDS7Zez5
         +FjTR6oxZ45GK3hd+D+HlKJgE4tkS20KZaZ7vp/MkUQ0Xzz2aeJHxxExTEhW+/Iyztf3
         mO7I/x+jSWpgJxA6ZX4laoIovo4XufMVegM0kjUL6J7emf+2chuLzBytGdq+3upV6Ngd
         7u/jny817rSA8IXSgUqxYs9UFUBHwovHE5rZHJLURobROdzUesljHixXW/cc7Kd25zP8
         x+PBBP2MAJCczEhO0t5WfGtLxo8Gdf+mDULxwJcFut+ZjCsITJdJBBkpzAxpEANkz7qy
         YKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CtjcYrzA5RtYrJvudSEyD3+ygKoSrCng1EqXjVEeKbw=;
        b=OyXogkGjYzvLTeiSAjVgci8XJGBqx/TmOvKwm+mcUw5oLD1OVTfyHR4GR4XsFbmhPn
         xONjQTnT9dIPEA48ZiNOxI9Ik2le+5fF0AMcidsz0u27NH0lmyb7EC+Tj1nB4JiEF6D4
         ZTYZ207YB7oZ7em9rLZENPxheAMFTHnZnk5McPH5znocui/RfJfRpZ2yUFoSCKcyKQTn
         +ipwOQ5OayhpiBJ5zqic5F25YCFUizN9ICU6YUVX29TjRhCHOORpEG4M3ec2uQhwvKWn
         FGCRBfgLnbAlkR3P+Dl9Mg2Aai9ER2plnnIycvcycGDf553wle7jEWHXSSxTXAIull/z
         1kNA==
X-Gm-Message-State: AOAM533TgG7x0cnCe0PuFvbXzOhoLeViIA0TH3ykHopSByeZ53r+YKW0
        maZxTpZ+iiYwaMaNj1QNMmBOk3JlUyGdrHM=
X-Google-Smtp-Source: ABdhPJyW+B4va+p11i60OaKxdHL8x7Z9eAsiRYkxCy6OSheMPocPqKQY4jFdzFYLvYy05IF68b3Wioi5lJjiyHI=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr269066qvb.17.1604532274612; Wed, 04 Nov 2020 15:24:34 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:51 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-15-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 14/18] driver core: Use device's fwnode to check if it is
 waiting for suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To check if a device is still waiting for its supplier devices to be
added, we used to check if the devices is in a global
waiting_for_suppliers list. Since the global list will be deleted in
subsequent patches, this patch stops using this check.

Instead, this patch uses a more device specific check. It checks if the
device's fwnode has any fwnode links that haven't been converted to
device links yet.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4ae5f2885ac5..d51dd564add1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
+static bool fw_devlink_is_permissive(void);
 
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
@@ -994,13 +995,13 @@ int device_links_check_suppliers(struct device *dev)
 	 * Device waiting for supplier to become available is not allowed to
 	 * probe.
 	 */
-	mutex_lock(&wfs_lock);
-	if (!list_empty(&dev->links.needs_suppliers) &&
-	    dev->links.need_for_probe) {
-		mutex_unlock(&wfs_lock);
+	mutex_lock(&fwnode_link_lock);
+	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
+	    !fw_devlink_is_permissive()) {
+		mutex_unlock(&fwnode_link_lock);
 		return -EPROBE_DEFER;
 	}
-	mutex_unlock(&wfs_lock);
+	mutex_unlock(&fwnode_link_lock);
 
 	device_links_write_lock();
 
@@ -1166,10 +1167,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	bool val;
 
 	device_lock(dev);
-	mutex_lock(&wfs_lock);
-	val = !list_empty(&dev->links.needs_suppliers)
-	      && dev->links.need_for_probe;
-	mutex_unlock(&wfs_lock);
+	val = !list_empty(&dev->fwnode->suppliers);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -2226,7 +2224,7 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
 
-	if (fw_devlink_flags && !fw_devlink_is_permissive()) {
+	if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
 		error = device_create_file(dev, &dev_attr_waiting_for_supplier);
 		if (error)
 			goto err_remove_dev_online;
-- 
2.29.1.341.ge80a0c044ae-goog

