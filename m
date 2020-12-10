Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9182D4FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgLJAoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbgLJAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:00 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D0C0611CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:43 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 143so3288491qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wKF1vMMrBlL3Nf1z4M/UQUVU8LetyRUPTbIEfnAIYlQ=;
        b=gqbd9DoMaRvvzvvMIqaS5F41tXsvEg/1IPa7tX68ji4V8ZFM0lAhGyUZ1CmiVZXVSh
         biDr/Ej0RPp58RM/ATaFiF2WLnZCp9mVyqJVF8saPqoaMIdnbxPdA9IzLH1s2jY1UK4Y
         H2lHueaV79j1DW3rTXM50YMPOTq29GTP2KnfVIJxkLxzhdbc+fjGIE2Eq7Ue0jnYz0A/
         cW2to2nIGGjeyaZYDoshUaphaprRyBhQwGVqtTeymXkz9SP2YoPNh3LxiaImeY19SgbI
         w5Q+FiKl6hlqVYo0yVw5f3cEDEQ9eba8GOePohl4kJKP3tZk/EQx4jdfOaSRMeVu6A09
         tSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKF1vMMrBlL3Nf1z4M/UQUVU8LetyRUPTbIEfnAIYlQ=;
        b=mfcgZRgE2fJCqOlTE0DTKgXc1akOll/ZeTnjv4rx9cn+qNfyMwkBnTTW6KjPq8Ujeq
         Epi6Ai8DVjj7cj8kwg/gPxTS6/J26tXJEVzsG1RiUuNkhUwcnbi4trn9DI3OTBNMgsxx
         Ueen7jiTUesR+zIyQQgXrtJmfC5SREcrrGBGvVsMOWCQERF50wQ0GC5FtRs6a48MWmxr
         taDD9AH1DkjhHgM0ZD/gRsMYCYHhsVKYeYolY4TnB/Gn3FuMHcb4EdvyF3xTziYm8yfw
         3e1+5ys1EbQZLM0ojs5uMzJ83Sh3ay00hl8MiGw8BkPBv3ge9RyITDW+ocK04SaEMu30
         v1+g==
X-Gm-Message-State: AOAM530msNSldmOGFF/54Bx9s6+lib/uEg3nEYzcjeTARUHJhqyS7Zx4
        vYfQp675MawF6EM6q/GYgVgYZw==
X-Google-Smtp-Source: ABdhPJwVjQblG8lz4nHLZuO6EXQnNDMXKQRm0jhOeWrGTKeTLfE1Ij+ZT0B/O2DFXL+mzXgo5kPtBQ==
X-Received: by 2002:a37:8384:: with SMTP id f126mr5922627qkd.500.1607561023216;
        Wed, 09 Dec 2020 16:43:43 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:42 -0800 (PST)
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
Subject: [PATCH v2 3/8] mm/gup: make __gup_longterm_locked common
Date:   Wed,  9 Dec 2020 19:43:30 -0500
Message-Id: <20201210004335.64634-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__gup_longterm_locked() has CMA || FS_DAX version and a common stub
version. In the preparation of prohibiting longterm pinning of pages from
movable zone make the CMA || FS_DAX version common, and delete the stub
version.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3a76c005a3e2..0e2de888a8b0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1567,7 +1567,6 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 
-#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
 #ifdef CONFIG_FS_DAX
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 {
@@ -1757,18 +1756,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		kfree(vmas_tmp);
 	return rc;
 }
-#else /* !CONFIG_FS_DAX && !CONFIG_CMA */
-static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long nr_pages,
-						  struct page **pages,
-						  struct vm_area_struct **vmas,
-						  unsigned int flags)
-{
-	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
-				       NULL, flags);
-}
-#endif /* CONFIG_FS_DAX || CONFIG_CMA */
 
 static bool is_valid_gup_flags(unsigned int gup_flags)
 {
-- 
2.25.1

