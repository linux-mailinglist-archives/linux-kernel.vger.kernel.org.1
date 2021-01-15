Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E02F703A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbhAOBvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbhAOBvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:51:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153ECC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:51:04 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x18so3885139pln.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BIjYDm3K1KHRZmio2zuA7xfkvJuK8fsOdB0aS9Jm5uM=;
        b=oQ8Lsyq6NEzBmzSWyR0Gb3cToeR6LHZ7l1dFXKFksSWHxM+Qire3jBJ6sWnC0ykPi2
         nad+2wIobBg2tkgz2qLwXuBB7FsMbs43pOGxb1P55B0DL325JSAeHyjbi3g5K3TkFBeT
         LmqBXSyLTPF5fYz452yaYUE1KDHh28Gj4gWiAFXLoSFpryg/aDtZ1tdZe/mh7yE+WuvY
         1nQoRlzpd2/72I51vPMuHnVXjYWFb86KA8KIb+uDwmIhkTWapx2q79KbCITKElefRAjo
         diaDzKw8oaa6sCqp47lPtKHnDcoVEg8Q325L70QUyj3eLgFcQC7pT46IOydnr7+eWOUb
         OZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BIjYDm3K1KHRZmio2zuA7xfkvJuK8fsOdB0aS9Jm5uM=;
        b=D87boifrKjrvlhwQfK/futlOyU+0ApggGw29fnlY00t6BS/z0wPoJFv6AV+8TsVf3s
         yIoTwMI9+RG0nSBUEqH+zM1UTLYcgDu0VM90gLkz6bPTP6tEr0r5fnPcd8bglHUTqFTl
         /pYJJqh0UubMJJsrSAY/YNAsnZw177RZEcTXDUNSyJR28gNju+CtCcrWwIXQcBnHMJ0G
         aoxBBpqW7UO8CLzC9wAIW7mRlEjB8Fcg9CL1YD/1gXcHZNq4uaB0GeL8tF0IAsIo4bu/
         iEJK3CF9RIPTgut20MLRqIVfe5ulgTI5tGo2G0gaX+XZNdyo5dcsa1m+yJ14PFb1CTw4
         Jf1w==
X-Gm-Message-State: AOAM5324CrVXwbbfcnkokrWZJDsFs5svhmJGN1uuq/H5SdNd7XFT6UEp
        /CfRyeU1KMdlpgAZctAESd+efizG1hPScjtN
X-Google-Smtp-Source: ABdhPJxXI9+kZQGHT5rpi4YFnrbq8m4aaXKxLLzO411ujl3IAQjnivfFzz58FFAMpmaD658+zeWm7A==
X-Received: by 2002:a17:902:426:b029:db:65c4:dbf7 with SMTP id 35-20020a1709020426b02900db65c4dbf7mr10493393ple.3.1610675463623;
        Thu, 14 Jan 2021 17:51:03 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id t5sm6548354pjr.22.2021.01.14.17.51.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 17:51:03 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     rdunlap@infradead.org, yejune.deng@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: dynamic_queue_limits: use memset and offsetof init
Date:   Fri, 15 Jan 2021 09:50:53 +0800
Message-Id: <1610675453-14603-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dql_reset(), use memset and offsetof instead of '= 0'.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 lib/dynamic_queue_limits.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index fde0aa2..21f0745 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -116,13 +116,7 @@ void dql_completed(struct dql *dql, unsigned int count)
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
-	dql->num_queued = 0;
-	dql->num_completed = 0;
-	dql->last_obj_cnt = 0;
-	dql->prev_num_queued = 0;
-	dql->prev_last_obj_cnt = 0;
-	dql->prev_ovlimit = 0;
+	memset(dql, 0, offsetof(struct dql, lowest_slack));
 	dql->lowest_slack = UINT_MAX;
 	dql->slack_start_time = jiffies;
 }
-- 
1.9.1

