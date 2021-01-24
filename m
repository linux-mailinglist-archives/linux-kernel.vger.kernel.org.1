Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24F301F94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAXXXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 18:23:43 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47185 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbhAXXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:23:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id ACD661812A4B2;
        Mon, 25 Jan 2021 00:21:04 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c7hrr677Ee-D; Mon, 25 Jan 2021 00:21:03 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ssoou87JZavJ; Mon, 25 Jan 2021 00:21:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/8] fuse: Implement MUSE - MTD in userspace
Date:   Mon, 25 Jan 2021 00:20:06 +0100
Message-Id: <20210124232007.21639-8-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MUSE allows implementing a MTD in userspace.
So far userspace has control over mtd_read, mtd_write, mtd_erase,
mtd_block_isbad, mtd_block_markbad, and mtd_sync.
It can also set the various MTD parameters such as
name, flags, site, writesize and erasesize.

That way advanced simulators for many types of flashes
can be implemented in userspace such that the complexity
is in userspace. Furthermore at some point we can depricate
ad-hoc in-kernel MTD simulators such as nandsim.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 Documentation/ABI/testing/sysfs-class-mtd |    8 +
 fs/fuse/Kconfig                           |   11 +
 fs/fuse/Makefile                          |    1 +
 fs/fuse/muse.c                            | 1086 +++++++++++++++++++++
 4 files changed, 1106 insertions(+)
 create mode 100644 fs/fuse/muse.c

diff --git a/Documentation/ABI/testing/sysfs-class-mtd b/Documentation/AB=
I/testing/sysfs-class-mtd
index 3bc7c0a95c92..1aa8d7855f9c 100644
--- a/Documentation/ABI/testing/sysfs-class-mtd
+++ b/Documentation/ABI/testing/sysfs-class-mtd
@@ -240,3 +240,11 @@ Contact:	linux-mtd@lists.infradead.org
 Description:
 		Number of bytes available for a client to place data into
 		the out of band area.
+
+What:		/sys/class/mtd/mtdX/muse_pid
+Date:		January 2021
+KernelVersion:	5.12
+Contact:	linux-mtd@lists.infradead.org
+Description:
+		If this MTD is a userspace driven MTD, muse_pid shows the PID
+		of the process behind it at creation time.
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 9c8cc1e7b3a5..2fc63dc18a53 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -56,3 +56,14 @@ config FUSE_DAX
=20
 	  If you want to allow mounting a Virtio Filesystem with the "dax"
 	  option, answer Y.
+
+config MUSE
+	tristate "Memory Technology Device (MTD) in Userspace support"
+	depends on FUSE_FS
+	select FUSE_HELPER
+	select MTD
+	help
+	  This FUSE extension allows an MTD to be implemented in userspace.
+
+	  If you want to develop or use a userspace MTD based on MUSE,
+	  answer Y or M.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 7a5768cce6be..67a7af3fb047 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_FUSE_FS) +=3D fuse.o
 obj-$(CONFIG_CUSE) +=3D cuse.o
 obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
+obj-$(CONFIG_MUSE) +=3D muse.o
=20
 fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
 fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
diff --git a/fs/fuse/muse.c b/fs/fuse/muse.c
new file mode 100644
index 000000000000..43f8e400abcd
--- /dev/null
+++ b/fs/fuse/muse.c
@@ -0,0 +1,1086 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MUSE: MTD in userspace
+ * Copyright (C) 2021 sigma star gmbh
+ * Author: Richard Weinberger <richard@nod.at>
+ */
+
+#define pr_fmt(fmt) "MUSE: " fmt
+
+#include <linux/fuse.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/workqueue.h>
+
+#include "fuse_i.h"
+
+/*
+ * struct muse_conn - MUSE connection object.
+ *
+ * @fm: FUSE mount object.
+ * @fc: FUSE connection object.
+ * @mtd: MTD object.
+ * @creator: PID of the creating process.
+ * @want_exit: Denotes that userspace is disconncted and the MTD shall b=
e
+ * removed as soon the last user vanishes.
+ * @mtd_registered: true if this MUSE connection sucessfully registered =
an MTD.
+ * @mtd_exit_work: work context for async MTD removal.
+ * @ref_mutex: synchronizes @want_exit and MTD put/get.
+ *
+ * Describes a connection to a userspace server.
+ * Each connection implements a single (master) MTD.
+ *
+ */
+struct muse_conn {
+	struct fuse_mount fm;
+	struct fuse_conn fc;
+	struct mtd_info mtd;
+	pid_t creator;
+	bool want_exit;
+	bool mtd_registered;
+	struct work_struct mtd_exit_work;
+	struct mutex ref_mutex;
+};
+
+/*
+ * struct muse_init_args - MUSE init arguments.
+ *
+ * @ap: FUSE argument pages object.
+ * @in: MUSE init parameters sent to userspace.
+ * @out: MUSE init parameters sent from userspace.
+ * @page: A single pages used to pass stringy key-value parameters
+ *        from userspace to this module.
+ * @desc: FUSE page description object.
+ *
+ * Descripes arguments used by the MUSE_INIT FUSE opcode.
+ *
+ */
+struct muse_init_args {
+	struct fuse_args_pages ap;
+	struct muse_init_in in;
+	struct muse_init_out out;
+	struct page *page;
+	struct fuse_page_desc desc;
+};
+
+/*
+ * struct muse_mtd_create_req - MUSE MTD creation request.
+ *
+ * @name: Name of the (master) MTD, usually something like muse-<pid>.
+ * @type: Type of the MTD, one out of MTD_RAM, MTD_ROM, MTD_NORFLASH,
+ *        MTD_NANDFLASH, MTD_DATAFLASH or MTD_MLCNANDFLASH.
+ * @size: Total size of the MTD.
+ * @writesize: writesize of the MTD.
+ * @writebufsize: writebufsize of the MTD, usually euqal to @writesize.
+ * @erasesize: erasesize of the MTD.
+ * @oobsize: Total number of out-of-band bytes per page (writesize),
+ *           only useful for NAND style MTDs.
+ * @oobavail: Number of available bytes in the out-of-band area.
+ *            Only useful for NAND style MTDs.
+ * @subpage_shift: Subpages shift value, either 0, 1 or 2. Only useful f=
or
+ *                 NAND style MTDs.
+ * @mtdparts: mtdparts string *without* leading MTD name which describes
+ *            partitioning of the MTD as understood by
+ *            drivers/mtd/parsers/cmdlinepart.c.
+ *
+ * Describes the MTD as desired by userspace.
+ *
+ */
+struct muse_mtd_create_req {
+	const char *name;
+	unsigned int type;
+	uint32_t flags;
+	uint64_t size;
+	uint32_t writesize;
+	uint32_t writebufsize;
+	uint32_t erasesize;
+	uint32_t oobsize;
+	uint32_t oobavail;
+	unsigned int subpage_shift;
+	const char *mtdparts;
+};
+
+/*
+ * struct muse_mtd_init_ctx
+ *
+ * @mtd_init_work: workqueue context object.
+ * @pd: Extra parameters for the MTD partition parser, usually an mtdpar=
ts
+ *      string.
+ * @mc: MUSE connection this object belongs to.
+ *
+ * Describes the parameter object passed to a workqueue worker to create=
 the
+ * MTD asynchronously.
+ *
+ */
+struct muse_mtd_init_ctx {
+	struct work_struct mtd_init_work;
+	struct mtd_part_parser_data pd;
+	struct muse_conn *mc;
+};
+
+static void muse_fc_release(struct fuse_conn *fc)
+{
+	struct muse_conn *mc =3D container_of(fc, struct muse_conn, fc);
+
+	WARN_ON_ONCE(mc->mtd.usecount);
+	kfree_rcu(mc, fc.rcu);
+}
+
+static struct muse_conn *get_mc_from_mtd(struct mtd_info *mtd)
+{
+	struct mtd_info *master =3D mtd_get_master(mtd);
+
+	return master->priv;
+}
+
+static int muse_mtd_erase(struct mtd_info *mtd, struct erase_info *instr=
)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+	struct fuse_mount *fm =3D &mc->fm;
+	struct muse_erase_in inarg;
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	inarg.addr =3D instr->addr;
+	inarg.len =3D instr->len;
+
+	args.opcode =3D MUSE_ERASE;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+
+	ret =3D fuse_simple_request(fm, &args);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int muse_mtd_markbad(struct mtd_info *mtd, loff_t addr)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+	struct fuse_mount *fm =3D &mc->fm;
+	struct muse_markbad_in inarg;
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	inarg.addr =3D addr;
+
+	args.opcode =3D MUSE_MARKBAD;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+
+	ret =3D fuse_simple_request(fm, &args);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int muse_mtd_isbad(struct mtd_info *mtd, loff_t addr)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+	struct fuse_mount *fm =3D &mc->fm;
+	struct muse_isbad_in inarg;
+	struct muse_isbad_out outarg;
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	inarg.addr =3D addr;
+
+	args.opcode =3D MUSE_ISBAD;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+	args.out_numargs =3D 1;
+	args.out_args[0].size =3D sizeof(outarg);
+	args.out_args[0].value =3D &outarg;
+
+	ret =3D fuse_simple_request(fm, &args);
+	if (ret < 0)
+		return ret;
+
+	return outarg.result;
+}
+
+static void muse_mtd_sync(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+	struct fuse_mount *fm =3D &mc->fm;
+	FUSE_ARGS(args);
+
+	args.opcode =3D MUSE_SYNC;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 0;
+
+	fuse_simple_request(fm, &args);
+}
+
+static ssize_t muse_send_write(struct fuse_args_pages *ap, struct fuse_m=
ount *fm,
+			       loff_t from, size_t count, int flags, int *soft_error)
+{
+	struct fuse_args *args =3D &ap->args;
+	ssize_t ret;
+
+	struct muse_write_in in;
+	struct muse_write_out out;
+
+	in.addr =3D from;
+	in.len =3D count;
+	in.flags =3D flags;
+	args->opcode =3D MUSE_WRITE;
+	args->nodeid =3D FUSE_ROOT_ID;
+	args->in_numargs =3D 2;
+	args->in_args[0].size =3D sizeof(in);
+	args->in_args[0].value =3D &in;
+	/*
+	 * args->in_args[1].value was set in set_ap_inout_bufs()
+	 */
+	args->in_args[1].size =3D count;
+	args->out_numargs =3D 1;
+	args->out_args[0].size =3D sizeof(out);
+	args->out_args[0].value =3D &out;
+
+	ret =3D fuse_simple_request(fm, &ap->args);
+	if (ret < 0)
+		goto out;
+
+	ret =3D out.len;
+	*soft_error =3D out.soft_error;
+
+out:
+	return ret;
+}
+
+static ssize_t muse_send_read(struct fuse_args_pages *ap, struct fuse_mo=
unt *fm,
+			      loff_t from, size_t count, int flags, int *soft_error)
+{
+	struct fuse_args *args =3D &ap->args;
+	ssize_t ret;
+
+	struct muse_read_in in;
+	struct muse_read_out out;
+
+	in.addr =3D from;
+	in.len =3D count;
+	in.flags =3D flags;
+	args->opcode =3D MUSE_READ;
+	args->nodeid =3D FUSE_ROOT_ID;
+	args->in_numargs =3D 1;
+	args->in_args[0].size =3D sizeof(in);
+	args->in_args[0].value =3D &in;
+	args->out_argvar =3D true;
+	args->out_numargs =3D 2;
+	args->out_args[0].size =3D sizeof(out);
+	args->out_args[0].value =3D &out;
+	/*
+	 * args->out_args[1].value was set in set_ap_inout_bufs()
+	 */
+	args->out_args[1].size =3D count;
+
+	ret =3D fuse_simple_request(fm, &ap->args);
+	if (ret < 0)
+		goto out;
+
+	ret =3D out.len;
+	*soft_error =3D out.soft_error;
+
+out:
+	return ret;
+}
+
+/*
+ * set_ap_inout_bufs - Set in/out buffers for fuse args
+ *
+ * @ap: FUSE args pages object
+ * @iter: IOV iter which describes source/destination of the IO operatio=
n
+ * @count: Inputs the max amount of data we can process,
+ *	   outputs the amount of data @iter has left.
+ * @write: If non-zero, this is a write operation, read otherwise.
+ *
+ * This function takes a IOV iter object and sets up FUSE args pointer.
+ * Since in MTD all buffers are kernel memory we can directly use
+ * fuse_get_user_addr().
+ */
+static void set_ap_inout_bufs(struct fuse_args_pages *ap, struct iov_ite=
r *iter,
+			      size_t *count, int write)
+{
+	unsigned long addr;
+	size_t frag_size;
+
+	addr =3D fuse_get_user_addr(iter);
+	frag_size =3D fuse_get_frag_size(iter, *count);
+
+	if (write)
+		ap->args.in_args[1].value =3D (void *)addr;
+	else
+		ap->args.out_args[1].value =3D (void *)addr;
+
+	iov_iter_advance(iter, frag_size);
+	*count =3D frag_size;
+}
+
+/*
+ * muse_do_io - MUSE main IO processing function.
+ *
+ * @mc: MUSE connection object.
+ * @ops: MTD read/write operation object.
+ * @pos: Where to start reading/writing on the MTD.
+ * @write: If non-zero, this is a write operation, read otherwise.
+ *
+ * This function is responsible for processing reads and writes to the M=
TD.
+ * It directly takes @pos and @ops from the MTD subsystem.
+ * All IO is synchronous and buffers provided by @ops have to be kernel =
memory.
+ * The userspace server can inject also custom errors into the IO path,
+ * mostly -EUCLEAN to signal fixed bit-flips or -EBADMSG for uncorrectab=
le
+ * bit-flips.
+ *
+ */
+static int muse_do_io(struct muse_conn *mc, struct mtd_oob_ops *ops,
+		      loff_t pos, int write)
+{
+	struct fuse_mount *fm =3D &mc->fm;
+	struct fuse_conn *fc =3D &mc->fc;
+	size_t fc_max_io =3D write ? fc->max_write : fc->max_read;
+	struct fuse_args_pages ap;
+	int oob =3D !!ops->ooblen;
+	unsigned int max_pages;
+	struct iov_iter iter;
+	struct kvec iov;
+	size_t count;
+	size_t retlen =3D 0;
+	int bitflips =3D 0;
+	int eccerrors =3D 0;
+	int retcode =3D 0;
+	int io_mode =3D 0;
+	ssize_t ret =3D 0;
+
+	/*
+	 * We don't support accessing in- and out-of-band data in the same op.
+	 * AFAICT FUSE does not support attaching two variable sized buffers to
+	 * a request.
+	 */
+	if ((ops->len && ops->ooblen) || (ops->datbuf && ops->oobbuf)) {
+		ret =3D -ENOTSUPP;
+		goto out;
+	}
+
+	if (!oob) {
+		iov.iov_base =3D ops->datbuf;
+		iov.iov_len =3D ops->len;
+		iov_iter_kvec(&iter, write ? WRITE : READ, &iov, 1, ops->len);
+
+		/*
+		 * When ops->ooblen is not set, we don't care about
+		 * MTD_OPS_PLACE_OOB vs. MTD_OPS_AUTO_OOB.
+		 */
+		io_mode |=3D MUSE_IO_INBAND;
+		if (ops->mode =3D=3D MTD_OPS_RAW)
+			io_mode |=3D MUSE_IO_RAW;
+	} else {
+		iov.iov_base =3D ops->oobbuf;
+		iov.iov_len =3D ops->ooblen;
+		iov_iter_kvec(&iter, write ? WRITE : READ, &iov, 1, ops->ooblen);
+
+		/*
+		 * When accessing OOB we just move the address by ooboffs.
+		 * This works because oobsize is smaller than writesize.
+		 */
+		pos +=3D ops->ooboffs;
+
+		if (ops->mode =3D=3D MTD_OPS_PLACE_OOB) {
+			io_mode |=3D MUSE_IO_OOB_PLACE;
+		} else if (ops->mode =3D=3D MTD_OPS_AUTO_OOB) {
+			io_mode |=3D MUSE_IO_OOB_AUTO;
+		} else if (ops->mode =3D=3D MTD_OPS_RAW) {
+			io_mode |=3D MUSE_IO_OOB_PLACE | MUSE_IO_RAW;
+		} else {
+			ret =3D -ENOTSUPP;
+			goto out;
+		}
+	}
+
+	/*
+	 * A full page needs to fit into a single FUSE request.
+	 */
+	if (fc_max_io < mc->mtd.writebufsize) {
+		ret =3D -ENOBUFS;
+		goto out;
+	}
+
+	count =3D iov_iter_count(&iter);
+
+	max_pages =3D iov_iter_npages(&iter, fc->max_pages);
+	memset(&ap, 0, sizeof(ap));
+
+	ap.pages =3D fuse_pages_alloc(max_pages, GFP_KERNEL, &ap.descs);
+	if (!ap.pages) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	while (count) {
+		size_t nbytes =3D min_t(size_t, count, fc_max_io);
+		int soft_error =3D 0;
+
+		set_ap_inout_bufs(&ap, &iter, &nbytes, write);
+
+		if (write)
+			ret =3D muse_send_write(&ap, fm, pos, nbytes, io_mode, &soft_error);
+		else
+			ret =3D muse_send_read(&ap, fm, pos, nbytes, io_mode, &soft_error);
+
+		kfree(ap.pages);
+		ap.pages =3D NULL;
+
+		if (ret < 0) {
+			iov_iter_revert(&iter, nbytes);
+			break;
+		}
+
+		if (soft_error) {
+			/*
+			 * Userspace wants to inject an error code.
+			 */
+
+			if (write) {
+				/*
+				 * For writes, take it as-is.
+				 */
+				ret =3D soft_error;
+				break;
+			}
+
+			/*
+			 * -EUCLEAN and -EBADMSG are special for reads
+			 * in MTD, it expects from a device to return all
+			 * requsted data even if there are (un)correctable errors.
+			 * The upper layer, such as UBI, has to deal with them.
+			 */
+			if (soft_error =3D=3D -EUCLEAN) {
+				bitflips++;
+			} else if (soft_error =3D=3D -EBADMSG) {
+				eccerrors++;
+			} else {
+				ret =3D soft_error;
+				break;
+			}
+		}
+
+		/*
+		 * No short reads are allowed in MTD.
+		 */
+		if (ret !=3D nbytes) {
+			iov_iter_revert(&iter, nbytes - ret);
+			ret =3D -EIO;
+			break;
+		}
+
+		count -=3D ret;
+		retlen +=3D ret;
+		pos +=3D ret;
+
+		if (count) {
+			max_pages =3D iov_iter_npages(&iter, fc->max_pages);
+			memset(&ap, 0, sizeof(ap));
+			ap.pages =3D fuse_pages_alloc(max_pages, GFP_KERNEL, &ap.descs);
+			if (!ap.pages)
+				break;
+		}
+	}
+
+	kfree(ap.pages);
+
+	if (bitflips)
+		retcode =3D -EUCLEAN;
+	if (eccerrors)
+		retcode =3D -EBADMSG;
+
+out:
+	/*
+	 * If ret is set, it must be a fatal error which overrides
+	 * -EUCLEAN and -EBADMSG.
+	 */
+	if (ret < 0)
+		retcode =3D ret;
+
+	if (oob)
+		ops->oobretlen =3D retlen;
+	else
+		ops->retlen =3D retlen;
+
+	return retcode;
+}
+
+static int muse_mtd_read_oob(struct mtd_info *mtd, loff_t from, struct m=
td_oob_ops *ops)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+
+	return muse_do_io(mc, ops, from, 0);
+}
+
+static int muse_mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mt=
d_oob_ops *ops)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+
+	return muse_do_io(mc, ops, to, 1);
+}
+
+static int muse_mtd_get_device(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+	int ret =3D 0;
+
+	mutex_lock(&mc->ref_mutex);
+
+	/*
+	 * Refuse a new reference if userspace is no longer connected.
+	 */
+	if (mc->want_exit) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	fuse_conn_get(&mc->fc);
+
+out:
+	mutex_unlock(&mc->ref_mutex);
+	return ret;
+}
+
+static ssize_t muse_pid_show(struct device *dev, struct device_attribute=
 *attr,
+			     char *buf)
+{
+	struct mtd_info *mtd =3D dev_get_drvdata(dev);
+	struct muse_conn *mc =3D container_of(mtd_get_master(mtd), struct muse_=
conn, mtd);
+
+	return sprintf(buf, "%d\n", mc->creator);
+}
+
+static DEVICE_ATTR_RO(muse_pid);
+
+static int install_sysfs_attrs(struct mtd_info *mtd)
+{
+	bool part_master =3D IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER);
+	struct mtd_info *child;
+	int ret =3D 0;
+
+	/*
+	 * Create the sysfs file only for visible MTDs, on the master device on=
ly
+	 * if CONFIG_MTD_PARTITIONED_MASTER enabled or it is unpartitioned.
+	 */
+	if (part_master || list_empty(&mtd->partitions)) {
+		ret =3D sysfs_create_file(&mtd->dev.kobj, &dev_attr_muse_pid.attr);
+		if (ret || !part_master)
+			goto out;
+	}
+
+	/*
+	 * ... and to all partitions, if there are any.
+	 */
+	list_for_each_entry(child, &mtd->partitions, part.node) {
+		ret =3D sysfs_create_file(&child->dev.kobj, &dev_attr_muse_pid.attr);
+		if (ret)
+			break;
+	}
+
+out:
+	return ret;
+}
+
+static void remove_sysfs_attrs(struct mtd_info *mtd)
+{
+	bool part_master =3D IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER);
+	struct mtd_info *child;
+
+	/*
+	 * Same logic as in install_sysfs_attrs().
+	 */
+	if (part_master || list_empty(&mtd->partitions)) {
+		sysfs_remove_file(&mtd->dev.kobj, &dev_attr_muse_pid.attr);
+		if (!part_master)
+			return;
+	}
+
+	list_for_each_entry(child, &mtd->partitions, part.node) {
+		sysfs_remove_file(&child->dev.kobj, &dev_attr_muse_pid.attr);
+	}
+}
+
+static void muse_exit_mtd_work(struct work_struct *work)
+{
+	struct muse_conn *mc =3D container_of(work, struct muse_conn, mtd_exit_=
work);
+
+	if (mc->mtd_registered) {
+		remove_sysfs_attrs(&mc->mtd);
+		mtd_device_unregister(&mc->mtd);
+		kfree(mc->mtd.name);
+	}
+	fuse_conn_put(&mc->fc);
+}
+
+/*
+ * MTD deregristation has to happen asynchronously.
+ * It will grap mtd_table_mutex but depending on the context
+ * we hold it already or hold mc->ref_mutex.
+ * The locking order is mtd_table_mutex > mc->ref_mutex.
+ */
+static void muse_remove_mtd_async(struct muse_conn *mc)
+{
+	INIT_WORK(&mc->mtd_exit_work, muse_exit_mtd_work);
+	schedule_work(&mc->mtd_exit_work);
+}
+
+static void muse_mtd_put_device(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D get_mc_from_mtd(mtd);
+
+	mutex_lock(&mc->ref_mutex);
+
+	if (mc->want_exit && mc->mtd.usecount =3D=3D 0) {
+		/*
+		 * This was the last reference on the MTD, remove it now.
+		 */
+		muse_remove_mtd_async(mc);
+	} else {
+		/*
+		 * The MTD has users or userspace is still connected,
+		 * keep the MTD and just decrement the FUSE connection
+		 * reference counter.
+		 */
+		fuse_conn_put(&mc->fc);
+	}
+	mutex_unlock(&mc->ref_mutex);
+}
+
+static int muse_verify_mtdreq(struct muse_mtd_create_req *req)
+{
+	int ret =3D -EINVAL;
+	uint64_t tmp;
+
+	if (!req->name)
+		goto out;
+
+	if (!req->size || !req->writesize || !req->erasesize)
+		goto out;
+
+	tmp =3D req->size;
+	if (do_div(tmp, req->writesize))
+		goto out;
+
+	tmp =3D req->size;
+	if (do_div(tmp, req->erasesize))
+		goto out;
+
+	if (req->oobsize < req->oobavail)
+		goto out;
+
+	if (req->oobsize >=3D req->writesize)
+		goto out;
+
+	if (req->flags & ~(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE))
+		goto out;
+
+	if (req->subpage_shift > 2)
+		goto out;
+
+	switch (req->type) {
+	case MTD_RAM:
+	case MTD_ROM:
+	case MTD_NORFLASH:
+	case MTD_NANDFLASH:
+	case MTD_DATAFLASH:
+	case MTD_MLCNANDFLASH:
+		break;
+	default:
+		goto out;
+	}
+
+	ret =3D 0;
+
+out:
+	return ret;
+}
+
+static int muse_parse_mtdreq(char *p, size_t len, struct mtd_info *mtd,
+			    struct mtd_part_parser_data *pd)
+{
+	struct muse_mtd_create_req req =3D {0};
+	char *end =3D p + len;
+	char *key, *val;
+	int ret;
+
+	for (;;) {
+		ret =3D fuse_kv_parse_one(&p, end, &key, &val);
+		if (ret < 0)
+			goto out;
+		if (!ret)
+			break;
+
+		if (strcmp(key, "NAME") =3D=3D 0) {
+			req.name =3D val;
+		} else if (strcmp(key, "TYPE") =3D=3D 0) {
+			unsigned int type;
+
+			ret =3D kstrtouint(val, 10, &type);
+			if (ret)
+				goto out;
+
+			req.type =3D type;
+		} else if (strcmp(key, "FLAGS") =3D=3D 0) {
+			ret =3D kstrtou32(val, 10, &req.flags);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "SIZE") =3D=3D 0) {
+			ret =3D kstrtou64(val, 10, &req.size);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "WRITESIZE") =3D=3D 0) {
+			ret =3D kstrtou32(val, 10, &req.writesize);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "WRITEBUFSIZE") =3D=3D 0) {
+			ret =3D kstrtou32(val, 10, &req.writebufsize);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "OOBSIZE") =3D=3D 0) {
+			ret =3D kstrtou32(val, 10, &req.oobsize);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "OOBAVAIL") =3D=3D 0) {
+			ret =3D kstrtou32(val, 10, &req.oobavail);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "ERASESIZE") =3D=3D 0) {
+			ret =3D kstrtou32(val, 10, &req.erasesize);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "SUBPAGESHIFT") =3D=3D 0) {
+			ret =3D kstrtouint(val, 10, &req.subpage_shift);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "PARTSCMDLINE") =3D=3D 0) {
+			req.mtdparts =3D val;
+		} else {
+			pr_warn("Ignoring unknown MTD param \"%s\"\n", key);
+		}
+	}
+
+	if (req.name && req.mtdparts && strlen(req.mtdparts) > 0) {
+		pd->mtdparts =3D kasprintf(GFP_KERNEL, "%s:%s", req.name, req.mtdparts=
);
+		if (!pd->mtdparts) {
+			ret =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret =3D muse_verify_mtdreq(&req);
+	if (ret)
+		goto out;
+
+	mtd->name =3D kstrdup(req.name, GFP_KERNEL);
+	if (!mtd->name) {
+		kfree(pd->mtdparts);
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	mtd->size =3D req.size;
+	mtd->erasesize =3D req.erasesize;
+	mtd->writesize =3D req.writesize;
+
+	if (req.writebufsize)
+		mtd->writebufsize =3D req.writebufsize;
+	else
+		mtd->writebufsize =3D mtd->writesize;
+
+	mtd->oobsize =3D req.oobsize;
+	mtd->oobavail =3D req.oobavail;
+	mtd->subpage_sft =3D req.subpage_shift;
+
+	mtd->type =3D req.type;
+	mtd->flags =3D MTD_MUSE | req.flags;
+
+	ret =3D 0;
+out:
+	return ret;
+}
+
+static void muse_init_mtd_work(struct work_struct *work)
+{
+	struct muse_mtd_init_ctx *ctx =3D container_of(work, struct muse_mtd_in=
it_ctx, mtd_init_work);
+	static const char * const part_probe_types[] =3D { "cmdlinepart", NULL =
};
+	struct muse_conn *mc =3D ctx->mc;
+
+	if (mtd_device_parse_register(&mc->mtd, part_probe_types, &ctx->pd, NUL=
L, 0) !=3D 0)
+		goto abort;
+
+	if (install_sysfs_attrs(&mc->mtd))
+		goto abort;
+
+	goto free_mtdparts;
+
+abort:
+	fuse_abort_conn(&mc->fc);
+
+free_mtdparts:
+	mc->mtd_registered =3D true;
+	kfree(ctx->pd.mtdparts);
+	kfree(ctx);
+}
+
+static void muse_process_init_reply(struct fuse_mount *fm,
+				    struct fuse_args *args, int error)
+{
+	struct fuse_conn *fc =3D fm->fc;
+	struct muse_init_args *mia =3D container_of(args, struct muse_init_args=
, ap.args);
+	struct muse_conn *mc =3D container_of(fc, struct muse_conn, fc);
+	struct fuse_args_pages *ap =3D &mia->ap;
+	struct muse_init_out *arg =3D &mia->out;
+	struct page *page =3D ap->pages[0];
+	struct mtd_info *mtd =3D &mc->mtd;
+	struct muse_mtd_init_ctx *init_ctx =3D NULL;
+	int ret;
+
+	init_ctx =3D kzalloc(sizeof(*init_ctx), GFP_KERNEL);
+	if (!init_ctx)
+		goto abort;
+
+	init_ctx->mc =3D mc;
+
+	if (error || arg->fuse_major !=3D FUSE_KERNEL_VERSION || arg->fuse_mino=
r < 34)
+		goto free_ctx;
+
+	fc->minor =3D arg->fuse_minor;
+	fc->max_read =3D max_t(unsigned int, arg->max_read, 4096);
+	fc->max_write =3D max_t(unsigned int, arg->max_write, 4096);
+
+	ret =3D muse_parse_mtdreq(page_address(page), ap->args.out_args[1].size=
,
+				mtd, &init_ctx->pd);
+	if (ret)
+		goto free_ctx;
+
+	mtd->_erase =3D muse_mtd_erase;
+	mtd->_sync =3D muse_mtd_sync;
+	mtd->_read_oob =3D muse_mtd_read_oob;
+	mtd->_write_oob =3D muse_mtd_write_oob;
+	mtd->_get_device =3D muse_mtd_get_device;
+	mtd->_put_device =3D muse_mtd_put_device;
+
+	/*
+	 * Bad blocks make only sense on NAND devices.
+	 * As soon _block_isbad is set, upper layer such as
+	 * UBI expects a working _block_isbad, so userspace
+	 * has to implement MUSE_ISBAD.
+	 */
+	if (mtd_type_is_nand(mtd)) {
+		mtd->_block_isbad =3D muse_mtd_isbad;
+		mtd->_block_markbad =3D muse_mtd_markbad;
+	}
+
+	mtd->priv =3D mc;
+	mtd->owner =3D THIS_MODULE;
+
+	/*
+	 * We want one READ/WRITE op per MTD io. So the MTD pagesize needs
+	 * to fit into max_write/max_read
+	 */
+	if (fc->max_write < mtd->writebufsize || fc->max_read < mtd->writebufsi=
ze)
+		goto free_name;
+
+	mc->creator =3D task_tgid_vnr(current);
+
+	kfree(mia);
+	__free_page(page);
+
+	INIT_WORK(&init_ctx->mtd_init_work, muse_init_mtd_work);
+
+	/*
+	 * MTD can access the device while probing it.
+	 * e.g. scanning for bad blocks or custom partition parsers.
+	 * So we need to do the final step in a different process
+	 * context. Otherwise we will lockup here if the userspace
+	 * side of this MUSE MTD is single threaded.
+	 */
+	schedule_work(&init_ctx->mtd_init_work);
+	return;
+
+free_name:
+	kfree(mtd->name);
+free_ctx:
+	kfree(init_ctx);
+abort:
+	kfree(mia);
+	__free_page(page);
+	fuse_abort_conn(fc);
+}
+
+static int muse_send_init(struct muse_conn *mc)
+{
+	struct fuse_mount *fm =3D &mc->fm;
+	struct fuse_args_pages *ap;
+	struct muse_init_args *mia;
+	struct page *page;
+	int ret =3D -ENOMEM;
+
+	BUILD_BUG_ON(MUSE_INIT_INFO_MAX > PAGE_SIZE);
+
+	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto err;
+
+	mia =3D kzalloc(sizeof(*mia), GFP_KERNEL);
+	if (!mia)
+		goto err_page;
+
+	ap =3D &mia->ap;
+	mia->in.fuse_major =3D FUSE_KERNEL_VERSION;
+	mia->in.fuse_minor =3D FUSE_KERNEL_MINOR_VERSION;
+	ap->args.opcode =3D MUSE_INIT;
+	ap->args.in_numargs =3D 1;
+	ap->args.in_args[0].size =3D sizeof(mia->in);
+	ap->args.in_args[0].value =3D &mia->in;
+	ap->args.out_numargs =3D 2;
+	ap->args.out_args[0].size =3D sizeof(mia->out);
+	ap->args.out_args[0].value =3D &mia->out;
+	ap->args.out_args[1].size =3D MUSE_INIT_INFO_MAX;
+	ap->args.out_argvar =3D true;
+	ap->args.out_pages =3D true;
+	ap->num_pages =3D 1;
+	ap->pages =3D &mia->page;
+	ap->descs =3D &mia->desc;
+	mia->page =3D page;
+	mia->desc.length =3D ap->args.out_args[1].size;
+	ap->args.end =3D muse_process_init_reply;
+
+	ret =3D fuse_simple_background(fm, &ap->args, GFP_KERNEL);
+	if (ret)
+		goto err_ia;
+
+	return 0;
+
+err_ia:
+	kfree(mia);
+err_page:
+	__free_page(page);
+err:
+	return ret;
+}
+
+static int muse_ctrl_open(struct inode *inode, struct file *file)
+{
+	struct muse_conn *mc;
+	struct fuse_dev *fud;
+	int ret;
+
+	/*
+	 * Paranoia check.
+	 */
+	if (!capable(CAP_SYS_ADMIN)) {
+		ret =3D -EPERM;
+		goto err;
+	}
+
+	mc =3D kzalloc(sizeof(*mc), GFP_KERNEL);
+	if (!mc) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	mutex_init(&mc->ref_mutex);
+
+	fuse_conn_init(&mc->fc, &mc->fm, get_user_ns(&init_user_ns),
+		       &fuse_dev_fiq_ops, NULL);
+
+	fud =3D fuse_dev_alloc_install(&mc->fc);
+	if (!fud) {
+		ret =3D -ENOMEM;
+		goto err_free;
+	}
+
+	mc->fc.release =3D muse_fc_release;
+	mc->fc.initialized =3D 1;
+
+	ret =3D muse_send_init(mc);
+	if (ret)
+		goto err_dev;
+
+	file->private_data =3D fud;
+
+	return 0;
+
+err_dev:
+	fuse_dev_free(fud);
+	fuse_conn_put(&mc->fc);
+err_free:
+	kfree(mc);
+err:
+	return ret;
+}
+
+static int muse_ctrl_release(struct inode *inode, struct file *file)
+{
+	struct fuse_dev *fud =3D file->private_data;
+	struct muse_conn *mc =3D container_of(fud->fc, struct muse_conn, fc);
+
+	mutex_lock(&mc->ref_mutex);
+	/*
+	 * Make sure that nobody can gain a new reference on our MTD.
+	 */
+	mc->want_exit =3D true;
+
+	/*
+	 * If the MTD has no users, remove it right now, keep it otherwise
+	 * until the last user is gone. During this phase all operations will
+	 * fail with -ENOTCONN.
+	 */
+	if (mc->mtd.usecount =3D=3D 0)
+		muse_remove_mtd_async(mc);
+	else
+		fuse_conn_put(&mc->fc);
+	mutex_unlock(&mc->ref_mutex);
+
+	return fuse_dev_release(inode, file);
+}
+
+static struct file_operations muse_ctrl_fops;
+
+static struct miscdevice muse_ctrl_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name  =3D "muse",
+	.fops =3D &muse_ctrl_fops,
+};
+
+static int __init muse_init(void)
+{
+	/*
+	 * Inherit from fuse_dev_operations and override open() plus release().
+	 */
+	muse_ctrl_fops =3D fuse_dev_operations;
+	muse_ctrl_fops.owner =3D THIS_MODULE;
+	muse_ctrl_fops.open =3D muse_ctrl_open;
+	muse_ctrl_fops.release =3D muse_ctrl_release;
+
+	return misc_register(&muse_ctrl_dev);
+}
+
+static void __exit muse_exit(void)
+{
+	misc_deregister(&muse_ctrl_dev);
+}
+
+module_init(muse_init);
+module_exit(muse_exit);
+
+MODULE_AUTHOR("Richard Weinberger <richard@nod.at>");
+MODULE_DESCRIPTION("MTD in userspace");
+MODULE_LICENSE("GPL");
--=20
2.26.2

