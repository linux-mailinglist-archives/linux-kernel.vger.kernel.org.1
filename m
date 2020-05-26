Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598BE19C7AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbgDBRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 13:11:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgDBRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585847475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=umWPoQrI980x5zzMSW5/7VpEhYybv0fVnNUHzVpWWpc=;
        b=cuhcJ+o5NJbfNcwiTlCY852ldIQV10cRyJ2GDbxSquo6z/z58FnYypW1NHhKnhBt6bsNdY
        nKcVwqfRRvps5kFvqxv+Y5vsU7CQsM8MdDmuvNs8XsUHRQRSbqoTfWMmO/SFrJqi2PJFuq
        Fe6EiFPJXjrsIdxUSz4fVwPQ8Qcfito=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-hPib8IDRP_WmKbz_ATvcTw-1; Thu, 02 Apr 2020 13:11:11 -0400
X-MC-Unique: hPib8IDRP_WmKbz_ATvcTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B160192D788;
        Thu,  2 Apr 2020 17:11:10 +0000 (UTC)
Received: from llong.com (ovpn-112-134.rdu2.redhat.com [10.10.112.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7F855C3F8;
        Thu,  2 Apr 2020 17:11:05 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] kernfs: Change kernfs_node lockdep name to "kn->active"
Date:   Thu,  2 Apr 2020 13:10:56 -0400
Message-Id: <20200402171056.27871-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernfs_node lockdep tracking is being done on kn->active, the
active reference count. The other reference count (kn->count) is not
tracked by lockdep. So change the lockdep name to reflect what it is
tracking.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 34366db3620d..fd6ddfe4cd94 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -1010,7 +1010,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	if (key) {
-		lockdep_init_map(&kn->dep_map, "kn->count", key, 0);
+		lockdep_init_map(&kn->dep_map, "kn->active", key, 0);
 		kn->flags |= KERNFS_LOCKDEP;
 	}
 #endif
-- 
2.18.1

