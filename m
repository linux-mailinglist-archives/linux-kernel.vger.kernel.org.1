Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2E2E8FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 06:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbhADFEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 00:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 00:04:54 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A9C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 21:04:13 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 15so30946365oix.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 21:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=dEV0wZXe8t4cW6sTq8NdrlzUWo8syyjgpiwm3vuG8Cw=;
        b=c/F6Ym9/e/H4Pj5c5Ix6yhLWlC914Jqt6+hjcjTM1vJaXcGUv5/Ls4WJeLTuCK6l4F
         maEkoE8SKMoS4aL7RCMV/SBT6NDGhJbLcy0p6mDfLaWfAeifE2wXZfxf4tdK5eQxJQDv
         hmvsuj5JCL5Eqr0z4kCNuPl48/+AyRsmSWBGrjYcAv9NjCZBKNjXOW6NLPMPpH8hX+8R
         CF+EPz1pOg0gyzFulPim0pcLdBQeddBlKnn8yX4NjnsrRwhkz0a/Y2/mfT+yOf2ozKzd
         Cy2VqbooOgyJMGB78lEYWrf4b/jzk8M6wtLAOrxa28zHs3HDinRnFjVIVJS2CmMMQ13G
         I9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=dEV0wZXe8t4cW6sTq8NdrlzUWo8syyjgpiwm3vuG8Cw=;
        b=ShLEhOeAGCkSgpcdoKCfII5omSt5/3ZYqjK+ji0yLswceXMspCkQAW65ZUJEJlXH0m
         8tzJFU2X5SLLLm8gpZKkehYDN6jAor3I4j9s5CumB/xKyUdTLuKXr+lExq4O4tX3MV10
         pYw5Yh+HHn8CxwCzYD2sY9Ua1lQOwDD9vFPVlAMjoXOB2fv+nJQ/Zxrzo6UEKiguw2/b
         yWnDGFVQCjhhgz00ZiXPmGWz3UnG9RO+0+9CTmh/v3Sm7cCRyjEOZaGUQ49v4En9hGoo
         Lzz54nb6gI3OyF1hG8owJ+M6lWBTjpJ0RYW47Gy7n1SUhmATtT65AAFC/84AUqLZUUuZ
         DREg==
X-Gm-Message-State: AOAM530P1ZFmcLQme8EusP0PCTxdyt82N4TWit1GCA05kBOwwwJZQSof
        BN5sASIVSMDZiKELaRnznGAqaQ==
X-Google-Smtp-Source: ABdhPJwUENfJggxNQsrF/y2HWOhsCRk/hrxcIqAn6mtWboxwkSJ3JlsSCEWuqbwbiVjOjvU5W1W4hA==
X-Received: by 2002:aca:5786:: with SMTP id l128mr16891541oib.145.1609736652718;
        Sun, 03 Jan 2021 21:04:12 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d10sm9326911ooh.32.2021.01.03.21.04.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 03 Jan 2021 21:04:12 -0800 (PST)
Date:   Sun, 3 Jan 2021 21:03:58 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hui Su <sh_def@163.com>, Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
Message-ID: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
recently added to the inline mem_cgroup_page_lruvec().

An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
been careful to do so after weeding out the mem_cgroup_disabled() case;
but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
clear_pgdat_congested() and age_active_anon().

Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().

Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/memcontrol.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
+++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
@@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
 {
 	struct mem_cgroup *memcg = page_memcg(page);
 
-	VM_WARN_ON_ONCE_PAGE(!memcg, page);
+	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
 	return mem_cgroup_lruvec(memcg, pgdat);
 }
 
