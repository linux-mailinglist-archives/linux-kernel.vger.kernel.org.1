Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20D32CEB8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgLDKBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:01:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7298C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:00:56 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so4744257wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7x7Rp0TwyGU3wHG6Q9tLIeUVomrTHpb9n0dn8AEf4Jc=;
        b=YQzTKjeznqR6nh+YOVr4xkXz9nA6EnppMzdyKoZa06H/pvINLvgXiWmhrRn2B9zaNR
         z6rINWv22epRN2Qdq7kATmRQGm+ESPdWScKlOFI69EMmqjCsd0Hk21Alb6jd3LioZOS0
         /4r9T+u7xY4+ESGGz/nOb5ghGC1gmp2FglmQF6KpMy2R8j0GAve81AnLotnZcjV6mQN6
         yHvPnejJGJRfhvIYEJeWQ20MKTqywdfSh0G5vtXV9DtaLFakkpuSly6FLkPO47UEq4/+
         chbwgFJy+1R+WEN+hh75/RYoloJ9Ft9o6ZyRAFUwFaIqRFTQmEcw203vtLGsNKSQdolj
         C2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7x7Rp0TwyGU3wHG6Q9tLIeUVomrTHpb9n0dn8AEf4Jc=;
        b=qpW4n9XD0alDM+vIlpXxhihj8n86C8tATZOmiCsWbwCUUlqP/Bd/qdc/x54mHV+1Lf
         WtV8kPCMikrr8MQJ3MlQ7rXwb4dYauzUQqM+Z+N/gl8VuiZFlhv3z7ZpHGIESd93tHsK
         mP8H7ERrflhjUmBtg97yVoeZzemTa3/H+IxyFq4P1bxE1C89PXv3GLzml3VrdPv/QEz4
         NF0uBsIiEfWqdbobDIZnS7eKSFjQslQRX1s+CetxVmrfMGeSTBrfs5TviTn2XOybF0wc
         UmMCizlK4oI7jsOCcvWr7pYcPtrNT5Vg5n2lVr5WvGSm0kP6pcIRzCSbduZW1VCyZ4ld
         z+3g==
X-Gm-Message-State: AOAM530rppgj2S2VzQnVU23nURa643zkFzCyQSS6vabTLubQPRu2Dj4I
        CWcq8YOMWYCas86tJiTbVUSxzni/FxUFkw==
X-Google-Smtp-Source: ABdhPJwsDu0o/j9bAwHrXCNweXvCaqsQgNjIzzVd4vrBqJW993/JE2U5QDcODxM/a0lBx1Hl81vXUA==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr4027566wrt.356.1607076055386;
        Fri, 04 Dec 2020 02:00:55 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id v4sm2907436wru.12.2020.12.04.02.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:00:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 4/4] samples: configfs: add a committable group
Date:   Fri,  4 Dec 2020 11:00:39 +0100
Message-Id: <20201204100039.19159-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201204100039.19159-1-brgl@bgdev.pl>
References: <20201204100039.19159-1-brgl@bgdev.pl>
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

