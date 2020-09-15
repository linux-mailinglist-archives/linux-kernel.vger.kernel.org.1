Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C316926B841
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIPAkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIONEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:04:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B5C061354
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:04:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so6637188pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jiL3ii4AJU2Njj/y/vFrTYFZ6QNs3Srg45f1FwlIOSw=;
        b=UCioyFq/nMf2pfW7YzyCEcx4LL4/jL1jJUkht2xjt+BMHebuzK/UKImXusybczC6tr
         hTRa9/L+br3pbdNipbSH20dV6etCd7/zplLBClKqkOe4p99jl807aGZocuBegTAKWegT
         qW2M0vOxaqwVOFS01ltZ94MXkaAN3yu7UcDSaUKd6lyuAbXXcRx6JaBNLO4WCBHrONrQ
         mI/sHDT9Q2NI5W8AOCu7XWmJSS7/IKrSpKT5OJnmwubKGNTLD2TMr7GFNW3wXS1xr9xB
         kQBgwh1xu2xzg1c75B4nGCznnkOnVs7OKDaGcFSPjqv8srW2nRfVyrrMT3OMOu6XNeyH
         5Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jiL3ii4AJU2Njj/y/vFrTYFZ6QNs3Srg45f1FwlIOSw=;
        b=H+FnHHL7pWd4bi4WrogMgfRjz6nD/Wy6IsSQTKbOCjBSGPC6t1/bGKJDmnwPRc+99s
         soS/45ri7sIye578bvNXWZVJyO7C+7UgINLS2MGGmUzM8fnvugLpfsrH9OdPqV9IpXUK
         WQmndpeAAAGj+wx4gNPnqU7omOtui690ay4XzcC8+SjfCpCOFgy++Jeni8aZrPppiocE
         A+WhPw0T+dr0L9yP/fFnjpJk9YAfCxqbsdHZW5V90sOMf1R8u0ZCTDxI/k62l2BUQwWj
         tidfEv/n+ELtlv5pfJe8dtrEhjDQF6g+KCbu88H5luR5NL58HHpgiydM1z6qKX/7BmFk
         zz4A==
X-Gm-Message-State: AOAM531thrk2VGlex9vueDofa0UJrQh0LgHlZ+7szDh1sQPp9VhKU10V
        at4GsIkX7vG7z/FBbfZ/M1RVUQ==
X-Google-Smtp-Source: ABdhPJzDjZ5u/kFp3j7KzOYJwm3WjE591cWhOwkG8OQSFmLJnogu52u+8IhXbjfuzBZdoCwfGeOYwQ==
X-Received: by 2002:a17:902:9887:b029:d1:e626:788d with SMTP id s7-20020a1709029887b02900d1e626788dmr1206774plp.53.1600175043242;
        Tue, 15 Sep 2020 06:04:03 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:04:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 24/24] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Tue, 15 Sep 2020 20:59:47 +0800
Message-Id: <20200915125947.26204-25-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only `RESERVE_VMEMMAP_SIZE / sizeof(struct page)` struct pages
can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so add a BUILD_BUG_ON
to catch this invalid usage of tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e66c3f10c583..63995ba74b6b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3994,6 +3994,8 @@ static int __init hugetlb_init(void)
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 	BUILD_BUG_ON_NOT_POWER_OF_2(sizeof(struct page));
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 #endif
 
 	if (!hugepages_supported()) {
-- 
2.20.1

