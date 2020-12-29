Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E332E6F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgL2KXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgL2KXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:23:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAFC061798
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:22:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 3so1934175wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzBIBC0fhIl1XSSH6o1Y94mhuL4g5zkjFrYGUjls+eg=;
        b=Ds0uQx7ZUhECpHWCCLYJq8yUVRhow/BgwBwcVuJc2p3vrDfbPCmDUXEQypyPS36CIJ
         6ThtYJzwrY2LNgPt7oAKKFbHPYEn9oACDT707WdoB8p9X9dggeZB5A0rfE/kNMKdq7yb
         TSx+QzwwC4t6U9X1jlKIUByIuyomlrhdwRsgmjK2UE71+bVez0hZqIRAuk7giLIDcQgV
         oOskvsAZ9YYT9VZxYKiKEbW2vpd8/qqMjGP3NPGFn+tTi8qT9zk9sMLgVe6Hplk6bRky
         ksK2QIJYWNEov+hJBIKQ2QqyZpUhYifoYqMTWfMXHiDsLswzR+s23BI47VarF+sYTPzs
         2qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzBIBC0fhIl1XSSH6o1Y94mhuL4g5zkjFrYGUjls+eg=;
        b=io2vMLpaZYv3OzV2W0sJySmlJgTGYqn6fQlpkV1FFKJh2KXucCd6D6cSn0qV+vJ3Ga
         DiTfMuhw5MHNOkqfVcyxqY2ihltdswL1caBKxkxa/HMMtXUw9gefUvEFYpA3aCaHgUaw
         HwyPakaJR+xq+DFjsyPk+Sx7N4kmVJ5S9gtrARybaQzDsrotw3CVQsga163c1l7Hzawf
         D+bc8TxO6oAqobxEoAo6BEr6hPQpSxE2TxgiC0yqZhMVVQdj7fOn3381cDXS+6JFSo9o
         zvc3urbSRrR3/gZZgF0wSdqE6It6aaP5PoprU3fZk5/GTTx/q9CxzzrJTimwjk0YbO+L
         f9Uw==
X-Gm-Message-State: AOAM53074X5Cu7I0g9KVf1wP8dFpdnmifqoqukotD/x9kjcMqQu/uAwF
        8IhttSQIGUzN3OZAs73C79UMhQ==
X-Google-Smtp-Source: ABdhPJwDS2I4cjxlvVORuXVKARID58uvowh9NYEJwQ4GOi3TwtNPG3tsxZgelwd2S2UGBnTc0FbIdA==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr2827471wmc.139.1609237361756;
        Tue, 29 Dec 2020 02:22:41 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id h5sm61174512wrp.56.2020.12.29.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 02:22:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 2/4] configfs: use (1UL << bit) for internal flags
Date:   Tue, 29 Dec 2020 11:22:33 +0100
Message-Id: <20201229102235.29550-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201229102235.29550-1-brgl@bgdev.pl>
References: <20201229102235.29550-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

For better readability and maintenance: use the (1UL << bit) for flag
definitions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 fs/configfs/configfs_internal.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 22dce2d35a4b..2d21bba92acf 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -46,16 +46,16 @@ struct configfs_dirent {
 	struct configfs_fragment *s_frag;
 };
 
-#define CONFIGFS_ROOT		0x0001
-#define CONFIGFS_DIR		0x0002
-#define CONFIGFS_ITEM_ATTR	0x0004
-#define CONFIGFS_ITEM_BIN_ATTR	0x0008
-#define CONFIGFS_ITEM_LINK	0x0020
-#define CONFIGFS_USET_DIR	0x0040
-#define CONFIGFS_USET_DEFAULT	0x0080
-#define CONFIGFS_USET_DROPPING	0x0100
-#define CONFIGFS_USET_IN_MKDIR	0x0200
-#define CONFIGFS_USET_CREATING	0x0400
+#define CONFIGFS_ROOT			(1UL << 0)
+#define CONFIGFS_DIR			(1UL << 1)
+#define CONFIGFS_ITEM_ATTR		(1UL << 2)
+#define CONFIGFS_ITEM_BIN_ATTR		(1UL << 3)
+#define CONFIGFS_ITEM_LINK		(1UL << 5)
+#define CONFIGFS_USET_DIR		(1UL << 6)
+#define CONFIGFS_USET_DEFAULT		(1UL << 7)
+#define CONFIGFS_USET_DROPPING		(1UL << 8)
+#define CONFIGFS_USET_IN_MKDIR		(1UL << 9)
+#define CONFIGFS_USET_CREATING		(1UL << 10)
 #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR | CONFIGFS_ITEM_BIN_ATTR)
 
 extern struct mutex configfs_symlink_mutex;
-- 
2.29.1

