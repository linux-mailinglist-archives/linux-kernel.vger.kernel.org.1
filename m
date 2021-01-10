Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3A2F073D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAJMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:42:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375EC06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g3so8081319plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaGXltvZsrp8CrKlla29akS0Y9Nr6dS/klR3W0Q0I3k=;
        b=mhH1+ONodj1jrEp44EgwTPMDpRYALjgkxKo7IAU4FLxQhOx+cQ7xJTKK4ST4aKUFRL
         ImjG14r00vwqLOEq1LtuX0K3jAyJxt+FAGBLG6xSPQWaEb0GzCchNO2AFzctpgzZ0w0N
         iCF6uzYn00XWOQ9HPQS5RLFG3MaGJRTQXR4N3ALAiP6H3G+3D749HLAXv0a7tultO+Cg
         4fhgUb1bXnGmov2qI8bEo52OmWqtCnADVZxxeSBaOD0zWwREBMFTumxjJSj63Z+nx5VD
         CtruF9wExES4ZgYpMBfxycWgp6K8d8TV0GUOwyVxdCxHSqmPeCO5CAdI1K8YLaUE/FJ4
         b3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KaGXltvZsrp8CrKlla29akS0Y9Nr6dS/klR3W0Q0I3k=;
        b=Vy+n4BQsgkcOp7C1YOr7IvKtNWlko0O46fhfuOtKdQ4KfPSogF9Fshna2RhfHUe2np
         zDQS68OL12W1bi+LAXPh060KReNy+4mjR1qWVwmQAy8V89EkYm4PE+TNQK2M+Okb8psR
         c29em58bjEQC1eMPvH5uWpbCKymEAScHgXHtJ9hWgnVZL2sYADMphnKCGolTF2QE+Lhx
         pwy+CveT1olRrz1tfHztt4P5xur9rMxTcBLwk3vXlESyVF4LEmc4Rrt43lOu0pTkv8pP
         6bv4lhhcy3vxGgoNQNI1U4/6SzPd45A2rlV3BzQCUGdofPIIQbeplu0qANjpGlbnUpvS
         kNeg==
X-Gm-Message-State: AOAM532tvk1jGt942PTrieulqaS0YgWKGh/vVwgtGjJruQdtlVLXfDfx
        9mvLvUkDa362t/hC07agpHuvYyQb5rg2teWvK/Y=
X-Google-Smtp-Source: ABdhPJwhzqxNy3uyJAZp111LPgXCrGrRbpbuCwkaaygJaHeHyHHUUioTRzwIzRdKi5SsZNGm87Hxhw==
X-Received: by 2002:a17:90a:b395:: with SMTP id e21mr12896195pjr.197.1610282488011;
        Sun, 10 Jan 2021 04:41:28 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id p9sm16176960pfq.136.2021.01.10.04.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 04:41:27 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose refcount is one
Date:   Sun, 10 Jan 2021 20:40:12 +0800
Message-Id: <20210110124017.86750-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210110124017.86750-1-songmuchun@bytedance.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the refcount is one when it is migrated, it means that the page
was freed from under us. So we are done and do not need to migrate.

This optimization is consistent with the regular pages, just like
unmap_and_move() does.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4385f2fb5d18..a6631c4eb6a6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		return -ENOSYS;
 	}
 
+	if (page_count(hpage) == 1) {
+		/* page was freed from under us. So we are done. */
+		putback_active_hugepage(hpage);
+		return MIGRATEPAGE_SUCCESS;
+	}
+
 	new_hpage = get_new_page(hpage, private);
 	if (!new_hpage)
 		return -ENOMEM;
-- 
2.11.0

