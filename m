Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9592528D082
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgJMOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:43:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:36758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJMOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:43:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC956B1A9;
        Tue, 13 Oct 2020 14:43:27 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 0/4] HWpoison: further fixes and cleanups
Date:   Tue, 13 Oct 2020 16:44:43 +0200
Message-Id: <20201013144447.6706-1-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes some more fixes and a cleanup.

Patch#2 and patch#3 are both fixes for taking a HWpoison page off a buddy
freelist, since having them there has proved to be bad (see [1] and
pathch#2's commit log).
Patch#3 does the same for hugetlb pages.

[1] https://lkml.org/lkml/2020/9/22/565

Thanks

Oscar Salvador (4):
  mm,hwpoison: drain pcplists before bailing out for non-buddy
    zero-refcount page
  mm,hwpoison: take free pages off the buddy freelists
  mm,hwpoison: take free pages off the buddy freelists for hugetlb
  mm,hwpoison: drop unneeded pcplist draining

 mm/madvise.c        |  5 ----
 mm/memory-failure.c | 70 +++++++++++++++++++++++++++++++++------------
 2 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.26.2

