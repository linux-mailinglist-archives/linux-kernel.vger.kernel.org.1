Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C722DDD39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgLRDRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLRDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:17:53 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD17C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:12 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id l7so776001qth.15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aGSlm6jI8HEoLIuo3eZ19ZVtzMcmMS/xVYmaLtCBxYg=;
        b=MmqrcGtqQFZFN7M/erail92z1PhayyzZ/9JeiCKtE70gqme6M/Z3pWMw0Qd0g5IuBx
         tdJmRnf+az6ZdjC4J9rF/22XaLRMXK1JgxVmj5zRZCRIXg1kcomYSbddFlGJBejDIgs9
         Jg/f8rdmdbjbsC8a9jj5mmOV1AJIHCU3Pk4AP519ys/dT63rZVqhXbE2ef8nh3qJd8vi
         ew2KgkJ5qn7C4JriAySWqIGJEA97k3wY26mzQTuuwGX6eZCJDY86spU7GStlbwJkFSNE
         p9K1jINAzV6/mZ36L2R1DsQgM0STgBD7bKD3l4p4H5sY++Cu/6GSUci8BzD4mux8tRh4
         e9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aGSlm6jI8HEoLIuo3eZ19ZVtzMcmMS/xVYmaLtCBxYg=;
        b=hBIPR+WKbEagb/6GYk83p3piEC01XMlf/88EIpL3bETneRMjUhcjzvtDlfBDbfBO9N
         UdcGymwVwnGYV/MM9Q5/X7AGxeXxqYSmN9pUdnUsofSdsfEN7x5dR3SaVLtMo5sxqs8M
         gFthRy3gMC5x/41y8R07e2Lw0BQZZ9X8oX1ZurJbOyhUUqO6aWReqS+gQ+e0wYTbYPRH
         5pyq3ShccUUtGKyNy8b3MXRMDBY2wyhIa/dJaFV0LnfpCHBD7rG5kvgJEsdB9LUxr1TZ
         1xGn99Pa/7bbf8ktFJTuA2K8SKWMH7Svz+8cFF5O5UMxxWChcBFzp/AeC8x4IEgdRJlF
         vY1g==
X-Gm-Message-State: AOAM530OCDERq9718ffD9yWFNUkdfwRmaUjjxvdMDixSvFB48u1HA56Z
        DMb0LNUfymtugIAu8agvRKfbX+FFBSqm8Hc=
X-Google-Smtp-Source: ABdhPJxdUhykJJJSbgL1/g45m1KXBh8e8ztKM7t8XUkLqZjwAEmBOhtYq1151VVcT8lQRLsJlbCPOIBu7Om8XPg=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:45a9:: with SMTP id
 y9mr2367070qvu.15.1608261431979; Thu, 17 Dec 2020 19:17:11 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:17:00 -0800
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
Message-Id: <20201218031703.3053753-3-saravanak@google.com>
Mime-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v1 2/5] driver core: Add device link support for INFERRED flag
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

This flag can never be added to a device link that already exists and
doesn't have the flag set. It can only be added when a device link is
created for the first time or it can be maintained if the device link
already has the it set.

This flag will be used for marking device links created ONLY by
inferring dependencies from data and NOT from explicit action by device
drivers/frameworks.  This will be useful in the future when we need to
deal with cycles in dependencies inferred from firmware.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 15 +++++++++++----
 include/linux/device.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fe8601197b84..5827dbff7f21 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -229,7 +229,8 @@ int device_is_dependent(struct device *dev, void *target)
 		return ret;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (link->flags == (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if ((link->flags & ~DL_FLAG_INFERRED) ==
+		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
 			continue;
 
 		if (link->consumer == target)
@@ -302,7 +303,8 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 
 	device_for_each_child(dev, NULL, device_reorder_to_tail);
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (link->flags == (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if ((link->flags & ~DL_FLAG_INFERRED) ==
+		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
 			continue;
 		device_reorder_to_tail(link->consumer, NULL);
 	}
@@ -546,7 +548,8 @@ postcore_initcall(devlink_class_init);
 #define DL_MANAGED_LINK_FLAGS (DL_FLAG_AUTOREMOVE_CONSUMER | \
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER  | \
-			       DL_FLAG_SYNC_STATE_ONLY)
+			       DL_FLAG_SYNC_STATE_ONLY | \
+			       DL_FLAG_INFERRED)
 
 #define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
 			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
@@ -615,7 +618,7 @@ struct device_link *device_link_add(struct device *consumer,
 	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
 	    (flags & DL_FLAG_SYNC_STATE_ONLY &&
-	     flags != DL_FLAG_SYNC_STATE_ONLY) ||
+	     (flags & ~DL_FLAG_INFERRED) != DL_FLAG_SYNC_STATE_ONLY) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
 		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
@@ -671,6 +674,10 @@ struct device_link *device_link_add(struct device *consumer,
 		if (link->consumer != consumer)
 			continue;
 
+		if (link->flags & DL_FLAG_INFERRED &&
+		    !(flags & DL_FLAG_INFERRED))
+			link->flags &= ~DL_FLAG_INFERRED;
+
 		if (flags & DL_FLAG_PM_RUNTIME) {
 			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
 				pm_runtime_new_link(consumer);
diff --git a/include/linux/device.h b/include/linux/device.h
index 89bb8b84173e..cb5eb2e58c25 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -323,6 +323,7 @@ enum device_link_state {
  * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
  * MANAGED: The core tracks presence of supplier/consumer drivers (internal).
  * SYNC_STATE_ONLY: Link only affects sync_state() behavior.
+ * INFERRED: Inferred from data (eg: firmware) and not from driver actions.
  */
 #define DL_FLAG_STATELESS		BIT(0)
 #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
@@ -332,6 +333,7 @@ enum device_link_state {
 #define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
 #define DL_FLAG_MANAGED			BIT(6)
 #define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
+#define DL_FLAG_INFERRED		BIT(8)
 
 /**
  * enum dl_dev_state - Device driver presence tracking information.
-- 
2.29.2.684.gfbc64c5ab5-goog

