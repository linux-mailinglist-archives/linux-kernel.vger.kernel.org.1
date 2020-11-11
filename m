Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7A52AE862
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgKKFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:49:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:43317 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKFtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:49:11 -0500
IronPort-SDR: LUi8RJhV8hrbqbzlUGVS5Y90IGT5gWsxEdXFIC42kkUoR2AjVIOGSPE61r7NabxQTe8eOx9RpZ
 FPWDFoFXkIWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="234263653"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="234263653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:49:08 -0800
IronPort-SDR: OWzgtDSwc83Sx2x0TyK831KhNCjvBKLd8K/TSF5eg6lkvgJRfiFlD5SJWGjJ+XrmkWdCxdOF34
 d1cJFueasE+g==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308336366"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:49:05 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/4][RFC] PM: sleep: export device_pm_remove() for driver use
Date:   Wed, 11 Nov 2020 13:51:33 +0800
Message-Id: <a0ed34e3486583770c6d0ee043a3ba9d7b08f504.1605073208.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export device_pm_remove() and move the declaration of device_pm_remove()
into generic power header file so that the drivers could use this interface
to disable power management on that device.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/main.c  |  1 +
 drivers/base/power/power.h |  8 --------
 include/linux/pm.h         | 12 ++++++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c7ac49042cee..4693da9d7d80 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -164,6 +164,7 @@ void device_pm_remove(struct device *dev)
 	pm_runtime_remove(dev);
 	device_pm_check_callbacks(dev);
 }
+EXPORT_SYMBOL_GPL(device_pm_remove);
 
 /**
  * device_pm_move_before - Move device in the PM core's list of active devices.
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808..8c2e45f3e5a9 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -20,7 +20,6 @@ static inline void pm_runtime_early_init(struct device *dev)
 
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_reinit(struct device *dev);
-extern void pm_runtime_remove(struct device *dev);
 extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
@@ -85,7 +84,6 @@ static inline void pm_runtime_early_init(struct device *dev)
 
 static inline void pm_runtime_init(struct device *dev) {}
 static inline void pm_runtime_reinit(struct device *dev) {}
-static inline void pm_runtime_remove(struct device *dev) {}
 
 static inline int dpm_sysfs_add(struct device *dev) { return 0; }
 static inline void dpm_sysfs_remove(struct device *dev) {}
@@ -109,7 +107,6 @@ static inline struct device *to_device(struct list_head *entry)
 
 extern void device_pm_sleep_init(struct device *dev);
 extern void device_pm_add(struct device *);
-extern void device_pm_remove(struct device *);
 extern void device_pm_move_before(struct device *, struct device *);
 extern void device_pm_move_after(struct device *, struct device *);
 extern void device_pm_move_last(struct device *);
@@ -133,11 +130,6 @@ static inline void device_pm_sleep_init(struct device *dev) {}
 
 static inline void device_pm_add(struct device *dev) {}
 
-static inline void device_pm_remove(struct device *dev)
-{
-	pm_runtime_remove(dev);
-}
-
 static inline void device_pm_move_before(struct device *deva,
 					 struct device *devb) {}
 static inline void device_pm_move_after(struct device *deva,
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 47aca6bac1d6..f9ceca6ac7ff 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -701,6 +701,11 @@ struct dev_pm_domain {
  * be able to use wakeup events to exit from runtime low-power states,
  * or from system low-power states such as standby or suspend-to-RAM.
  */
+#ifdef CONFIG_PM
+extern void pm_runtime_remove(struct device *dev);
+#else
+static inline void pm_runtime_remove(struct device *dev) {}
+#endif
 
 #ifdef CONFIG_PM_SLEEP
 extern void device_pm_lock(void);
@@ -753,6 +758,8 @@ extern void pm_generic_complete(struct device *dev);
 extern bool dev_pm_skip_resume(struct device *dev);
 extern bool dev_pm_skip_suspend(struct device *dev);
 
+extern void device_pm_remove(struct device *dev);
+
 #else /* !CONFIG_PM_SLEEP */
 
 #define device_pm_lock() do {} while (0)
@@ -774,6 +781,11 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
 {
 }
 
+static inline void device_pm_remove(struct device *dev)
+{
+	pm_runtime_remove(dev);
+}
+
 #define pm_generic_prepare		NULL
 #define pm_generic_suspend_late		NULL
 #define pm_generic_suspend_noirq	NULL
-- 
2.17.1

