Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879262CEB90
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgLDKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbgLDKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:01:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55321C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:00:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so4683325wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzBIBC0fhIl1XSSH6o1Y94mhuL4g5zkjFrYGUjls+eg=;
        b=UhfK81r6T9nK+weRQwWhzwJJChMaZ+S11jhVz+Adkw+eZZRODntKHub1jqCB1hhcUR
         UTrxI2ieLIgDz2owl4ao+wNM7xXAzpEaK3VS5nU27dNLHp8Rth0PDJReBiaWTSmawgNv
         h5oRAJq1iIYytoFsKByp7gM+VLb1w6dZ8Mg4h/qVLKswN41X1MaFchpUHlFyxkmUXzCV
         vDh199TqpoJi9hqOHAzxDH+5FZvIGZh4b+KYskCOHA7NrlluW3uVfrpM8MtFWvRBPeFV
         HBbXpEIcWZ+FuUPwZlqp2yG94ire/6k7CkNwCyYoKZdT+s+nBEDGA6K3VdbLoYWxQr63
         YR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzBIBC0fhIl1XSSH6o1Y94mhuL4g5zkjFrYGUjls+eg=;
        b=grVPnsBscL/CxcIIzhKYSnL8+uStM2OTbrBxYXij5jdj6HyEPGpQdJlHjot9PYXU9g
         gPjtk3DhvgGsUXRYCeoO1aGPpv0j1XSw2eUkx891thM1j90S0zI8fiy9yRSb+0bk2dl9
         Y/iwFbbkbN0WNZ6nPl8ett/oX6yjKpfkp3T0ntPdDvjaVgocRUGqu79EWaSAXDSa9SBB
         AtS19oN5J5tgMIgkULcUBFtY/CE0C7g4pRwlDTLdj0KKXZTCesIJpirPtIjGEXOsAESI
         mQYA4ne9J+PIq6Rrkwn6AV3MS3YmwRq5F2kA/8PnSC34IicUkqN2ZerPGMHVaRyWYXQx
         Mkww==
X-Gm-Message-State: AOAM531h/kx8hjR+oec8lpB1cGXw25V2iTNCZ4R8lB4IHURHmlxeH+Pz
        J4A+hYgqLZc7xeyXct0LfbO0CA==
X-Google-Smtp-Source: ABdhPJyGU3rS4tBHOSqmld7d63Ox9yIFlUhT9RwCyd+siCXMPp+hBAEq1b95BzKVyHB1k5sFl2e8AA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr3931704wrp.201.1607076053085;
        Fri, 04 Dec 2020 02:00:53 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id v4sm2907436wru.12.2020.12.04.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:00:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/4] configfs: use (1UL << bit) for internal flags
Date:   Fri,  4 Dec 2020 11:00:37 +0100
Message-Id: <20201204100039.19159-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201204100039.19159-1-brgl@bgdev.pl>
References: <20201204100039.19159-1-brgl@bgdev.pl>
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

