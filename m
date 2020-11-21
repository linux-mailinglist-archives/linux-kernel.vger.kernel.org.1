Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC802BBC04
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKUCDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgKUCDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:03:19 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2472C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:03:18 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id r5so5150985qvr.15
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TDH6sKF+25uJe3sYo1DkxQ2WsvdJDRIVI/Vx11qvHv0=;
        b=CRhGb2ssFoN8jV9EKkRfvLzAyT6vs0pAPoP3mlKKlfYL8xfFLIGkhUDuQS7xxtgbym
         N6/C1nnKo2saz/AAZpqUmzqximqL94cyCamjx8A6LvmQqYh6DhIkSveqAFRFwJhaNGIS
         dAwX7NRQd4MzarcH1nQ4zLVN4NpiWj8VTe/Qn2ArYNnLkwvnNreUGNmU52gEbt2c3Hu/
         Qq2sWaXZr7nBByFFHlUjRhb/fRmMFeImX9ez71sBAiQlULSGW/3fDUGcuWdeZruFXPYX
         KEEJZ/5S3aZInGZtCBB58vZV4/osfC7OrwljZ1WSEyfLr3lEOPzjEFOY/nYMX0Lk4cz2
         eTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TDH6sKF+25uJe3sYo1DkxQ2WsvdJDRIVI/Vx11qvHv0=;
        b=C/d7fehRSVqex01JUjG+i8kab7HWtfJBaJXpZ4YBiDiF0uibuMB0Sq+tVWo/GqAmRY
         wb7zhbTAH0BRoFesQXrPuqLKe/9nwV+7iKPnrG9snO3lm02zws9NYs4wIVtyWseb30N9
         bwiMVzHxutqJ2DqLiEgCs9yrWPJAJXE4P+FFDP1bawAGnLYJGIiu1v72EiYmQQ4pZGrG
         duYIAkMCysOoy/lii+VNuo4vTBAapp3kYYtjqg7q8IyoL2DFBHVGtT6eXaal1wqpgEPd
         aSJHbDiAy6O34QcHoEh+qSrUdSWXgwKx/vu/7ZQ9kK9Rjr34vTcb3nY3jmmBQZgAg9gk
         vFcw==
X-Gm-Message-State: AOAM530TfHzDYieziuzRRESJdomSLam5CM/xOcpkaz4UM+A4AHbP1wh8
        suxXJ78ur8veiPwTd0tv50c2fLvlGxyVg2Y=
X-Google-Smtp-Source: ABdhPJx51C0SU2lAydPfKuJ16S1v5AwFANmnRet4R5tmtjmVrjb7V9OqzMmQprV4NxbyZQlfBM442vd1HdoXKYE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:c78e:: with SMTP id
 k14mr19214638qvj.5.1605924197961; Fri, 20 Nov 2020 18:03:17 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:28 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-14-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 13/17] driver core: Use device's fwnode to check if it is
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
index 395dece1c83a..1873cecb0cc4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
+static bool fw_devlink_is_permissive(void);
 
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
@@ -995,13 +996,13 @@ int device_links_check_suppliers(struct device *dev)
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
 
@@ -1167,10 +1168,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
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
@@ -2202,7 +2200,7 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
 
-	if (fw_devlink_flags && !fw_devlink_is_permissive()) {
+	if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
 		error = device_create_file(dev, &dev_attr_waiting_for_supplier);
 		if (error)
 			goto err_remove_dev_online;
-- 
2.29.2.454.gaff20da3a2-goog

