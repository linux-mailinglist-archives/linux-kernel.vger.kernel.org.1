Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B82D0212
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 10:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgLFI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 03:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLFI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:58:54 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D05C0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 00:58:07 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id f14so5606892pju.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 00:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6K7q1C4aJV74LX9XzVIffEohV+cRacrmIp1D6GqZ88=;
        b=wbbdNcohGtl2TDgFPwVXnP/R+H6oQayEahb3/U42bl0C7LgjfwxjWQhZocOA7q6nF1
         FmtvtIEcyBL9V+t39mbO4lzaK3D9oTeBvtaHdFlFz5TlDEYOB9DOU0g0r52AFuZaHxwI
         rNZH7gI3CebsuonBrBQOiF4iPffZnK0CGnQx6yEn+aOC1vD6rAOzROGitnJm3cR9VnOl
         gqkZAkaKqh8+KCdEtr403lAWfvLGFsCx7aTVag6VoJpSRcIBDj5fiHqADmh6SBeDTCPy
         342drhgb5CF35xSJJ4tpvkbgw+y4UbM3sqdXlFOrxBuNhZZjGjtPYWqJpBpiUtqLJ9P7
         vLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6K7q1C4aJV74LX9XzVIffEohV+cRacrmIp1D6GqZ88=;
        b=B/l5rxyurNYHU2irGhAmguql5K8afBHzI4Z/535vkOCpZVMV7tntZc4hVtrVeMpxiI
         UO/ueYrPGXExKk7heHdzPUC9FHwa4F+G6i55YGe5lGBygQ/IdKPZZZraIfqYarZpKnaX
         hgXmB/XMQ62LlBe/OFYuMXHIqGtmHulGrQ0c/CqotWN49hd3j7NQxpfNUjAqIMnz5Ej1
         HmMyC5pgwTn3C+KE9MN4zDD5OhShC6WtxTUa5aqODAj0vCGnc2H0GK33Yi4VOnRe/Ybj
         QGdE8QXqGybjO/1czgSjK8XwB5/cuKru/Q0HtctBRyVffEW9zKWftf0X4LpSoxyUxLGy
         19jg==
X-Gm-Message-State: AOAM532DmNKL3+Hytfzr1Te6pmin7t7RMSksW6Qr5Z1MlX9wme2uytDe
        2cX3N6yNFbxQVeFUbLTLb/0gug==
X-Google-Smtp-Source: ABdhPJyfHVyh7hYzrbWUhvvlsa1DqXRvUHBK3jetmU5XqNrfzpGIhr/V2qq4qyQHKsD7jAzQVJK8mA==
X-Received: by 2002:a17:90a:4fe5:: with SMTP id q92mr11474674pjh.188.1607245087541;
        Sun, 06 Dec 2020 00:58:07 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id l8sm6915502pjq.22.2020.12.06.00.58.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:58:06 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        sfr@canb.auug.org.au, alexander.h.duyck@linux.intel.com,
        chris@chrisdown.name, laoar.shao@gmail.com,
        richard.weiyang@gmail.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: optimize per-lruvec stats counter memory usage
Date:   Sun,  6 Dec 2020 16:56:39 +0800
Message-Id: <20201206085639.12627-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
to optimize memory usage.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 6 +++++-
 mm/memcontrol.c            | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f9a496c4eac7..34cf119976b1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -92,6 +92,10 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+struct per_cpu_lruvec_stat {
+	s32 count[NR_VM_NODE_STAT_ITEMS];
+};
+
 /*
  * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
  * which have elements charged to this memcg.
@@ -111,7 +115,7 @@ struct mem_cgroup_per_node {
 	struct lruvec_stat __percpu *lruvec_stat_local;
 
 	/* Subtree VM stats (batched updates) */
-	struct lruvec_stat __percpu *lruvec_stat_cpu;
+	struct per_cpu_lruvec_stat __percpu *lruvec_stat_cpu;
 	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 49fbcf003bf5..c874ea37b05d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5184,7 +5184,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 		return 1;
 	}
 
-	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
+	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct per_cpu_lruvec_stat,
 					       GFP_KERNEL_ACCOUNT);
 	if (!pn->lruvec_stat_cpu) {
 		free_percpu(pn->lruvec_stat_local);
-- 
2.11.0

