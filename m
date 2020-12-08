Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5975C2D21FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLHEVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgLHEVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:21:39 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65922C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:20:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t7so12631126pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYYxHKy2hNUOwy6YEzcM7TOwb+Qq885tP2jcyrxWyck=;
        b=gEpUnsZWYOjoACAUsQZDmde/SEQQIOvKt+ueoQYzxcPNg33SDVHk9FF1gWVVaN6rs4
         /aPL5PPxMnaE+DPh8DMDUoxFDpMJXOYSZs/IupuC1Q/TVUZZ1023ynmZ+enC3EPTOC3n
         hj8AGMbUX4SDYfWwFpT6VNLLopbu/Zp7aV83yNWA7hJAPq/+5Jqk9mYqHCVyp0bmK/o6
         ZfaRvPqDmHVJAhILi2YKpfJizlkIQL3Y04ky1LvHktsPKsw4k92k6hh6Bxam5CkIg4c+
         LHpPGdsTcqgRmcHOKKSym3csLwmcz5qUUiSxWAB9f8fTbZmkoNgnQshKdURnH/7YkbGs
         mUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYYxHKy2hNUOwy6YEzcM7TOwb+Qq885tP2jcyrxWyck=;
        b=LH/CEcrn5qx85VLhqDAxJbLmHdGMcZt7Wnj0K7qF8DSwlc5S9BBaj+rnDX53uZ03la
         Pbsxkh/uFEyzja3w+LXGGA7vA4Dq6sExYCM6l39iHCNqkKoya1FUzF20tLPzvO6ygGij
         No1krSm+gadDcDIO9xr/HABMVHZOqQkOTtABNBYFqDBLvl6j2slkWTcRxx93OiSXPV9Q
         omRP0is6yk5bFQu9HQAVlBF0AlPKR6rNVuY0g20lEOmz5ZngbCRzxmKXU5+TAjPZ7UxX
         uSAnoPhpxiIkU5E9Wn9R8e8Gc2MO4e3Hc8wdp6GHUj93z+HOFZxr31OpbIDlBMpiofJW
         xOxw==
X-Gm-Message-State: AOAM532ciyFGCYJbGhgkkcga1O96L5cuirP7JemQkr5KYYwch2uxXfDv
        VCVf8p+3bAuOw9i+kqvkpGhMDw==
X-Google-Smtp-Source: ABdhPJx4XV3psoCYFQP0G4bYZi/2ONeVaNl9iWtUxxUXrX/TPLVKdBUrKH5so2rbiHM24rrZ0hcmDw==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr2312127pjb.232.1607401259049;
        Mon, 07 Dec 2020 20:20:59 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id mr7sm1031166pjb.31.2020.12.07.20.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:20:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 1/7] mm: memcontrol: fix NR_ANON_THPS account
Date:   Tue,  8 Dec 2020 12:18:41 +0800
Message-Id: <20201208041847.72122-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201208041847.72122-1-songmuchun@bytedance.com>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
by one rather than nr_pages.

Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b80328f52fb4..8818bf64d6fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5653,10 +5653,8 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
+				__dec_lruvec_state(from_vec, NR_ANON_THPS);
+				__inc_lruvec_state(to_vec, NR_ANON_THPS);
 			}
 
 		}
-- 
2.11.0

