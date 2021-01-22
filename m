Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23337300D56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbhAVUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:06:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbhAVON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:13:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C2F923A9B;
        Fri, 22 Jan 2021 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611324608;
        bh=Ohi3lbdYamlZv7/5kwTSRLQED6psUb4Pb71oq58o9pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrkeSevS5uRjzjvHlCFo5U/j5hNPVBWNbB1D0q+GKVdNCnupf4I/cn8JWXH7R6/SJ
         CkILEC8KPI+5TlGzyhUZuaZAMxZgO25FJ07uqr8Ep26RMiPWFH6GPIfHkNbp9fSvVy
         OHu4GKMmNPxLDgElcsxgto3SRRje+4qE2fpWQSWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.4 14/31] NFS: nfs_igrab_and_active must first reference the superblock
Date:   Fri, 22 Jan 2021 15:08:28 +0100
Message-Id: <20210122135732.446757237@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122135731.873346566@linuxfoundation.org>
References: <20210122135731.873346566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 896567ee7f17a8a736cda8a28cc987228410a2ac upstream.

Before referencing the inode, we must ensure that the superblock can be
referenced. Otherwise, we can end up with iput() calling superblock
operations that are no longer valid or accessible.

Fixes: ea7c38fef0b7 ("NFSv4: Ensure we reference the inode for return-on-close in delegreturn")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/internal.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -534,12 +534,14 @@ extern int nfs41_walk_client_list(struct
 
 static inline struct inode *nfs_igrab_and_active(struct inode *inode)
 {
-	inode = igrab(inode);
-	if (inode != NULL && !nfs_sb_active(inode->i_sb)) {
-		iput(inode);
-		inode = NULL;
+	struct super_block *sb = inode->i_sb;
+
+	if (sb && nfs_sb_active(sb)) {
+		if (igrab(inode))
+			return inode;
+		nfs_sb_deactive(sb);
 	}
-	return inode;
+	return NULL;
 }
 
 static inline void nfs_iput_and_deactive(struct inode *inode)


