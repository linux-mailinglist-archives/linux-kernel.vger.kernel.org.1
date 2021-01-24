Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB2301F91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhAXXXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 18:23:03 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47180 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbhAXXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:22:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 8668B1812A4B6;
        Mon, 25 Jan 2021 00:21:02 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qVqT6mphhTMm; Mon, 25 Jan 2021 00:21:02 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OVbrgLCKol4h; Mon, 25 Jan 2021 00:21:01 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/8] mtd: Allow passing a custom cmdline to cmdline line parser
Date:   Mon, 25 Jan 2021 00:20:04 +0100
Message-Id: <20210124232007.21639-6-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmdline parser uses usually the mtdparts string from the kernel cmdli=
ne.
For special purpose MTDs like MUSE it is useful to pass a custom
mtdparts string to the parser. This allows the MTD simulator in
userspace directly passing a mtdparts string and the new MTD
partitioned.

To achieve this, struct mtd_part_parser_data now has a mtdparts pointer
where a custom mtdparts string can be provided, it overrules the kernel
cmdline.
Since the cmdline parser stays for ever in the kernel, the memory lifecyc=
le
had to be changed a little such that custom mtdparts string don't result
in memory leaks.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/parsers/cmdlinepart.c | 73 ++++++++++++++++++++++++-------
 include/linux/mtd/partitions.h    |  2 +
 2 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/parsers/cmdlinepart.c b/drivers/mtd/parsers/cmdl=
inepart.c
index 0ddff1a4b51f..f0fe87267380 100644
--- a/drivers/mtd/parsers/cmdlinepart.c
+++ b/drivers/mtd/parsers/cmdlinepart.c
@@ -64,7 +64,7 @@ struct cmdline_mtd_partition {
 };
=20
 /* mtdpart_setup() parses into here */
-static struct cmdline_mtd_partition *partitions;
+static struct cmdline_mtd_partition *cmdline_partitions;
=20
 /* the command line passed to mtdpart_setup() */
 static char *mtdparts;
@@ -138,9 +138,6 @@ static struct mtd_partition * newpart(char *s,
 		name_len =3D 13; /* Partition_000 */
 	}
=20
-	/* record name length for memory allocation later */
-	extra_mem_size +=3D name_len + 1;
-
 	/* test for options */
 	if (strncmp(s, "ro", 2) =3D=3D 0) {
 		mask_flags |=3D MTD_WRITEABLE;
@@ -192,12 +189,17 @@ static struct mtd_partition * newpart(char *s,
 	parts[this_part].offset =3D offset;
 	parts[this_part].mask_flags =3D mask_flags;
 	parts[this_part].add_flags =3D add_flags;
+
+	/*
+	 * Will get free()'ed in ->cleanup()
+	 */
 	if (name)
-		strlcpy(extra_mem, name, name_len + 1);
+		parts[this_part].name =3D kmemdup_nul(name, name_len, GFP_KERNEL);
 	else
-		sprintf(extra_mem, "Partition_%03d", this_part);
-	parts[this_part].name =3D extra_mem;
-	extra_mem +=3D name_len + 1;
+		parts[this_part].name =3D kasprintf(GFP_KERNEL, "Partition_%03d", this=
_part);
+
+	if (!parts[this_part].name)
+		return ERR_PTR(-ENOMEM);
=20
 	dbg(("partition %d: name <%s>, offset %llx, size %llx, mask flags %x\n"=
,
 	     this_part, parts[this_part].name, parts[this_part].offset,
@@ -217,7 +219,7 @@ static struct mtd_partition * newpart(char *s,
 /*
  * Parse the command line.
  */
-static int mtdpart_setup_real(char *s)
+static int mtdpart_setup_real(char *s, struct cmdline_mtd_partition **pa=
rtitions)
 {
 	cmdline_parsed =3D 1;
=20
@@ -301,8 +303,8 @@ static int mtdpart_setup_real(char *s)
 		strlcpy(this_mtd->mtd_id, mtd_id, mtd_id_len + 1);
=20
 		/* link into chain */
-		this_mtd->next =3D partitions;
-		partitions =3D this_mtd;
+		this_mtd->next =3D *partitions;
+		*partitions =3D this_mtd;
=20
 		dbg(("mtdid=3D<%s> num_parts=3D<%d>\n",
 		     this_mtd->mtd_id, this_mtd->num_parts));
@@ -335,13 +337,23 @@ static int parse_cmdline_partitions(struct mtd_info=
 *master,
 				    struct mtd_part_parser_data *data)
 {
 	unsigned long long offset;
-	int i, err;
+	int i, err, num_parts;
 	struct cmdline_mtd_partition *part;
 	const char *mtd_id =3D master->name;
+	struct cmdline_mtd_partition *parsed_parts =3D cmdline_partitions;
+	bool free_parts =3D false;
+
+	if (data && data->mtdparts) {
+		parsed_parts =3D NULL;
=20
-	/* parse command line */
-	if (!cmdline_parsed) {
-		err =3D mtdpart_setup_real(cmdline);
+		err =3D mtdpart_setup_real(data->mtdparts, &parsed_parts);
+		if (err)
+			return err;
+
+		free_parts =3D true;
+	} else if (!cmdline_parsed) {
+		/* parse command line */
+		err =3D mtdpart_setup_real(cmdline, &cmdline_partitions);
 		if (err)
 			return err;
 	}
@@ -350,7 +362,7 @@ static int parse_cmdline_partitions(struct mtd_info *=
master,
 	 * Search for the partition definition matching master->name.
 	 * If master->name is not set, stop at first partition definition.
 	 */
-	for (part =3D partitions; part; part =3D part->next) {
+	for (part =3D parsed_parts; part; part =3D part->next) {
 		if ((!mtd_id) || (!strcmp(part->mtd_id, mtd_id)))
 			break;
 	}
@@ -384,12 +396,38 @@ static int parse_cmdline_partitions(struct mtd_info=
 *master,
 		}
 	}
=20
+	/*
+	 * Will get free()'ed in ->cleanup()
+	 */
 	*pparts =3D kmemdup(part->parts, sizeof(*part->parts) * part->num_parts=
,
 			  GFP_KERNEL);
 	if (!*pparts)
 		return -ENOMEM;
=20
-	return part->num_parts;
+	num_parts =3D part->num_parts;
+
+	if (free_parts =3D=3D true) {
+		part =3D parsed_parts;
+		while (part) {
+			struct cmdline_mtd_partition *next =3D part->next;
+
+			kfree(part->parts);
+			part =3D next;
+		}
+	}
+
+	return num_parts;
+}
+
+static void cmdline_partitions_cleanup(const struct mtd_partition *ppart=
s,
+				       int nr_parts)
+{
+	int i;
+
+	for (i =3D 0; i < nr_parts; i++)
+		kfree(pparts[i].name);
+
+	kfree(pparts);
 }
=20
=20
@@ -410,6 +448,7 @@ __setup("mtdparts=3D", mtdpart_setup);
=20
 static struct mtd_part_parser cmdline_parser =3D {
 	.parse_fn =3D parse_cmdline_partitions,
+	.cleanup =3D cmdline_partitions_cleanup,
 	.name =3D "cmdlinepart",
 };
=20
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partition=
s.h
index b74a539ec581..6c8b3399143d 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -65,9 +65,11 @@ struct device_node;
 /**
  * struct mtd_part_parser_data - used to pass data to MTD partition pars=
ers.
  * @origin: for RedBoot, start address of MTD device
+ * @mtdparts: for cmdline parser, use this string instead of mtdparts=3D=
 from cmdline
  */
 struct mtd_part_parser_data {
 	unsigned long origin;
+	char *mtdparts;
 };
=20
=20
--=20
2.26.2

