Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2595E2002B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgFSH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:28:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729548AbgFSH25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:28:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C6557FF27759ABF67639;
        Fri, 19 Jun 2020 15:28:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 15:28:51 +0800
Subject: Re: [PATCH v2] f2fs-tools: introduce set_node_footer to initialize
 node footer
To:     <zhaowuyun@wingtech.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1592548634-1065-1-git-send-email-zhaowuyun@wingtech.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2b44ed71-deba-2c48-bd8a-6b6099fe5a8f@huawei.com>
Date:   Fri, 19 Jun 2020 15:28:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1592548634-1065-1-git-send-email-zhaowuyun@wingtech.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/19 14:37, zhaowuyun@wingtech.com wrote:
> From: Wuyun Zhao <zhaowuyun@wingtech.com>
> 
> the filesystem will use the cold flag, so deal with it to avoid
> potential issue of inconsistency
> 
> Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
> ---
>  fsck/dir.c         |  6 +-----
>  fsck/node.c        |  9 +++++----
>  include/f2fs_fs.h  | 20 ++++++++++++++++++++
>  mkfs/f2fs_format.c | 14 +++++---------
>  4 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 5f4f75e..64aa539 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -517,11 +517,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
>  	}
>  
>  	set_file_temperature(sbi, node_blk, de->name);
> -
> -	node_blk->footer.ino = cpu_to_le32(de->ino);
> -	node_blk->footer.nid = cpu_to_le32(de->ino);
> -	node_blk->footer.flag = 0;
> -	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> +	set_node_footer(node_blk, de->ino, de->ino, 0, le64_to_cpu(ckpt->checkpoint_ver), S_ISDIR(mode));
>  
>  	if (S_ISDIR(mode)) {
>  		make_empty_dir(sbi, node_blk);
> diff --git a/fsck/node.c b/fsck/node.c
> index 229a99c..66e8a81 100644
> --- a/fsck/node.c
> +++ b/fsck/node.c
> @@ -69,16 +69,17 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
>  	block_t blkaddr = NULL_ADDR;
>  	int type;
>  	int ret;
> +	u32 ino;

nid_t ino;

> +	u64 cp_ver;
>  
>  	f2fs_inode = dn->inode_blk;
>  
>  	node_blk = calloc(BLOCK_SZ, 1);
>  	ASSERT(node_blk);
>  
> -	node_blk->footer.nid = cpu_to_le32(dn->nid);
> -	node_blk->footer.ino = f2fs_inode->footer.ino;
> -	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
> -	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> +	ino = le32_to_cpu(f2fs_inode->footer.ino);
> +	cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
> +	set_node_footer(node_blk, dn->nid, ino, ofs, cp_ver, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
>  
>  	type = CURSEG_COLD_NODE;
>  	if (IS_DNODE(node_blk)) {
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 709bfd8..3583df4 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -923,6 +923,26 @@ struct f2fs_node {
>  	struct node_footer footer;
>  } __attribute__((packed));
>  
> +static inline void set_cold_node(struct f2fs_node *rn, bool is_dir)
> +{
> +	unsigned int flag = le32_to_cpu(rn->footer.flag);
> +
> +	if (is_dir)
> +		flag &= ~(0x1 << COLD_BIT_SHIFT);
> +	else
> +		flag |= (0x1 << COLD_BIT_SHIFT);
> +	rn->footer.flag = cpu_to_le32(flag);
> +}
> +
> +static inline void set_node_footer(struct f2fs_node *rn, u32 nid, u32 ino, u32 ofs, u64 ver, bool is_dir)

Sorry, I forgot to add parameter for next_blkaddr...

Could you check this?

From: Wuyun Zhao <zhaowuyun@wingtech.com>
Subject: [PATCH] f2fs-tools: introduce set_node_footer to initialize node
 footer

the filesystem will use the cold flag, so deal with it to avoid
potential issue of inconsistency

Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
---
 fsck/dir.c         |  7 ++-----
 fsck/node.c        |  8 ++++----
 include/f2fs_fs.h  | 23 +++++++++++++++++++++++
 mkfs/f2fs_format.c | 34 +++++++++++++---------------------
 4 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 5f4f75ebed77..b067aec9cffd 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -517,11 +517,8 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 	}

 	set_file_temperature(sbi, node_blk, de->name);
-
-	node_blk->footer.ino = cpu_to_le32(de->ino);
-	node_blk->footer.nid = cpu_to_le32(de->ino);
-	node_blk->footer.flag = 0;
-	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_node_footer(node_blk, de->ino, de->ino, 0,
+			le64_to_cpu(ckpt->checkpoint_ver), 0, S_ISDIR(mode));

 	if (S_ISDIR(mode)) {
 		make_empty_dir(sbi, node_blk);
diff --git a/fsck/node.c b/fsck/node.c
index 229a99cab481..da010ff669cc 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -69,16 +69,16 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 	block_t blkaddr = NULL_ADDR;
 	int type;
 	int ret;
+	nid_t ino = le32_to_cpu(f2fs_inode->footer.ino);
+	u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);

 	f2fs_inode = dn->inode_blk;

 	node_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk);

-	node_blk->footer.nid = cpu_to_le32(dn->nid);
-	node_blk->footer.ino = f2fs_inode->footer.ino;
-	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
-	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_node_footer(node_blk, dn->nid, ino, ofs, cp_ver, 0,
+			S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));

 	type = CURSEG_COLD_NODE;
 	if (IS_DNODE(node_blk)) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 265f50c69fd1..0fe478ed820c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -923,6 +923,29 @@ struct f2fs_node {
 	struct node_footer footer;
 } __attribute__((packed));

+static inline void set_cold_node(struct f2fs_node *rn, bool is_dir)
+{
+	unsigned int flag = le32_to_cpu(rn->footer.flag);
+
+	if (is_dir)
+		flag &= ~(0x1 << COLD_BIT_SHIFT);
+	else
+		flag |= (0x1 << COLD_BIT_SHIFT);
+	rn->footer.flag = cpu_to_le32(flag);
+}
+
+static inline void set_node_footer(struct f2fs_node *rn, u32 nid, u32 ino,
+					u32 ofs, u64 ver, block_t blkaddr,
+					bool is_dir)
+{
+	rn->footer.nid = cpu_to_le32(nid);
+	rn->footer.ino = cpu_to_le32(ino);
+	rn->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
+	rn->footer.cp_ver = cpu_to_le64(ver);
+	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
+	set_cold_node(rn, is_dir);
+}
+
 /*
  * For NAT entries
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 44575e0049fa..cb40e5a76332 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1094,6 +1094,9 @@ static int f2fs_write_root_inode(void)
 	struct f2fs_node *raw_node = NULL;
 	u_int64_t blk_size_bytes, data_blk_nor;
 	u_int64_t main_area_node_seg_blk_offset = 0;
+	nid_t nid = le32_to_cpu(sb->root_ino);
+	block_t blkaddr = cpu_to_le32(get_sb(main_blkaddr) +
+				c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + 1);

 	raw_node = calloc(F2FS_BLKSIZE, 1);
 	if (raw_node == NULL) {
@@ -1101,13 +1104,7 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}

-	raw_node->footer.nid = sb->root_ino;
-	raw_node->footer.ino = sb->root_ino;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] *
-			c.blks_per_seg + 1);
+	set_node_footer(raw_node, nid, nid, 0, 1, blkaddr, 1);

 	raw_node->i.i_mode = cpu_to_le16(0x41ed);
 	if (c.lpf_ino)
@@ -1256,6 +1253,10 @@ static int f2fs_write_qf_inode(int qtype)
 	u_int64_t main_area_node_seg_blk_offset = 0;
 	__le32 raw_id;
 	int i;
+	nid_t qf_ino = le32_to_cpu(sb->qf_ino[qtype]);
+	block_t blkaddr = cpu_to_le32(get_sb(main_blkaddr) +
+					c.cur_seg[CURSEG_HOT_NODE] *
+					c.blks_per_seg + 1 + qtype + 1);

 	raw_node = calloc(F2FS_BLKSIZE, 1);
 	if (raw_node == NULL) {
@@ -1263,13 +1264,7 @@ static int f2fs_write_qf_inode(int qtype)
 		return -1;
 	}

-	raw_node->footer.nid = sb->qf_ino[qtype];
-	raw_node->footer.ino = sb->qf_ino[qtype];
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] *
-			c.blks_per_seg + 1 + qtype + 1);
+	set_node_footer(raw_node, qf_ino, qf_ino, 0, 1, blkaddr, 0);

 	raw_node->i.i_mode = cpu_to_le16(0x8180);
 	raw_node->i.i_links = cpu_to_le32(1);
@@ -1447,6 +1442,9 @@ static int f2fs_write_lpf_inode(void)
 	struct f2fs_node *raw_node;
 	u_int64_t blk_size_bytes, main_area_node_seg_blk_offset;
 	block_t data_blk_nor;
+	block_t blkaddr = cpu_to_le32(get_sb(main_blkaddr) +
+				c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
+				1 + c.quota_inum + 1);
 	int err = 0;

 	ASSERT(c.lpf_ino);
@@ -1457,13 +1455,7 @@ static int f2fs_write_lpf_inode(void)
 		return -1;
 	}

-	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
-	raw_node->footer.ino = raw_node->footer.nid;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
-			1 + c.quota_inum + 1);
+	set_node_footer(raw_node, c.lpf_ino, c.lpf_ino, 0, 1, blkaddr, 1);

 	raw_node->i.i_mode = cpu_to_le16(0x41c0); /* 0700 */
 	raw_node->i.i_links = cpu_to_le32(2);
-- 
2.26.2




> +{
> +	rn->footer.nid = cpu_to_le32(nid);
> +	rn->footer.ino = cpu_to_le32(ino);
> +	rn->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
> +	rn->footer.cp_ver = cpu_to_le64(ver);
> +	set_cold_node(rn, is_dir);
> +}
> +
>  /*
>   * For NAT entries
>   */
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 44575e0..b371adf 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -1101,9 +1101,7 @@ static int f2fs_write_root_inode(void)
>  		return -1;
>  	}
>  
> -	raw_node->footer.nid = sb->root_ino;
> -	raw_node->footer.ino = sb->root_ino;
> -	raw_node->footer.cp_ver = cpu_to_le64(1);
> +	set_node_footer(raw_node, le32_to_cpu(sb->root_ino), le32_to_cpu(sb->root_ino), 0, 1, 1);
>  	raw_node->footer.next_blkaddr = cpu_to_le32(
>  			get_sb(main_blkaddr) +
>  			c.cur_seg[CURSEG_HOT_NODE] *
> @@ -1256,6 +1254,7 @@ static int f2fs_write_qf_inode(int qtype)
>  	u_int64_t main_area_node_seg_blk_offset = 0;
>  	__le32 raw_id;
>  	int i;
> +	u32 qf_ino;
>  
>  	raw_node = calloc(F2FS_BLKSIZE, 1);
>  	if (raw_node == NULL) {
> @@ -1263,9 +1262,8 @@ static int f2fs_write_qf_inode(int qtype)
>  		return -1;
>  	}
>  
> -	raw_node->footer.nid = sb->qf_ino[qtype];
> -	raw_node->footer.ino = sb->qf_ino[qtype];
> -	raw_node->footer.cp_ver = cpu_to_le64(1);
> +	qf_ino = le32_to_cpu(sb->qf_ino[qtype]);
> +	set_node_footer(raw_node, qf_ino, qf_ino, 0, 1, 0);
>  	raw_node->footer.next_blkaddr = cpu_to_le32(
>  			get_sb(main_blkaddr) +
>  			c.cur_seg[CURSEG_HOT_NODE] *
> @@ -1457,9 +1455,7 @@ static int f2fs_write_lpf_inode(void)
>  		return -1;
>  	}
>  
> -	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
> -	raw_node->footer.ino = raw_node->footer.nid;
> -	raw_node->footer.cp_ver = cpu_to_le64(1);
> +	set_node_footer(raw_node, c.lpf_ino, c.lpf_ino, 0, 1, 1);
>  	raw_node->footer.next_blkaddr = cpu_to_le32(
>  			get_sb(main_blkaddr) +
>  			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
> 
