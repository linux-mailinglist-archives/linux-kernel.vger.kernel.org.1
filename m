Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A92C42CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgKYPXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgKYPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:23:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1050C061A51
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i2so2299470wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDbkvSf5fNUpzUAKbQoZuPL0hUU6h4+IAc/1iPlvY2Q=;
        b=EVv6vyrXRECc0dDkpLcW8hMx4pDplgOIZXwp2M2CePc89gdUmi7RIfpfe9uZ6ieWQB
         +lGygicFoVJ/oZzdm3jp2mv82cXUf1Yr4cqDAGW7nFug7B6qn6j5JpTMQgDybGJm+UNU
         /gpxOlEEbK165m+oHv5J7L921ygJj0W2rJEh5S37f2FOKOK9xpH2YrW/ja7a9aY4pGXw
         zEZDQI7YIvSHavDTV8FBJS9/vygAGpjvO1BPlThjFCgqTJGNL8S0gDiTk+tLj0i5fjBQ
         FaaK0RcSM/V53Az7LTHK/ODnOBGTvN4Qw9K58+fs46p3zaPIKET0sxWD+xS71ew7GooF
         muMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDbkvSf5fNUpzUAKbQoZuPL0hUU6h4+IAc/1iPlvY2Q=;
        b=n3a+8s+JvK+bReqXFDxHBpzfzu0UnmwAc+mVR1k3QyOEeWZVNkTrodie54HCy7jRzz
         d+50WXM343tyCS6OIxQCKaU1c1sq6+bpE+jbTCGg1reo3WMVBnPwD7uHZwKcCBlgCKbn
         FE2k2O4OXQYIc5BsX461zDnXU0/QML9X1u97Yrl6eDsgffArumgdw7ssuY2IDdxjB8D+
         mnWRv5m2OdkNfmxrqffXiJm8dCfRl6lw9gcbYGf6HOtozz04iCTumeUKrXreLRDWzEi8
         1lcL21xCgwWvpV4diKypLMam4fBWQqCJbM9LjD2qOxNfQ5OCvBahqt9Iq7+Jwjkf3tAq
         /4CQ==
X-Gm-Message-State: AOAM530jM41yMy7YZuZDl7fdDfbBXHULAtNDRF5FHIubjlXEVykM8Wwo
        +S29Dh2RuR/BI7VszyKMwPPiqg==
X-Google-Smtp-Source: ABdhPJyHio0KPcnrfeP0zTte66b1zT1CGVzjp1KfF/RtoHrOBFMIeq3wAiOTGyQo7PmwPi2QjMgnhg==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr4672876wrb.228.1606317818682;
        Wed, 25 Nov 2020 07:23:38 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 9sm4896731wmo.34.2020.11.25.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:23:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/4] configfs: use BIT() for internal flags
Date:   Wed, 25 Nov 2020 16:22:45 +0100
Message-Id: <20201125152247.30809-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201125152247.30809-1-brgl@bgdev.pl>
References: <20201125152247.30809-1-brgl@bgdev.pl>
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

