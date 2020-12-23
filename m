Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4542D2E17B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgLWDW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgLWDW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:22:29 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D5C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:21:49 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f17so9709342pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mFZyCDSKT7M9u+5W8OWtlSdmvWZ5CLcm6MzN9YnowAw=;
        b=sX2qVid2gZ+viCOcfR/UPV2I4crcfPvtYoxHSKnQSaWvaSDr01BcZnfjCRHA2nOOdz
         3woobCycs7GarDwzrHezCMPUU5kAMn+LOxHwtBY1bf/cj7S8AyPRXHB0euL3xGpVcu71
         E/Qa72TfTgITAZSo0p/McQOg10FW8s7kW25lGKLhm+X7MZ4coGw3k6lmfEk+q0VjfuWX
         Qq6gdXDBaqFwvdTdvvlyNTTT36CkmpTASSRBlVxnuE7Z+ZcD0RNJTGV1WyXj9Pq8xFQo
         gSuycF8v537uf8pks3XVrBA9rxXWJ+LJbKdyGYREZfb9GFxV0XBwznFWNZ8xusuMG9ec
         0M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mFZyCDSKT7M9u+5W8OWtlSdmvWZ5CLcm6MzN9YnowAw=;
        b=p1HxTr6hZnWn1Q5FgF7PBfR2FLLY2LPAQdEbRfKHVNjU4vrs+mJWz3ZD6I7+3vEdHX
         h0aQrqz1WWkSA763TqJil1YyR+ggm13uKrNLpqizsH3mmAQGC+xOaBpLcTVx5zqAzBcY
         axA3PWOmPnXBTjso85BZGEX/2WRNrZ3NpDk7WfiMISlB30/vgiMFn7TJ7qMKPyGJ6A7d
         hMjWLiDHOc71LACPguEbJJS9CVrJW41uXG/HJKAti2QK1I8pVIFkbeDuSKo0lXxqSKgl
         KbDNKm/etknIj+N3geI/MROQPzQTAWLbqczetjx9AQMwI6H/oCWEDPmrdnd1CwOIhP0L
         IH5g==
X-Gm-Message-State: AOAM530KMw9lCegalYygCjXOtlcv7hY+Xxz5GueiTTeYeimgThweZDtf
        jrBc5uft/zpru+CvQopL8oM=
X-Google-Smtp-Source: ABdhPJwe/h8gcyrhwKAmUnbjbzSK2jH4feR1EtQhfX6YFV0uwKjIek1dU4Ik7eV6u+i7xrcEnsGqLw==
X-Received: by 2002:a63:f158:: with SMTP id o24mr128658pgk.245.1608693708454;
        Tue, 22 Dec 2020 19:21:48 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.58.4])
        by smtp.gmail.com with ESMTPSA id w90sm14164078pjw.10.2020.12.22.19.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 19:21:47 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: add prototype for __add_to_page_cache_locked()
Date:   Wed, 23 Dec 2020 08:51:42 +0530
Message-Id: <1608693702-4665-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it causes a gcc warning:

../mm/filemap.c:830:14: warning: no previous prototype for
`__add_to_page_cache_locked' [-Wmissing-prototypes]

A previous attempt to make this function static led to compilation
errors when CONFIG_DEBUG_INFO_BTF is enabled because
__add_to_page_cache_locked() is referred to by BPF code.

Adding a prototype will silence the warning.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
v2:
	Updated change logs and code comments as per review.
	s/offset/index.

 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5299b90a..c1e9081 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,6 +216,13 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
+/*
+ * Any attempt to mark this function as static leads to build failure
+ * when CONFIG_DEBUG_INFO_BTF is enabled because __add_to_page_cache_locked()
+ * is referred to by BPF code. This must be visible for error injection.
+ */
+int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
+		pgoff_t index, gfp_t gfp, void **shadowp);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
-- 
1.9.1

