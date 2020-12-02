Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56DF2CB47F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgLBFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgLBFYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:21 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33891C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:41 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id b8so419049ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vWbivB19k0h8/AlP1XM1Nmc7af9oF18AMBG0uJjqBZg=;
        b=g96m6GkPZHfEbSkiqZwo4JVs7jb4V5m6B/E80Zsyu24GkvrsPZp7AWEJhI//1ghTWN
         5NLAv8o3wcP/KZpZQmNSbfpDFqZdUUVJjfkMerBm1X/+ACWSdy3aELusEZYv6b7yhiB7
         xXf+WbsGmnygy23Xtkg0rrAJSR4ApXWWUWpH9P6mRfqmGZGMmqJZwL4rI1Dpc5Btmo2j
         3QTXixFypX+bc0zrN6L05FqlHYHxxx57GyOhX0pEAvYLw28iOO7qbYYIOeFby7eDuglc
         oeeGldegA6vLLJ/FQvIVi3vDW1lkYcV72cVcRusrIxeiCzIDe90yPtpiRDj8k6F0UaS6
         Bxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWbivB19k0h8/AlP1XM1Nmc7af9oF18AMBG0uJjqBZg=;
        b=s8B6RXw0L95JVqTSuQFLWgLlLv3M4+xTcy0rMmvM8SlOoobx9oKux0HIC0LABWC8kP
         5mJH0oqDR0KIh6dEs8iShaDUu50WhLK+IzM3hH8GciFv5JlB2QeypClpSKvNsY5V86bH
         OFSEnZW/glJHBAsvo8I0rAuY7F/Md2uZ2SlCVyGzwETAwgAD0i34hSmgIwS5jx7wENPJ
         Af9eamEzqpX90yuRyuv5mmJ2w+4L+7h7MKRpzAgUQU3rpWu6DOUXLP1UkEfXpEtHf+E+
         yZIhBrqBNp2H6b6Zv6cXSpb4kBpBdDO+wV6utNx2eQfbUD6c8wNtWJPtPhpYOOsEXRC8
         xxMw==
X-Gm-Message-State: AOAM533xIwW+ykzkPSGLNW+628BVKAPPwCldZjNLcm4e0yw+VpkwpylH
        I239dZ921xCxpBd0cwqHbFeJZQ==
X-Google-Smtp-Source: ABdhPJxgs+HxskX0uhoP9WOG8kbRPPRX02QP9Wypzqg6Mj5iS3wfXYkcKGeLH1LvMeVA4mW5Ql4yNA==
X-Received: by 2002:a05:6e02:80b:: with SMTP id u11mr925843ilm.43.1606886620616;
        Tue, 01 Dec 2020 21:23:40 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:40 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 3/6] mm/gup: make __gup_longterm_locked common
Date:   Wed,  2 Dec 2020 00:23:27 -0500
Message-Id: <20201202052330.474592-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
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

