Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4690D2BA783
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKTKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:33:23 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59969 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbgKTKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:33:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UFzFPZv_1605868399;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFzFPZv_1605868399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Nov 2020 18:33:20 +0800
Subject: Re: [PATCH next-akpm] mm/memcg: add missed warning in
 mem_cgroup_lruvec
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hui Su <sh_def@163.com>, Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1605864603-49118-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <94f17bb7-ec61-5b72-3555-fabeb5a4d73b@linux.alibaba.com>
Date:   Fri, 20 Nov 2020 18:31:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605864603-49118-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/20 ÏÂÎç5:30, Alex Shi Ð´µÀ:
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 925b09ace986..7809020ef7bd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -618,6 +618,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  		goto out;
>  	}
>  
> +	VM_WARN_ON_ONCE_PAGE(!memcg, page);

Very sorry for typo above! please use the updated patch.


From 68d69172f21f39928cf8ff204f5ff5cd62ac7776 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 20 Nov 2020 17:02:41 +0800
Subject: [PATCH] mm/memcg: add missed warning in mem_cgroup_lruvec

commit "(mm/memcontrol:rewrite mem_cgroup_page_lruvec())" on mm tree use
mem_cgroup_lruvec to rewrite mem_cgroup_page_lruvec, but it missed a
DEBUG_VM warning as following, since we always charge a page before
return from allocation. Add back this warning is helpful:

	VM_WARN_ON_ONCE(!memcg);

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
index 925b09ace986..303438822818 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -618,6 +618,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 		goto out;
 	}
 
+	VM_WARN_ON_ONCE(!memcg);
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-- 
2.29.GIT

