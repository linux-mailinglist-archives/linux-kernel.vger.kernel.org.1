Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5126D685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIQI1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:27:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgIQI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:27:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69645B206;
        Thu, 17 Sep 2020 08:28:25 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Date:   Thu, 17 Sep 2020 10:10:42 +0200
Message-Id: <20200917081049.27428-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes some fixups (patch#1,patch#2 and patch#3)
and some cleanups (patch#4-7).

Patch#1 is a fix to take off HWPoison pages off a buddy freelist since
it can lead us to having HWPoison pages back in the game without no one
noticing it.
So fix it (we did that already for soft_offline_page [1]).

Patch#2 is fixing a rebasing problem that made the call
to page_handle_poison from _soft_offline_page set the
wrong value for hugepage_or_freepage. [2]

Patch#3 is not really a fixup, but tries to re-handle a page
in case it was allocated under us.

[1] https://patchwork.kernel.org/cover/11704083/
[2] https://patchwork.kernel.org/comment/23619775/

Thanks

Oscar Salvador (7):
  mm,hwpoison: take free pages off the buddy freelists
  mm,hwpoison: Do not set hugepage_or_freepage unconditionally
  mm,hwpoison: Try to narrow window race for free pages
  mm,hwpoison: refactor madvise_inject_error
  mm,hwpoison: drain pcplists before bailing out for non-buddy
    zero-refcount page
  mm,hwpoison: drop unneeded pcplist draining
  mm,hwpoison: remove stale code

 mm/madvise.c        | 36 +++++++++++----------------
 mm/memory-failure.c | 59 +++++++++++++++++++++++++++++++++------------
 2 files changed, 58 insertions(+), 37 deletions(-)

-- 
2.26.2

