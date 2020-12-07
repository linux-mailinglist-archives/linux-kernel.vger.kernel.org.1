Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC32D1CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgLGWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:10:47 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972FC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:01 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id t81so825879qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NUUwU6TjT3HyGB9RueCAB8d5pAXhZlLPodEuPtCiIe8=;
        b=ObBnEqLPiYhcG3Hu24F75+fiSoOlISDP8AEk2dEwKw8DXQ2no8vwQphsjQeaa8mU21
         G+yKnsK8H36RdkvZb5ZvjmAshF+j4wymnXefNW9l9NdApT5qh98jXb+mUhSRDMm74EuU
         c1O+CEyT+xnb6q8cT5uAWvK4n4q7wOzJ37bh0YGWmnTPqM5kT6uzAo7FsYi5HOgAz4T2
         z6PlOZIbDSdoSTUeLIxCW8gmDH3D8r4jD1JgCUtq5x4vrHj+GL+Al/csWuzsaZw8T7jx
         J+ue+XHUU7/u8AKvM6jiEDmf+ukbvucUb5gd8qLAFXXtvUjV1s4MW6SpIyrJm4z1jwxo
         PxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NUUwU6TjT3HyGB9RueCAB8d5pAXhZlLPodEuPtCiIe8=;
        b=cmv0S9BqbzTvXMxN9eRgchmNLQx7NuHq2hQC4oRkUfCEdAbXGgKFX2A7oQ6W/q4bl9
         XI3j7EJL2vdPWBHc3hXBE8KGUPdjyDo1vn/YTd+bMUN5nvD0UM46ODOGdI+0LtEumdpO
         7AvV2rjXi/lUaXOptybxp73MvRT+EfEDAhIEWkJoYaE5NUdcmc+BmH50LYHjM+nTQTXp
         7ubRcirXAQIlAmSgZgoG85PLxJOoFa989GIh6B5VTDwcoj2ZOGcOse9Vb8MeBTW6uN8K
         6vycH+A6HoDigvEwisdyhC8sGu2ZOjcBijVJYD6OLeSm59pvhyFRNWeE7X2hJBgkjTM6
         kY/g==
X-Gm-Message-State: AOAM531zcxmCtzofJyRD3A0BCCXDZwuIWtZw1TfBWetPwarv4MJW3wBW
        9HtkZnvFV+WbZHG39tM5fHUkDK72f5M=
X-Google-Smtp-Source: ABdhPJz/8T3IWmeavAxHk+jT7Vw7keSUWRVyXIHJJZI58G9AGi4sgKu7k1sqhZHkTpGeUv/BTJtvpMp4wPU=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a0c:f809:: with SMTP id r9mr23244783qvn.17.1607379000338;
 Mon, 07 Dec 2020 14:10:00 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:38 -0700
Message-Id: <20201207220949.830352-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 00/11] mm: lru related cleanups
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

The cleanups are intended to reduce the verbosity in lru list
operations and make them less error-prone. A typical example
would be how the patches change __activate_page():

 static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
 	if (!PageActive(page) && !PageUnevictable(page)) {
-		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec, lru);
+		del_page_from_lru_list(page, lruvec);
 		SetPageActive(page);
-		lru += LRU_ACTIVE;
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 		trace_mm_lru_activate(page);
 
There are a few more places like __activate_page() and they are
unnecessarily repetitive in terms of figuring out which list a page
should be added onto or deleted from. And with the duplicated code
removed, they are easier to read, IMO.

Patch 1 to 5 basically cover the above. Patch 6 and 7 make code more
robust by improving bug reporting. Patch 8, 9 and 10 take care of
some dangling helpers left in header files. Patch 11 isn't strictly a
clean-up patch, but it seems still relevant to include it here.

Yu Zhao (11):
  mm: use add_page_to_lru_list()
  mm: shuffle lru list addition and deletion functions
  mm: don't pass "enum lru_list" to lru list addition functions
  mm: don't pass "enum lru_list" to trace_mm_lru_insertion()
  mm: don't pass "enum lru_list" to del_page_from_lru_list()
  mm: add __clear_page_lru_flags() to replace page_off_lru()
  mm: VM_BUG_ON lru page flags
  mm: fold page_lru_base_type() into its sole caller
  mm: fold __update_lru_size() into its sole caller
  mm: make lruvec_lru_size() static
  mm: enlarge the "int nr_pages" parameter of update_lru_size()

 include/linux/memcontrol.h     |  10 +--
 include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
 include/linux/mmzone.h         |   2 -
 include/linux/vmstat.h         |   6 +-
 include/trace/events/pagemap.h |  11 ++--
 mm/compaction.c                |   2 +-
 mm/memcontrol.c                |  10 +--
 mm/mlock.c                     |   3 +-
 mm/swap.c                      |  50 ++++++--------
 mm/vmscan.c                    |  21 ++----
 10 files changed, 91 insertions(+), 139 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

