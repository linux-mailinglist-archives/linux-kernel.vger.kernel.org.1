Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34822C87AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgK3PVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgK3PVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:21:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CDC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:22 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x4so4919800pln.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffovrVtJKksWNRWUIw8Bwgz8i6vc1Ozc0RtsISNKfww=;
        b=klomQ8KWXhQezM67EV9p26nQ6ZZ3IO/xktcuhuVa+SYPC0dawJizzg7cCdu7YrP5/o
         M+Q9c5zasxnmC31GNSkzQSpHFUrz1P4OxBr27kQx88bwVhC0fQDoFnsc5C0PutMGYpMv
         jurte5p68rqoWac+bUKDXiNIpkGecf1gbZq3p7j9d0haeR1yeXyxsasn5/vG7aS9buwH
         Ao74exP4vJfO6kojH2qbxGOOZiflmjpV9QfBla8pXp+7F+eselgyFHq39WTNVezJOi3g
         QyNgSjL9g4zFslQdajvFw6TnWodbX+De2zyFuROSQPPsYP03OpqIo3RwEQ1Z5rMq8Lha
         guIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffovrVtJKksWNRWUIw8Bwgz8i6vc1Ozc0RtsISNKfww=;
        b=QzaxFqacBJwKrrckYHmsuoEg2Nnp2sFLt/AQ1jLdqo8K+5ug7Xbd0veEtdfbd0aSbg
         9207mT4QXusyMo5JojTREnx9MrO+q4AnfKf+FSK06olUDYrMVScJwlNBP6V4Yx8zx5VR
         M7mrWIhys65S/WFgrl8iarQVRbDucYdrvRtiNuSvIpZ7uzR3Jg1FmjfCOPioWlKl6VON
         3LXyL+a/0wh/AYMYqz+cSlw0yNDJ2lTXFCnVXhTY8ymoX2HXpdi0pln5Ylz/Z5fg9bsJ
         5NZwWipROC6+loLUZWwKvxWQQa1MyEoOoo9VyaKwJKVbXv2i9E2IQCO4fFCkyYZzdvEv
         6Rgg==
X-Gm-Message-State: AOAM5304tBx/poB/N5YHVzmM7fZqc6L1R6+ludbRyT6REGB+nft7NF9V
        2qArzWac1t58zgkbp3DCOmPFGw==
X-Google-Smtp-Source: ABdhPJyD0IEADf+EEGcLsEqeBHemhCygMIWK8oLWIpbFL5MK72KpW0o1uysekvtHK2pv+cW3Oa8vbw==
X-Received: by 2002:a17:902:d916:b029:da:3e9e:cd7c with SMTP id c22-20020a170902d916b02900da3e9ecd7cmr18670878plz.27.1606749622441;
        Mon, 30 Nov 2020 07:20:22 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.20.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:20:21 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 06/15] mm/hugetlb: Disable freeing vmemmap if struct page size is not power of two
Date:   Mon, 30 Nov 2020 23:18:29 +0800
Message-Id: <20201130151838.11208-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
when the size of struct page is a power of two.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 51152e258f39..ad8fc61ea273 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
+	if (!is_power_of_2(sizeof(struct page))) {
+		pr_info("disable freeing vmemmap pages for %s\n", h->name);
+		return;
+	}
+
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page and the first tail page are not to be freed to buddy
-- 
2.11.0

