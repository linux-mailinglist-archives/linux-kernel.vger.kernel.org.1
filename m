Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF612B2FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKNSue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:50:34 -0500
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:51136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbgKNSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:50:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 66D15837F24D;
        Sat, 14 Nov 2020 18:50:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1540:1711:1730:1747:1777:1792:2393:2559:2562:2895:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:4605:5007:6261:10004:10848:11026:11658:11914:12043:12291:12296:12297:12438:12679:12683:12895:13069:13095:13311:13357:13894:14095:14096:14384:14394:14721:21080:21433:21451:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bit08_130d4de27319
X-Filterd-Recvd-Size: 1734
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Nov 2020 18:50:29 +0000 (UTC)
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
Subject: [PATCH V2 0/5] mm: Convert sysfs sprintf family to sysfs_emit
Date:   Sat, 14 Nov 2020 10:50:21 -0800
Message-Id: <cover.1605376435.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new sysfs_emit family and not the sprintf family.

V2: Correct missing page test defect in mm/slub.c slabs_cpu_partial_show()
    Trivial update to commit message in mm: shmem

Joe Perches (5):
  mm: Use sysfs_emit for struct kobject * uses
  mm: huge_memory: Convert remaining use of sprintf to sysfs_emit and
    neatening
  mm:backing-dev: Use sysfs_emit in macro defining functions
  mm: shmem: Convert shmem_enabled_show to use sysfs_emit_at
  mm: slub: Convert sysfs sprintf family to sysfs_emit/sysfs_emit_at

 mm/backing-dev.c |   8 +--
 mm/huge_memory.c |  56 +++++++++++-------
 mm/hugetlb.c     |  13 ++--
 mm/khugepaged.c  |  22 +++----
 mm/ksm.c         |  32 +++++-----
 mm/shmem.c       |  21 ++++---
 mm/slub.c        | 150 ++++++++++++++++++++++++-----------------------
 mm/swap_state.c  |   3 +-
 8 files changed, 164 insertions(+), 141 deletions(-)

-- 
2.26.0

