Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835AD2A8362
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgKEQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731309AbgKEQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:20:07 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:20:06 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so1002479pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92a0pEOlUy2xokOf1YuWqGl17gZaVzxLn3jpBpiTxK4=;
        b=SEoMjFsAI7JlD1WXn5pf6xi/PC4FXjxVgkdoUa2BvuQJ96sdUJCIUH88xQ/yMGg86g
         HhmCxgTwKrlXwOWfIrt9TJs755fOZSdeGEulLGROJgl5IBkGoXI4chkJCSB/IwiEummM
         HpcbJYQC3LsKYotHfE2BAmWLxcpEIJWlHQ25lKX08Eppx3k1cRpETAPpmZz/5IIyn92k
         C/ACKassAA6bxfo2BeQ6T10TVVFf/LxcEseqhtj12EQVM6cgvtRnJH1XMAkYXDorLNII
         7uJHBUszi1pIKaSexs/tZAh43PZBj0oZ3rk5PbxIAtA3Z3PdYeRkV7aiXVkrxwiPDL4S
         23gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92a0pEOlUy2xokOf1YuWqGl17gZaVzxLn3jpBpiTxK4=;
        b=HtskL0+SBEXX1s5v9xSgJIxwEK8lOwr1vzbPj29UPJ7ulXrrf4bHfjFGttrgIttMYe
         dY2fQKS7X9uoTgK824S8/YzQyvfI//L6mlZsPcLug6A3ykEdQafbOLA6q3ZPxcJ5IdO9
         T+eC34ZY485I/W8WlZ2V9bvDK0CDVlnAkX7A4JtVL1D72fxEH1YrlVarpo7mUGm4/hTJ
         S4RkN1fc7FXFQe5RrV8D64TIF2UFv49HVpZpXY/XlnhyPEQokmE71aE13UcjPTA+rBkQ
         j4ixi2mizg18KG7WRzT4MLlXFGP3jPJGz5mEB+59xz1cg32Q0Z1o3srhv94T0QvxgnAH
         7oqw==
X-Gm-Message-State: AOAM533RvORmq2MFdR78epTOAQ1uJVJzxic9QLnhqteirtY6Hjja5TWv
        rzUpU+OlxVX33d+uuSDB6KYKww==
X-Google-Smtp-Source: ABdhPJxZRkOJbvLrEv4X3oRp2YgJcOYMvl+wHSmA+wwDJuo4jd0oH8FqLkt3WCB4DjyAXGy/y+a24Q==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr3310411pjb.102.1604593205814;
        Thu, 05 Nov 2020 08:20:05 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.95])
        by smtp.gmail.com with ESMTPSA id h5sm3054841pfk.126.2020.11.05.08.19.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:20:04 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        guro@fb.com, mhocko@suse.com, laoar.shao@gmail.com,
        chris@chrisdown.name, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcontrol: fix missing wakeup polling thread
Date:   Fri,  6 Nov 2020 00:19:36 +0800
Message-Id: <20201105161936.98312-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wen poll the swap.events, we can miss being waked up when the swap
event occurs. Because we didn't notify.

Fixes: f3a53a3a1e5b ("mm, memcontrol: implement memory.swap.events")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 changelog in v2:
 - Fix problem, thanks Johannes.

 include/linux/memcontrol.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0f4dd7829fb2..4f7821be5561 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1074,12 +1074,19 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
+	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
+			  event == MEMCG_SWAP_FAIL;
+
 	atomic_long_inc(&memcg->memory_events_local[event]);
-	cgroup_file_notify(&memcg->events_local_file);
+	if (!swap_event)
+		cgroup_file_notify(&memcg->events_local_file);
 
 	do {
 		atomic_long_inc(&memcg->memory_events[event]);
-		cgroup_file_notify(&memcg->events_file);
+		if (swap_event)
+			cgroup_file_notify(&memcg->swap_events_file);
+		else
+			cgroup_file_notify(&memcg->events_file);
 
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 			break;
-- 
2.20.1

