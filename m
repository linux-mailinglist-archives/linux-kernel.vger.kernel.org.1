Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234A2A09B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJ3PY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgJ3PY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604071466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QwLkawJq9ox4OkwlI6rcfvvTwI6YSYml8hrmWz5QMs4=;
        b=LVYMPiojJTt3fBy+catAdG48iCQxvxVD4aYt5kdmhP6vUmVT5xc2fWPb8WGJ9bjMFm7wEc
        HvEA7yCVcHqqK7PgSOSpvlj1sGcEc12+ulyGlhue3hpgkHdl1LxwghXfBtJVX8ODItmkkM
        DitbvoGqCFVt/A33WWAcE9iBjuwWtM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-KjTXOrOBOp6_ImkjQbGxcg-1; Fri, 30 Oct 2020 11:24:22 -0400
X-MC-Unique: KjTXOrOBOp6_ImkjQbGxcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6A58F62E8;
        Fri, 30 Oct 2020 15:24:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D231109F192;
        Fri, 30 Oct 2020 15:24:17 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@redhat.com>
Subject: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
Date:   Fri, 30 Oct 2020 11:24:07 -0400
Message-Id: <20201030152407.43598-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need to call putname() before do_renameat2() returning -EINVAL
to avoid memory leaks.

Fixes: 3c5499fa56f5 ("fs: make do_renameat2() take struct filename")
Signed-off-by: Qian Cai <cai@redhat.com>
---
 fs/namei.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 27f5a4e025fd..9dc5e1b139c9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4362,11 +4362,11 @@ int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 	int error;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
-		return -EINVAL;
+		goto out;
 
 	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT)) &&
 	    (flags & RENAME_EXCHANGE))
-		return -EINVAL;
+		goto out;
 
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
@@ -4486,6 +4486,14 @@ int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 	}
 exit:
 	return error;
+out:
+	if (!IS_ERR(oldname))
+		putname(oldname);
+
+	if (!IS_ERR(newname))
+		putname(newname);
+
+	return -EINVAL;
 }
 
 SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
-- 
2.28.0

