Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64B22FAFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbhASEsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbhASEls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:41:48 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE72C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:39:36 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c1so12903464qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FjN+we3a/4BMKfp2FRLzct/HukxeBsArEgb5Xvx6VvM=;
        b=T9ylunAntNqXbYouxPdl8dwV99Sb9aRtUlMsbQ3DW0BpmaX5STOjlICi/P/1VX+iSq
         kt/svqsK3J2GxzSqX5lXoqQmJP2+iNbWmPvkjVmaEHcFs6N8FiZXFLjD6tG8yc/d1266
         7kGqVnRQrD7dBZfp3UmZt8oaOBRYD5OlqK6E62Jx0AqsVal4ivecdWSKp+8msVVQ7ac+
         QPWCIOrOcBrSu2OHSILBYgFoCOoOq6CT0rIdYlEIlekGYvCa2Tn+1uWe+Y7t8pTMidFn
         WJ8rdhf71pe6Dl/7axwWPboK1r+EjkCTArUW2fpNBvq0NZp/xfZl5MRUEZi2s8WQ8ldf
         0iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjN+we3a/4BMKfp2FRLzct/HukxeBsArEgb5Xvx6VvM=;
        b=VqNKEtwLutilGa84c5PhlNouvzVQLK5Z6gBmiBm8uHG6YiVFjYL/RoxO0Gv07p+Ota
         UtPTIUvV0MB5npLxwpNCexxX2Cmjnj6Jp0b01gB0aZzNIIY7KKmKs5ODIqfgG1pdpXt2
         R1CW53yXwv7MsVQaQxHQq3C+TSvn4ozcxu9lyss/Or03G7hE17ZRW9SFRn6NOxV+0zR3
         LQtI3ZynGro4wylB6NbgNAmSslH8qvFtWa0HZNjQ4cK6IcJEw0G3/l15RuBKBi3YGkWc
         V7Fpe/s62BJPrUOFGhojMOehxUf6/Vxs8PClRrrYiZGQDqCa9u/Q2qZ2wLIgo5lJlmDt
         DYMQ==
X-Gm-Message-State: AOAM530qJ2MiccAvq59sDM7mfC0GLWNuFWRD5Y+1FzUoe8uvl2mOBVoH
        dnjkhu3trE5DjLUriG9gIURJLA==
X-Google-Smtp-Source: ABdhPJwv/MB7KhqSh2I2lnS9blqr0Aoc1I8RzA6d5NHQd3cXRN2dgkMdOi+5gZaNcp5Ro/P8Wu0Nvw==
X-Received: by 2002:ac8:5509:: with SMTP id j9mr2643575qtq.284.1611031175343;
        Mon, 18 Jan 2021 20:39:35 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:34 -0800 (PST)
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
Subject: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
Date:   Mon, 18 Jan 2021 23:39:14 -0500
Message-Id: <20210119043920.155044-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero page should not be used for long term pinned pages. Once pages
are pinned their physical addresses cannot changed until they are unpinned.

Guarantee to always return real pages when they are pinned by adding
FOLL_WRITE.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 857b273e32ac..9a817652f501 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1668,8 +1668,16 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	unsigned long flags = 0;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM)
+	if (gup_flags & FOLL_LONGTERM) {
+		/*
+		 * We are long term pinning pages and their PA's should not
+		 * change until unpinned. Without FOLL_WRITE we might get zero
+		 * page which we do not want. Force creating normal
+		 * pages by adding FOLL_WRITE.
+		 */
+		gup_flags |= FOLL_WRITE;
 		flags = memalloc_pin_save();
+	}
 
 	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
 				     gup_flags);
-- 
2.25.1

