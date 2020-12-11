Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA52D7FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393384AbgLKUWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbgLKUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:22:25 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45621C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:45 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j26so7288567qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g6NOhJ3w3XRzsqZuC7ga0SKkBBZ5s5oSTRUPFdoho3o=;
        b=QIPBzIB9YCwxjTmgunmw4D66koVC14iWgJ5vMT9WKGGdO/jqIVhcL4FXyOkLjiIgwx
         2w/qGjWQFjXJd2w3pkSca+bt5aVw5jUgxXMbVac7h+DpJ83Br/D9jE82VTAkwBlT1Rmw
         3FXxFGz7ak389EY2W1/R4dmSgNKt09Q1a6FiIcYKEOvzB8dkwEHbpVZYJZo88vtsdrm4
         eUKzO1mPeGf02VF+u6ekNdjnRupaeN7zwPbY8uT52XeDZfExtvGWr9yGlBik8X9lBxN8
         g5ROSqOruM869dzTToz2XzCgs6b1DakksWvGy7bAPZAbdHwqfkT2n/zDJ6CHexwINi3p
         lTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6NOhJ3w3XRzsqZuC7ga0SKkBBZ5s5oSTRUPFdoho3o=;
        b=diONQ2AmHglUBlP1ol5+EtX/u85WC/iU5ShyoGqSqTxE0a1k1c8aambcCkXztommLC
         NhXHt0TPDYydrKXeIlt9juMzt9Yi4gaAs4Rovzh1G45OevFnJf1JzEz5uaUCn1ahQuHn
         AGQvnhCBlWXjtQmgTbEppYst4J4DSC70EodHt2F9eoD02Iv42DQBlvvMSq6mq8KZfzX0
         zs3r7xh8vNcZeEh27uAqhZd9tPBvXn2fvi5G5GH5a7CQcSGYRLseTSafCDmhiERcuDT5
         weFpgELFpDX5Jr4ak+pvQ14MZThmKwNTvAeckrySXjipvNpCdRRpp7Aw/2Kq6yXsLdx0
         cJ0g==
X-Gm-Message-State: AOAM530PE7zQ+IYzQUON1a0fKEPo8wKFrT+BPCWTPTTyuTsEj2QxpJ1h
        eeVD3lOv44zolYStHWQJTvxr0w==
X-Google-Smtp-Source: ABdhPJzZqhcqsCxmzzgOEDVNGFUk9Dt2CNmfQPAeukFqgySkrYTp9H2Ov8uq/5CM5Fj9kDUmv8+bLg==
X-Received: by 2002:aed:2ba5:: with SMTP id e34mr18349348qtd.146.1607718104558;
        Fri, 11 Dec 2020 12:21:44 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y192sm8514455qkb.12.2020.12.11.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:21:43 -0800 (PST)
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
Subject: [PATCH v3 1/6] mm/gup: don't pin migrated cma pages in movable zone
Date:   Fri, 11 Dec 2020 15:21:35 -0500
Message-Id: <20201211202140.396852-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211202140.396852-1-pasha.tatashin@soleen.com>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
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
index 0c866af5d96f..87452fcad048 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1565,7 +1565,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

