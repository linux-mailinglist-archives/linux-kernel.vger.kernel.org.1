Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4C2DDD38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbgLRDRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLRDRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:17:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA98C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l8so988126ybj.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RSY5eexAmqiatBXBkzHm9BbiMeICwDAwdlFwY4m+sdE=;
        b=VHNx4abbgBK3gYhE2NZdOY+Ht9Jtu72zt/dygVNk4ZCNfJsfu9mSxBTTHvExAlNOyV
         BjMVxWzm4eOs3KNTtEbI0KX8BzOt2aIicw+A+4DPRNnLqmARawuS0IbT14feLk1aIHls
         py+9l51TjzfRjoRUaOMoeuJraSXifLaf3eUOI42AY20tTa0sIE8erc2LhKyiJyKRHfh3
         V38CLZNHxv9RVgd7SE57EjPSO84h3IyurYYU35qENdJhmCZln5BXHgzO8iQcO1rZ8sil
         pJCuPwgW/8YnI136XftokRzwXHa/WDRhoG6ufk78nIvm9zO8zLlBoWLeXR1csU8zXRJH
         UeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RSY5eexAmqiatBXBkzHm9BbiMeICwDAwdlFwY4m+sdE=;
        b=QX4+Xa+Fwo8OH0pfapvfJQHVHnKr62LSl63YY/Zcd1UETdXl03vN1ECfTeQXualtq9
         knSrwWlLPmh8aUT+qHkd0oQc+W3cc9Wm6yzYkJ6HromlN+nKMB9lOwIMQhVqV0YUTWgc
         SFsDUE4MRp6hdWuF2SMRHsvB1+pSDvW6CIA5BPrgR3f86e3p92yBv39ZgpysUYcgC2QW
         0zNhHr+9+h2FowlnXhr3/K8qwdAwpBIkRn16hYBqllTTXc7BXYX0QsTUOx9wZ4Rwn6uV
         oJYhb/HVQiQKudcQLPMRgAoA1IwFuRtirUm4uEXc3ctmp/6PI+OO+i6q+Qo4zcf8HPjI
         RRLQ==
X-Gm-Message-State: AOAM531OV04z2671awL5wETpiqRNpkU8kz01H11lJlVXN2T8Pd05wuFd
        kM83iNWX+kJKv6Ej6jZ74IqqAYv4uwWS1vc=
X-Google-Smtp-Source: ABdhPJy3LMv1OQ2UTqbdWuaAigb3CF/mFkoqAGCBsjaTsxHmDOx7gO7N3Hi2CaQVfBUfLxoqYfj2hOfo5m+y4zc=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:d753:: with SMTP id
 o80mr3166316ybg.169.1608261429370; Thu, 17 Dec 2020 19:17:09 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:16:59 -0800
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
Message-Id: <20201218031703.3053753-2-saravanak@google.com>
Mime-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v1 1/5] driver core: Add debug logs for device link related
 probe deferrals
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

There's insufficient logging when device links or fw_devlink (waiting to
create device links) cause probe deferrals.  This makes it hard to debug
devices not getting probed. So, add debug logs to make it easy to debug.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 25e08e5f40bd..fe8601197b84 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -929,6 +929,10 @@ int device_links_check_suppliers(struct device *dev)
 	mutex_lock(&fwnode_link_lock);
 	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
 	    !fw_devlink_is_permissive()) {
+		dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
+			list_first_entry(&dev->fwnode->suppliers,
+			struct fwnode_link,
+			c_hook)->supplier);
 		mutex_unlock(&fwnode_link_lock);
 		return -EPROBE_DEFER;
 	}
@@ -943,6 +947,8 @@ int device_links_check_suppliers(struct device *dev)
 		if (link->status != DL_STATE_AVAILABLE &&
 		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
 			device_links_missing_supplier(dev);
+			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
+				dev_name(link->supplier));
 			ret = -EPROBE_DEFER;
 			break;
 		}
-- 
2.29.2.684.gfbc64c5ab5-goog

