Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762D2CF86C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgLEA5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgLEA5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:57:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB08C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:57:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n62so9128982ybf.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=A1Lj5wdBwhWI3/NZis+5wQtu4fgI0QHg2XLOYoA+ZsE=;
        b=rK5FtNbGTrbXsv8crucJEXOPV/qReOPYclBy+WD02NPNCuuw5oLe6P+Wz9xAmkUPPD
         iIwrWE8QtrSMSHR9w4J1sdBIoHQI2ZO5v34Xw8XMAUFEWygBJT2rnooV50NYrOAljyFH
         gfTmCelZkE+DSBF7gvguZVAdc6sujGMBs25l3UmKHI8VgoxTjVEZtEHCL/Uel0XpL+Yn
         xk4Fvm1lU+YPPUEx+uXFidDFB69mwfxwTUrtfqaQGZXuygQ3dVDbtHRln78x/jT73CD8
         SgBuBghOV4o/ZXfQuGz80WfDIcxXlc1CP50R3M9uQYztqAhsuXmP4u1pvYPsds7ZTZPA
         2oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=A1Lj5wdBwhWI3/NZis+5wQtu4fgI0QHg2XLOYoA+ZsE=;
        b=Rv3alzYgTA3fQ2Mvnt19uxP0Ue0wxGFHR988AROq8DihVffVsdeLez25lIyX/yQaUn
         JLUngAt1Ld9SJj1n16dyjG3VaDnz7GGQ+5hs/ulebeQjQZgtWRvfcqBPCzFnluIRwsm2
         Qf90t1/PlOh82KQT0ZZJmMy10clRssEKc9BcI7SjEyEVLicpned0z6I1cHynP0d0+kEV
         1aSgKyHqgr0PynrSW7V5OQ960WsWrhzOyG7Y73KBx1R78gkIQYc5riYZxz4DdxM+2nQ3
         IByLTb0a8lbJC8ZJtJEKJUUTeOjgx8pwb9rp6u6xOUgw/1au7Pi622yfrdimTkzc45l8
         vhCw==
X-Gm-Message-State: AOAM532M7krzRvnk2+9R8k9j2bboy7A6mc48EWp3gVDLtQEM/ITgx+uu
        KxzspELSHXlcmjMi2J54i3iZZD2NVcK7GQ==
X-Google-Smtp-Source: ABdhPJxWC6wr6nJXVhJeawUoOdYJCvQp3PG0vNPu9Uinib12RLi2quurO+thENLVMhq8ulgNd1vh5L4lge37RA==
Sender: "tstrudel via sendgmr" <tstrudel@legoland2.mtv.corp.google.com>
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:fd20])
 (user=tstrudel job=sendgmr) by 2002:a25:16c4:: with SMTP id
 187mr8772467ybw.39.1607129844956; Fri, 04 Dec 2020 16:57:24 -0800 (PST)
Date:   Fri,  4 Dec 2020 16:57:16 -0800
Message-Id: <20201205005716.307137-1-tstrudel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v3] PM: domains: create debugfs nodes when adding power domains
From:   Thierry Strudel <tstrudel@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Strudel <tstrudel@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs nodes were created in genpd_debug_init alled in late_initcall
preventing power domains registered though loadable modules to have
a debugfs entry.

Create/remove debugfs nodes when the power domain is added/removed
to/from the internal gpd_list.

Signed-off-by: Thierry Strudel <tstrudel@google.com>
---
v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
v3: remove extra trailing char added by mistake in v2 - kernel test robot 
 drivers/base/power/domain.c | 83 ++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 743268996336..3e40ef5cd9ab 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -24,6 +24,16 @@
 
 #include "power.h"
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+static struct dentry *genpd_debugfs_dir;
+#endif
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -1880,6 +1890,21 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+#ifdef CONFIG_DEBUG_FS
+static void genpd_debug_add(struct generic_pm_domain *genpd);
+
+static void genpd_debug_remove(struct generic_pm_domain *genpd)
+{
+	struct dentry *d;
+
+	d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
+	debugfs_remove(d);
+}
+#else
+static void genpd_debug_add(struct generic_pm_domain *genpd) {}
+static void genpd_debug_remove(struct generic_pm_domain *genpd) {}
+#endif
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1954,6 +1979,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
+	genpd_debug_add(genpd);
 	mutex_unlock(&gpd_list_lock);
 
 	return 0;
@@ -1987,6 +2013,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 		kfree(link);
 	}
 
+	genpd_debug_remove(genpd);
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
@@ -2893,14 +2920,6 @@ core_initcall(genpd_bus_init);
 /***        debugfs support        ***/
 
 #ifdef CONFIG_DEBUG_FS
-#include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/init.h>
-#include <linux/kobject.h>
-static struct dentry *genpd_debugfs_dir;
-
 /*
  * TODO: This function is a slightly modified version of rtpm_status_show
  * from sysfs.c, so generalize it.
@@ -3177,9 +3196,34 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
 DEFINE_SHOW_ATTRIBUTE(devices);
 DEFINE_SHOW_ATTRIBUTE(perf_state);
 
-static int __init genpd_debug_init(void)
+static void genpd_debug_add(struct generic_pm_domain *genpd)
 {
 	struct dentry *d;
+
+	if (!genpd_debugfs_dir)
+		return;
+
+	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+
+	debugfs_create_file("current_state", 0444,
+			    d, genpd, &status_fops);
+	debugfs_create_file("sub_domains", 0444,
+			    d, genpd, &sub_domains_fops);
+	debugfs_create_file("idle_states", 0444,
+			    d, genpd, &idle_states_fops);
+	debugfs_create_file("active_time", 0444,
+			    d, genpd, &active_time_fops);
+	debugfs_create_file("total_idle_time", 0444,
+			    d, genpd, &total_idle_time_fops);
+	debugfs_create_file("devices", 0444,
+			    d, genpd, &devices_fops);
+	if (genpd->set_performance_state)
+		debugfs_create_file("perf_state", 0444,
+				    d, genpd, &perf_state_fops);
+}
+
+static int __init genpd_debug_init(void)
+{
 	struct generic_pm_domain *genpd;
 
 	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
@@ -3187,25 +3231,8 @@ static int __init genpd_debug_init(void)
 	debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
 			    NULL, &summary_fops);
 
-	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
-
-		debugfs_create_file("current_state", 0444,
-				d, genpd, &status_fops);
-		debugfs_create_file("sub_domains", 0444,
-				d, genpd, &sub_domains_fops);
-		debugfs_create_file("idle_states", 0444,
-				d, genpd, &idle_states_fops);
-		debugfs_create_file("active_time", 0444,
-				d, genpd, &active_time_fops);
-		debugfs_create_file("total_idle_time", 0444,
-				d, genpd, &total_idle_time_fops);
-		debugfs_create_file("devices", 0444,
-				d, genpd, &devices_fops);
-		if (genpd->set_performance_state)
-			debugfs_create_file("perf_state", 0444,
-					    d, genpd, &perf_state_fops);
-	}
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+		genpd_debug_add(genpd);
 
 	return 0;
 }
-- 
2.29.2.576.ga3fc446d84-goog

