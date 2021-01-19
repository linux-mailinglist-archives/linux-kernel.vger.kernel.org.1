Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3302FB1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbhASGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbhASGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:36:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 22:35:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c22so12354321pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 22:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5t2YjjrAXHch+7Xya1g/yjAqbZsA5MpNpKfsmJhRf4=;
        b=kFyYDXH/HoKISTq0lGJTbQu68KwzA1WoUcj+zq03SxTIxjeFVzCqbMMfTtNbz1Z5k9
         Hh95YZKxP8gvVdYnuk/dCJwmi9uwCCnAQCAnkdVuUhYW9k/fQQUXdsaaAh79hHauBzIZ
         HQg69TqOHgF3iQ40pVqTzu8T8mETV9KG0eY6WcXiU8ZmqnojPFOT0FqOxRfzOVAEcecB
         F1BwPWkwvmUqyO1qjsEgIctdhtKQ1VjYV2JsFrviE2aRQQZ/Ww+ap/8Pr8QrBc1oxoE6
         5EpObs7CH9uY9Th/12LKB6irG9reJS7Nt2fQgEnqekUXJzxkgHTxSrHAmcWsqpym1xGA
         Obcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5t2YjjrAXHch+7Xya1g/yjAqbZsA5MpNpKfsmJhRf4=;
        b=KQyopVMjXiwcmBKyDxtPruL2fUjZrHfvKqdXyLs0YyraNpiP8otpftQgyVadR23MQ+
         +/XbTr9wThOLz7C8wxXwRCeIiUwsBKwIb55mOtb4jQqLobMZwfNmwRxLYO4Ji3v7eQmM
         x2DWpa8jIwQDRmpnDzMHqiyQgDqR7ur0/+gBOT/Nk1k1OGk/AKtuZfJcEuBpGe8Ba0Ql
         pzWV9l/cAFbZDpvBKXzVL1HvRDtsJhblBSiUwr12GK+JAF2GtejI8wYbeRYwa56Be34W
         YrciwzoRtCPMjXgQCFfqCtp/0aLVmtFnqYVyhL2CyNG/hRLbrbjRUgLCgKy9SfEgkXw/
         E/Bw==
X-Gm-Message-State: AOAM532Bd4gdwt+H96+vgoXYFPTfUAfWdX8h28xjKo8oGFzDjlxB8ALH
        1QCZJx6P1yEhxa2Ka1MeHvcs5A==
X-Google-Smtp-Source: ABdhPJz/3uXoF3KKJza1xEuNergpk0wDYBT20iygWGP3plOndf+LX/fnc5hewqGbptdFlh+CG1BvlA==
X-Received: by 2002:a63:2265:: with SMTP id t37mr3109575pgm.336.1611038156869;
        Mon, 18 Jan 2021 22:35:56 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id h12sm17824893pgs.7.2021.01.18.22.35.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 22:35:56 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Prepare for ->set_opp() helper to work without regulators
Date:   Tue, 19 Jan 2021 12:05:51 +0530
Message-Id: <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now the ->set_opp() helper (i.e. special implementation for
setting the OPPs for platforms) was implemented only to take care of
multiple regulators case, but going forward we would need that for other
use cases as well.

This patch prepares for that by allocating the regulator specific part
from dev_pm_opp_set_regulators() and the opp helper part from
dev_pm_opp_register_set_opp_helper().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Dmitry,

I haven't tested this patch, can you please help with that ?

 drivers/opp/core.c | 81 ++++++++++++++++++++++++----------------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b1a2296f3065..f80b6f1ca108 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1817,38 +1817,6 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
-static int _allocate_set_opp_data(struct opp_table *opp_table)
-{
-	struct dev_pm_set_opp_data *data;
-	int len, count = opp_table->regulator_count;
-
-	if (WARN_ON(!opp_table->regulators))
-		return -EINVAL;
-
-	/* space for set_opp_data */
-	len = sizeof(*data);
-
-	/* space for old_opp.supplies and new_opp.supplies */
-	len += 2 * sizeof(struct dev_pm_opp_supply) * count;
-
-	data = kzalloc(len, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->old_opp.supplies = (void *)(data + 1);
-	data->new_opp.supplies = data->old_opp.supplies + count;
-
-	opp_table->set_opp_data = data;
-
-	return 0;
-}
-
-static void _free_set_opp_data(struct opp_table *opp_table)
-{
-	kfree(opp_table->set_opp_data);
-	opp_table->set_opp_data = NULL;
-}
-
 /**
  * dev_pm_opp_set_regulators() - Set regulator names for the device
  * @dev: Device for which regulator name is being set.
@@ -1865,6 +1833,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 					    const char * const names[],
 					    unsigned int count)
 {
+	struct dev_pm_opp_supply *supplies;
+	struct dev_pm_set_opp_data *data;
 	struct opp_table *opp_table;
 	struct regulator *reg;
 	int ret, i;
@@ -1906,10 +1876,20 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 
 	opp_table->regulator_count = count;
 
-	/* Allocate block only once to pass to set_opp() routines */
-	ret = _allocate_set_opp_data(opp_table);
-	if (ret)
+	supplies = kmalloc_array(count * 2, sizeof(*supplies), GFP_KERNEL);
+	if (!supplies) {
+		ret = -ENOMEM;
 		goto free_regulators;
+	}
+
+	mutex_lock(&opp_table->lock);
+	opp_table->sod_supplies = supplies;
+	if (opp_table->set_opp_data) {
+		data = opp_table->set_opp_data;
+		data->old_opp.supplies = supplies;
+		data->new_opp.supplies = supplies + count;
+	}
+	mutex_unlock(&opp_table->lock);
 
 	return opp_table;
 
@@ -1952,9 +1932,16 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
 
-	_free_set_opp_data(opp_table);
+	mutex_lock(&opp_table->lock);
+	if (opp_table->sod_supplies) {
+		opp_table->set_opp_data->old_opp.supplies = NULL;
+		opp_table->set_opp_data->new_opp.supplies = NULL;
+	}
+	mutex_unlock(&opp_table->lock);
 
+	kfree(opp_table->sod_supplies);
 	kfree(opp_table->regulators);
+	opp_table->sod_supplies = NULL;
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
 
@@ -2046,6 +2033,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
+	struct dev_pm_set_opp_data *data;
 	struct opp_table *opp_table;
 
 	if (!set_opp)
@@ -2062,8 +2050,23 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 	}
 
 	/* Another CPU that shares the OPP table has set the helper ? */
-	if (!opp_table->set_opp)
-		opp_table->set_opp = set_opp;
+	if (opp_table->set_opp)
+		return opp_table;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&opp_table->lock);
+	opp_table->set_opp_data = data;
+	if (opp_table->sod_supplies) {
+		data->old_opp.supplies = opp_table->sod_supplies;
+		data->new_opp.supplies = opp_table->sod_supplies +
+					 opp_table->regulator_count;
+	}
+	mutex_unlock(&opp_table->lock);
+
+	opp_table->set_opp = set_opp;
 
 	return opp_table;
 }
@@ -2085,6 +2088,8 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
 	opp_table->set_opp = NULL;
+	kfree(opp_table->set_opp_data);
+	opp_table->set_opp_data = NULL;
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4ced7ffa8158..4408cfcb0f31 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -155,6 +155,7 @@ enum opp_table_access {
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
+ * @sod_supplies: Set opp data supplies
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
@@ -202,6 +203,7 @@ struct opp_table {
 	bool is_genpd;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	struct dev_pm_opp_supply *sod_supplies;
 	struct dev_pm_set_opp_data *set_opp_data;
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.25.0.rc1.19.g042ed3e048af

