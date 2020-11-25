Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ABC2C42CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgKYPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgKYPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:23:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC98C061A52
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so1781220wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7x7Rp0TwyGU3wHG6Q9tLIeUVomrTHpb9n0dn8AEf4Jc=;
        b=0Md9cfM0MOxKSUkUQxsFMHYf7S6ICmMbXjUYhUWMppj5M8qEHrSsr/4rrSFfnTXOYn
         8idXIFA0sgWL4OFj74pKEmUsdBhXQBdSmSFY1A3dRXST9/LW/rNXYxLX4xg54vasQj6L
         SBJpg47h18HjqeKx5QBuyyYJmOs4E3VBZ8dOkYtdNKCFmOKQqLfC9rnQz3h/6wejc0uv
         9AMh1pYotUZYGWdhfaDfeVYt+7nrObG7p574GvPwsjEjpPt9ibU/mtIigWw1gyJw4GF9
         EU/yj097+vfZs3v9tciVtvsiah0NNVX7uwKnwml/ijgnQwN7PJDkkspffYqQn+/52Nrg
         UpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7x7Rp0TwyGU3wHG6Q9tLIeUVomrTHpb9n0dn8AEf4Jc=;
        b=S9n30b7PVkD2G5EIc4leJaXc2GfYUyzhdXGAYh55tRBPar5wNhhEk4hN5f0YK/R0h8
         bWjvXGyYKwmpyNipeHy0MzYYIIKINZc7BAouZeTsqWa3TBBdGLysqM3YIhnpMRRbSoUm
         0oeiXyrXvI0fHO7JylJHULPYgy80hYNKNMaztr+IcrkUoNPba9H+4IYoonx7PjuMi88a
         IFW/hJPl/g6cjb+2fozFokc87hnmO2eJ36SIaY3aTLNTQx7OxNJQ7TCDmrowGfOBOGQX
         YL5T4sYUZBa7HT7P3I4eCOJ13tLNOy1mxadei47TrEfh3D4cK77t5lx+HupWjWtelGNV
         UKLg==
X-Gm-Message-State: AOAM532u9sunzp7EEaBi3aQYOsIOzPJjSMTl4ln3jehHrS3JKQnCvw1k
        4Flth7ixe+KZIUFVRrvu4XWcQA==
X-Google-Smtp-Source: ABdhPJxwoVEoidRcsj+NcShfPadYw58Zn8vRO9HcR3GNXYQzOqfwhsMQhQrK3P1vIIDCsT88EjdOmQ==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr4401421wmb.99.1606317821723;
        Wed, 25 Nov 2020 07:23:41 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 9sm4896731wmo.34.2020.11.25.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:23:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/4] samples: configfs: add a committable group
Date:   Wed, 25 Nov 2020 16:22:47 +0100
Message-Id: <20201125152247.30809-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201125152247.30809-1-brgl@bgdev.pl>
References: <20201125152247.30809-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add an example of using committable items to configfs samples. Each
config item has two attributes: read-write 'storeme' which works
similarly to other examples in this file and a read-only 'committed'
attribute which changes its value between false and true depending on
whether it's committed or not at the moment.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 150 +++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index f9008be7a8a1..08fc22c7aa55 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -315,6 +315,155 @@ static struct configfs_subsystem group_children_subsys = {
 
 /* ----------------------------------------------------------------- */
 
+/*
+ * 04-committable-children
+ *
+ * This is an example of a committable group.  It's similar to the simple
+ * children example but each config_item has an additional 'committed'
+ * attribute which is read-only and is only modified when the config_item
+ * is moved from the 'pending' to the 'live' directory.
+ */
+
+struct committable_child {
+	struct config_item item;
+	int storeme;
+	bool committed;
+};
+
+static inline struct committable_child *
+to_committable_child(struct config_item *item)
+{
+	return container_of(item, struct committable_child, item);
+}
+
+static ssize_t
+committable_child_storeme_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_committable_child(item)->storeme);
+}
+
+static ssize_t committable_child_storeme_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct committable_child *child = to_committable_child(item);
+	int ret;
+
+	ret = kstrtoint(page, 10, &child->storeme);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+CONFIGFS_ATTR(committable_child_, storeme);
+
+static ssize_t
+committable_child_committed_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%s\n",
+		to_committable_child(item)->committed ? "true" : "false");
+}
+
+CONFIGFS_ATTR_RO(committable_child_, committed);
+
+static struct configfs_attribute *committable_child_attrs[] = {
+	&committable_child_attr_storeme,
+	&committable_child_attr_committed,
+	NULL,
+};
+
+static void committable_child_release(struct config_item *item)
+{
+	kfree(to_committable_child(item));
+}
+
+static struct configfs_item_operations committable_child_item_ops = {
+	.release	= committable_child_release,
+};
+
+static const struct config_item_type committable_child_type = {
+	.ct_item_ops	= &committable_child_item_ops,
+	.ct_attrs	= committable_child_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+struct committable_children {
+	struct config_group group;
+};
+
+static struct config_item *
+committable_children_make_item(struct config_group *group, const char *name)
+{
+	struct committable_child *child;
+
+	child = kzalloc(sizeof(*child), GFP_KERNEL);
+	if (!child)
+		return ERR_PTR(-ENOMEM);
+
+	config_item_init_type_name(&child->item, name, &committable_child_type);
+
+	return &child->item;
+}
+
+static ssize_t
+committable_children_description_show(struct config_item *item, char *page)
+{
+	return sprintf(page,
+"[04-committable-children]\n"
+"\n"
+"This subsystem allows creation of committable config_items.  The subsystem\n"
+"has two subdirectories: pending and live.  New config_items can only be\n"
+"created in pending/ and they have one writable and readable attribute as\n"
+"well as a single read-only attribute.  The latter is only changed once the\n"
+"item is 'committed'.  This is done by moving the config_item (using\n"
+"rename()) to the live/ directory.  At that point even the read-write\n"
+"attributes can no longer be written to.\n");
+}
+
+CONFIGFS_ATTR_RO(committable_children_, description);
+
+static struct configfs_attribute *committable_children_attrs[] = {
+	&committable_children_attr_description,
+	NULL,
+};
+
+static int committable_children_commit_item(struct config_item *item)
+{
+	to_committable_child(item)->committed = true;
+
+	return 0;
+}
+
+static int committable_children_uncommit_item(struct config_item *item)
+{
+	to_committable_child(item)->committed = false;
+
+	return 0;
+}
+
+static struct configfs_group_operations committable_children_group_ops = {
+	.make_item	= committable_children_make_item,
+	.commit_item	= committable_children_commit_item,
+	.uncommit_item	= committable_children_uncommit_item,
+};
+
+static const struct config_item_type committable_children_type = {
+	.ct_group_ops	= &committable_children_group_ops,
+	.ct_attrs	= committable_children_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem committable_children_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "04-committable-children",
+			.ci_type = &committable_children_type,
+		},
+	},
+};
+
+/* ----------------------------------------------------------------- */
+
 /*
  * We're now done with our subsystem definitions.
  * For convenience in this module, here's a list of them all.  It
@@ -326,6 +475,7 @@ static struct configfs_subsystem *example_subsys[] = {
 	&childless_subsys.subsys,
 	&simple_children_subsys,
 	&group_children_subsys,
+	&committable_children_subsys,
 	NULL,
 };
 
-- 
2.29.1

