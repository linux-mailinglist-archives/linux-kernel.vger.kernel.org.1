Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26590261EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbgIHTy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgIHPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB59C0619C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:29:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id B60AA28CBC9
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org
Cc:     enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: [PATCH] regmap: debugfs: potentially duplicate the name string of the config
Date:   Tue,  8 Sep 2020 17:28:59 +0200
Message-Id: <20200908152859.26279-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function regmap_debugfs_init the name of the regmap_config is assigned
in a node of regmap_debugfs_early_list to be used later after regmap
is initialized. It is unknown how and when the name is allocated and freed.
Therefore the name should be copied to the node using 'kstrdup_const'.
This fixes an error
"debugfs: Directory 'dummy-' with parent 'regmap' already present!"
where the name was freed in function of_syscon_register before
it was accessed.

Fixes: a52eaeb1898bc (regmap: debugfs: Fix a boot time crash with early regmap init)
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/base/regmap/regmap-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f58baff2be0a..0845c4a2e33e 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -569,7 +569,7 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		if (!node)
 			return;
 		node->map = map;
-		node->name = name;
+		node->name = kstrdup_const(name, GFP_KERNEL);
 		mutex_lock(&regmap_debugfs_early_lock);
 		list_add(&node->link, &regmap_debugfs_early_list);
 		mutex_unlock(&regmap_debugfs_early_lock);
@@ -664,6 +664,7 @@ void regmap_debugfs_exit(struct regmap *map)
 					 link) {
 			if (node->map == map) {
 				list_del(&node->link);
+				kfree_const(node->name);
 				kfree(node);
 			}
 		}
@@ -681,6 +682,7 @@ void regmap_debugfs_initcall(void)
 	list_for_each_entry_safe(node, tmp, &regmap_debugfs_early_list, link) {
 		regmap_debugfs_init(node->map, node->name);
 		list_del(&node->link);
+		kfree_const(node->name);
 		kfree(node);
 	}
 	mutex_unlock(&regmap_debugfs_early_lock);
-- 
2.17.1

