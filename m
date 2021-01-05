Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB12EA620
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbhAEHss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbhAEHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609832841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=wOy4fK678d0NueCMqqzfT88gnxVHOqdKrxq/VekxyZo=;
        b=dAhwTj9+asnqiQ3LBHUZKB8akxf6sJgGB/zPLWSivux0BTqNOCK8rs9kny2OHx0rJboa2J
        dZ5L7KwxdnPqE17+G7QF40T1XYvWv0hN9dMFSOTHRrfUXPHVcZjxGMc8p/yxO3OKzZ+o4L
        VCvthLqw0EqThqMw4RwkE6V5EmtvY4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-fUe9xwRuP4me0ntpRdt3Mw-1; Tue, 05 Jan 2021 02:47:17 -0500
X-MC-Unique: fUe9xwRuP4me0ntpRdt3Mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52498015DC;
        Tue,  5 Jan 2021 07:47:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-56.pek2.redhat.com [10.72.13.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E02A71CA2;
        Tue,  5 Jan 2021 07:47:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v3 0/4] mm: clean up names and parameters of memmap_init_xxxx functions
Date:   Tue,  5 Jan 2021 15:47:04 +0800
Message-Id: <20210105074708.18483-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is correcting inappropriate function names of
memmap_init_xxx, and simplify parameters of functions in the code flow
when I tried to fix a regression bug in memmap defer init. These are
taken from the v2 patchset, the bug fixing patch has bee sent alone and
merged. So send the rest as v3.

No any change comparing with v2, except of adding Mike's 'Reviewed-by' tag.

V2 post is here:
https://lore.kernel.org/linux-mm/20201220082754.6900-1-bhe@redhat.com/

Baoquan He (4):
  mm: rename memmap_init() and memmap_init_zone()
  mm: simplify parater of function memmap_init_zone()
  mm: simplify parameter of setup_usemap()
  mm: remove unneeded local variable in free_area_init_core

 arch/ia64/include/asm/pgtable.h |  3 +-
 arch/ia64/mm/init.c             | 14 +++++----
 include/linux/mm.h              |  2 +-
 mm/memory_hotplug.c             |  2 +-
 mm/page_alloc.c                 | 54 +++++++++++++++------------------
 5 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.17.2

