Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7B26890C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgINKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:16:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgINKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:16:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D25EB25B;
        Mon, 14 Sep 2020 10:16:19 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Date:   Mon, 14 Sep 2020 12:15:54 +0200
Message-Id: <20200914101559.17103-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The important bit of this patchset is patch#1, which is a fix to take off
HWPoison pages off a buddy freelist since it can lead us to having HWPoison
pages back in the game without no one noticing it.
So fix it (we did that already for soft_offline_page [1]).

The other patches are clean-ups and not that important, so if anything,
consider patch#1 for inclusion.

[1] https://patchwork.kernel.org/cover/11704083/

Thanks

Oscar Salvador (5):
  mm,hwpoison: take free pages off the buddy freelists
  mm,hwpoison: refactor madvise_inject_error
  mm,hwpoison: drain pcplists before bailing out for non-buddy
    zero-refcount page
  mm,hwpoison: drop unneeded pcplist draining
  mm,hwpoison: remove stale code

 mm/madvise.c        | 36 +++++++++++++-------------------
 mm/memory-failure.c | 50 +++++++++++++++++++++++++++++++++------------
 2 files changed, 51 insertions(+), 35 deletions(-)

-- 
2.26.2

