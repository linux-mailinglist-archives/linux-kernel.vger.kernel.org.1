Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD72E2C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgLYUVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLYUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:21 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2EC061795
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:21 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d9so4560490iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zbv3GqKmFFd2Wj/K1jc9e+J1e7/J+FZ3SGIcCo4QdOw=;
        b=UUepLdFBRJpcrnwX6tWc4DKCLqkCJmJcU6bmMzVA3tb4C3bIQReKmY7E7A/yeminB6
         lghen2yBpS9XZs0yeaK77sCAdXRdey7uxC/fyCvlyZJ2+yMvjxQRmR8Fj+FUGNX8ih63
         MRSKHLaWLzYByFuwVu9Moz33m+yuE1L+FZDl1r+SZZ+KvKUTapmcCcvWAEAJExLhHxDH
         41cyR6BuZo6ALZ8ijcbjOLWpmiOriI5GW5hVJFPhxecr8L8XJ3pPkRgHsP1SqAdNXfTZ
         G/TE1lKdAW0UfP6sdSN4k8mXmacAVCvG3La/UnnAJhJzcHl/7+lD0XecwVMGxrm1HEdb
         /jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zbv3GqKmFFd2Wj/K1jc9e+J1e7/J+FZ3SGIcCo4QdOw=;
        b=XwB1xb81fwyPxSLD5n4uU4ehaTqpPi18kKIlAub3ABnxuw6OP03iaiyeslUtQAicrz
         B6LH+jmc6zMNczppwM4FjAc5RLGC6bVHBIiHaHfkCPlPEwUXvcAGB8BTyzISvrxe/xFn
         kgivPmg06ILHGDkJqWeYYDwEQTKlaqYi5IirpKICGHTU2fEZb5MsRtuRdmkOQqULK7Hw
         TJw9F7dxMfdwplkSW035liCPcxPPimSKE3dnz8Y4kqFGUtYPawucBfpj4CGvyxbXdrvq
         AWbdQjMu68PriP6zB0trsLPHRo7Q4vWkVsKDWGvMO8Rb5OzJoqhE054xLRVtKz1k+dqI
         Fpxg==
X-Gm-Message-State: AOAM531sEiqZQmHdfF2m5mDVywJWnbEGnBtLhh8PoSGqAGX5XF2QBOup
        Can1/mR3YMCj5NECfZraxQrc7V0qP4qR/Q==
X-Google-Smtp-Source: ABdhPJyIq7l8MHg6vXc2VxwliJ3HAhuA84EVWYEZLjCprNWQIdOq/8yfaSsGRG8S++lE+ORihJbapA==
X-Received: by 2002:a05:6602:142:: with SMTP id v2mr29341016iot.32.1608927620858;
        Fri, 25 Dec 2020 12:20:20 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:20 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 06/19] dyndbg: accept null site in ddebug_change
Date:   Fri, 25 Dec 2020 13:19:31 -0700
Message-Id: <20201225201944.3701590-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a debug-print that includes site info, by adding an alternate
debug message that does not.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 050c65142d9b..5422cef58130 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -232,10 +232,17 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dc->filename), dp->lineno,
-				 dt->mod_name, dc->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
+
+			if (dc)
+				v2pr_info("changed %s:%d [%s]%s =%s\n",
+					  trim_prefix(dc->filename), dp->lineno,
+					  dt->mod_name, dc->function,
+					  ddebug_describe_flags(dp->flags, &fbuf));
+			else
+				v2pr_info("changed %s:%d =%s \"%s\"\n",
+					  dt->mod_name, dp->lineno,
+					  ddebug_describe_flags(dp->flags, &fbuf),
+					  dp->format);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.29.2

