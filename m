Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E3300FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbhAVWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbhAVWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EAFC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b62so6898329ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CLgXtoSMSf4chkEdW8yrd9bZvEDFHVek70YcRsgvLdo=;
        b=n21Qu+vhD3FPQnNErkSfyB1JJsQj8dItdHyxzI4vIlKcnF69dBaAYDhS5EVTSWeTET
         lAFQAhNAm9xzKpF31PCWyVotC/FoEYwZEvKIfZB6X+cCVucd53PWMQ0+6RXC+2zHfl6O
         XM5vBvdJa/29P+ox0xdEyex8bfXnupKtZDsU5lzohHPAluJPt8nVS97YAgV4oSQXBE7a
         6P0cM21iJv4Mqj8xTw1RKaQHaupNxxdnVTmIYsHhVtHj8f6Y97B2TTR4dPsyVqUVZXII
         y0E0ubLraQ/d/r2J/Lr5YsD2dTZKtpoBQGWVcAebiuVnFixbtqMqy91djMJEYKcJz6XU
         5nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CLgXtoSMSf4chkEdW8yrd9bZvEDFHVek70YcRsgvLdo=;
        b=kQ+lD6wH62ypSWOe8NHd4jJac0HXraD3s1U5A5nguV5SlsSdF4nyCqB8q5jyVQIVyG
         Ib61XonmIRLaT445Sq8OMR+ueUu8mrfo4Ay9zrYxQ1sBLOT5YWEz563HMVMZM+PTB+2V
         CBTUJkMuUTJqSgjEomoXj/UwqwYeT7H4f1byIuyFmhWWREobWDnSZmOxwvXpuy5eRorc
         NIQqnzYzySndKIBGEbHRzeJ9hyag7U403UbJicZpGgkbcKWdmN6xQc4T38noXp+UbnDJ
         9WW9FMhkvXKsZ531YxSRMpCTVPNQpJcbmi+RuH4daPRrlINQANg4v9VnO9g/GYMKwt8c
         ++3A==
X-Gm-Message-State: AOAM5331B3zMdvQc3XWA/TqwiKeVjOaZQDyoyx+/bCn+kfLprN8bfxbx
        cY+BS5Dn8gIWkq53VZlE65N0EL47CHA=
X-Google-Smtp-Source: ABdhPJzIdc5hTMSR1DaMMMCo4TFYoBE0en2JSCPQGQzA1Er5XzYdpjzSDq/j5NqC0FnAyeiIi+/Ammgzqgw=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:a86:: with SMTP id 128mr8664734ybk.370.1611353173347;
 Fri, 22 Jan 2021 14:06:13 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:58 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 08/10] mm: fold page_lru_base_type() into its sole caller
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've removed all other references to this function.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-9-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 include/linux/mm_inline.h | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6d907a4dd6ad..7183c7a03f09 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -45,21 +45,6 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 #endif
 }
 
-/**
- * page_lru_base_type - which LRU list type should a page be on?
- * @page: the page to test
- *
- * Used for LRU list index arithmetic.
- *
- * Returns the base LRU type - file or anon - @page should be on.
- */
-static inline enum lru_list page_lru_base_type(struct page *page)
-{
-	if (page_is_file_lru(page))
-		return LRU_INACTIVE_FILE;
-	return LRU_INACTIVE_ANON;
-}
-
 /**
  * __clear_page_lru_flags - clear page lru flags before releasing a page
  * @page: the page that was on lru and now has a zero reference
@@ -92,12 +77,12 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
 
 	if (PageUnevictable(page))
-		lru = LRU_UNEVICTABLE;
-	else {
-		lru = page_lru_base_type(page);
-		if (PageActive(page))
-			lru += LRU_ACTIVE;
-	}
+		return LRU_UNEVICTABLE;
+
+	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+	if (PageActive(page))
+		lru += LRU_ACTIVE;
+
 	return lru;
 }
 
-- 
2.30.0.280.ga3ce27912f-goog

