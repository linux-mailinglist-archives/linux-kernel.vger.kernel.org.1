Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941CF1EA0CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFAJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:02 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51531 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbgFAJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:01 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:18:59 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSq003135;
        Mon, 1 Jun 2020 12:18:58 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 2/8] platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
Date:   Mon,  1 Jun 2020 12:18:45 +0300
Message-Id: <20200601091851.5491-3-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601091851.5491-1-vadimp@mellanox.com>
References: <20200601091851.5491-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send "udev" event with environmental data in order to allow handling
"ENV{}" variables in "udev" rules.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 832fcf282d45..5420d5bb0e6c 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -97,13 +97,36 @@ struct mlxreg_hotplug_priv_data {
 	u8 not_asserted;
 };
 
+/* Environment variables array for udev. */
+static char *mlxreg_hotplug_udev_envp[] = { NULL, NULL };
+
+static int
+mlxreg_hotplug_udev_event_send(struct kobject *kobj,
+			       struct mlxreg_core_data *data, bool action)
+{
+	char event_str[MLXREG_CORE_LABEL_MAX_SIZE + 2];
+	char label[MLXREG_CORE_LABEL_MAX_SIZE] = { 0 };
+	int i;
+
+	mlxreg_hotplug_udev_envp[0] = event_str;
+	for (i = 0; data->label[i]; i++)
+		label[i] = toupper(data->label[i]);
+
+	if (action)
+		snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=1", label);
+	else
+		snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=0", label);
+
+	return kobject_uevent_env(kobj, KOBJ_CHANGE, mlxreg_hotplug_udev_envp);
+}
+
 static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 					struct mlxreg_core_data *data)
 {
 	struct mlxreg_core_hotplug_platform_data *pdata;
 
 	/* Notify user by sending hwmon uevent. */
-	kobject_uevent(&priv->hwmon->kobj, KOBJ_CHANGE);
+	mlxreg_hotplug_udev_event_send(&priv->hwmon->kobj, data, true);
 
 	/*
 	 * Return if adapter number is negative. It could be in case hotplug
@@ -141,7 +164,7 @@ mlxreg_hotplug_device_destroy(struct mlxreg_hotplug_priv_data *priv,
 			      struct mlxreg_core_data *data)
 {
 	/* Notify user by sending hwmon uevent. */
-	kobject_uevent(&priv->hwmon->kobj, KOBJ_CHANGE);
+	mlxreg_hotplug_udev_event_send(&priv->hwmon->kobj, data, false);
 
 	if (data->hpdev.client) {
 		i2c_unregister_device(data->hpdev.client);
-- 
2.11.0

