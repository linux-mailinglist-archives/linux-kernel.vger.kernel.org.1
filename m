Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F492CB47E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgLBFYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgLBFYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:19 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B4EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:39 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id f5so434222ilj.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CpKoGHvxtKgwzmlV3ZPMeHJLr+EFBiNKpVwHZEuJXQ0=;
        b=mXaAEbMD2mJMb6+nQYBLdGk8VJKAskLxfLQhyPDM8oSqX6bfHvGVqReAC/ngwpbpm5
         ICrQx0+ZhlDZLwTh8Fz4/e7TSkX9V+VBNYiUIw+0iSFrQny6wAwoHHAcLipd8g+J4lT/
         2435aDyExhY+A1YuhwxNhEWGa5qAHJiDrXM0PPEJ8dFShwp3QFl5he719duEUpTknuKS
         lsaZ3STSSMp791cizh8wk2tSbRcS3Q2GLYsY6j+9yVtw2QlRdmr776c1+nwQC8QOflJ6
         9lLq/b4V4fzMJ3fZgfOENONWF9D1c5ysv46vjbO6r01+k55btqfrT4W5V0nltTqqDTIK
         v+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpKoGHvxtKgwzmlV3ZPMeHJLr+EFBiNKpVwHZEuJXQ0=;
        b=aoA0RNenMyVt2JaXBCxZo9uJNkfINXpkWB2N0J8c5xmIB11rgGlc8So9/CFHupcDKj
         5XUqE0mzK706FZCO/7nVBxs+3LrU6Gpif8a9CYZMjzQJJC/rDRRHt6GVryHc9kBqFiR+
         ucxoUazu8x0oT16+lGAxlSKQve/mgH/iA9xDtEocXatqI/7f/WFzbFY1PWj1hJscbRkF
         kKqqti3AYvNjEzDreatJ1qtde27OoMIH8i4T95U9zkJFy2lnhZswNBGHyYRGry4yHuXX
         cLGZ4D+iwUCUu1zkNzXRjeXzNb7UTy0y6qtPMivrQYde23KB3V5jB3uu77iYul4zubKL
         bL/w==
X-Gm-Message-State: AOAM530bP8pJdJpthSapT14i+7BLhT8HNvIXcJS3VgOqDx712jwcvISX
        20DVXzO3jdrTXBCN1KwhwEyXhg==
X-Google-Smtp-Source: ABdhPJz3xU6WUFCEx3XYhA8SLFw5JFA/5ztJvoX+p2Xi3reK3z9aXuJQcQDf3c5HDzC/jXnwJPc6uA==
X-Received: by 2002:a05:6e02:1948:: with SMTP id x8mr941650ilu.225.1606886618551;
        Tue, 01 Dec 2020 21:23:38 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:37 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 2/6] mm/gup: don't pin migrated cma pages in movable zone
Date:   Wed,  2 Dec 2020 00:23:26 -0500
Message-Id: <20201202052330.474592-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
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

