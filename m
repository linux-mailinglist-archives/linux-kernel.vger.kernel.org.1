Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CADC3004CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbhAVOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:03:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbhAVOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611324011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bVl+s9G2fJlIxrzrDasHbmLMepcSpXcYlZqYRn6El3M=;
        b=B+ygcWww1nGmCrP0H7SWyOXGrNrKoEcxeGxluxNvS6DklsonKO7nPKuS+A0NQsw3st/VU7
        1MH8wSMCFU04vJ44geTkgUlVQxl8CT4xR8Zekh+mmgh2bSCUIheBx9RBbqs0QkZqPNJqt2
        TzrE6dw/SsCBI7+9O3b8i1Sg9oV6zvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-QvjFMAs9M2Co55ASvyTAgQ-1; Fri, 22 Jan 2021 09:00:09 -0500
X-MC-Unique: QvjFMAs9M2Co55ASvyTAgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A65E9425D6;
        Fri, 22 Jan 2021 14:00:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9414019C59;
        Fri, 22 Jan 2021 13:59:57 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com, lkp@intel.com
Subject: [PATCH v5 0/5] mm: clean up names and parameters of memmap_init_xxxx functions
Date:   Fri, 22 Jan 2021 21:59:51 +0800
Message-Id: <20210122135956.5946-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is correcting inappropriate function names of
memmap_init_xxx, and simplify parameters of functions in the code flow.
And also fix a prototype warning reported by lkp.

This is based on the latest next/master.

V4 can be found here:
https://lore.kernel.org/linux-mm/20210120045213.6571-1-bhe@redhat.com/

v4->v5:
 - Add patch 1 into series which fixes a prototype warning from kernel
   test robot. Then rebase the v4 patches on top of it.

v3->v4:
 - Rebased patch 1, 2 on top of Mike's below new patch.
   [PATCH v3 0/2] mm: fix initialization of struct page for holes in  memory layout

 - Move the code of renaming function parameter 'range_start_pfn' and local
   variable 'range_end_pfn' of memmap_init() from patch 1 to patch 2
   according to David's comment.

 - Use the reverse Christmas tree style to reorder the local variables
   in memmap_init_zone() in patch 2 accodrding to David's comment.

Baoquan He (5):
  mm: fix prototype warning from kernel test robot
  mm: rename memmap_init() and memmap_init_zone()
  mm: simplify parater of function memmap_init_zone()
  mm: simplify parameter of setup_usemap()
  mm: remove unneeded local variable in free_area_init_core

 arch/ia64/include/asm/pgtable.h |  6 -----
 arch/ia64/mm/init.c             | 14 +++++-----
 include/linux/mm.h              |  3 ++-
 mm/memory_hotplug.c             |  2 +-
 mm/page_alloc.c                 | 46 ++++++++++++++-------------------
 5 files changed, 31 insertions(+), 40 deletions(-)

-- 
2.17.2

