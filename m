Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE012E17B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgLWDRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLWDRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:17:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:16:35 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id f9so9564571pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pZ/f9glxrB61iTY56LM8LbDjB/Q+1kPVuyGxtSMpD60=;
        b=a5iXl82aPWXZl9htUz2CCi5ocQVKvWIgFSpmm96zJ2qJHhdxOAOAKrafizeIRHtTmW
         Ta1S1Wa2zg9HgaUnA7+bGXAVNDIQlcDRLUXHONEltXwijSbo0W2BR9qCX9Qi3xyG5cqA
         qS6HirR+afprUAO5XCOm9KZIH0G1U+hYX8ZebgdpVnkcaUdbsj7xtZfX8YJhwnfXQov5
         Kwcy0+aPLPZNjabm3cRIHoIgIE//83gGFyEXAEc9FEoziFbrUX1cTofgVngK5UWLB/HC
         f9sibjJ/Klvft6mKvn22u5y7BlztwkGlA2Fe3Rexd8lDq7aMem5Lig4F8C+vEb6GgsJ1
         Mvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pZ/f9glxrB61iTY56LM8LbDjB/Q+1kPVuyGxtSMpD60=;
        b=fbnK8r3tomXlm4fgLUp5I2SVIG3dA2CEvDva5cLOeN0iLG2ujj0fVyg5FDZnTZkAuX
         Jn0Q+FIUENPsLiGEKpdoWe9Tr/1Fz/b/MYBkAu2r2mVv5z5Jicvq3uqUUXYX+cTfEQRF
         EnjYpRmTCXfY/r80UXlAPhUAEzM0RRG3jLDm63AXp3AYSCX22j2gAcNPhIoTm9nffryu
         bfh7wdF08CQBTEOopT3+2Kwivqs73wx6BxqWtZjkBlcUwVlm835Gn1dCwKGtGqU5rOcL
         9nwNqrKFrWVOlV5NLKbQZYLW7C55BrsJHXwsIXE4ajJEWcEQOh11sG33yFKHFkdaOQ8q
         q2+Q==
X-Gm-Message-State: AOAM530jH0062Y0bhFuBAdKFx4WWk4MHbVabf5Ei0o/z/z4mX5Ahkx+W
        JtH4LhTJ7Py58LoQQIYIZAI=
X-Google-Smtp-Source: ABdhPJxIj56h7Vic1yGYrNP21l4beMDOEgHzF+G2bnBHycPwzgqGo6gCa3gheBOS9oL7XANv/E3Ebg==
X-Received: by 2002:a63:f348:: with SMTP id t8mr22524553pgj.425.1608693395400;
        Tue, 22 Dec 2020 19:16:35 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.58.4])
        by smtp.gmail.com with ESMTPSA id e6sm19915887pjr.34.2020.12.22.19.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 19:16:34 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Date:   Wed, 23 Dec 2020 08:46:18 +0530
Message-Id: <1608693378-4392-1-git-send-email-jrdr.linux@gmail.com>
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

