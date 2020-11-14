Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30F72B2ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKNRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 12:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgKNRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 12:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605374156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YQLowdxGlMEyZdFvJbR1bzJYwIvZNLk9X1xruKsNhMI=;
        b=b6L49ADagHr6dxbhJad1tGF+5Fj9yxsnNZbmz9ijzCQYfl+sIH/srTYPeZBXDzTUhMTKjR
        cFpSoVKX+IB+jnudGyEkdhCCJ+hlCyVRMsh8mJhvqjaqa9TTBhb38GE1BtuGn8mtiOOb8w
        mhO9qA24jy0rxi6T/TIIDKWnJvf2j+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-if28wJAQMB2-_D8HdYYYRg-1; Sat, 14 Nov 2020 12:15:54 -0500
X-MC-Unique: if28wJAQMB2-_D8HdYYYRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC9157052;
        Sat, 14 Nov 2020 17:15:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 348802C31E;
        Sat, 14 Nov 2020 17:15:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_write_end() when called with copied == 0
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Nov 2020 17:15:51 +0000
Message-ID: <160537415141.3024088.7100009150583164795.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When afs_write_end() is called with copied == 0, it tries to set the dirty
region, but there's no way to actually encode a 0-length region in the
encoding in page->private.  "0,0", for example, indicates a 1-byte region
at offset 0.  The maths miscalculates this and sets it incorrectly.

Fix it to just do nothing but unlock and put the page in this case.  We
don't actually need to mark the page dirty as nothing presumably changed.

Fixes: 65dd2d6072d3 ("afs: Alter dirty range encoding in page->private")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/write.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 50371207f327..f34d13d294fa 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -174,6 +174,9 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
 
+	if (copied == 0)
+		goto out;
+
 	maybe_i_size = pos + copied;
 
 	i_size = i_size_read(&vnode->vfs_inode);


