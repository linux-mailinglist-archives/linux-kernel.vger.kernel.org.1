Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4462657C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgIKD7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 23:59:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725648AbgIKD64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:58:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 581677D1528170FD2269;
        Fri, 11 Sep 2020 11:58:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 11:58:46 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <sfrench@samba.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 5/5] cifs: fix comparison to bool warning in smb2ops.c
Date:   Fri, 11 Sep 2020 12:05:39 +0800
Message-ID: <20200911040539.113307-6-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200911040539.113307-1-zhengbin13@huawei.com>
References: <20200911040539.113307-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

fs/cifs/smb2ops.c:3199:6-15: WARNING: Comparison to bool
fs/cifs/smb2ops.c:3223:5-14: WARNING: Comparison to bool
fs/cifs/smb2ops.c:3301:6-15: WARNING: Comparison to bool
fs/cifs/smb2ops.c:3311:6-15: WARNING: Comparison to bool
fs/cifs/smb2ops.c:3341:6-15: WARNING: Comparison to bool

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 fs/cifs/smb2ops.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 32f90dc82c84..213a0e3d9f76 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3196,7 +3196,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,

 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
-		if (keep_size == false) {
+		if (!keep_size) {
 			rc = -EOPNOTSUPP;
 			trace_smb3_zero_err(xid, cfile->fid.persistent_fid,
 				tcon->tid, ses->Suid, offset, len, rc);
@@ -3220,7 +3220,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * do we also need to change the size of the file?
 	 */
-	if (keep_size == false && i_size_read(inode) < offset + len) {
+	if (!keep_size && i_size_read(inode) < offset + len) {
 		eof = cpu_to_le64(offset + len);
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
@@ -3298,7 +3298,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 				tcon->ses->Suid, off, len);
 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
-		if (keep_size == false) {
+		if (!keep_size) {
 			trace_smb3_falloc_err(xid, cfile->fid.persistent_fid,
 				tcon->tid, tcon->ses->Suid, off, len, rc);
 			free_xid(xid);
@@ -3308,7 +3308,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * Extending the file
 	 */
-	if ((keep_size == false) && i_size_read(inode) < off + len) {
+	if (!keep_size && i_size_read(inode) < off + len) {
 		rc = inode_newsize_ok(inode, off + len);
 		if (rc)
 			goto out;
@@ -3338,7 +3338,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		goto out;
 	}

-	if ((keep_size == true) || (i_size_read(inode) >= off + len)) {
+	if (keep_size || (i_size_read(inode) >= off + len)) {
 		/*
 		 * Check if falloc starts within first few pages of file
 		 * and ends within a few pages of the end of file to
--
2.26.0.106.g9fadedd

