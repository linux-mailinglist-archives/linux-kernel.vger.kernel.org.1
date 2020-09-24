Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ECB27715E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgIXMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgIXMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E16C0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so3385790wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1jhauYGMzwdJGCGOlXszgBlcwt9/RDQUAhdcgOoilU=;
        b=WX/1+nanqrzs+kR3nlrE3toL9264Tauy4V0m1HlipYhXVawFdu94iMimmoF7e4WYIa
         TOjeZWA6theHt9BxURI69M02sD5ERL7UMQRTo22nJuFS1VQTIp4F66tneUSTMXQnl7JW
         qkldrfd+YhL7iaJchFrvteEXCkl/p+TlRX4iDVvHthRMo+a3ZUWI4JvdKbLgvF3AnKHr
         FLIL4L5RQPM+ggtXdyVlq0kFFT0bVltViyOVYpDge7RHQCLyEZDLiURpcw3c5hChokrE
         0XUrm0qPYAj4d+BaCbIAhr/mydEq8IKziztWFymInDa289BwR/EaRT2xJ9Nun6oqiYU6
         XPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1jhauYGMzwdJGCGOlXszgBlcwt9/RDQUAhdcgOoilU=;
        b=k0jWi0ZdCmsGP8ezvkXzzqPz3hx4tJliae11qDdsuVfu4UG6Q99T5sevb7ejLZVuvC
         12DHiqoMgisS5cb6o9oCGq0MKTiqzI6ikiMm/72Zqk6y7aOSe1AE0YUKqaP6pvJQw/Kg
         5g3LBGvzE39EU8V7johW9eIDMjeENkv3wYmU0tFsNfEd5SfPbc+IHFERFP+3jZQDFgcF
         1VGF/IUB6CT2X0iWQEfpj3iNv0g1Z30Vk+zOJ5SP3NzUQib9UFg3EDEp/fQYju6XnaRm
         eISZjlZ1RPgqR9z30wRztJxGsxsNFy4ub7MycXLYeNXnSqU3L9Hzg3whR+EfHAmShtyr
         dGHQ==
X-Gm-Message-State: AOAM530dYx6IYoL9W+ISviAWOds4XO+auHB0xk5Sb5SthugbPlqWYZgo
        0jizxQoZCz2xAgyb9rjTcR92Jp6tzl2HRg==
X-Google-Smtp-Source: ABdhPJwUzk8lfX3FYxsETKKF0ShBtYMgFRqFqBFE00f4JaBGkowdAYRGEAnlERdch4Z4grNf4+2BgA==
X-Received: by 2002:a1c:9ad0:: with SMTP id c199mr4635314wme.54.1600951538754;
        Thu, 24 Sep 2020 05:45:38 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/12] samples: configfs: drop unnecessary ternary operators
Date:   Thu, 24 Sep 2020 14:45:18 +0200
Message-Id: <20200924124526.17365-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checking pointers for NULL value before passing them to container_of()
is pointless because even if we return NULL from the ternary operator,
none of the users checks the returned value but they instead dereference
it unconditionally. AFAICT this cannot really happen either. Simplify
the code by removing the ternary operators from to_childless() et al.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index d3370180bcce..e339404dce1c 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -37,8 +37,8 @@ struct childless {
 
 static inline struct childless *to_childless(struct config_item *item)
 {
-	return item ? container_of(to_configfs_subsystem(to_config_group(item)),
-			struct childless, subsys) : NULL;
+	return container_of(to_configfs_subsystem(to_config_group(item)),
+			    struct childless, subsys);
 }
 
 static ssize_t childless_showme_show(struct config_item *item, char *page)
@@ -132,7 +132,7 @@ struct simple_child {
 
 static inline struct simple_child *to_simple_child(struct config_item *item)
 {
-	return item ? container_of(item, struct simple_child, item) : NULL;
+	return container_of(item, struct simple_child, item);
 }
 
 static ssize_t simple_child_storeme_show(struct config_item *item, char *page)
@@ -187,8 +187,8 @@ struct simple_children {
 
 static inline struct simple_children *to_simple_children(struct config_item *item)
 {
-	return item ? container_of(to_config_group(item),
-			struct simple_children, group) : NULL;
+	return container_of(to_config_group(item),
+			    struct simple_children, group);
 }
 
 static struct config_item *simple_children_make_item(struct config_group *group,
-- 
2.17.1

