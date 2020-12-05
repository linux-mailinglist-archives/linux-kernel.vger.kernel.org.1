Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054562CFC78
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgLESTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgLERzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:55:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F3C094241
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 05:02:52 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g18so5322538pgk.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CowKSBe21ybUCNZpbXy3BdqlRA0xnHhkE4QdTXQDr3k=;
        b=1E/sfXgHaC4PaGNOQGTv5UbJpGKRfVFVfNwfoMAvioxro0OeUnyGU7+KbNrPOmzCJB
         Uc+HeD8TjLwjqb5MX1YfYNo3gGGM7+9qKPJNif8ipbHCrN6r7rYKmOi8fBHe67OyeSBy
         Y1P4LecS8PHQ1OnnbNTZD/cwAKl6OFG9NvKKfrPw4bK9RC4BPsZNj48E9G7vqAjSylgL
         5pvEUV3NYJodopVNMOcvf6Kls5MhenBu7FAvV7gfzrSFhzJ2wLUsvGk6BhmB+JtCXpVw
         obRyNkYZAykzB3ugmrBdd4T4Vi3xL+S4QOJd9QNRYELJOY2AWIKE8QOyBmaBnF3al2AA
         yeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CowKSBe21ybUCNZpbXy3BdqlRA0xnHhkE4QdTXQDr3k=;
        b=SZB7BZEQy2j+82P6xyPF9Txmnczm8c0Bv6HnlKX/jympEYqSA/fKjlUcpjdtTvCsIB
         mLgVNH2nYwR/tW83M99EhxhFsC0jg3W4csI9/LA7V+q44/fA0FKGG1BeMBBYXj82g5fd
         osll5JsErnjsAwllA+abEsVPG4JRa9q/YP6M47XA3zwhRedLV1ogWohjdHaJmakQlXVv
         Eat8CA7Uo5MMdW6fJlcr8lW7Ccnauba1UmgDQZzAQ0l+LO8hm1yMSDSlmnTE6MLVvPGj
         8X/8wb8UsGogD5aXN+4kRDasn9z3wsjR2lPR7GL8epT3UbmbYCMy5yrCwBfn5HBJYNs0
         6UyA==
X-Gm-Message-State: AOAM533PFr7IK6Uua4xw4JOC2PSXn4Zuwsk5ysJWASVJC3tIA2AbyHn5
        KgBRf5MdNw9JLrLBvbUpR+ukow==
X-Google-Smtp-Source: ABdhPJx+y6G4rm2gt0gKnr+PKMwRmh0AURFtJ3VRUjZceruiOVQhaXh+OwSXp+cpSpnljOk2jlgDNQ==
X-Received: by 2002:a63:2202:: with SMTP id i2mr11434673pgi.63.1607173371732;
        Sat, 05 Dec 2020 05:02:51 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:02:51 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/9] mm: vmstat: fix stat_threshold for NR_KERNEL_STACK_KB
Date:   Sat,  5 Dec 2020 21:02:16 +0800
Message-Id: <20201205130224.81607-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel stack is being accounted in KiB not page, so the
stat_threshold should also adjust to byte.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/vmstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8d77ee426e22..f7857a7052e4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -353,6 +353,8 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
+	if (unlikely(item == NR_KERNEL_STACK_KB))
+		t <<= PAGE_SHIFT;
 
 	if (unlikely(abs(x) > t)) {
 		node_page_state_add(x, pgdat, item);
@@ -573,6 +575,8 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 * for all cpus in a node.
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
+		if (unlikely(item == NR_KERNEL_STACK_KB))
+			t <<= PAGE_SHIFT;
 
 		o = this_cpu_read(*p);
 		n = delta + o;
-- 
2.11.0

