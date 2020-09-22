Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2527439C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgIVN5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64A38AC7D;
        Tue, 22 Sep 2020 13:57:42 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 00/14] HWPOISON: soft offline rework 
Date:   Tue, 22 Sep 2020 15:56:36 +0200
Message-Id: <20200922135650.1634-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is the latest version of soft offline rework patchset
targetted for v5.9.

This patchset fixes a couple of issues that the patchset Naoya
sent [1] contained due to rebasing problems and a misunterdansting.

Main focus of this series is to stabilize soft offline.  Historically soft
offlined pages have suffered from racy conditions because PageHWPoison is
used to a little too aggressively, which (directly or indirectly) invades
other mm code which cares little about hwpoison.  This results in unexpected
behavior or kernel panic, which is very far from soft offline's "do not
disturb userspace or other kernel component" policy.
An example of this can be found here [2].

Along with several cleanups, this code refactors and changes the way soft
offline work.
Main point of this change set is to contain target page "via buddy allocator"
or in migrating path.
For ther former we first free the target page as we do for normal pages, and
once it has reached buddy and it has been taken off the freelists, we flag it
as HWpoison.
For the latter we never get to release the page in unmap_and_move, so
the page is under our control and we can handle it in hwpoison code.

[1] https://patchwork.kernel.org/cover/11704083/
[2] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u


Naoya Horiguchi (5):
  mm,hwpoison: cleanup unused PageHuge() check
  mm, hwpoison: remove recalculating hpage
  mm,hwpoison-inject: don't pin for hwpoison_filter
  mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
  mm,hwpoison: double-check page count in __get_any_page()

Oscar Salvador (9):
  mm,hwpoison: unexport get_hwpoison_page and make it static
  mm,hwpoison: refactor madvise_inject_error
  mm,hwpoison: kill put_hwpoison_page
  mm,hwpoison: unify THP handling for hard and soft offline
  mm,hwpoison: rework soft offline for free pages
  mm,hwpoison: rework soft offline for in-use pages
  mm,hwpoison: refactor soft_offline_huge_page and __soft_offline_page
  mm,hwpoison: return 0 if the page is already poisoned in soft-offline
  mm,hwpoison: Try to narrow window race for free pages

 include/linux/mm.h         |   3 +-
 include/linux/page-flags.h |   6 +-
 include/ras/ras_event.h    |   3 +
 mm/hwpoison-inject.c       |  18 +--
 mm/madvise.c               |  35 ++---
 mm/memory-failure.c        | 311 +++++++++++++++++--------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  71 +++++++--
 8 files changed, 231 insertions(+), 227 deletions(-)

-- 
2.26.2

