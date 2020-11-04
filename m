Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340292A64BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgKDM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgKDM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:57:32 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D183AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 04:57:30 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 13so17221052pfy.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 04:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCaDVnkzgwcyS8s60Oo5A0OYurNXKmUDNuMnE4qDEf0=;
        b=V3WtJcLTy/YzDxq9caP1mRIMslRig3ngoZG5RxJtLY/6eaWMvtT+6VhZ271dcndcAK
         X3HDD62zy/CqTpJ8J4bxLcmJHQ6gwzwAG4Wvk8XZCBrbsGJ6488GPLuWob6CDtMz3mQK
         LQLGtWD4uZEjMvqz0u17CLqShFvKCItbxNkiXdh0ekhqYEvIr6CMdVFZiBpAQAJU0NLK
         WM+JCslQ2wB9hytWHJEp33dJoYrY78eLP8BrLMWoMMf/uS2XDIO9ozQsMsdWy6CjQSJX
         c1TqPqKmzvjoGngU+9S8tFDzDXkOYHRUCMrvV/DaQ9XTSCXpvXOb6tRTlotwaS6uEaqK
         OyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCaDVnkzgwcyS8s60Oo5A0OYurNXKmUDNuMnE4qDEf0=;
        b=oNCifLt7tFbEikTVvLotwOnGFvI+cEEOxb70kv/mUsVdpoFEJoSWHtWewVAASEYxiW
         0fg7HSDHcI0wNRdcoUtPTmS6WZvZ/xktcEW8Kg6wTOdhmvI4IyfnwkomHITW81RSI8Wx
         5+sQ52friQRILYOUIviuCHUjlR6THoswFcALpFoCBQQujcxO152DZsg5/C9O6wlRrSd/
         z5dF8sz1qRURTG4xC1r8ppIkj133Uo1YZV3yahCKLZNFcGQe8BOTx3EJbT7uWq1HQ+h9
         dNNIenTdfDqjZUavIofFFAtmVBEsdktzynMRRoUhx8UjRmiqDOyu8tx5EfALrnRRxtIn
         hEYA==
X-Gm-Message-State: AOAM533No4GgVhtTB+babJG2r9wNf0nRmxzqud+DL+i0LzHQAlUaqIWm
        zrOFO406BO4WXwOCuGSdlRCnKg==
X-Google-Smtp-Source: ABdhPJwO0/cBGMXugqUhSTlCYj31+a2zgLzGcAL6zoXrVDtz2M2NiRy24SKLaR76OFkL1k+kY+nJXw==
X-Received: by 2002:a05:6a00:78d:b029:18b:f46:5262 with SMTP id g13-20020a056a00078db029018b0f465262mr10886287pfu.74.1604494650420;
        Wed, 04 Nov 2020 04:57:30 -0800 (PST)
Received: from Smcdef-MBP.local.net ([103.136.221.67])
        by smtp.gmail.com with ESMTPSA id e201sm2567763pfh.73.2020.11.04.04.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 04:57:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        guro@fb.com, mhocko@suse.com, laoar.shao@gmail.com,
        chris@chrisdown.name, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix missing wakeup polling thread
Date:   Wed,  4 Nov 2020 20:55:58 +0800
Message-Id: <20201104125558.49472-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wen poll the memory.swap.events, we can miss being waked up when the
swap event occurs. Because we didn't notify.

Fixes: f3a53a3a1e5b ("mm, memcontrol: implement memory.swap.events")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0f4dd7829fb2..2456cb737329 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1071,15 +1071,29 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 	rcu_read_unlock();
 }
 
+static inline bool is_swap_memory_event(enum memcg_memory_event event)
+{
+	return event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
+	       event == MEMCG_SWAP_FAIL;
+}
+
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
+	bool swap_event = is_swap_memory_event(event);
+	struct cgroup_file *cfile;
+
 	atomic_long_inc(&memcg->memory_events_local[event]);
-	cgroup_file_notify(&memcg->events_local_file);
+	if (swap_event) {
+		cfile = &memcg->swap_events_file;
+	} else {
+		cfile = &memcg->events_file;
+		cgroup_file_notify(&memcg->events_local_file);
+	}
 
 	do {
 		atomic_long_inc(&memcg->memory_events[event]);
-		cgroup_file_notify(&memcg->events_file);
+		cgroup_file_notify(cfile);
 
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 			break;
-- 
2.20.1

