Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37B2CEC23
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgLDK0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:26:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgLDK0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:26:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 824F5ACB5;
        Fri,  4 Dec 2020 10:26:04 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, vbabka@suse.cz, qcai@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/3] HWPoison: Refactor get page interface
Date:   Fri,  4 Dec 2020 11:25:55 +0100
Message-Id: <20201204102558.31607-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is v2.
I left out the MF_COUNT_INCREASED changes as we need to have the
pages pinned when coming from madvise, otherwise we might be messing
with a page which belongs to someone else.

I ran several tests [1] [2] to make sure nothing is broken.

 @Andrew: Please, remove [3] from mmotm and linux-next and replace it
          with this one.

Thanks

[1] https://github.com/Naoya-Horiguchi/mm_regression
[2] https://e.coding.net/cailca/linux/mm
[3] https://patchwork.kernel.org/project/linux-mm/cover/20201119105716.5962-1-osalvador@suse.de/

V1 -> V2:
 - Adressed feedback from Vlastimil
 - Add Acked-by from Vlastimil

Oscar Salvador (3):
  mm,hwpoison: Refactor get_any_page
  mm,hwpoison: Disable pcplists before grabbing a refcount
  mm,hwpoison: Remove drain_all_pages from shake_page

 mm/memory-failure.c | 168 +++++++++++++++++++-------------------------
 1 file changed, 74 insertions(+), 94 deletions(-)

-- 
2.26.2

