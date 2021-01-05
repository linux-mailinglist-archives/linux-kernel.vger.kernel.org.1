Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45BA2EAD36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbhAEOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbhAEOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609856079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FFhE3QWiTuwXxm7OOOvYxjR2y1OcGJ9OkHckxaAUKOg=;
        b=BGDefi9Pjf4kSDMv/8kTTTfroemPMHwdbZ/FK5HmRtRdtuUVvkJo8+qufdB+GKxKDd0OYi
        WlvUn/476zAZXDVPbe1+xt0g/VR1cU5JJyhD+28Roa2g3C1J7mR+4FcWXY6lTJvkGhKWAl
        NymnfMnAlc5AZ0PdSrwy5REZdaxPRSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-WmPIvgh9OzCVoS7xFTbaoQ-1; Tue, 05 Jan 2021 09:14:35 -0500
X-MC-Unique: WmPIvgh9OzCVoS7xFTbaoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC5E180A095;
        Tue,  5 Jan 2021 14:14:33 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.36.110.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64C925D6D3;
        Tue,  5 Jan 2021 14:14:30 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, jack@suse.cz,
        willy@infradead.org, mgorman@suse.de, mhocko@suse.com,
        songliubraving@fb.com, akpm@linux-foundation.org,
        jstancek@redhat.com
Subject: [PATCH] mm: migrate: initialize err in do_migrate_pages
Date:   Tue,  5 Jan 2021 15:14:20 +0100
Message-Id: <456a021c7ef3636d7668cec9dcb4a446a4244812.1609855564.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 236c32eb1096 ("mm: migrate: clean up migrate_prep{_local}")',
do_migrate_pages can return uninitialized variable 'err' (which is
propagated to user-space as error) when 'from' and 'to' nodesets
are identical. This can be reproduced with LTP migrate_pages01,
which calls migrate_pages() with same set for both old/new_nodes.

Add 'err' initialization back.

Fixes: 236c32eb1096 ("mm: migrate: clean up migrate_prep{_local}")
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8cf96bd21341..2c3a86502053 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1111,7 +1111,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		     const nodemask_t *to, int flags)
 {
 	int busy = 0;
-	int err;
+	int err = 0;
 	nodemask_t tmp;
 
 	migrate_prep();
-- 
2.18.1

