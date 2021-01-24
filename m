Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A83301F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAXXWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 18:22:02 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:46984 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbhAXXVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:21:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2AF42181D91AC;
        Mon, 25 Jan 2021 00:21:01 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G1T-RcRj43zU; Mon, 25 Jan 2021 00:21:00 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 86Bd4mavDEFC; Mon, 25 Jan 2021 00:21:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/8] fuse: Export IO helpers
Date:   Mon, 25 Jan 2021 00:20:01 +0100
Message-Id: <20210124232007.21639-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MUSE will use this functions in its IO path,
so export them.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/file.c   | 16 +++-------------
 fs/fuse/fuse_i.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..d41660b7f5bc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -20,8 +20,8 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
=20
-static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
-				      struct fuse_page_desc **desc)
+struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
+			       struct fuse_page_desc **desc)
 {
 	struct page **pages;
=20
@@ -31,6 +31,7 @@ static struct page **fuse_pages_alloc(unsigned int npag=
es, gfp_t flags,
=20
 	return pages;
 }
+EXPORT_SYMBOL_GPL(fuse_pages_alloc);
=20
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid, struct file=
 *file,
 			  int opcode, struct fuse_open_out *outargp)
@@ -1356,17 +1357,6 @@ static inline void fuse_page_descs_length_init(str=
uct fuse_page_desc *descs,
 		descs[i].length =3D PAGE_SIZE - descs[i].offset;
 }
=20
-static inline unsigned long fuse_get_user_addr(const struct iov_iter *ii=
)
-{
-	return (unsigned long)ii->iov->iov_base + ii->iov_offset;
-}
-
-static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
-					size_t max_size)
-{
-	return min(iov_iter_single_seg_count(ii), max_size);
-}
-
 static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_it=
er *ii,
 			       size_t *nbytesp, int write,
 			       unsigned int max_pages)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7c4b8cb93f9f..8c56a3fd2c4e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -31,6 +31,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/uio.h>
=20
 /** Default max number of pages that can be used in a single read reques=
t */
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
@@ -871,6 +872,17 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
=20
+static inline unsigned long fuse_get_user_addr(const struct iov_iter *ii=
)
+{
+	return (unsigned long)ii->iov->iov_base + ii->iov_offset;
+}
+
+static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
+					size_t max_size)
+{
+	return min(iov_iter_single_seg_count(ii), max_size);
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
=20
@@ -1213,4 +1225,8 @@ void fuse_dax_inode_cleanup(struct inode *inode);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_ali=
gnment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
=20
+/* file.c */
+struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
+			       struct fuse_page_desc **desc);
+
 #endif /* _FS_FUSE_I_H */
--=20
2.26.2

