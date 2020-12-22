Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4D2E0B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgLVOUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgLVOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:20:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FFC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:20:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c22so8419483pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGTeTgqDGXSlUNEC7yTbtPqWuox/xuKUp/2OGBGVyNw=;
        b=owjabjD0ALRBjr+V3ZtRoWks1EzSJTy7G5/Egzlm4gqZMidG7PDJhKmmRu91V5MCH1
         d109LhhOF/8jIHDmuopOFM89WylJ4siZCJbnsAYncFFi/SQmYEgZr/IG0MvwRaGidSD3
         /x0j3WQKtKJ8HEdcPXWi968sD1SG5I5U/LKcEZt4xbRjDjxtypg/SZP2NVkpJTRzN0Td
         t9EU68+/tPRpbvlI7ihxkgETnnjswU/K28hwb/qKO220hbHVNezk0umdDpNDohgKNgYF
         KfBPHZ19ajJOPd3YjiqXgyUqGgEgah3Iafw7my8yQkwxZS7sbv3cHvP1fQI+77FFwB7b
         P2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGTeTgqDGXSlUNEC7yTbtPqWuox/xuKUp/2OGBGVyNw=;
        b=DqABPxtwuo+PvBubzg6VrJGzlQSR2RDHfdt8LT1vaRd4qDuSZqdys3xXAWv032lLXg
         gxqFqlcZ7yeNCxpmK/kowVTmYsIPCCCnr+IDPNIrwuz0Pu3R/DwHteGwcrEyUmms9dyy
         OhSHrzxq/a0mH9MRvzyNDC0lKaGc/BHHTx1U4h96HgbBl/GFlsXfVQcllV/6M0tm6Q1I
         bsXs76D0W1pXpQS+X5nVT6fG2fXHoEI24JyBc4/pvwG4+sgXYKIXd5aHtyGsQtFZUuVL
         7DrB4xdGF3qAHAStcCuFIqgUcvyxfnp6foeghzA/TMEetfaBqU8WQcsWXrAMJM2MsYm3
         ge2w==
X-Gm-Message-State: AOAM5303uiLpjjeeljL1gFeZT4az0+j4fWsWbK6LtT5apXiH+FmQiiwh
        q/51eW5RH24fywhB0FZyTsI=
X-Google-Smtp-Source: ABdhPJwkChu33siT8Ggm8KeG+LAC0fLTNjg8yajbLi1lIRTwvDawSJzuZUu09nknK7IvWZRs65azmw==
X-Received: by 2002:a63:2f05:: with SMTP id v5mr20156868pgv.3.1608646800674;
        Tue, 22 Dec 2020 06:20:00 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.58.4])
        by smtp.gmail.com with ESMTPSA id r14sm14755744pgi.27.2020.12.22.06.19.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 06:19:59 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Date:   Tue, 22 Dec 2020 19:49:52 +0530
Message-Id: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it cause gcc warning:
          ^~~~~~~~~~~~~~~
../mm/filemap.c:830:14: warning: no previous prototype for
‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
 noinline int __add_to_page_cache_locked(struct page *page,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~

A previous attempt to make this function static leads to
compile error for few architectures.

Adding a prototype will silence the warning.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5299b90a..ac07f65 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,6 +216,12 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
+/*
+ * Any attempt to mark this function as static leads to build failure
+ * for few architectures. Adding a prototype to silence gcc warning.
+ */
+int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
+		pgoff_t offset, gfp_t gfp, void **shadowp);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
-- 
1.9.1

