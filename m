Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76A260CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgIHH4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 03:56:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbgIHH4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80E01B6CD;
        Tue,  8 Sep 2020 07:56:35 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/5] HWpoison: further fixes and cleanups
Date:   Tue,  8 Sep 2020 09:56:21 +0200
Message-Id: <20200908075626.11976-1-osalvador@suse.de>
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
  mm,hwpoison: Take free pages off the buddy freelists
  mm,hwpoison: Refactor madvise_inject_error
  mm,hwpoison: Drain pcplists before bailing out for non-buddy
    zero-refcount page
  mm,hwpoison: Drop unneeded pcplist draining
  mm,hwpoison: Remove stale code

 mm/madvise.c        | 34 ++++++++++++------------------
 mm/memory-failure.c | 50 +++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 34 deletions(-)

-- 
2.26.2

