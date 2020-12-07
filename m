Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1142D1CE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgLGWLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgLGWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:11:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B40C0611CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s30so13002744ybe.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yXXP8quBOjVl1OL9RcYZvWTz/kgt9y486O6FjVXA5xY=;
        b=tKfFhaUpHhIEcN5B0oEAXQi1YVvvtNTn5VnR3es/0Zgh8LP5+PcT2ZvOokvDcd/zjm
         e1HPTjOqBasqW1hy8QbsLfVIBX1lP5I3jneG28Q4WG/JJK9roWQpnFU8/0siY4qxGsqS
         UdJNMaSQlzAAk2JYDIDx8+Asl3Z/Hen+9ykXYXXgdWAs/pHAenrOnfqg+2neULTmPS4w
         MbOC1UJ3s9JdvsHziY3jCg/5kUnMNSD4lgNgIRFvkwb6EIFOsFnBsaWdrVE1Y+kO+1DD
         //Zz/j9FQy8BfNodeodRtGE3sBonCXdhQFqWjczlMV47xALVM46y5l7Ne27oYDMACip8
         UO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yXXP8quBOjVl1OL9RcYZvWTz/kgt9y486O6FjVXA5xY=;
        b=GYCv9E1LWl86B4qfLnpbWtzrdnUKRQ8xE7kJDzl3QxNHuETVP1N28nU4yRUFU5jNMF
         1aAmHAyE2cJS+heDdpJ8YHCE+SNZYtASoll7JIDX3T3j1/cqf+M3XeDwW8s4nOCHsUkp
         O5ijuFdbFsMW1IOJhp1iWHDN1hwQ224eaXkxwYfeppVSVXmhectdTYsQZPTvd0Gpfifs
         Kl9R38nQbrQ/7onxUrJB16J7ZvkJlsTtIviR17hZIRN0tjH2w3SiDJK5s+Cg+a9GBqlZ
         29aOFOgiszMv3rg9WAbfyosmHPusLhNrZlG0VuvAR3X8al0yVIYL2X/+DmnEcI9GpC6g
         J7GQ==
X-Gm-Message-State: AOAM5316b7Bx9bdLkLibOh6aXLUnzsHyJWso65qzx3XaL1gPZp4tv5FV
        O3Mg0ECKJMGvWYnecGUJkslS9E8ofNY=
X-Google-Smtp-Source: ABdhPJz6IzTe5gVmF8PWCCMI+lC10tI2SH2ofu361/HjN9RsmEeOFq50ryygNPV7peCXpdeCwUo4G+330mw=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:397:: with SMTP id 145mr24269777ybd.6.1607379012926;
 Mon, 07 Dec 2020 14:10:12 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:47 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 09/11] mm: fold __update_lru_size() into its sole caller
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other references to the function were removed after
commit a892cb6b977f ("mm/vmscan.c: use update_lru_size() in update_lru_sizes()")

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 7183c7a03f09..355ea1ee32bd 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -24,7 +24,7 @@ static inline int page_is_file_lru(struct page *page)
 	return !PageSwapBacked(page);
 }
 
-static __always_inline void __update_lru_size(struct lruvec *lruvec,
+static __always_inline void update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
 				int nr_pages)
 {
@@ -33,13 +33,6 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
-}
-
-static __always_inline void update_lru_size(struct lruvec *lruvec,
-				enum lru_list lru, enum zone_type zid,
-				int nr_pages)
-{
-	__update_lru_size(lruvec, lru, zid, nr_pages);
 #ifdef CONFIG_MEMCG
 	mem_cgroup_update_lru_size(lruvec, lru, zid, nr_pages);
 #endif
-- 
2.29.2.576.ga3fc446d84-goog

