Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481B42D4FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgLJAos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgLJAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:22 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29FC0617B0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:42 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id q7so1616689qvt.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vo/yLKAiBS5h7nMLASyDzuT56nkaTKWz46PdLnDqyVo=;
        b=lWcq4VQzxkaWPyNizEDNGYhGjugYHnHlB7gIkV8AVNth2RU1O8bPJqDyqXkjGelUBb
         DtuSfCf2vU3iQ2Aw2aHIB/OUhtzdIKvp9GPqGanu6vYYeLYd8uHYXfCfkRfHwbkwK0nn
         AA+lWcTiJyWmv/jcnvBHdVb8hyCNhk7oArTBfqp+Rx1gSVn6hSBDo+x8ejNat3qPP7Pw
         I0ouWxKweeSLCAuynp4EjKkntCkncxKCEJmdCf3dlExR9b+ZDCgZWGnvRPaP8NUKW7G2
         V244hehbzwIJzbQTSVR+BTFmASHF1nXUTfYoDWSs1CLrVlB3p++uRUQ/RlMTreKpyCvF
         RO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo/yLKAiBS5h7nMLASyDzuT56nkaTKWz46PdLnDqyVo=;
        b=P84890dH6fYBmMBggn5nNRm1NDspCTRL5B/XMKSsZV5p6V5R4PRlxS8IWP8lkY9+c4
         SQrC2kuTK/KZ+13l+wDHS6b35ctgbgu2wj78gzazIV7S2FtzZSUSmkgSeij0h2ccDycp
         JnDlGkpGjJvXmZXfMSYOuyM2k9tlH2OVvTmicM5IXBcWcfSgBERoJiTS71QgBf93a4Zi
         3vsJ6ca9OUQjyFk16EDJZHg8K0bEkPIIMqGm+KyFF2l6ieGAIy6Bh6CtzH6vq5nuaSxf
         2HPGm1i98odCFaXqhDugCyiVLRYFzEEhfZXiQlbmlvz/oIcqkOhLeb2UNT9/mmvAaCeF
         1ptg==
X-Gm-Message-State: AOAM531Tmk2pTXa6aeHK/t70dUtbz45+WBRQhuUPt12HVztHIJHvpLos
        /9Jp4uLnapodQM4UjIkEsujicg==
X-Google-Smtp-Source: ABdhPJydALvSGS7GDNYtKUswYkrylNumV2tLiFG9B8JTmcFkB18LgsEdm1vhHem+5qCNXzlbBRkswg==
X-Received: by 2002:a0c:e6e7:: with SMTP id m7mr6461346qvn.11.1607561021480;
        Wed, 09 Dec 2020 16:43:41 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:40 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/8] mm/gup: don't pin migrated cma pages in movable zone
Date:   Wed,  9 Dec 2020 19:43:29 -0500
Message-Id: <20201210004335.64634-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
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
index cdb8b9eeb016..3a76c005a3e2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1610,7 +1610,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

