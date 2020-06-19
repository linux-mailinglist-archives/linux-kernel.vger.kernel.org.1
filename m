Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363652009F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgFSNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 09:24:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57116 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732284AbgFSNYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592573083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SeUhzn3LdY5rlFLoRtP7OyzBplT1sTQKVu/qNGGh0Sc=;
        b=KuQKykJ68QV5fbx3VnQIvLxIEg2gALDgcSfr0xtAYswIEK8J1lBw4bzJESLpLXiP0HWgK2
        mVP0xX0nA8L8jG4Psbuqhm46Zk06GjTD5onmQy9E/4lSHzE85iOJsHaKJM2pxmvKMON8j4
        vnwQA/pSclnwG5plPbUJ3KcQoPgtneI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-uAX2pE9fO7qYHQFJvuugMA-1; Fri, 19 Jun 2020 09:24:40 -0400
X-MC-Unique: uAX2pE9fO7qYHQFJvuugMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C00364AD9;
        Fri, 19 Jun 2020 13:24:16 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5518CBE81;
        Fri, 19 Jun 2020 13:24:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/2] mm: vm_total_pages and build_all_zonelists() cleanup
Date:   Fri, 19 Jun 2020 15:24:08 +0200
Message-Id: <20200619132410.23859-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's drop vm_total_pages and inline nr_free_pagecache_pages() into
build_all_zonelists().

David Hildenbrand (2):
  mm: drop vm_total_pages
  mm/page_alloc: drop nr_free_pagecache_pages()

 include/linux/swap.h |  2 --
 mm/memory_hotplug.c  |  3 ---
 mm/page-writeback.c  |  6 ++----
 mm/page_alloc.c      | 18 ++++--------------
 mm/vmscan.c          |  5 -----
 5 files changed, 6 insertions(+), 28 deletions(-)

-- 
2.26.2

