Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38AE2BA62B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKTJaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:30:12 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42686 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgKTJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:30:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UFzA.8j_1605864606;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFzA.8j_1605864606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Nov 2020 17:30:07 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hui Su <sh_def@163.com>, Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next-akpm] mm/memcg: add missed warning in mem_cgroup_lruvec
Date:   Fri, 20 Nov 2020 17:30:03 +0800
Message-Id: <1605864603-49118-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "(mm/memcontrol:rewrite mem_cgroup_page_lruvec())" on mm tree use
mem_cgroup_lruvec to rewrite mem_cgroup_page_lruvec, but it missed a
DEBUG_VM warning as following, since we always charge a page before
return from allocation. Add back this warning is helpful:

	VM_WARN_ON_ONCE_PAGE(!memcg, page);

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Shakeel Butt <shakeelb@google.com> 
Cc: Roman Gushchin <guro@fb.com> 
Cc: Michal Hocko <mhocko@suse.com> 
Cc: Yafang Shao <laoar.shao@gmail.com> 
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com> 
Cc: Hui Su <sh_def@163.com>
Cc: Wei Yang <richard.weiyang@gmail.com> 
Cc: linux-kernel@vger.kernel.org 
---
 include/linux/memcontrol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 925b09ace986..7809020ef7bd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -618,6 +618,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 		goto out;
 	}
 
+	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-- 
2.29.GIT

