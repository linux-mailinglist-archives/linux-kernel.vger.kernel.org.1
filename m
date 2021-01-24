Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E552301F93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbhAXXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 18:23:34 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47182 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbhAXXWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:22:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id C27B2180FCFCB;
        Mon, 25 Jan 2021 00:21:02 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0zSQ5wgsYSEQ; Mon, 25 Jan 2021 00:21:02 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2bhaQ0vUSK7X; Mon, 25 Jan 2021 00:21:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/8] fuse: Add MUSE specific defines FUSE interface
Date:   Mon, 25 Jan 2021 00:20:05 +0100
Message-Id: <20210124232007.21639-7-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raise the FUSE API minor version to 34 and add all
MUSE specific operations and data structures.

MUSE_INIT: Initialize a new connection and installs the MTD
MUSE_ERASE: Erases a block
MUSE_READ: Reads a page with or without OOB
MUSE_WRITE: Writes a page with or without OOB
MUSE_MARKBAD: Marks a block as bad
MUSE_ISBAD: Checks whether a block is bad
MUSE_SYNC: Flushes all cached data

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/uapi/linux/fuse.h | 76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 98ca64d1beb6..1c8fa9e42e73 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -179,6 +179,10 @@
  *  7.33
  *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_S=
UIDGID
  *  - add FUSE_OPEN_KILL_SUIDGID
+ *
+ *  7.34
+ *  - add support for MUSE: MUSE_INIT, MUSE_ERASE, MUSE_READ, MUSE_WRITE=
,
+ *    MUSE_MARKBAD, MUSE_ISBAD and MUSE_SYNC
  */
=20
 #ifndef _LINUX_FUSE_H
@@ -503,6 +507,15 @@ enum fuse_opcode {
 	/* CUSE specific operations */
 	CUSE_INIT		=3D 4096,
=20
+	/* MUSE specific operations */
+	MUSE_INIT		=3D 8192,
+	MUSE_ERASE		=3D 8193,
+	MUSE_READ		=3D 8194,
+	MUSE_WRITE		=3D 8195,
+	MUSE_MARKBAD		=3D 8196,
+	MUSE_ISBAD		=3D 8197,
+	MUSE_SYNC		=3D 8198,
+
 	/* Reserved opcodes: helpful to detect structure endian-ness */
 	CUSE_INIT_BSWAP_RESERVED	=3D 1048576,	/* CUSE_INIT << 8 */
 	FUSE_INIT_BSWAP_RESERVED	=3D 436207616,	/* FUSE_INIT << 24 */
@@ -956,4 +969,67 @@ struct fuse_removemapping_one {
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
=20
+#define MUSE_INIT_INFO_MAX 4096
+
+struct muse_init_in {
+	uint32_t	fuse_major;
+	uint32_t	fuse_minor;
+};
+
+struct muse_init_out {
+	uint32_t	fuse_major;
+	uint32_t	fuse_minor;
+	uint32_t	max_read;
+	uint32_t	max_write;
+};
+
+struct muse_erase_in {
+	uint64_t	addr;
+	uint64_t	len;
+};
+
+#define MUSE_IO_INBAND		(1 << 0)
+#define MUSE_IO_OOB_AUTO	(1 << 1)
+#define MUSE_IO_OOB_PLACE	(1 << 2)
+#define MUSE_IO_RAW		(1 << 3)
+
+struct muse_read_in {
+	uint64_t	addr;
+	uint64_t	len;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct muse_read_out {
+	uint64_t	len;
+	uint32_t	soft_error;
+	uint32_t	padding;
+};
+
+struct muse_write_in {
+	uint64_t	addr;
+	uint64_t	len;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct muse_write_out {
+	uint64_t	len;
+	uint32_t	soft_error;
+	uint32_t	padding;
+};
+
+struct muse_markbad_in {
+	uint64_t	addr;
+};
+
+struct muse_isbad_in {
+	uint64_t	addr;
+};
+
+struct muse_isbad_out {
+	uint32_t	result;
+	uint32_t	padding;
+};
+
 #endif /* _LINUX_FUSE_H */
--=20
2.26.2

