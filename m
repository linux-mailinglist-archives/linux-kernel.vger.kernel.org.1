Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6B52D4FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgLJAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgLJAoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:20 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC5C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:40 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q7so1616656qvt.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YDDAi2s6I9irj1eFCp+Xpz5CYfQrtxxsgY8jH6RM458=;
        b=Nk+AuTMfxQ6BbAHmfpjqdXSFnw1CX0GCnpt5Rtr+S5ZZHzRoxhUkXzjSaLBFo9FKnP
         +IGv/oMQZ60Z5oFcu+WcBKLRJVlJIYOStwwQhx8A63/pkfbIk01AMMQrVYLFm122JdCB
         ZhbhX33sTQJUJplzJA2KCaOHlmGycGbsVHpDDZmMcTiFO6zgEcZ5bn3oKR/nhS7NmGXE
         lSUNz94k7ztCGv2c6TPO+oYZAaXQIIpJzaTSorVPYYAS5rRfsh2MWxhI1wbtSM8fm6SD
         ty0uVYq1b+GXDXOHEDRKOXvQB09Qf6VhbIcqJueEsD6VjWHJFlCxwCjTIUSuBPWyseQi
         q3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDDAi2s6I9irj1eFCp+Xpz5CYfQrtxxsgY8jH6RM458=;
        b=Wt8gKM4m8Yfr8IvwQBK3dmVXYDClF2v6gT66gyknXEXz/tHKcvQCAElVE378ccZB+4
         lx2GOnZqZW1S4NF1bp4WaVERCQoprMRO6t0BzqoU/xnZf8FIT5OpP8Lvg0PYU2N8kAO7
         4dexhQfbRiux+HxYL5VJvSV2w+TnEipce93R+0E64CcQg+uU7GPx9bgHOV2t5WzTWVwq
         Ki6iOmq6+e5CbXmDWjDyUiUnFzIn9YE+XQraTKlTwV/yW6RkaOGD1U6RaRAHmHy5h1xn
         31oRvz9jNsnhIQSendHeLhknPGed61m2uFHkgQ/vYUZLEOKfJCnsnCqzGQxByJ9m+xSA
         BfIw==
X-Gm-Message-State: AOAM532Fc9ZZy/94Z7nBWWGHQqlWHBNKw9wAvy7e2qwvcZHlGyHy+MXM
        4JDJr/xam7wjmEgCWzIorVgHng==
X-Google-Smtp-Source: ABdhPJzAa7q5sUByKWOSFZ0Py2q3Uc376O6i1oNIXW+AdlNdeOTECHVZXZpiUJYIRGDv8y9xQIyh+Q==
X-Received: by 2002:ad4:4051:: with SMTP id r17mr5889435qvp.39.1607561019788;
        Wed, 09 Dec 2020 16:43:39 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:39 -0800 (PST)
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
Subject: [PATCH v2 1/8] mm/gup: perform check_dax_vmas only when FS_DAX is enabled
Date:   Wed,  9 Dec 2020 19:43:28 -0500
Message-Id: <20201210004335.64634-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check_dax_vmas() and run through the npage loop of
pinned pages if FS_DAX is not enabled.

Add a stub check_dax_vmas() function for no-FS_DAX case.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609..cdb8b9eeb016 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1568,6 +1568,7 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
+#ifdef CONFIG_FS_DAX
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 {
 	long i;
@@ -1586,6 +1587,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 	}
 	return false;
 }
+#else
+static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+	return false;
+}
+#endif
 
 #ifdef CONFIG_CMA
 static long check_and_migrate_cma_pages(struct mm_struct *mm,
-- 
2.25.1

