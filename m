Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B729D85D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgJ1Wbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgJ1Wba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=J0xULd9Gnp2Y1H3NgBBIqBBMdY9D5TWHhLQFKvUwk0Q=; b=ByipIkb76f0WMClntW0L48i16z
        wNIvst9S9R3DehaeQ5XNPuLWqRk9k9e7I8x8Lj5t/QO+KwSkqGvKqaLp7e3kpeDuNYubn5nGszw7o
        ci0xsJC7WWm3mwOQwAlRI3vx4iLg02mgodTX4idgtKMZ67iNjAW+dVfbIO8JWqbxnbg68I28j22Fo
        qcWH5fwLm98K+zJcpCSo4+o5TQw5QP9RHi4VtQ0Ujbhgch0UixBR9mRITVFYa3C20ACMkfgz5p1YR
        dp8yiZaJxzxNkEZ0z1PbSn0nT8gxl35IHRFk8FAs/CANU2zC8+I2n355q5tZ3xPZeyKlYXctBZGWy
        4Bb1nyPQ==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXqut-0004iN-U3; Wed, 28 Oct 2020 19:15:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] procfs: delete duplicated words + other fixes
Date:   Wed, 28 Oct 2020 12:15:25 -0700
Message-Id: <20201028191525.13413-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete repeated words in fs/proc/.
{the, which}
where "which which" was changed to "with which".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
This is a resend because Alexey requested that I send this thru Andrew.

 fs/proc/base.c     |    2 +-
 fs/proc/proc_net.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200804.orig/fs/proc/base.c
+++ linux-next-20200804/fs/proc/base.c
@@ -2016,7 +2016,7 @@ const struct dentry_operations pid_dentr
  * file type from dcache entry.
  *
  * Since all of the proc inode numbers are dynamically generated, the inode
- * numbers do not exist until the inode is cache.  This means creating the
+ * numbers do not exist until the inode is cache.  This means creating
  * the dcache entry in readdir is necessary to keep the inode numbers
  * reported by readdir in sync with the inode numbers reported
  * by stat.
--- linux-next-20200804.orig/fs/proc/proc_net.c
+++ linux-next-20200804/fs/proc/proc_net.c
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_data);
  * @mode: The file's access mode.
  * @parent: The parent directory in which to create.
  * @ops: The seq_file ops with which to read the file.
- * @write: The write method which which to 'modify' the file.
+ * @write: The write method with which to 'modify' the file.
  * @data: Data for retrieval by PDE_DATA().
  *
  * Create a network namespaced proc file in the @parent directory with the
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_single
  * @mode: The file's access mode.
  * @parent: The parent directory in which to create.
  * @show: The seqfile show method with which to read the file.
- * @write: The write method which which to 'modify' the file.
+ * @write: The write method with which to 'modify' the file.
  * @data: Data for retrieval by PDE_DATA().
  *
  * Create a network-namespaced proc file in the @parent directory with the
