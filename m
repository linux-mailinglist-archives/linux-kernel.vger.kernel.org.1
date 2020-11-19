Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6802B9077
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKSK5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:57:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:35758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgKSK5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:57:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CA66AE30;
        Thu, 19 Nov 2020 10:57:28 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/7] HWPoison: Refactor get page interface
Date:   Thu, 19 Nov 2020 11:57:09 +0100
Message-Id: <20201119105716.5962-1-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following up on previous fix-ups an refactors, this patchset simplifies
the get page interface and removes the MF_COUNT_INCREASED trick we have
for soft offline.

Please, note that this patchset is on top of [1] and [2].

This patchset does three things:

 1) Drops MF_COUNT_INCREASED trick
 2) Refactors get page interface
 3) Places a common entry for grabbin a page from both hard offline
    and soft offline guarded by zone_pcp_{disable/enable}, so we do not
    have to drain pcplists by ourself and retry again.

Note that the MF_COUNT_INCREASED trick was left because if get_hwpoison_page
races with put_page (e.g:)

CPU0                         CPU1
put_page (refcount decremented to 0)
 __put_single_page
  free_unref_page
   free_unref_page_prepare
    free_pcp_prepare
     free_pages_prepare                           soft_offline_page
     :page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP     get_any_page
                            			    get_hwpoison_page
   free_unref_page_commit
    free_one_page
     __free_one_page (place it in buddy)

get_hwpoison_page sees that page has a refcount of 0, but since it was not placed
in buddy yet we cannot really handle it.
We now have a sort of maximum passes in get_any_page, so in case we race
with either an allocation or a put_page, we retry again.

After an off-list discussion with Naoya, he agreed to proceed.

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=364009
[2] https://patchwork.kernel.org/project/linux-mm/list/?series=381903

Naoya Horiguchi (3):
  mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
  mm,hwpoison: remove MF_COUNT_INCREASED
  mm,hwpoison: remove flag argument from soft offline functions

Oscar Salvador (4):
  mm,hwpoison: Refactor get_any_page
  mm,hwpoison: Drop pfn parameter
  mm,hwpoison: Disable pcplists before grabbing a refcount
  mm,hwpoison: Remove drain_all_pages from shake_page

 drivers/base/memory.c |   2 +-
 include/linux/mm.h    |   9 +--
 mm/madvise.c          |  19 +++--
 mm/memory-failure.c   | 168 +++++++++++++++++-------------------------
 4 files changed, 85 insertions(+), 113 deletions(-)

-- 
2.26.2

