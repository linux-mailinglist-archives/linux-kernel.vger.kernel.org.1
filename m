Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF9285A99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgJGIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:37:22 -0400
Received: from verein.lst.de ([213.95.11.211]:36611 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgJGIhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:37:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 364336736F; Wed,  7 Oct 2020 10:37:16 +0200 (CEST)
Date:   Wed, 7 Oct 2020 10:37:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <20201007083715.GA15695@lst.de>
References: <20201006155220.GA11668@lst.de> <202010070007.8FF59EC42@keescook> <20201007075537.GA12531@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007075537.GA12531@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at this more:  in addition to the block code being totally
broken, there is really no point in mtdpstore even using this code.
It does nothing but minimal parameter validation to just pass it
on to the pstore zone interface.  IMHO writing the mtd code directly
to the zone interface makes a whole lot more sense even if we grow
a non-broken block backend at some point.  Something like this:

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
deleted file mode 100644
index 296d5027787ac2..00000000000000
--- a/Documentation/admin-guide/pstore-blk.rst
+++ /dev/null
@@ -1,243 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-pstore block oops/panic logger
-==============================
-
-Introduction
-------------
-
-pstore block (pstore/blk) is an oops/panic logger that writes its logs to a
-block device and non-block device before the system crashes. You can get
-these log files by mounting pstore filesystem like::
-
-    mount -t pstore pstore /sys/fs/pstore
-
-
-pstore block concepts
----------------------
-
-pstore/blk provides efficient configuration method for pstore/blk, which
-divides all configurations into two parts, configurations for user and
-configurations for driver.
-
-Configurations for user determine how pstore/blk works, such as pmsg_size,
-kmsg_size and so on. All of them support both Kconfig and module parameters,
-but module parameters have priority over Kconfig.
-
-Configurations for driver are all about block device and non-block device,
-such as total_size of block device and read/write operations.
-
-Configurations for user
------------------------
-
-All of these configurations support both Kconfig and module parameters, but
-module parameters have priority over Kconfig.
-
-Here is an example for module parameters::
-
-        pstore_blk.blkdev=179:7 pstore_blk.kmsg_size=64
-
-The detail of each configurations may be of interest to you.
-
-blkdev
-~~~~~~
-
-The block device to use. Most of the time, it is a partition of block device.
-It's required for pstore/blk. It is also used for MTD device.
-
-It accepts the following variants for block device:
-
-1. <hex_major><hex_minor> device number in hexadecimal represents itself; no
-   leading 0x, for example b302.
-#. /dev/<disk_name> represents the device number of disk
-#. /dev/<disk_name><decimal> represents the device number of partition - device
-   number of disk plus the partition number
-#. /dev/<disk_name>p<decimal> - same as the above; this form is used when disk
-   name of partitioned disk ends with a digit.
-#. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF represents the unique id of
-   a partition if the partition table provides it. The UUID may be either an
-   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-PP,
-   where SSSSSSSS is a zero-filled hex representation of the 32-bit
-   "NT disk signature", and PP is a zero-filled hex representation of the
-   1-based partition number.
-#. PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to a
-   partition with a known unique id.
-#. <major>:<minor> major and minor number of the device separated by a colon.
-
-It accepts the following variants for MTD device:
-
-1. <device name> MTD device name. "pstore" is recommended.
-#. <device number> MTD device number.
-
-kmsg_size
-~~~~~~~~~
-
-The chunk size in KB for oops/panic front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care oops/panic log.
-
-There are multiple chunks for oops/panic front-end depending on the remaining
-space except other pstore front-ends.
-
-pstore/blk will log to oops/panic chunks one by one, and always overwrite the
-oldest chunk if there is no more free chunk.
-
-pmsg_size
-~~~~~~~~~
-
-The chunk size in KB for pmsg front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care pmsg log.
-
-Unlike oops/panic front-end, there is only one chunk for pmsg front-end.
-
-Pmsg is a user space accessible pstore object. Writes to */dev/pmsg0* are
-appended to the chunk. On reboot the contents are available in
-*/sys/fs/pstore/pmsg-pstore-blk-0*.
-
-console_size
-~~~~~~~~~~~~
-
-The chunk size in KB for console front-end.  It **MUST** be a multiple of 4.
-It's optional if you do not care console log.
-
-Similar to pmsg front-end, there is only one chunk for console front-end.
-
-All log of console will be appended to the chunk. On reboot the contents are
-available in */sys/fs/pstore/console-pstore-blk-0*.
-
-ftrace_size
-~~~~~~~~~~~
-
-The chunk size in KB for ftrace front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care console log.
-
-Similar to oops front-end, there are multiple chunks for ftrace front-end
-depending on the count of cpu processors. Each chunk size is equal to
-ftrace_size / processors_count.
-
-All log of ftrace will be appended to the chunk. On reboot the contents are
-combined and available in */sys/fs/pstore/ftrace-pstore-blk-0*.
-
-Persistent function tracing might be useful for debugging software or hardware
-related hangs. Here is an example of usage::
-
- # mount -t pstore pstore /sys/fs/pstore
- # mount -t debugfs debugfs /sys/kernel/debug/
- # echo 1 > /sys/kernel/debug/pstore/record_ftrace
- # reboot -f
- [...]
- # mount -t pstore pstore /sys/fs/pstore
- # tail /sys/fs/pstore/ftrace-pstore-blk-0
- CPU:0 ts:5914676 c0063828  c0063b94  call_cpuidle <- cpu_startup_entry+0x1b8/0x1e0
- CPU:0 ts:5914678 c039ecdc  c006385c  cpuidle_enter_state <- call_cpuidle+0x44/0x48
- CPU:0 ts:5914680 c039e9a0  c039ecf0  cpuidle_enter_freeze <- cpuidle_enter_state+0x304/0x314
- CPU:0 ts:5914681 c0063870  c039ea30  sched_idle_set_state <- cpuidle_enter_state+0x44/0x314
- CPU:1 ts:5916720 c0160f59  c015ee04  kernfs_unmap_bin_file <- __kernfs_remove+0x140/0x204
- CPU:1 ts:5916721 c05ca625  c015ee0c  __mutex_lock_slowpath <- __kernfs_remove+0x148/0x204
- CPU:1 ts:5916723 c05c813d  c05ca630  yield_to <- __mutex_lock_slowpath+0x314/0x358
- CPU:1 ts:5916724 c05ca2d1  c05ca638  __ww_mutex_lock <- __mutex_lock_slowpath+0x31c/0x358
-
-max_reason
-~~~~~~~~~~
-
-Limiting which kinds of kmsg dumps are stored can be controlled via
-the ``max_reason`` value, as defined in include/linux/kmsg_dump.h's
-``enum kmsg_dump_reason``. For example, to store both Oopses and Panics,
-``max_reason`` should be set to 2 (KMSG_DUMP_OOPS), to store only Panics
-``max_reason`` should be set to 1 (KMSG_DUMP_PANIC). Setting this to 0
-(KMSG_DUMP_UNDEF), means the reason filtering will be controlled by the
-``printk.always_kmsg_dump`` boot param: if unset, it'll be KMSG_DUMP_OOPS,
-otherwise KMSG_DUMP_MAX.
-
-Configurations for driver
--------------------------
-
-Only a block device driver cares about these configurations. A block device
-driver uses ``register_pstore_blk`` to register to pstore/blk.
-
-.. kernel-doc:: fs/pstore/blk.c
-   :identifiers: register_pstore_blk
-
-A non-block device driver uses ``register_pstore_device`` with
-``struct pstore_device_info`` to register to pstore/blk.
-
-.. kernel-doc:: fs/pstore/blk.c
-   :identifiers: register_pstore_device
-
-.. kernel-doc:: include/linux/pstore_blk.h
-   :identifiers: pstore_device_info
-
-Compression and header
-----------------------
-
-Block device is large enough for uncompressed oops data. Actually we do not
-recommend data compression because pstore/blk will insert some information into
-the first line of oops/panic data. For example::
-
-        Panic: Total 16 times
-
-It means that it's OOPS|Panic for the 16th time since the first booting.
-Sometimes the number of occurrences of oops|panic since the first booting is
-important to judge whether the system is stable.
-
-The following line is inserted by pstore filesystem. For example::
-
-        Oops#2 Part1
-
-It means that it's OOPS for the 2nd time on the last boot.
-
-Reading the data
-----------------
-
-The dump data can be read from the pstore filesystem. The format for these
-files is ``dmesg-pstore-blk-[N]`` for oops/panic front-end,
-``pmsg-pstore-blk-0`` for pmsg front-end and so on.  The timestamp of the
-dump file records the trigger time. To delete a stored record from block
-device, simply unlink the respective pstore file.
-
-Attentions in panic read/write APIs
------------------------------------
-
-If on panic, the kernel is not going to run for much longer, the tasks will not
-be scheduled and most kernel resources will be out of service. It
-looks like a single-threaded program running on a single-core computer.
-
-The following points require special attention for panic read/write APIs:
-
-1. Can **NOT** allocate any memory.
-   If you need memory, just allocate while the block driver is initializing
-   rather than waiting until the panic.
-#. Must be polled, **NOT** interrupt driven.
-   No task schedule any more. The block driver should delay to ensure the write
-   succeeds, but NOT sleep.
-#. Can **NOT** take any lock.
-   There is no other task, nor any shared resource; you are safe to break all
-   locks.
-#. Just use CPU to transfer.
-   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
-#. Control registers directly.
-   Please control registers directly rather than use Linux kernel resources.
-   Do I/O map while initializing rather than wait until a panic occurs.
-#. Reset your block device and controller if necessary.
-   If you are not sure of the state of your block device and controller when
-   a panic occurs, you are safe to stop and reset them.
-
-pstore/blk supports psblk_blkdev_info(), which is defined in
-*linux/pstore_blk.h*, to get information of using block device, such as the
-device number, sector count and start sector of the whole disk.
-
-pstore block internals
-----------------------
-
-For developer reference, here are all the important structures and APIs:
-
-.. kernel-doc:: fs/pstore/zone.c
-   :internal:
-
-.. kernel-doc:: include/linux/pstore_zone.h
-   :internal:
-
-.. kernel-doc:: fs/pstore/blk.c
-   :export:
-
-.. kernel-doc:: include/linux/pstore_blk.h
-   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a54806ebf0209..fa656d8ba1a6a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14037,7 +14037,6 @@ M:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
 F:	Documentation/admin-guide/ramoops.rst
-F:	Documentation/admin-guide/pstore-blk.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 F:	drivers/acpi/apei/erst.c
 F:	drivers/firmware/efi/efi-pstore.c
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 6ddab796216db9..edce458f0c5ac1 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -172,7 +172,7 @@ config MTD_OOPS
 
 config MTD_PSTORE
 	tristate "Log panic/oops to an MTD buffer based on pstore"
-	depends on PSTORE_BLK
+	select PSTORE_ZONE
 	help
 	  This enables panic and oops messages to be logged to a circular
 	  buffer in a flash partition where it can be read back as files after
@@ -180,6 +180,39 @@ config MTD_PSTORE
 
 	  If unsure, say N.
 
+config MTD_PSTORE_DEVICE
+	string "device identifier"
+	depends on MTD_PSTORE
+	default ""
+	help
+	  Which mtd device should be used for pstore/mtd.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/mtd, but module parameters have priority over Kconfig.
+
+config MTD_PSTORE_KMSG_SIZE
+	int "Size in Kbytes of kmsg dump log to store"
+	depends on MTD_PSTORE
+	default 64
+	help
+	  This just sets size of kmsg dump (oops, panic, etc) log for
+	  pstore/mtd. The size is in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/mtd, but module parameters have priority over Kconfig.
+
+config MTD_PSTORE_MAX_REASON
+	int "Maximum kmsg dump reason to store"
+	depends on MTD_PSTORE
+	default 2
+	help
+	  The maximum reason for kmsg dumps to store. The default is
+	  2 (KMSG_DUMP_OOPS), see include/linux/kmsg_dump.h's
+	  enum kmsg_dump_reason for more details.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/mtd, but module parameters have priority over Kconfig.
+
 config MTD_SWAP
 	tristate "Swap on MTD device support"
 	depends on MTD && SWAP
diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index a3ae8778f6a9b9..bc51985f3ec137 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -3,16 +3,19 @@
 #define dev_fmt(fmt) "mtdoops-pstore: " fmt
 
 #include <linux/kernel.h>
+#include <linux/kconfig.h>
 #include <linux/module.h>
-#include <linux/pstore_blk.h>
+#include <linux/pstore.h>
+#include <linux/pstore_zone.h>
 #include <linux/mtd/mtd.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
 
 static struct mtdpstore_context {
 	int index;
-	struct pstore_blk_config info;
-	struct pstore_device_info dev;
+	char device[80];
+	enum kmsg_dump_reason max_reason;
+	unsigned long kmsg_size;
 	struct mtd_info *mtd;
 	unsigned long *rmmap;		/* removed bit map */
 	unsigned long *usedmap;		/* used bit map */
@@ -24,6 +27,32 @@ static struct mtdpstore_context {
 	unsigned long *badmap;		/* bad block bit map */
 } oops_cxt;
 
+static long kmsg_size = CONFIG_MTD_PSTORE_KMSG_SIZE;
+module_param(kmsg_size, long, 0400);
+MODULE_PARM_DESC(kmsg_size, "kmsg dump record size in kbytes");
+
+static int max_reason = CONFIG_MTD_PSTORE_MAX_REASON;
+module_param(max_reason, int, 0400);
+MODULE_PARM_DESC(max_reason,
+		 "maximum reason for kmsg dump (default 2: Oops and Panic)");
+
+static char device[80] = CONFIG_MTD_PSTORE_DEVICE;
+module_param_string(device, device, 80, 0400);
+MODULE_PARM_DESC(device, "block device for pstore storage");
+
+static struct pstore_zone_info *pstore_zone_info;
+
+#define check_size(name, alignsize) ({				\
+	long _##name_ = (name);					\
+	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+	if (_##name_ & ((alignsize) - 1)) {			\
+		pr_info(#name " must align to %d\n",		\
+				(alignsize));			\
+		_##name_ = ALIGN(name, (alignsize));		\
+	}							\
+	_##name_;						\
+})
+
 static int mtdpstore_block_isbad(struct mtdpstore_context *cxt, loff_t off)
 {
 	int ret;
@@ -61,7 +90,7 @@ static inline void mtdpstore_mark_used(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
+	u64 zonenum = div_u64(off, cxt->kmsg_size);
 
 	dev_dbg(&mtd->dev, "mark zone %llu used\n", zonenum);
 	set_bit(zonenum, cxt->usedmap);
@@ -71,7 +100,7 @@ static inline void mtdpstore_mark_unused(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
+	u64 zonenum = div_u64(off, cxt->kmsg_size);
 
 	dev_dbg(&mtd->dev, "mark zone %llu unused\n", zonenum);
 	clear_bit(zonenum, cxt->usedmap);
@@ -81,11 +110,11 @@ static inline void mtdpstore_block_mark_unused(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u32 zonecnt = mtd->erasesize / cxt->kmsg_size;
 	u64 zonenum;
 
 	off = ALIGN_DOWN(off, mtd->erasesize);
-	zonenum = div_u64(off, cxt->info.kmsg_size);
+	zonenum = div_u64(off, cxt->kmsg_size);
 	while (zonecnt > 0) {
 		dev_dbg(&mtd->dev, "mark zone %llu unused\n", zonenum);
 		clear_bit(zonenum, cxt->usedmap);
@@ -96,7 +125,7 @@ static inline void mtdpstore_block_mark_unused(struct mtdpstore_context *cxt,
 
 static inline int mtdpstore_is_used(struct mtdpstore_context *cxt, loff_t off)
 {
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
+	u64 zonenum = div_u64(off, cxt->kmsg_size);
 	u64 blknum = div_u64(off, cxt->mtd->erasesize);
 
 	if (test_bit(blknum, cxt->badmap))
@@ -108,11 +137,11 @@ static int mtdpstore_block_is_used(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u32 zonecnt = mtd->erasesize / cxt->kmsg_size;
 	u64 zonenum;
 
 	off = ALIGN_DOWN(off, mtd->erasesize);
-	zonenum = div_u64(off, cxt->info.kmsg_size);
+	zonenum = div_u64(off, cxt->kmsg_size);
 	while (zonecnt > 0) {
 		if (test_bit(zonenum, cxt->usedmap))
 			return true;
@@ -140,7 +169,7 @@ static int mtdpstore_is_empty(struct mtdpstore_context *cxt, char *buf,
 static void mtdpstore_mark_removed(struct mtdpstore_context *cxt, loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
+	u64 zonenum = div_u64(off, cxt->kmsg_size);
 
 	dev_dbg(&mtd->dev, "mark zone %llu removed\n", zonenum);
 	set_bit(zonenum, cxt->rmmap);
@@ -150,11 +179,11 @@ static void mtdpstore_block_clear_removed(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u32 zonecnt = mtd->erasesize / cxt->kmsg_size;
 	u64 zonenum;
 
 	off = ALIGN_DOWN(off, mtd->erasesize);
-	zonenum = div_u64(off, cxt->info.kmsg_size);
+	zonenum = div_u64(off, cxt->kmsg_size);
 	while (zonecnt > 0) {
 		clear_bit(zonenum, cxt->rmmap);
 		zonenum++;
@@ -166,11 +195,11 @@ static int mtdpstore_block_is_removed(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u32 zonecnt = mtd->erasesize / cxt->kmsg_size;
 	u64 zonenum;
 
 	off = ALIGN_DOWN(off, mtd->erasesize);
-	zonenum = div_u64(off, cxt->info.kmsg_size);
+	zonenum = div_u64(off, cxt->kmsg_size);
 	while (zonecnt > 0) {
 		if (test_bit(zonenum, cxt->rmmap))
 			return true;
@@ -196,7 +225,7 @@ static int mtdpstore_erase_do(struct mtdpstore_context *cxt, loff_t off)
 	else
 		dev_err(&mtd->dev, "erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
 		       (unsigned long long)erase.addr,
-		       (unsigned long long)erase.len, cxt->info.device);
+		       (unsigned long long)erase.len, cxt->device);
 	return ret;
 }
 
@@ -238,8 +267,8 @@ static int mtdpstore_security(struct mtdpstore_context *cxt, loff_t off)
 {
 	int ret = 0, i;
 	struct mtd_info *mtd = cxt->mtd;
-	u32 zonenum = (u32)div_u64(off, cxt->info.kmsg_size);
-	u32 zonecnt = (u32)div_u64(cxt->mtd->size, cxt->info.kmsg_size);
+	u32 zonenum = (u32)div_u64(off, cxt->kmsg_size);
+	u32 zonecnt = (u32)div_u64(cxt->mtd->size, cxt->kmsg_size);
 	u32 blkcnt = (u32)div_u64(cxt->mtd->size, cxt->mtd->erasesize);
 	u32 erasesize = cxt->mtd->erasesize;
 
@@ -382,10 +411,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 {
 	int ret;
 	struct mtdpstore_context *cxt = &oops_cxt;
-	struct pstore_blk_config *info = &cxt->info;
 	unsigned long longcnt;
 
-	if (!strcmp(mtd->name, info->device))
+	if (!strcmp(mtd->name, cxt->device))
 		cxt->index = mtd->index;
 
 	if (mtd->index != cxt->index || cxt->index < 0)
@@ -393,7 +421,7 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 
 	dev_dbg(&mtd->dev, "found matching MTD device %s\n", mtd->name);
 
-	if (mtd->size < info->kmsg_size * 2) {
+	if (mtd->size < cxt->kmsg_size * 2) {
 		dev_err(&mtd->dev, "MTD partition %d not big enough\n",
 				mtd->index);
 		return;
@@ -404,39 +432,51 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	 * is larger than erasesize, some errors will occur since mtdpsotre
 	 * is designed on it.
 	 */
-	if (mtd->erasesize < info->kmsg_size) {
+	if (mtd->erasesize < cxt->kmsg_size) {
 		dev_err(&mtd->dev, "eraseblock size of MTD partition %d too small\n",
 				mtd->index);
 		return;
 	}
-	if (unlikely(info->kmsg_size % mtd->writesize)) {
+	if (unlikely(cxt->kmsg_size % mtd->writesize)) {
 		dev_err(&mtd->dev, "record size %lu KB must align to write size %d KB\n",
-				info->kmsg_size / 1024,
+				cxt->kmsg_size / 1024,
 				mtd->writesize / 1024);
 		return;
 	}
 
-	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
+	longcnt = BITS_TO_LONGS(div_u64(mtd->size, cxt->kmsg_size));
 	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
 	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
 
-	cxt->dev.total_size = mtd->size;
-	/* just support dmesg right now */
-	cxt->dev.flags = PSTORE_FLAGS_DMESG;
-	cxt->dev.read = mtdpstore_read;
-	cxt->dev.write = mtdpstore_write;
-	cxt->dev.erase = mtdpstore_erase;
-	cxt->dev.panic_write = mtdpstore_panic_write;
+	if (!mtd->size)
+		return;
 
-	ret = register_pstore_device(&cxt->dev);
-	if (ret) {
-		dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
-				mtd->index);
+	if (pstore_zone_info)
+		return;
+	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
+	if (!pstore_zone_info)
 		return;
+
+	/* just support dmesg right now */
+	pstore_zone_info->kmsg_size = cxt->kmsg_size / 1024;
+	pstore_zone_info->total_size = mtd->size;
+	pstore_zone_info->max_reason = max_reason;
+	pstore_zone_info->read = mtdpstore_read;
+	pstore_zone_info->write = mtdpstore_write;
+	pstore_zone_info->erase = mtdpstore_erase;
+	pstore_zone_info->panic_write = mtdpstore_panic_write;
+	pstore_zone_info->name = KBUILD_MODNAME;
+	pstore_zone_info->owner = THIS_MODULE;
+
+	ret = register_pstore_zone(pstore_zone_info);
+	if (ret) {
+		kfree(pstore_zone_info);
+		pstore_zone_info = NULL;
 	}
+
 	cxt->mtd = mtd;
 	dev_info(&mtd->dev, "Attached to MTD device %d\n", mtd->index);
 }
@@ -468,7 +508,7 @@ static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,
 
 	/* 3rd. write back */
 	while (size) {
-		unsigned int zonesize = cxt->info.kmsg_size;
+		unsigned int zonesize = cxt->kmsg_size;
 
 		/* there is valid data on block, write back */
 		if (mtdpstore_is_used(cxt, off)) {
@@ -526,7 +566,12 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
 
 	mtdpstore_flush_removed(cxt);
 
-	unregister_pstore_device(&cxt->dev);
+	if (pstore_zone_info) {
+		unregister_pstore_zone(pstore_zone_info);
+		kfree(pstore_zone_info);
+		pstore_zone_info = NULL;
+	}
+
 	kfree(cxt->badmap);
 	kfree(cxt->usedmap);
 	kfree(cxt->rmmap);
@@ -543,23 +588,22 @@ static int __init mtdpstore_init(void)
 {
 	int ret;
 	struct mtdpstore_context *cxt = &oops_cxt;
-	struct pstore_blk_config *info = &cxt->info;
-
-	ret = pstore_blk_get_config(info);
-	if (unlikely(ret))
-		return ret;
 
-	if (strlen(info->device) == 0) {
+	strncpy(cxt->device, device, 80);
+	if (strlen(cxt->device) == 0) {
 		pr_err("mtd device must be supplied (device name is empty)\n");
 		return -EINVAL;
 	}
-	if (!info->kmsg_size) {
+
+	cxt->max_reason = max_reason;
+	cxt->kmsg_size = check_size(kmsg_size, 4096);
+	if (!cxt->kmsg_size) {
 		pr_err("no backend enabled (kmsg_size is 0)\n");
 		return -EINVAL;
 	}
 
 	/* Setup the MTD device to use */
-	ret = kstrtoint((char *)info->device, 0, &cxt->index);
+	ret = kstrtoint((char *)cxt->device, 0, &cxt->index);
 	if (ret)
 		cxt->index = -1;
 
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index e16a49ebfe546d..98d2457bdd9f0a 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -160,105 +160,3 @@ config PSTORE_ZONE
 	help
 	  The common layer for pstore/blk (and pstore/ram in the future)
 	  to manage storage in zones.
-
-config PSTORE_BLK
-	tristate "Log panic/oops to a block device"
-	depends on PSTORE
-	depends on BLOCK
-	select PSTORE_ZONE
-	default n
-	help
-	  This enables panic and oops message to be logged to a block dev
-	  where it can be read back at some later point.
-
-	  For more information, see Documentation/admin-guide/pstore-blk.rst
-
-	  If unsure, say N.
-
-config PSTORE_BLK_BLKDEV
-	string "block device identifier"
-	depends on PSTORE_BLK
-	default ""
-	help
-	  Which block device should be used for pstore/blk.
-
-	  It accepts the following variants:
-	  1) <hex_major><hex_minor> device number in hexadecimal representation,
-	     with no leading 0x, for example b302.
-	  2) /dev/<disk_name> represents the device name of disk
-	  3) /dev/<disk_name><decimal> represents the device name and number
-	     of partition - device number of disk plus the partition number
-	  4) /dev/<disk_name>p<decimal> - same as the above, this form is
-	     used when disk name of partitioned disk ends with a digit.
-	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
-	     unique id of a partition if the partition table provides it.
-	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
-	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
-	     filled hex representation of the 32-bit "NT disk signature", and PP
-	     is a zero-filled hex representation of the 1-based partition number.
-	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
-	     to a partition with a known unique id.
-	  7) <major>:<minor> major and minor number of the device separated by
-	     a colon.
-
-	  NOTE that, both Kconfig and module parameters can configure
-	  pstore/blk, but module parameters have priority over Kconfig.
-
-config PSTORE_BLK_KMSG_SIZE
-	int "Size in Kbytes of kmsg dump log to store"
-	depends on PSTORE_BLK
-	default 64
-	help
-	  This just sets size of kmsg dump (oops, panic, etc) log for
-	  pstore/blk. The size is in KB and must be a multiple of 4.
-
-	  NOTE that, both Kconfig and module parameters can configure
-	  pstore/blk, but module parameters have priority over Kconfig.
-
-config PSTORE_BLK_MAX_REASON
-	int "Maximum kmsg dump reason to store"
-	depends on PSTORE_BLK
-	default 2
-	help
-	  The maximum reason for kmsg dumps to store. The default is
-	  2 (KMSG_DUMP_OOPS), see include/linux/kmsg_dump.h's
-	  enum kmsg_dump_reason for more details.
-
-	  NOTE that, both Kconfig and module parameters can configure
-	  pstore/blk, but module parameters have priority over Kconfig.
-
-config PSTORE_BLK_PMSG_SIZE
-	int "Size in Kbytes of pmsg to store"
-	depends on PSTORE_BLK
-	depends on PSTORE_PMSG
-	default 64
-	help
-	  This just sets size of pmsg (pmsg_size) for pstore/blk. The size is
-	  in KB and must be a multiple of 4.
-
-	  NOTE that, both Kconfig and module parameters can configure
-	  pstore/blk, but module parameters have priority over Kconfig.
-
-config PSTORE_BLK_CONSOLE_SIZE
-	int "Size in Kbytes of console log to store"
-	depends on PSTORE_BLK
-	depends on PSTORE_CONSOLE
-	default 64
-	help
-	  This just sets size of console log (console_size) to store via
-	  pstore/blk. The size is in KB and must be a multiple of 4.
-
-	  NOTE that, both Kconfig and module parameters can configure
-	  pstore/blk, but module parameters have priority over Kconfig.
-
-config PSTORE_BLK_FTRACE_SIZE
-	int "Size in Kbytes of ftrace log to store"
-	depends on PSTORE_BLK
-	depends on PSTORE_FTRACE
-	default 64
-	help
-	  This just sets size of ftrace log (ftrace_size) for pstore/blk. The
-	  size is in KB and must be a multiple of 4.
-
-	  NOTE that, both Kconfig and module parameters can configure
-	  pstore/blk, but module parameters have priority over Kconfig.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index c270467aeecea7..58a967cbe4af71 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -15,6 +15,3 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
 pstore_zone-objs += zone.o
 obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
-
-pstore_blk-objs += blk.o
-obj-$(CONFIG_PSTORE_BLK)	+= pstore_blk.o
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
deleted file mode 100644
index fcd5563dde063c..00000000000000
--- a/fs/pstore/blk.c
+++ /dev/null
@@ -1,517 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Implements pstore backend driver that write to block (or non-block) storage
- * devices, using the pstore/zone API.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include "../../block/blk.h"
-#include <linux/blkdev.h>
-#include <linux/string.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/pstore_blk.h>
-#include <linux/mount.h>
-#include <linux/uio.h>
-
-static long kmsg_size = CONFIG_PSTORE_BLK_KMSG_SIZE;
-module_param(kmsg_size, long, 0400);
-MODULE_PARM_DESC(kmsg_size, "kmsg dump record size in kbytes");
-
-static int max_reason = CONFIG_PSTORE_BLK_MAX_REASON;
-module_param(max_reason, int, 0400);
-MODULE_PARM_DESC(max_reason,
-		 "maximum reason for kmsg dump (default 2: Oops and Panic)");
-
-#if IS_ENABLED(CONFIG_PSTORE_PMSG)
-static long pmsg_size = CONFIG_PSTORE_BLK_PMSG_SIZE;
-#else
-static long pmsg_size = -1;
-#endif
-module_param(pmsg_size, long, 0400);
-MODULE_PARM_DESC(pmsg_size, "pmsg size in kbytes");
-
-#if IS_ENABLED(CONFIG_PSTORE_CONSOLE)
-static long console_size = CONFIG_PSTORE_BLK_CONSOLE_SIZE;
-#else
-static long console_size = -1;
-#endif
-module_param(console_size, long, 0400);
-MODULE_PARM_DESC(console_size, "console size in kbytes");
-
-#if IS_ENABLED(CONFIG_PSTORE_FTRACE)
-static long ftrace_size = CONFIG_PSTORE_BLK_FTRACE_SIZE;
-#else
-static long ftrace_size = -1;
-#endif
-module_param(ftrace_size, long, 0400);
-MODULE_PARM_DESC(ftrace_size, "ftrace size in kbytes");
-
-static bool best_effort;
-module_param(best_effort, bool, 0400);
-MODULE_PARM_DESC(best_effort, "use best effort to write (i.e. do not require storage driver pstore support, default: off)");
-
-/*
- * blkdev - the block device to use for pstore storage
- *
- * Usually, this will be a partition of a block device.
- *
- * blkdev accepts the following variants:
- * 1) <hex_major><hex_minor> device number in hexadecimal representation,
- *    with no leading 0x, for example b302.
- * 2) /dev/<disk_name> represents the device number of disk
- * 3) /dev/<disk_name><decimal> represents the device number
- *    of partition - device number of disk plus the partition number
- * 4) /dev/<disk_name>p<decimal> - same as the above, that form is
- *    used when disk name of partitioned disk ends on a digit.
- * 5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
- *    unique id of a partition if the partition table provides it.
- *    The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
- *    partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
- *    filled hex representation of the 32-bit "NT disk signature", and PP
- *    is a zero-filled hex representation of the 1-based partition number.
- * 6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
- *    a partition with a known unique id.
- * 7) <major>:<minor> major and minor number of the device separated by
- *    a colon.
- */
-static char blkdev[80] = CONFIG_PSTORE_BLK_BLKDEV;
-module_param_string(blkdev, blkdev, 80, 0400);
-MODULE_PARM_DESC(blkdev, "block device for pstore storage");
-
-/*
- * All globals must only be accessed under the pstore_blk_lock
- * during the register/unregister functions.
- */
-static DEFINE_MUTEX(pstore_blk_lock);
-static struct block_device *psblk_bdev;
-static struct pstore_zone_info *pstore_zone_info;
-static pstore_blk_panic_write_op blkdev_panic_write;
-
-struct bdev_info {
-	dev_t devt;
-	sector_t nr_sects;
-	sector_t start_sect;
-};
-
-#define check_size(name, alignsize) ({				\
-	long _##name_ = (name);					\
-	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
-	if (_##name_ & ((alignsize) - 1)) {			\
-		pr_info(#name " must align to %d\n",		\
-				(alignsize));			\
-		_##name_ = ALIGN(name, (alignsize));		\
-	}							\
-	_##name_;						\
-})
-
-static int __register_pstore_device(struct pstore_device_info *dev)
-{
-	int ret;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
-		return -EINVAL;
-
-	/* someone already registered before */
-	if (pstore_zone_info)
-		return -EBUSY;
-
-	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
-	if (!pstore_zone_info)
-		return -ENOMEM;
-
-	/* zero means not limit on which backends to attempt to store. */
-	if (!dev->flags)
-		dev->flags = UINT_MAX;
-
-#define verify_size(name, alignsize, enabled) {				\
-		long _##name_;						\
-		if (enabled)						\
-			_##name_ = check_size(name, alignsize);		\
-		else							\
-			_##name_ = 0;					\
-		name = _##name_ / 1024;					\
-		pstore_zone_info->name = _##name_;			\
-	}
-
-	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
-	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
-	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
-	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
-#undef verify_size
-
-	pstore_zone_info->total_size = dev->total_size;
-	pstore_zone_info->max_reason = max_reason;
-	pstore_zone_info->read = dev->read;
-	pstore_zone_info->write = dev->write;
-	pstore_zone_info->erase = dev->erase;
-	pstore_zone_info->panic_write = dev->panic_write;
-	pstore_zone_info->name = KBUILD_MODNAME;
-	pstore_zone_info->owner = THIS_MODULE;
-
-	ret = register_pstore_zone(pstore_zone_info);
-	if (ret) {
-		kfree(pstore_zone_info);
-		pstore_zone_info = NULL;
-	}
-	return ret;
-}
-/**
- * register_pstore_device() - register non-block device to pstore/blk
- *
- * @dev: non-block device information
- *
- * Return:
- * * 0		- OK
- * * Others	- something error.
- */
-int register_pstore_device(struct pstore_device_info *dev)
-{
-	int ret;
-
-	mutex_lock(&pstore_blk_lock);
-	ret = __register_pstore_device(dev);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_pstore_device);
-
-static void __unregister_pstore_device(struct pstore_device_info *dev)
-{
-	lockdep_assert_held(&pstore_blk_lock);
-	if (pstore_zone_info && pstore_zone_info->read == dev->read) {
-		unregister_pstore_zone(pstore_zone_info);
-		kfree(pstore_zone_info);
-		pstore_zone_info = NULL;
-	}
-}
-
-/**
- * unregister_pstore_device() - unregister non-block device from pstore/blk
- *
- * @dev: non-block device information
- */
-void unregister_pstore_device(struct pstore_device_info *dev)
-{
-	mutex_lock(&pstore_blk_lock);
-	__unregister_pstore_device(dev);
-	mutex_unlock(&pstore_blk_lock);
-}
-EXPORT_SYMBOL_GPL(unregister_pstore_device);
-
-/**
- * psblk_get_bdev() - open block device
- *
- * @holder:	Exclusive holder identifier
- * @info:	Information about bdev to fill in
- *
- * Return: pointer to block device on success and others on error.
- *
- * On success, the returned block_device has reference count of one.
- */
-static struct block_device *psblk_get_bdev(void *holder,
-					   struct bdev_info *info)
-{
-	struct block_device *bdev = ERR_PTR(-ENODEV);
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
-	sector_t nr_sects;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (pstore_zone_info)
-		return ERR_PTR(-EBUSY);
-
-	if (!blkdev[0])
-		return ERR_PTR(-ENODEV);
-
-	if (holder)
-		mode |= FMODE_EXCL;
-	bdev = blkdev_get_by_path(blkdev, mode, holder);
-	if (IS_ERR(bdev)) {
-		dev_t devt;
-
-		devt = name_to_dev_t(blkdev);
-		if (devt == 0)
-			return ERR_PTR(-ENODEV);
-		bdev = blkdev_get_by_dev(devt, mode, holder);
-		if (IS_ERR(bdev))
-			return bdev;
-	}
-
-	nr_sects = part_nr_sects_read(bdev->bd_part);
-	if (!nr_sects) {
-		pr_err("not enough space for '%s'\n", blkdev);
-		blkdev_put(bdev, mode);
-		return ERR_PTR(-ENOSPC);
-	}
-
-	if (info) {
-		info->devt = bdev->bd_dev;
-		info->nr_sects = nr_sects;
-		info->start_sect = get_start_sect(bdev);
-	}
-
-	return bdev;
-}
-
-static void psblk_put_bdev(struct block_device *bdev, void *holder)
-{
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (!bdev)
-		return;
-
-	if (holder)
-		mode |= FMODE_EXCL;
-	blkdev_put(bdev, mode);
-}
-
-static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
-{
-	struct block_device *bdev = psblk_bdev;
-	struct file file;
-	struct kiocb kiocb;
-	struct iov_iter iter;
-	struct kvec iov = {.iov_base = buf, .iov_len = bytes};
-
-	if (!bdev)
-		return -ENODEV;
-
-	memset(&file, 0, sizeof(struct file));
-	file.f_mapping = bdev->bd_inode->i_mapping;
-	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
-	file.f_inode = bdev->bd_inode;
-	file_ra_state_init(&file.f_ra, file.f_mapping);
-
-	init_sync_kiocb(&kiocb, &file);
-	kiocb.ki_pos = pos;
-	iov_iter_kvec(&iter, READ, &iov, 1, bytes);
-
-	return generic_file_read_iter(&kiocb, &iter);
-}
-
-static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
-		loff_t pos)
-{
-	struct block_device *bdev = psblk_bdev;
-	struct iov_iter iter;
-	struct kiocb kiocb;
-	struct file file;
-	ssize_t ret;
-	struct kvec iov = {.iov_base = (void *)buf, .iov_len = bytes};
-
-	if (!bdev)
-		return -ENODEV;
-
-	/* Console/Ftrace backend may handle buffer until flush dirty zones */
-	if (in_interrupt() || irqs_disabled())
-		return -EBUSY;
-
-	memset(&file, 0, sizeof(struct file));
-	file.f_mapping = bdev->bd_inode->i_mapping;
-	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
-	file.f_inode = bdev->bd_inode;
-
-	init_sync_kiocb(&kiocb, &file);
-	kiocb.ki_pos = pos;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, bytes);
-
-	inode_lock(bdev->bd_inode);
-	ret = generic_write_checks(&kiocb, &iter);
-	if (ret > 0)
-		ret = generic_perform_write(&file, &iter, pos);
-	inode_unlock(bdev->bd_inode);
-
-	if (likely(ret > 0)) {
-		const struct file_operations f_op = {.fsync = blkdev_fsync};
-
-		file.f_op = &f_op;
-		kiocb.ki_pos += ret;
-		ret = generic_write_sync(&kiocb, ret);
-	}
-	return ret;
-}
-
-static ssize_t psblk_blk_panic_write(const char *buf, size_t size,
-		loff_t off)
-{
-	int ret;
-
-	if (!blkdev_panic_write)
-		return -EOPNOTSUPP;
-
-	/* size and off must align to SECTOR_SIZE for block device */
-	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
-			size >> SECTOR_SHIFT);
-	/* try next zone */
-	if (ret == -ENOMSG)
-		return ret;
-	return ret ? -EIO : size;
-}
-
-static int __register_pstore_blk(struct pstore_blk_info *info)
-{
-	char bdev_name[BDEVNAME_SIZE];
-	struct block_device *bdev;
-	struct pstore_device_info dev;
-	struct bdev_info binfo;
-	void *holder = blkdev;
-	int ret = -ENODEV;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	/* hold bdev exclusively */
-	memset(&binfo, 0, sizeof(binfo));
-	bdev = psblk_get_bdev(holder, &binfo);
-	if (IS_ERR(bdev)) {
-		pr_err("failed to open '%s'!\n", blkdev);
-		return PTR_ERR(bdev);
-	}
-
-	/* only allow driver matching the @blkdev */
-	if (!binfo.devt || (!best_effort &&
-			    MAJOR(binfo.devt) != info->major)) {
-		pr_debug("invalid major %u (expect %u)\n",
-				info->major, MAJOR(binfo.devt));
-		ret = -ENODEV;
-		goto err_put_bdev;
-	}
-
-	/* psblk_bdev must be assigned before register to pstore/blk */
-	psblk_bdev = bdev;
-	blkdev_panic_write = info->panic_write;
-
-	/* Copy back block device details. */
-	info->devt = binfo.devt;
-	info->nr_sects = binfo.nr_sects;
-	info->start_sect = binfo.start_sect;
-
-	memset(&dev, 0, sizeof(dev));
-	dev.total_size = info->nr_sects << SECTOR_SHIFT;
-	dev.flags = info->flags;
-	dev.read = psblk_generic_blk_read;
-	dev.write = psblk_generic_blk_write;
-	dev.erase = NULL;
-	dev.panic_write = info->panic_write ? psblk_blk_panic_write : NULL;
-
-	ret = __register_pstore_device(&dev);
-	if (ret)
-		goto err_put_bdev;
-
-	bdevname(bdev, bdev_name);
-	pr_info("attached %s%s\n", bdev_name,
-		info->panic_write ? "" : " (no dedicated panic_write!)");
-	return 0;
-
-err_put_bdev:
-	psblk_bdev = NULL;
-	blkdev_panic_write = NULL;
-	psblk_put_bdev(bdev, holder);
-	return ret;
-}
-
-/**
- * register_pstore_blk() - register block device to pstore/blk
- *
- * @info: details on the desired block device interface
- *
- * Return:
- * * 0		- OK
- * * Others	- something error.
- */
-int register_pstore_blk(struct pstore_blk_info *info)
-{
-	int ret;
-
-	mutex_lock(&pstore_blk_lock);
-	ret = __register_pstore_blk(info);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_pstore_blk);
-
-static void __unregister_pstore_blk(unsigned int major)
-{
-	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
-	void *holder = blkdev;
-
-	lockdep_assert_held(&pstore_blk_lock);
-	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
-		__unregister_pstore_device(&dev);
-		psblk_put_bdev(psblk_bdev, holder);
-		blkdev_panic_write = NULL;
-		psblk_bdev = NULL;
-	}
-}
-
-/**
- * unregister_pstore_blk() - unregister block device from pstore/blk
- *
- * @major: the major device number of device
- */
-void unregister_pstore_blk(unsigned int major)
-{
-	mutex_lock(&pstore_blk_lock);
-	__unregister_pstore_blk(major);
-	mutex_unlock(&pstore_blk_lock);
-}
-EXPORT_SYMBOL_GPL(unregister_pstore_blk);
-
-/* get information of pstore/blk */
-int pstore_blk_get_config(struct pstore_blk_config *info)
-{
-	strncpy(info->device, blkdev, 80);
-	info->max_reason = max_reason;
-	info->kmsg_size = check_size(kmsg_size, 4096);
-	info->pmsg_size = check_size(pmsg_size, 4096);
-	info->ftrace_size = check_size(ftrace_size, 4096);
-	info->console_size = check_size(console_size, 4096);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pstore_blk_get_config);
-
-static int __init pstore_blk_init(void)
-{
-	struct pstore_blk_info info = { };
-	int ret = 0;
-
-	mutex_lock(&pstore_blk_lock);
-	if (!pstore_zone_info && best_effort && blkdev[0])
-		ret = __register_pstore_blk(&info);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-late_initcall(pstore_blk_init);
-
-static void __exit pstore_blk_exit(void)
-{
-	mutex_lock(&pstore_blk_lock);
-	if (psblk_bdev)
-		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
-	else {
-		struct pstore_device_info dev = { };
-
-		if (pstore_zone_info)
-			dev.read = pstore_zone_info->read;
-		__unregister_pstore_device(&dev);
-	}
-	mutex_unlock(&pstore_blk_lock);
-}
-module_exit(pstore_blk_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
-MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
-MODULE_DESCRIPTION("pstore backend for block devices");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
deleted file mode 100644
index 61e914522b0193..00000000000000
--- a/include/linux/pstore_blk.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __PSTORE_BLK_H_
-#define __PSTORE_BLK_H_
-
-#include <linux/types.h>
-#include <linux/pstore.h>
-#include <linux/pstore_zone.h>
-
-/**
- * typedef pstore_blk_panic_write_op - panic write operation to block device
- *
- * @buf: the data to write
- * @start_sect: start sector to block device
- * @sects: sectors count on buf
- *
- * Return: On success, zero should be returned. Others excluding -ENOMSG
- * mean error. -ENOMSG means to try next zone.
- *
- * Panic write to block device must be aligned to SECTOR_SIZE.
- */
-typedef int (*pstore_blk_panic_write_op)(const char *buf, sector_t start_sect,
-		sector_t sects);
-
-/**
- * struct pstore_blk_info - pstore/blk registration details
- *
- * @major:	Which major device number to support with pstore/blk
- * @flags:	The supported PSTORE_FLAGS_* from linux/pstore.h.
- * @panic_write:The write operation only used for the panic case.
- *		This can be NULL, but is recommended to avoid losing
- *		crash data if the kernel's IO path or work queues are
- *		broken during a panic.
- * @devt:	The dev_t that pstore/blk has attached to.
- * @nr_sects:	Number of sectors on @devt.
- * @start_sect:	Starting sector on @devt.
- */
-struct pstore_blk_info {
-	unsigned int major;
-	unsigned int flags;
-	pstore_blk_panic_write_op panic_write;
-
-	/* Filled in by pstore/blk after registration. */
-	dev_t devt;
-	sector_t nr_sects;
-	sector_t start_sect;
-};
-
-int  register_pstore_blk(struct pstore_blk_info *info);
-void unregister_pstore_blk(unsigned int major);
-
-/**
- * struct pstore_device_info - back-end pstore/blk driver structure.
- *
- * @total_size: The total size in bytes pstore/blk can use. It must be greater
- *		than 4096 and be multiple of 4096.
- * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
- *		linux/pstore.h. It means what front-ends this device support.
- *		Zero means all backends for compatible.
- * @read:	The general read operation. Both of the function parameters
- *		@size and @offset are relative value to bock device (not the
- *		whole disk).
- *		On success, the number of bytes should be returned, others
- *		means error.
- * @write:	The same as @read, but the following error number:
- *		-EBUSY means try to write again later.
- *		-ENOMSG means to try next zone.
- * @erase:	The general erase operation for device with special removing
- *		job. Both of the function parameters @size and @offset are
- *		relative value to storage.
- *		Return 0 on success and others on failure.
- * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters are relative
- *		value to storage.
- *		On success, the number of bytes should be returned, others
- *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
- */
-struct pstore_device_info {
-	unsigned long total_size;
-	unsigned int flags;
-	pstore_zone_read_op read;
-	pstore_zone_write_op write;
-	pstore_zone_erase_op erase;
-	pstore_zone_write_op panic_write;
-};
-
-int  register_pstore_device(struct pstore_device_info *dev);
-void unregister_pstore_device(struct pstore_device_info *dev);
-
-/**
- * struct pstore_blk_config - the pstore_blk backend configuration
- *
- * @device:		Name of the desired block device
- * @max_reason:		Maximum kmsg dump reason to store to block device
- * @kmsg_size:		Total size of for kmsg dumps
- * @pmsg_size:		Total size of the pmsg storage area
- * @console_size:	Total size of the console storage area
- * @ftrace_size:	Total size for ftrace logging data (for all CPUs)
- */
-struct pstore_blk_config {
-	char device[80];
-	enum kmsg_dump_reason max_reason;
-	unsigned long kmsg_size;
-	unsigned long pmsg_size;
-	unsigned long console_size;
-	unsigned long ftrace_size;
-};
-
-/**
- * pstore_blk_get_config - get a copy of the pstore_blk backend configuration
- *
- * @info:	The sturct pstore_blk_config to be filled in
- *
- * Failure returns negative error code, and success returns 0.
- */
-int pstore_blk_get_config(struct pstore_blk_config *info);
-
-#endif
