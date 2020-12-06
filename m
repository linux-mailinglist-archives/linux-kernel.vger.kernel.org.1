Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6692D02A0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgLFKSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLFKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:45 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82CC094242
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 02:18:14 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so5585245plo.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxjzCofAcULr7bnQMbpOvZCW6tNXMo722rzO5X3X+g0=;
        b=l0t429mzGcnZFwxy/27EHeyds85DHU2/SvU/cTTFIMKpTZQ13vGzScVjnNJc1Qfgdl
         tq3J8LH2Po4yAdE4Qo1uNZ9GfP2dCXBM7HpnjMHacvON/LTEfdfapf3sJCtF6f1t+m//
         Rdasl44TWp0U1bs3j6e3qWDr9Qn4cvq1JzncWvKY7tQL+4hmLSOUSIIajJobIPEmCai1
         ok61QC0poafIrVv2iaxO+AbBLSIJ7BNrJjU/r+EtWVpKKiZe8qX3AGUSS983k1LeN9AL
         G+VQSyqTH4X1j0tI7iZy9yvMHaPD1FXpVWoKPjzR3GdmseCxF/0+PH5flDA0QOufjbFW
         Swlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxjzCofAcULr7bnQMbpOvZCW6tNXMo722rzO5X3X+g0=;
        b=qH3jXm4mIilgWLgKsABVM7y7Y6GzxnMiIUq72e+gKXIIhQ+CQ9mfKLQ1Jsx61MxzOh
         YjmZcIzZ5xI/YO7L+AaKcKigXZxaL8S7zN1o53rRV8xZrmu/JZlq+8SCh10ISZ+ijaF7
         VVENIBe77E1dNlkOz8PEyQfM5exEDvoUWB7bGpXsIUNZ2eT7NZc5Rdxrs1FyI+PIDbvh
         sNVsSCzUguRPOyPJzTpRAc+Irw4Z13NFq32IEBRvFSpCZw/R0nn4Ll73GoQMjyO4TLsX
         +P/GynJDUJ29goj4U50RWTbe502UzhdZs942hPUec6KObeF0S/QA4gST9ImWx8trqYQM
         C7kg==
X-Gm-Message-State: AOAM533Z2DBNg2jmhUPpd/4ZEJ36/StrKmWdlAy9TUJ1GcyjYcu6V3V+
        Wuj/IGAixHvsFbbqx+vo8d24Bg==
X-Google-Smtp-Source: ABdhPJwhfw1qSbAuBw+1RM7qEp36SUEwopFNg3Q2irPAgag3zrJxkL8XTXGjZkVkY1IB6k2hYZijDg==
X-Received: by 2002:a17:90b:390b:: with SMTP id ob11mr11955031pjb.66.1607249893914;
        Sun, 06 Dec 2020 02:18:13 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.18.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:18:13 -0800 (PST)
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
Subject: [RESEND PATCH v2 09/12] mm: memcontrol: convert vmstat slab counters to bytes
Date:   Sun,  6 Dec 2020 18:14:48 +0800
Message-Id: <20201206101451.14706-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the global and per-node counters are stored in pages, however memcg
and lruvec counters are stored in bytes. This scheme looks weird.
So convert all vmstat slab counters to bytes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/vmstat.h | 17 ++++++++++-------
 mm/vmstat.c            | 21 ++++++++++-----------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 322dcbfcc933..fd1a3d5d4926 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -197,18 +197,26 @@ static inline
 unsigned long global_node_page_state_pages(enum node_stat_item item)
 {
 	long x = atomic_long_read(&vm_node_stat[item]);
+
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
 #endif
+	if (vmstat_item_in_bytes(item))
+		x >>= PAGE_SHIFT;
 	return x;
 }
 
 static inline unsigned long global_node_page_state(enum node_stat_item item)
 {
-	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+	long x = atomic_long_read(&vm_node_stat[item]);
 
-	return global_node_page_state_pages(item);
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
 }
 
 static inline unsigned long zone_page_state(struct zone *zone,
@@ -312,11 +320,6 @@ static inline void __mod_zone_page_state(struct zone *zone,
 static inline void __mod_node_page_state(struct pglist_data *pgdat,
 			enum node_stat_item item, int delta)
 {
-	if (vmstat_item_in_bytes(item)) {
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
 	node_page_state_add(delta, pgdat, item);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8d77ee426e22..7fb0c7cb9516 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -345,11 +345,6 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	long x;
 	long t;
 
-	if (vmstat_item_in_bytes(item)) {
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -554,11 +549,6 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 	s8 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
-	if (vmstat_item_in_bytes(item)) {
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
 	do {
 		z = 0;  /* overflow to node counters */
 
@@ -1012,19 +1002,28 @@ unsigned long node_page_state_pages(struct pglist_data *pgdat,
 				    enum node_stat_item item)
 {
 	long x = atomic_long_read(&pgdat->vm_stat[item]);
+
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
 #endif
+	if (vmstat_item_in_bytes(item))
+		x >>= PAGE_SHIFT;
 	return x;
 }
 
 unsigned long node_page_state(struct pglist_data *pgdat,
 			      enum node_stat_item item)
 {
+	long x = atomic_long_read(&pgdat->vm_stat[item]);
+
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
-	return node_page_state_pages(pgdat, item);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
 }
 #endif
 
-- 
2.11.0

