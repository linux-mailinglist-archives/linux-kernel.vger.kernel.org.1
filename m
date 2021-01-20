Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFF2FCA22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbhATEyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:54:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbhATExx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611118345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/8WS3H42aR1zsrNriB4Gm0bVye82UhBg/CcjDS9qLJs=;
        b=hLpftof+FfQ3t+hnOMLH0cnhv5fnZd5wa58RC/tj02aB5flgMtuSIZwEDdl/OM+uK3/qOo
        DwQ2wGIgcOZg8XGe8y2lLV32wMDCp9fAbv2KoZnsfFL/UXGbkmHxZK4BcwDuhpdo8+CgaV
        AeHVQ0VI7D/5PK+RlRSVQQV9C2MWGpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-CeTqUKB6MPOzkNNfd2glIg-1; Tue, 19 Jan 2021 23:52:21 -0500
X-MC-Unique: CeTqUKB6MPOzkNNfd2glIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7507F801817;
        Wed, 20 Jan 2021 04:52:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC9C7092B;
        Wed, 20 Jan 2021 04:52:14 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v4 0/4] mm: clean up names and parameters of memmap_init_xxxx functions
Date:   Wed, 20 Jan 2021 12:52:09 +0800
Message-Id: <20210120045213.6571-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is correcting inappropriate function names of
memmap_init_xxx, and simplify parameters of functions in the code flow
when I tried to fix a regression bug in memmap defer init. 

This is based on the latest next/master.

v3 can be found here:
https://lore.kernel.org/linux-mm/20210105074708.18483-1-bhe@redhat.com/

v3->v4:
 - Rebased patch 1, 2 on top of Mike's below new patch.
   [PATCH v3 0/2] mm: fix initialization of struct page for holes in  memory layout
  
 - Move the code of renaming function parameter 'range_start_pfn' and local
   variable 'range_end_pfn' of memmap_init() from patch 1 to patch 2
   according to David's comment.

 - Use the reverse Christmas tree style to reorder the local variables
   in memmap_init_zone() in patch 2 accodrding to David's comment.

Baoquan He (4):
  mm: rename memmap_init() and memmap_init_zone()
  mm: simplify parater of function memmap_init_zone()
  mm: simplify parameter of setup_usemap()
  mm: remove unneeded local variable in free_area_init_core

 arch/ia64/include/asm/pgtable.h |  3 +--
 arch/ia64/mm/init.c             | 14 +++++-----
 include/linux/mm.h              |  2 +-
 mm/memory_hotplug.c             |  2 +-
 mm/page_alloc.c                 | 46 ++++++++++++++-------------------
 5 files changed, 31 insertions(+), 36 deletions(-)

-- 
2.17.2

