Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8250277159
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgIXMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIXMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11739C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v12so3454671wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/tFilKmHU+SH/+t3WOuqWvsfxEgDeOExybstGXOxtHM=;
        b=mq+/E5sc3ku/KS8Dl8W2uYbPJh8jFqoZt+pzkXTEy+gupH/9RNu4H9cMTM209jBrFE
         knHqUyo35EvvZZs9V8JYLfHVdU2URi7Ll+0HQvS3ofg88+8YirLa9jZ3uynsX5LaTYm5
         rldz+/rOyJU4HyByzASmiDcSzZsSusZgt4Jc3KYuP13IryoqCIC/yF/+3X+bppfWZiKJ
         xsjIprZmcD5nClQ/hr2ay5OmrREUhdWLUuS/vNIZ5srGaUHJYQKzPGvQfFsvX2nGqxyN
         w830f8q8k1OhJVp07kk5E41dyZvUPLEMSvEzv+XQrbwPDVvbhlsT30/5srtmzjXpqGxJ
         7lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/tFilKmHU+SH/+t3WOuqWvsfxEgDeOExybstGXOxtHM=;
        b=Z7/qzZf9HvVxOv8UwIg8+7vTL7PI5XPUF8s/6vk5nENeecOW03aLNX3K+jqVN4Jn1y
         n5jV1mFQCz8ZpRStHv5DXch8sjS/AE9WiFBFUNTJqh6AEEQVSiljzyqOOTPesw5X5tzX
         BkcvtPDfuJd1MtZKpXNOAa/KylfygbqPxSQGo7P7cXn/faJ55jbzmmUZhbtUeqZi4pkA
         fTySnRd8131Ngx+LBbHapphFXsAsTJnQh6ItDNubALuO5NJQ4kYPdukIEy9R5NwuEelT
         ZM1nhkzKjOiMqk/yMDGti4q2o9QRE5+4vSiYoJQWvfpe+lFZ9r6w6RQCJk+SKUBxBi4V
         qm4g==
X-Gm-Message-State: AOAM533yStU9376lqTlLyHLFulGtRoRQMxRPDQwwxtJj4z3v1FE59M8v
        +8MNa3QUsr7ch2jNAurB3LQJhA==
X-Google-Smtp-Source: ABdhPJwbsLQ9T3pXOpooN2fN3u/WJfggJFI+hjuyScQ94E+dclJiOF558BM9Zx+itXctRKV4aVURnA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr4571681wml.6.1600951542753;
        Thu, 24 Sep 2020 05:45:42 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/12] samples: configfs: replace simple_strtoul() with kstrtoint()
Date:   Thu, 24 Sep 2020 14:45:21 +0200
Message-Id: <20200924124526.17365-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

simple_strtoul() is deprecated. Use kstrtoint().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 3e6f0e0b0f72..d89a1ffea620 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -14,6 +14,7 @@
 
 #include <linux/configfs.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -61,17 +62,11 @@ static ssize_t childless_storeme_store(struct config_item *item,
 				       const char *page, size_t count)
 {
 	struct childless *childless = to_childless(item);
-	unsigned long tmp;
-	char *p = (char *) page;
-
-	tmp = simple_strtoul(p, &p, 10);
-	if (!p || (*p && (*p != '\n')))
-		return -EINVAL;
-
-	if (tmp > INT_MAX)
-		return -ERANGE;
+	int ret;
 
-	childless->storeme = tmp;
+	ret = kstrtoint(page, 10, &childless->storeme);
+	if (ret)
+		return ret;
 
 	return count;
 }
@@ -144,17 +139,11 @@ static ssize_t simple_child_storeme_store(struct config_item *item,
 					  const char *page, size_t count)
 {
 	struct simple_child *simple_child = to_simple_child(item);
-	unsigned long tmp;
-	char *p = (char *) page;
-
-	tmp = simple_strtoul(p, &p, 10);
-	if (!p || (*p && (*p != '\n')))
-		return -EINVAL;
-
-	if (tmp > INT_MAX)
-		return -ERANGE;
+	int ret;
 
-	simple_child->storeme = tmp;
+	ret = kstrtoint(page, 10, &simple_child->storeme);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.17.1

