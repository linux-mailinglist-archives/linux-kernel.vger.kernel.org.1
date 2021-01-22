Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE28300F37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbhAVVuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:50:39 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:32918 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbhAVVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:31:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2197D181CBE08;
        Fri, 22 Jan 2021 22:22:36 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8QZnjaY9GVmZ; Fri, 22 Jan 2021 22:22:35 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5sE-lpCPrN4m; Fri, 22 Jan 2021 22:22:35 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     david@sigma-star.at, richard@nod.at, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ubifs: Harden ubifs_jnl_write_inode()
Date:   Fri, 22 Jan 2021 22:22:29 +0100
Message-Id: <20210122212229.17072-5-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210122212229.17072-1-richard@nod.at>
References: <20210122212229.17072-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that ubifs_jnl_write_inode() cannot be abused and will
not write less data then expected.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/journal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 03410ae0813a..1b28fcc5b9fe 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -844,10 +844,12 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, con=
st struct inode *inode)
 	struct ubifs_ino_node *ino, *ino_start;
 	struct ubifs_inode *ui =3D ubifs_inode(inode);
 	int sync =3D 0, write_len =3D 0, ilen =3D UBIFS_INO_NODE_SZ;
-	int last_reference =3D !inode->i_nlink;
+	int last_reference =3D !inode->i_nlink, xattr_inos_written =3D 0;
 	int kill_xattrs =3D ui->xattr_cnt && last_reference;
 	u8 hash[UBIFS_HASH_ARR_SZ];
=20
+	ubifs_assert(c, !ui->xattr);
+
 	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
=20
 	/*
@@ -917,12 +919,14 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, con=
st struct inode *inode)
 			pack_inode(c, ino, xino, 0);
 			ino =3D (void *)ino + UBIFS_INO_NODE_SZ;
 			iput(xino);
+			xattr_inos_written++;
=20
 			kfree(pxent);
 			pxent =3D xent;
 			key_read(c, &xent->key, &key);
 		}
 		kfree(pxent);
+		ubifs_assert(c, xattr_inos_written =3D=3D ui->xattr_cnt);
 	}
=20
 	pack_inode(c, ino, inode, 1);
--=20
2.26.2

