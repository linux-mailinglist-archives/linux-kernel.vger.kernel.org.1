Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F172DDD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgLRDR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLRDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:17:58 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774DC061285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:17 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 188so838816qkh.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ze4XOvFEhAFtlSdMcuBI7D1GQXU8R7BhKMHlV+ZR3VU=;
        b=IJ0VSIqJAtMYDY6z4BhSrAqMrmPJwjf0n0Ck25Y2cHHXvynEcITOF8IzeWnfo094m/
         MKZNXk/41epZfMoycOgGCbt+y6ICR1iLkWClH9DHaTAS3n8a4zWiyID5hPPwVwYyq6nZ
         pbNzMIfBf+J6ASoX5L/PS1rSNVVFFz2V7e9f+qGq+K27fE0cPlpN/sPvR5eXnxSlTSdA
         zV7dzvHixTf9Y0dYZagIC3sc6d/yhbAUmCT+iOP+i5pImwLWmC4mS1oBnTA6zBDOT5LL
         VnIVU3o2w9+RC8zONESvpgbzPwaawsTeRuo86zuHVJnzXtjh77YUlIJlKidYdSc8Fk1X
         dkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ze4XOvFEhAFtlSdMcuBI7D1GQXU8R7BhKMHlV+ZR3VU=;
        b=BSEmQouCcJdhIYZ/rchzYLlgF3d85NVUWDS0mYSU03YdGtsB+8LRCVAWbftHebCJrt
         TW06GPQILawW92an44J/anFfeRptl9l3DmsM1BYqr3cvgINJNDMyOIHz0ZPOZFXY3+wR
         HC1IqdKOpGlf2pjLa15NTD5d4c6qY2Z1A0n0NvdJiKLaTmnQvmqyt+gcsWv8TJLLPLbs
         drDQA/6PwYxRPN3pW7DrLBm41fkq++Dmf00piGcP6IW+SVOWEY5N4hTcGPPPf20DD+VF
         LsZDVWYWr5tmOIpWzNsokqWZI6JIMjKHjV66B3BfxbOv++wBAHbZi0lqt/5r/uZtX/OB
         zj7w==
X-Gm-Message-State: AOAM532s+kbMMszWapCQUlEhlJMJqBefyqknSj+dVxOqPLepBzsyRhw7
        3aObLnCihkQ2X1nbFaQG4nFA539S+mPpnVs=
X-Google-Smtp-Source: ABdhPJyZ01wXW6/QWZ4HMjw4Ynnfi/+UhoQQvoSwsSAhNJk96UYGbGcs7WDD9xLY7f2+tvoMj4sDALz3NHwYjWM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a05:6214:20a7:: with SMTP id
 7mr2331481qvd.59.1608261436930; Thu, 17 Dec 2020 19:17:16 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:17:02 -0800
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
Message-Id: <20201218031703.3053753-5-saravanak@google.com>
Mime-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v1 4/5] driver core: Handle cycles in device links created by fw_devlink
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, firmware can have cyclic dependencies between devices. But
one or more of those dependencies in the cycle are false dependencies
that don't affect the probing of the device.

fw_devlink can detect some of these false dependencies using logic. But
when it can't, we don't want to block probing of the devices in this
cyclic dependency.

So, instead of using normal device links for the devices in this cycle,
we need to switch to SYNC_STATE_ONLY device links between these devices.
This is so that sync_state() callback correctness is still maintained
while we allow these device to probe.

This is functionally similar to switching to fw_devlink=permissive just
for the devices in the cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1107d03aa6b3..4cc030361165 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1505,6 +1505,53 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
 		fw_devlink_parse_fwtree(child);
 }
 
+/**
+ * fw_devlink_relax_cycle - Convert cyclic links to SYNC_STATE_ONLY links
+ * @con: Device to check dependencies for.
+ * @sup: Device to check against.
+ *
+ * Check if @sup depends on @con or any device dependent on it (its child or
+ * its consumer etc).  When such a cyclic dependency is found, convert all
+ * device links created solely by fw_devlink into SYNC_STATE_ONLY device links.
+ * This is the equivalent of doing fw_devlink=permissive just between the
+ * devices in the cycle. We need to do this because, at this point, fw_devlink
+ * can't tell which of these dependencies is not a real dependency.
+ *
+ * Return 1 if a cycle is found. Otherwise, return 0.
+ */
+int fw_devlink_relax_cycle(struct device *con, void *sup)
+{
+	struct device_link *link;
+	int ret;
+
+	if (con == sup)
+		return 1;
+
+	ret = device_for_each_child(con, sup, fw_devlink_relax_cycle);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(link, &con->links.consumers, s_node) {
+		if ((link->flags & ~DL_FLAG_INFERRED) ==
+		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+			continue;
+
+		if (!fw_devlink_relax_cycle(link->consumer, sup))
+			continue;
+
+		ret = 1;
+
+		if (!(link->flags & DL_FLAG_INFERRED))
+			continue;
+
+		pm_runtime_drop_link(link);
+		link->flags = DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE;
+		dev_dbg(link->consumer, "Relaxing link with %s\n",
+			dev_name(link->supplier));
+	}
+	return ret;
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con - Consumer device for the device link
@@ -1536,8 +1583,17 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * If this fails, it is due to cycles in device links.  Just
 		 * give up on this link and treat it as invalid.
 		 */
-		if (!device_link_add(con, sup_dev, flags))
+		if (!device_link_add(con, sup_dev, flags) &&
+		    !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
+			dev_info(con, "Fixing up cyclic dependency with %s\n",
+				 dev_name(sup_dev));
+			device_links_write_lock();
+			fw_devlink_relax_cycle(con, sup_dev);
+			device_links_write_unlock();
+			device_link_add(con, sup_dev,
+					FW_DEVLINK_FLAGS_PERMISSIVE);
 			ret = -EINVAL;
+		}
 
 		goto out;
 	}
-- 
2.29.2.684.gfbc64c5ab5-goog

