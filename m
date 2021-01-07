Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313922EC7DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 02:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAGB6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 20:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGB6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 20:58:40 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21ADC0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 17:57:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e22so4157813iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 17:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBhbyGC0ghDa64442+yUIBNNWv+lX69CZj1Vh/83Nbg=;
        b=vWu0kv5D8PyFflOwXPBKmGJk9Am5CzepUCGqUsLYHKt3JeNvPbrTLmqdnw7VwDl8cp
         6SUfqlfS8xs1iiU/XdNOOMRlK1EjD3qNZej7xdsyDCYD6Hl7G2ZDwE5mGjewC4eRNSRI
         qJGn4JmAa6smhzSUGRt3o73JOnZciSNgeIabP5n27sYHG/NGy4z1TDLO1oIGAV0ErR2J
         kO5LR1VvSnTb1tehv/hAB9ssEYR+C1fIqQZWImt2nM68eshfwQls8UMRNm+GOOptn2m5
         8oukm8yR/JUg7dWnUfqsTOWpoJCg7rII/LRaeC0NAkAsoSfgCdDvjZveyRkYhTJd3nte
         djzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBhbyGC0ghDa64442+yUIBNNWv+lX69CZj1Vh/83Nbg=;
        b=S3QF2QSkVUBUXJ7L5gfE9/BZYved1dLR7V/4DymD3Gj2dmi/JR8q1JNWpA6Gh+EqyG
         0SfmymrRyupIfuU5KEMR1XBNccLhhymuxU39VyEg65QI9flkhV/o60zPHZzTWbvjvchS
         wteYUNYvyUZPZXXbIpk0uP023ANJSmPD92ryiHe8mqRkd8quVYRkzSZ+XrkQAzI9GMfM
         RVwIUXzb5+ZDZVp30X/ZYDn44OkYaqIDtYLNSI8B5Ly+FNfP5k2rDKUTcVOP4AZvksb2
         +xZHY3sk9rHT37WJaEe9JXR9KxbESAQaqL8zLuVmzojrFrJOnSJ0/JkXPt+7BMeY26Y9
         Rzhg==
X-Gm-Message-State: AOAM531e7otkTGxM5iPStpOeN5S+MgASEnSi/kG1a6JS7MVmXioGLou1
        xsuYqQL8536PXc2d/gthYkk5T2c7z2kMQ0H9
X-Google-Smtp-Source: ABdhPJzZV02BW+zfLWrkqm4fUYdzndVazMIZ7B4PzvGMPBJ4hrsMBuPonqZejV+mn4kBR/VnoiYRSQ==
X-Received: by 2002:a6b:b7c4:: with SMTP id h187mr5067966iof.76.1609984679249;
        Wed, 06 Jan 2021 17:57:59 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id x2sm2427177ior.42.2021.01.06.17.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 17:57:58 -0800 (PST)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Cc:     jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH 1/1] sched/fair:Avoid unnecessary assignment to cfs_rq->on_list
Date:   Thu,  7 Jan 2021 09:57:26 +0800
Message-Id: <20210107015726.54362-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

Obviously, cfs_rq->on_list is already equal to 1 when cfs_rq->on_list
is assigned a value of 1, so an else branch is needed to avoid unnecessary
assignment operations.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..ef6ebd95443d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -305,8 +305,8 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 
 	if (cfs_rq->on_list)
 		return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
-
-	cfs_rq->on_list = 1;
+	else
+		cfs_rq->on_list = 1;
 
 	/*
 	 * Ensure we either appear before our parent (if already
-- 
2.18.2

