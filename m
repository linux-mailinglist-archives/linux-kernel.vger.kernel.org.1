Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DD1B45C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDVNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 09:02:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:36155 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVNCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:02:24 -0400
IronPort-SDR: rorQCw0q2R6v8zPX3jAvSzoe5MiZ97mNDK6v/xOdIMhVouumnX6Yb28+q77GR08eFriY86ypoA
 v95q+tcjdGWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 06:02:24 -0700
IronPort-SDR: E69Q9OB6go9Ju0MH5vHWY2mWynPEjVOJN41VEIVOvwmvh/jjyEVuo9LVCnoHcXkck9EckhAoml
 vpibX5r+Jlhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="290826895"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 06:02:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A52FA58F; Wed, 22 Apr 2020 16:02:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] stm class: Replace uuid_t with plain u8 uuid[16]
Date:   Wed, 22 Apr 2020 16:02:20 +0300
Message-Id: <20200422130220.38619-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that uuid_t use in STM code abuses UUID API. Moreover,
this type is only useful when we parse user input. Due to above
replace uuid_t with u8 uuid[16] and use uuid_t only when parse
user input.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/stm/p_sys-t.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 360b5c03df95b..04d13b3785d3b 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -76,7 +76,7 @@ enum sys_t_message_string_subtype {
 				 MIPI_SYST_SEVERITY(MAX))
 
 struct sys_t_policy_node {
-	uuid_t		uuid;
+	u8		uuid[UUID_SIZE];
 	bool		do_len;
 	unsigned long	ts_interval;
 	unsigned long	clocksync_interval;
@@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
 {
 	struct sys_t_policy_node *pn = priv;
 
-	generate_random_uuid(pn->uuid.b);
+	generate_random_uuid(pn->uuid);
 }
 
 static int sys_t_output_open(void *priv, struct stm_output *output)
@@ -120,7 +120,7 @@ static ssize_t sys_t_policy_uuid_show(struct config_item *item,
 {
 	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
 
-	return sprintf(page, "%pU\n", &pn->uuid);
+	return sprintf(page, "%pU\n", pn->uuid);
 }
 
 static ssize_t
@@ -129,13 +129,17 @@ sys_t_policy_uuid_store(struct config_item *item, const char *page,
 {
 	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
 	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
+	uuid_t uuid;
 	int ret;
 
 	mutex_lock(mutexp);
-	ret = uuid_parse(page, &pn->uuid);
+	ret = uuid_parse(page, &uuid);
 	mutex_unlock(mutexp);
+	if (ret)
+		return ret;
 
-	return ret < 0 ? ret : count;
+	export_uuid(pn->uuid, &uuid);
+	return count;
 }
 
 CONFIGFS_ATTR(sys_t_policy_, uuid);
@@ -322,7 +326,7 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 		return sz;
 
 	/* GUID */
-	sz = stm_data_write(data, m, c, false, op->node.uuid.b, UUID_SIZE);
+	sz = stm_data_write(data, m, c, false, op->node.uuid, sizeof(op->node.uuid));
 	if (sz <= 0)
 		return sz;
 
-- 
2.26.1

