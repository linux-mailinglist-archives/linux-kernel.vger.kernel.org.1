Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1529DCD9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgJ2Acv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733176AbgJ1WXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ne++NwAowBsZnEzENFSXOGSBJsnQe3xK6jfU1qsRalc=;
        b=Dy/2fK9FNGXzjdrCcjZML3oiDwP/SdfaE2A6TcjWWqqKkTJpZxSVf4KckWhZtt0qONxSRu
        ZQl7ICV/YUOgJvRiADFlNCuWnze15naVhhKsh1FeIPh50bwHwPeE+Pxa0Afrz/DS/OT+0o
        WKM2LOUqeuy4IZY4IXe3aH7dZL6g3Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-jVl6CifXPDG0Hr_b1AbcPA-1; Wed, 28 Oct 2020 18:23:21 -0400
X-MC-Unique: jVl6CifXPDG0Hr_b1AbcPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1830C8049DE;
        Wed, 28 Oct 2020 22:23:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32AED19D61;
        Wed, 28 Oct 2020 22:23:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/11] afs: Fix page leak on afs_write_begin() failure
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Nick Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:23:18 +0000
Message-ID: <160392379844.592578.11228676987413311828.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the leak of the target page in afs_write_begin() when it fails.

Fixes: 15b4650e55e0 ("afs: convert to new aops")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Nick Piggin <npiggin@gmail.com>
---

 fs/afs/write.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 50d5ff4ad70d..6eb367d04eda 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -76,7 +76,7 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
  */
 int afs_write_begin(struct file *file, struct address_space *mapping,
 		    loff_t pos, unsigned len, unsigned flags,
-		    struct page **pagep, void **fsdata)
+		    struct page **_page, void **fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct page *page;
@@ -110,9 +110,6 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		SetPageUptodate(page);
 	}
 
-	/* page won't leak in error case: it eventually gets cleaned off LRU */
-	*pagep = page;
-
 try_again:
 	/* See if this page is already partially written in a way that we can
 	 * merge the new write with.
@@ -155,6 +152,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		set_page_private(page, priv);
 	else
 		attach_page_private(page, (void *)priv);
+	*_page = page;
 	_leave(" = 0");
 	return 0;
 
@@ -164,17 +162,18 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 flush_conflicting_write:
 	_debug("flush conflict");
 	ret = write_one_page(page);
-	if (ret < 0) {
-		_leave(" = %d", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto error;
 
 	ret = lock_page_killable(page);
-	if (ret < 0) {
-		_leave(" = %d", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto error;
 	goto try_again;
+
+error:
+	put_page(page);
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*


