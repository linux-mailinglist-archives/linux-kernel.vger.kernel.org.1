Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC325225792
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGTG0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 02:26:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23639 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbgGTG0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595226390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sumRvwSTbxBORUEi/iKTdK+XpZsHbvlEnY9UD4E9X0k=;
        b=Ev7xTj5cRbzYonqQPBGp1Q5lyOZXoUhNfm07Mk78u+cH9vNvY+0rM9pY4vHzUuZTeMScFH
        rq6NcLzcJHXQWc7Pczu+A/F6Ywh0ewdzg3Yh2JvuANA5F0AXgtTojaS4wBt+iFi9gEu1qx
        YSvMJNjGNcq7c9suWNOcOyWB5ayK1G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-RYo64Zx3NVOLsu4tuKi0hQ-1; Mon, 20 Jul 2020 02:26:28 -0400
X-MC-Unique: RYo64Zx3NVOLsu4tuKi0hQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 274CD800688;
        Mon, 20 Jul 2020 06:26:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 229B878526;
        Mon, 20 Jul 2020 06:26:24 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH 0/5] mm/hugetlb: Small cleanup and improvement
Date:   Mon, 20 Jul 2020 14:26:18 +0800
Message-Id: <20200720062623.13135-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1~4 are small cleanup.

Patch 5 is to add warning message when failed to increase or decrease
the expected number of persistent huge pages by writing into
/proc/sys/vm/nr_hugepages
/sys/kernel/mm/hugepages/hugepages-xxx/nr_hugepages.

Baoquan He (5):
  mm/hugetlb.c: Fix typo of glb_reserve
  mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned return bool
  mm/hugetlb.c: Remove the unnecessary non_swap_entry()
  doc/vm: fix typo in in the hugetlb admin documentation
  mm/hugetl.c: warn out if expected count of huge pages adjustment is
    not achieved

 Documentation/admin-guide/mm/hugetlbpage.rst |  2 +-
 mm/hugetlb.c                                 | 49 ++++++++++++--------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.17.2

