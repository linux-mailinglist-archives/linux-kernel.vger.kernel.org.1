Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E782302C19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbhAYT6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732022AbhAYTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:52:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596ABC061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Du/q5LRry+qwFWg6D6J8n4Tp2lbFgXQBONbvdq1RoxI=; b=EUbx38SULFVOZla3Li/Ps//cmQ
        5806UI+xS1E6FYpo/85hoj4d5UK6PVShPFSRFtHVl1v+Ecch0zoA7C7XUmd36vR7ia3REBgL2wXmP
        yYx8Fd5zRPkspFQDjvM14QS8CbOaltRhTLRNCzcY8Rv7DLCAoYhWqCikDS6y93MNPHtEIM4qxo2e9
        svZNWKrXAgCdGM+qzdiExY6zSfuL1RIXZq2CIR4jSFa0aAmLWXT2tnMrMXF1DCCZAOhAkpQTctJXD
        kK8uWjv3mF1hmFGeQw7hioMYEHwzksxlp7jfZT+vVt7q950JmyaCPmO6QnBFzflGRHZQwv/f12EGO
        Rxo37hdw==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l47tf-0007C7-R3; Mon, 25 Jan 2021 19:51:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH RESEND] fs: afs: delete repeated words in comments
Date:   Mon, 25 Jan 2021 11:51:30 -0800
Message-Id: <20210125195130.24735-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words {the, consider} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org
---
 fs/afs/flock.c  |    2 +-
 fs/afs/rotate.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/afs/flock.c
+++ linux-next-20200807/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_v
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
--- linux-next-20200807.orig/fs/afs/rotate.c
+++ linux-next-20200807/fs/afs/rotate.c
@@ -236,7 +236,7 @@ bool afs_select_fileserver(struct afs_op
 
 		case VMOVED:
 			/* The volume migrated to another server.  We consider
-			 * consider all locks and callbacks broken and request
+			 * all locks and callbacks broken and request
 			 * an update from the VLDB.
 			 *
 			 * We also limit the number of VMOVED hops we will
