Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C250D2C79FA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgK2Q24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Q24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:28:56 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4289C0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 08:28:15 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so14430816wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVmMpj1hqEAblmsM0FlTKIQm84iwL+6VPpnSTrXXJRQ=;
        b=lm5N0KlxF1pfVVTpgnYXTlRL12WzH3txR+Yx0j9t68KIilNu0TVGrvro8yk7aEfD2W
         ozKBRkdGdojWyjPP1t4DNF0xdY/ZrZKHaOjYHIzXmknIwB8sl48HAY6VtiJHGf18cUBF
         X0PMZK86i5l6ETs43l+/del1DK2sHbyC+EJGyWuenlQ8JEjVlZY7BWcgf7dJpRCC4BNK
         LNRQk+OL7kSnXy+/MDe/lFSCaWMPuw8FSrlvJhFu/Jg0lHMsZYUNk4QAEvv+DDAyuPcg
         pZvgHq4bsd+9qf/5HVo3vXGihZSzPYh7Kz5ljoGqyKlbXuwk+L/b70JTLBmNNAzUz/CH
         spjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVmMpj1hqEAblmsM0FlTKIQm84iwL+6VPpnSTrXXJRQ=;
        b=cnLfQRvkR92kUbYU+/z8LzxrCDBlG9ZAi1v3/vFzM08tKzKuNxLHXZrLNM3QgxX5lZ
         65IAgIHSdmdhfr/Amh8RDa1AcHpPlkFZ9u0iXFScKbirLZFBkp7cwLdl5o7lw83/TVAh
         euTbwxmGp7YZBBrH2ks+RBoSqL8lHakZ33FD/8IYqo38w4uSSVsAHglGIHLbyReTKyy2
         tYLvDvPj0rjAw6fuNaTy3mR6fk8D6zKgBi/Wxjp4WfBZ/f0K6SRTQC+lznfD0lwTEvTd
         0H3YF90pG/pJ84p4shmACPYLRF5XnVyNqEpV2HU4orW/GblFcPFBO19k+poqZH3jiumj
         JqFg==
X-Gm-Message-State: AOAM533VegU2k/UbhE+j9WiSAQssVr1ciICW8vg53xQWqYOMVUhiNXiO
        0Fx6rAuo2PzStHbrExymzDk=
X-Google-Smtp-Source: ABdhPJwS1UVkn2ZZQVfJ2EDRGhDSVky5GtMZhkcNZ0AmP5ebcFPTwEDKOGjc9wva0RCVqkaxjiZ0BA==
X-Received: by 2002:a1c:6008:: with SMTP id u8mr3272101wmb.173.1606667294500;
        Sun, 29 Nov 2020 08:28:14 -0800 (PST)
Received: from unjustified.home ([2a00:23c5:31b:1:320d:9008:393b:5754])
        by smtp.gmail.com with ESMTPSA id f16sm20475608wmh.7.2020.11.29.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:28:13 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm: page_alloc: refactor setup_per_zone_lowmem_reserve()
Date:   Sun, 29 Nov 2020 16:27:58 +0000
Message-Id: <20201129162758.115907-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_per_zone_lowmem_reserve() iterates through each zone setting
zone->lowmem_reserve[j] = 0 (where j is the zone's index) then
iterates backwards through all proceeding zones, setting
lower_zone->lowmem_reserve[j] = sum(managed pages of higher zones) /
lowmem_reserve_ratio[idx] for each (where idx is the lower zone's
index).

If the lower zone has no managed pages or its ratio is 0 then all of its
lowmem_reserve[] entries are effectively zeroed.

As these arrays are only assigned here and all lowmem_reserve[] entries
for index < this zone's index are implicitly assumed to be 0 (as these
are specifically output in show_free_areas() and zoneinfo_show_print()
for example) there is no need to additionally zero index == this zone's
index too. This patch avoids zeroing unnecessarily.

Rather than iterating through zones and setting lowmem_reserve[j] for
each lower zone this patch reverse the process and populates each zone's
lowmem_reserve[] values in ascending order.

This clarifies what is going on especially in the case of zero managed
pages or ratio which is now explicitly shown to clear these values.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/page_alloc.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f91df593bf71..39f92de1228f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7862,31 +7862,24 @@ static void calculate_totalreserve_pages(void)
 static void setup_per_zone_lowmem_reserve(void)
 {
 	struct pglist_data *pgdat;
-	enum zone_type j, idx;
+	enum zone_type i, j;
 
 	for_each_online_pgdat(pgdat) {
-		for (j = 0; j < MAX_NR_ZONES; j++) {
-			struct zone *zone = pgdat->node_zones + j;
-			unsigned long managed_pages = zone_managed_pages(zone);
-
-			zone->lowmem_reserve[j] = 0;
-
-			idx = j;
-			while (idx) {
-				struct zone *lower_zone;
-
-				idx--;
-				lower_zone = pgdat->node_zones + idx;
-
-				if (!sysctl_lowmem_reserve_ratio[idx] ||
-				    !zone_managed_pages(lower_zone)) {
-					lower_zone->lowmem_reserve[j] = 0;
-					continue;
+		for (i = 0; i < MAX_NR_ZONES - 1; i++) {
+			struct zone *zone = &pgdat->node_zones[i];
+			int ratio = sysctl_lowmem_reserve_ratio[i];
+			bool clear = !ratio || !zone_managed_pages(zone);
+			unsigned long managed_pages = 0;
+
+			for (j = i + 1; j < MAX_NR_ZONES; j++) {
+				if (clear) {
+					zone->lowmem_reserve[j] = 0;
 				} else {
-					lower_zone->lowmem_reserve[j] =
-						managed_pages / sysctl_lowmem_reserve_ratio[idx];
+					struct zone *upper_zone = &pgdat->node_zones[j];
+
+					managed_pages += zone_managed_pages(upper_zone);
+					zone->lowmem_reserve[j] = managed_pages / ratio;
 				}
-				managed_pages += zone_managed_pages(lower_zone);
 			}
 		}
 	}
-- 
2.29.2

