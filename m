Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934E92C89E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgK3QsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgK3QsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:48:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4790C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:47:13 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id u10so269734wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDbkvSf5fNUpzUAKbQoZuPL0hUU6h4+IAc/1iPlvY2Q=;
        b=YU5iVWDb9MWT81FymG5Q3m0sDFpotiJq/4KaBmGPS5O/ZnXgDsbru4G31jBtUsFQlW
         FCXiDSCZV9zGyV6Djw4Wt1k41Xb13CAO03j55oM6QRek8wlDqbOjAFp16sHHPEpKlEEc
         NpvKf+YRwZHGCDwUSKXnN1aLpeXS2wKghOX+Ni97J/zpmPwXsls5+dvj39OXBKpws9iw
         Q6jNSe/gZCDGWz5F//T+fvQYQiGN7YdPS/m9Ie5wIvFMnagM0kWLMT5NMqwt4ZF7k3ZZ
         1oCrPQNMelSRPSpRLOd62BBKUFDFH5mdsyL1S8UntHtNd1TNtVEFhssjhCi81FyPnpSO
         ZLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDbkvSf5fNUpzUAKbQoZuPL0hUU6h4+IAc/1iPlvY2Q=;
        b=fINxYdudVAb5h9YeYDlXyttnpAAIt5LzwJAywKGKDLQ3887PS95hfbvM4WJm+omlCr
         m2BXVjFjh3r2Qdf8tHQ9v42sxNcP9AnRz8pZPEOL8aAex/jJwHwGzmLgYI058ql+ikoi
         kaIFD5lqBx+KtPQmChO/xi7pcPJXa6rslAepFD773xdo1BwO0Fgc9M30SA9Vtue1va58
         kH5oVJZzf661YslOonDO2SszQ2yYekThkb+7ECNgLBVwEvZCm8L24S4RJJ2VFv5hSqOh
         58+s6LvHBjEW4hQueyTBR/klcfwn2YzT/X7Y2C2k8+hLkWA44sGqUFISckbVa30JpnK5
         R8Lg==
X-Gm-Message-State: AOAM531hGn+2oYTt7TuE8Y1F+Gs9UVtV4AWVkhRjIuht8QlgsYf4ngml
        C0WUkcI2yG7fBM27pSNBp6G+46WsFxm2PA==
X-Google-Smtp-Source: ABdhPJxZ8Wk2EWZ2QW3TklsbNKkoh5+7d/IP7pxojp81fNbkQDHnS8w5Qwu/ivzzUV3USaLYgzHrfg==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr13662372wmq.1.1606754832489;
        Mon, 30 Nov 2020 08:47:12 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b4sm8400805wrr.30.2020.11.30.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:47:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/4] configfs: use BIT() for internal flags
Date:   Mon, 30 Nov 2020 17:47:02 +0100
Message-Id: <20201130164704.22991-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201130164704.22991-1-brgl@bgdev.pl>
References: <20201130164704.22991-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

For better readability and maintenance: use the BIT() macro for flag
definitions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 fs/configfs/configfs_internal.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 22dce2d35a4b..855f00868654 100644
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
+#define CONFIGFS_ROOT			BIT(0)
+#define CONFIGFS_DIR			BIT(1)
+#define CONFIGFS_ITEM_ATTR		BIT(2)
+#define CONFIGFS_ITEM_BIN_ATTR		BIT(3)
+#define CONFIGFS_ITEM_LINK		BIT(5)
+#define CONFIGFS_USET_DIR		BIT(6)
+#define CONFIGFS_USET_DEFAULT		BIT(7)
+#define CONFIGFS_USET_DROPPING		BIT(8)
+#define CONFIGFS_USET_IN_MKDIR		BIT(9)
+#define CONFIGFS_USET_CREATING		BIT(10)
 #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR | CONFIGFS_ITEM_BIN_ATTR)
 
 extern struct mutex configfs_symlink_mutex;
-- 
2.29.1

