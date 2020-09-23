Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80037274E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgIWBoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIWBoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:13 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:13 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id c4so2177699oou.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hLiIbAtsbfohp7c0vgT14E8MEiVASC1KIFtLz/6LR8=;
        b=FxZkeup464Y7Gv/2kVxNmm/Cnnq5mondgHVs8gR0soq3mStmLpEJBXGFkykzblGQjn
         6VeRBK+JXgM6LxT8+gxnEW7yaox0mQJ3hd+5R2pLjTo53kJqBYLF5blmL+/OzOvu3Qum
         wkAZgPUGYYxlFfQ2h4HxbKBhY81Zj+YWNk058=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hLiIbAtsbfohp7c0vgT14E8MEiVASC1KIFtLz/6LR8=;
        b=tXaQNhfJ/MgciFoozQLvQSDt55MF24vuf2hMKwCslj2dfzdDmpQppAtw6u6Osrfrdn
         e7FFuAUwcfBetVRJC2fhtOsl/FCzuAIMc2wb+OxmGqHo/n+GGC0kfP3H1hHEe2yCav8k
         Z2twDcT0SPVLj6otaddLkmoF+1eSik0Q3Tx7H/d1RHlv5LujCtKir+KPV9kN/7RKArY7
         AG4qYV9TNuPrZdloOq5j7Lo3bLbcN2rQhssBXIsvaYmtAWjMp8nbnDWV8Ptnc/OYUerO
         yikg1ZAX7uQgxtfhUiv7BhfMLImBd66fTZQ9zIMdUJUN6jYokn4X08ZBuz344yTb2mCW
         pgxg==
X-Gm-Message-State: AOAM531ZUQWYEKKSuo/JKT+eAQFkSR3JfLcbCB10ocIVmUtDavi/koK/
        IyfbLoiPKs1fXO02xaNtltPw8g==
X-Google-Smtp-Source: ABdhPJySQ0rrZLDJPi1pVZLR79uUj6ZXNqGwvTLNDbIY3O/uGSP+7/eLHUQDN83cY8AuKoceQLeviQ==
X-Received: by 2002:a4a:1dc3:: with SMTP id 186mr4925079oog.88.1600825452613;
        Tue, 22 Sep 2020 18:44:12 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:12 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/11] drivers/base/devcoredump: convert devcd_count to counter_atomic
Date:   Tue, 22 Sep 2020 19:43:33 -0600
Message-Id: <651bc1a1e1cbf5e2a1b9f60118d5c163b93eeb43.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600816121.git.skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

devcd_count is used to track dev_coredumpm device count and used in
device name string. It doesn't guard object lifetimes, device usage
counts, device open counts, and pm states. There is very little chance
of this counter overflowing. Convert it to use counter_atomic.

This conversion doesn't change the oveflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/devcoredump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e42d0b514384..d719424d1e0b 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
+#include <linux/counters.h>
 
 static struct class devcd_class;
 
@@ -255,7 +256,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 				   void *data, size_t datalen),
 		   void (*free)(void *data))
 {
-	static atomic_t devcd_count = ATOMIC_INIT(0);
+	static struct counter_atomic devcd_count = COUNTER_ATOMIC_INIT(0);
 	struct devcd_entry *devcd;
 	struct device *existing;
 
@@ -286,7 +287,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
-		     atomic_inc_return(&devcd_count));
+		     counter_atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
 	if (device_add(&devcd->devcd_dev))
-- 
2.25.1

