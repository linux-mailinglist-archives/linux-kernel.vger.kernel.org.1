Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D602726CE82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgIPWR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgIPWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 18:17:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88353C0611BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 14:42:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so8579796lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VncGTmlGJZTO0vP8zn5c6pmOsTrbLikm9gWDwOKiU5w=;
        b=W95oKDiEQYylk5s66d1puFpGBg+lWGmOEyQtPeK7ynxG6fiy+7Yg2mgZQok1qNO+2W
         elKrf5apWMTlsZXUPl10huJeY45Wi6z2QVn+LrHPz2IBJUHJoCh+94+bdX7aNTAVhu/5
         mECw6mtcwly98gZTucnhMCXGAUkIXNxg7oG6NujzL3ZnlNiGVZNp4G3tjH89qQQsLUn6
         i04d7AYaFpvORxRdb6+q/j3UMg3ywfa833DUP2ZCZvcWuKbAlHwMKhNmwRHeyHm99H9O
         UCuoXZO61UZsnx9cg5FHYR8Igy+Pt9V5R/BJDXD9l+QWm0sM8dgdX4bXFci1HD8msLH+
         +xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VncGTmlGJZTO0vP8zn5c6pmOsTrbLikm9gWDwOKiU5w=;
        b=G24/kSN8KS+IQnmpfKBwpich+ecrXA6DDM68harA5ah0VSqgpzpZ4KD+ronYr9k/7f
         oKWOEc3YPou1Qt+m9PgJzG8Rlv81wh/5xtWb8xEpmnLUWQwBCY4h+R70egQfd5GpM9iC
         8hUuxJ3lATNV4HN8j/zoeL+s9i2S7/nJySYooieyXutysyZrROhhv5gEAcJ/GiaMsv6d
         Z52n/HFo+o39eLq+cvnQorY+Upkv5knF/xk1MsbFCFg7rQcKgj4sCqq5k7w9cUb7bxdb
         DbGEJbohfWvuX6gkX2yieaPE5koMffx7nKfkzxEgUgPLyUriH6gEMBj2LZVrFQJsXgoy
         2jVA==
X-Gm-Message-State: AOAM532MzB9Jiw5MMMp51PNBxZre176r+BqacYwBev+50+518jyvzkya
        LSwpckKoLLqchQzOix6KaQp+ej/MsxBXCg==
X-Google-Smtp-Source: ABdhPJze3q2Ag0unqydwFw8KUefGFJFfPSxcdeTGFTTJbQq8KAAvyNZ40vJEFBE2yrq6jPDYkYgyLA==
X-Received: by 2002:ac2:495a:: with SMTP id o26mr9320500lfi.94.1600292523014;
        Wed, 16 Sep 2020 14:42:03 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id j28sm5153293lfk.97.2020.09.16.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 14:42:02 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/page_alloc.c: fix early params garbage value accesses
Date:   Wed, 16 Sep 2020 23:41:25 +0200
Message-Id: <20200916214125.28271-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously in '__init early_init_on_alloc' and '__init early_init_on_free'
the return values from 'kstrtobool' were not handled properly. That caused
potential garbage value read from variable 'bool_result'. Introduced patch
fixes error handling.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6b699d273d6e..112e5a63f9ca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -155,16 +155,16 @@ static int __init early_init_on_alloc(char *buf)
 	int ret;
 	bool bool_result;
 
-	if (!buf)
-		return -EINVAL;
 	ret = kstrtobool(buf, &bool_result);
+	if (ret)
+		return ret;
 	if (bool_result && page_poisoning_enabled())
 		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_alloc\n");
 	if (bool_result)
 		static_branch_enable(&init_on_alloc);
 	else
 		static_branch_disable(&init_on_alloc);
-	return ret;
+	return 0;
 }
 early_param("init_on_alloc", early_init_on_alloc);
 
@@ -173,16 +173,16 @@ static int __init early_init_on_free(char *buf)
 	int ret;
 	bool bool_result;
 
-	if (!buf)
-		return -EINVAL;
 	ret = kstrtobool(buf, &bool_result);
+	if (ret)
+		return ret;
 	if (bool_result && page_poisoning_enabled())
 		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_free\n");
 	if (bool_result)
 		static_branch_enable(&init_on_free);
 	else
 		static_branch_disable(&init_on_free);
-	return ret;
+	return 0;
 }
 early_param("init_on_free", early_init_on_free);
 
-- 
2.20.1

