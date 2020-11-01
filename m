Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82962A213D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgKAUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 15:12:59 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:34114 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgKAUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:12:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 214901DF8;
        Sun,  1 Nov 2020 20:12:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:988:989:1260:1311:1314:1345:1437:1515:1534:1539:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3351:3865:3866:3867:3868:3870:4605:5007:6261:10004:10848:11026:11658:11914:12043:12291:12296:12297:12679:12683:12895:13069:13311:13357:13894:14095:14096:14384:14394:14721:21080:21433:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: swing88_211050b272aa
X-Filterd-Recvd-Size: 1598
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 20:12:56 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mm: Convert sysfs sprintf family to sysfs_emit
Date:   Sun,  1 Nov 2020 12:12:47 -0800
Message-Id: <cover.1604261483.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new sysfs_emit family and not the sprintf family.

Joe Perches (5):
  mm: Use sysfs_emit for struct kobject * uses
  mm: huge_memory: Convert remaining use of sprintf to sysfs_emit and neatening
  mm:backing-dev: Use sysfs_emit in macro defining functions
  mm: shmem: Convert shmem_enabled_show to use sysfs_emit_at
  mm: slub: Convert sysfs sprintf family to sysfs_emit/sysfs_emit_at

 mm/backing-dev.c |   8 +--
 mm/huge_memory.c |  56 +++++++++++-------
 mm/hugetlb.c     |  13 +++--
 mm/khugepaged.c  |  22 +++----
 mm/ksm.c         |  32 +++++-----
 mm/shmem.c       |  21 ++++---
 mm/slub.c        | 148 ++++++++++++++++++++++++-----------------------
 mm/swap_state.c  |   3 +-
 8 files changed, 163 insertions(+), 140 deletions(-)

-- 
2.26.0

