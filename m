Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBA2FC716
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbhATBqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbhATBoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:44:25 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DBC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:38 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 19so589226qkh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=k3UV+tDJFr+BKK3SSCpump1HUAtfuWyB3vS0LsN5fFAtz4WTPM/kPfMX6f7azPyAi2
         Hy5M6t3n4O4rmylRtxe4c7sC0bV8+0OvyNP3ZZ4nLrIpmoNU4o58Zfglxs2St1XzFukH
         hsbqH769UPvhuyWV+rOOmMbI1AObZhKuZ2SCh7bwxPLN7QRrqdO7fuq5Tr4Uv8e2Id0O
         Xc+E/yROvbKWmlFHupHjdhDN1/7oMmnz1o3AUNkHOTb1MC0LQ2B88d9ClGIfu6MV9bo3
         rn4PiTCrb7/vrinyIPhnEftr0SI0zN3glm7iCVTH7vDhfmaS5WPQi4cdSa3IIvRm/hfE
         htpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=g0B0Twpj44DXlNK6H1Q0macEcLWu3dtZasJXwYACUMbgsYyU1wY+2sTgYXMrgAscW/
         cm4nIHJrz0uCgcA+nGyjDLVeKrsb+0qMiMWjKXrW7955glaMSMWwCTLd7bKrMNSJrQgf
         R/wEuCxBwUk1/NeAK+EO2Xnri8w6jxBmRwdnKZ1DJbBgbNkQExw1lM1OxV3mPG3TQBf7
         WLkZrwxb9z7RDM1bV6E4nY5Ys/CnrFsjdoi7nJytnCT17r72Xg4FuWvAGHT6+LxmDICw
         uh3uxCk7s0QNsvYvocFZrig+YTVonZPa6yZ75kEcgV0TZVPDp76h2ZqmUl4U/sLB9do4
         5CDg==
X-Gm-Message-State: AOAM533m/DrPfIpMLoW1Fyad+VihmnLudorJUDQAInx1vjqukapp77yw
        OPyqHChp5TP3vRV1KtvRasoi1Q==
X-Google-Smtp-Source: ABdhPJw/w3n1JtoHciRMldIMV+u/1mfbbFkskDr23rQOCI1lzfOX0iF0LEkdMvvV0EJt5+9QPKx29Q==
X-Received: by 2002:a37:883:: with SMTP id 125mr7628509qki.366.1611107017485;
        Tue, 19 Jan 2021 17:43:37 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a9sm391871qkk.39.2021.01.19.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:43:36 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Tue, 19 Jan 2021 20:43:20 -0500
Message-Id: <20210120014333.222547-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120014333.222547-1-pasha.tatashin@soleen.com>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order not to fragment CMA the pinned pages are migrated. However,
they are migrated to ZONE_MOVABLE, which also should not have pinned pages.

Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
is allowed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3e086b073624..24f25b1e9103 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1563,7 +1563,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

