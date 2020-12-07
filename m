Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F42D1CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgLGWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgLGWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:11:33 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5DC0611C5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:12 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id h1so3845174qvr.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=h0OiZUD2Xpj8wH+yrifT175RqRi+PBeb00G32sH3P0Y=;
        b=DvNTqP0Jlg37VPbc2IrU9Pi+z1DkfYcdpq+P8NKbSX5O4nR9+j1cJ/O7LgDhG6ijWS
         5WJrRyQ9KRj2fcmKVTH6HUkEAC3mRxu+7jsql3dYH6K0bEbI6sQmRqfgK5T6Sn0lsNsQ
         FV2ifEGawMSAgN48r8Rk38P1zjpaAOaqsFPr7xuR9r6XpdYY8KWCUlLUBwWGdy2sC/b3
         97xjHAFK+USl+MsFwNv1hwIoc9J3eGUDlJg+qVSMHN+ioy3g07+q1CtrpQA7AMlzd+Xi
         MRstm38sV1pNPo6mendy2h7S1ZhNp6ekXl1EEep86WN2Xr2a3m+olse1oMEm/wEdfDPT
         ipuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h0OiZUD2Xpj8wH+yrifT175RqRi+PBeb00G32sH3P0Y=;
        b=FzCD3VcDwh+rAblgYcDJOBtff8BzvI9BFeE8uhCuPRZeI+3wzPN/DCIOHaRD+SMD+n
         1t9s5ovG5d/XNJT7ijVmXnqzUP8biLZllhKs3OeUSBIKk/3NeEpH++oI7TSGi4qYLifi
         ltZDEEcl0WG6Tq74yY9RjYHEnpvOh9dL+7xy8ArEpG0sFu5Xx+OqXpTZokLM3jRC6Lbj
         7Mmjn5QZvom51bbZF3cfmA/SN8MOZpaw+hWXaxNs2R5OUKeNcAJ3FOrZosnY3zoNYjN0
         Nr3Ta0Fm79Qhvud3EeTXNRsTtQa0HA4NoNJTA9H9/sQeF1WwTn+uFaeAp/kcISlnO9uQ
         kY+g==
X-Gm-Message-State: AOAM530cY6vSOaaXB1Pvq8cCmXx1KW7W3YQQbNQvtWGxXyVAlu74sVvy
        CAcmrdOnfZxNEwzXmkd5LT4FJNYnzQU=
X-Google-Smtp-Source: ABdhPJwqHNXxnqK14pujguHwfglOZuFBgiZx/0erN/Z0wWVSGH4yVtQs+MW8BefBjdNfc6hh2AsPchdiBe4=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a05:6214:1785:: with SMTP id
 ct5mr4855273qvb.26.1607379011448; Mon, 07 Dec 2020 14:10:11 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:46 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 08/11] mm: fold page_lru_base_type() into its sole caller
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

Signed-off-by: Yu Zhao <yuzhao@google.com>
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
2.29.2.576.ga3fc446d84-goog

