Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013322D1C68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgLGVyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:54:15 -0500
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:59564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgLGVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:54:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 98E05100E7B40;
        Mon,  7 Dec 2020 21:53:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:1:41:69:355:379:599:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1730:1747:1777:1792:2194:2196:2199:2200:2393:2553:2559:2562:2638:2692:2828:2898:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:4250:4303:4321:4384:4385:4395:4605:5007:6117:7903:7904:8957:9592:10004:10848:11026:11232:11233:11473:11658:11914:12043:12291:12296:12297:12438:12555:12683:12740:12760:12895:12986:13161:13229:13439:14659:21080:21324:21433:21451:21626:21740:21939:21990:30012:30054:30056:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cave79_04001bc273e1
X-Filterd-Recvd-Size: 13367
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Dec 2020 21:53:31 +0000 (UTC)
Message-ID: <9aed191d0babdfc9da202faab930623a6aa35c61.camel@perches.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: support chksum
From:   Joe Perches <joe@perches.com>
To:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Date:   Mon, 07 Dec 2020 13:53:30 -0800
In-Reply-To: <X86Sb2pvD53MzO5+@gmail.com>
References: <20201126103209.67985-1-yuchao0@huawei.com>
         <X86Sb2pvD53MzO5+@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-07 at 12:37 -0800, Eric Biggers wrote:
> On Thu, Nov 26, 2020 at 06:32:09PM +0800, Chao Yu wrote:
> > +	if (!ret && fi->i_compress_flag & 1 << COMPRESS_CHKSUM) {
> 
> This really could use some parentheses.  People shouldn't have to look up a
> C operator precedence table to understand the code.
> 
> > +		u32 provided = le32_to_cpu(dic->cbuf->chksum);
> > +		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
> > +
> > +		if (provided != calculated) {
> > +			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
> > +				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
> > +				printk_ratelimited(
> > +					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
> > +					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
> > +					provided, calculated);
> > +			}
> > +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +			WARN_ON_ONCE(1);
> 
> WARN, WARN_ON_ONCE, BUG, BUG_ON, etc. are only for kernel bugs, not for invalid
> inputs from disk or userspace.
> 
> There is already a log message printed just above, so it seems this WARN_ON_ONCE
> should just be removed.

And this should probably be
				pr_info_ratelimited("F2FS-fs etc...);
with a terminating newline in the format too.

With the current -next, maybe adding new f2fs_<level>_ratelimited macros
would make more sense.

The logging macro definitions are moved to allow the f2fs_<level>_ratelimited
to work for the one use in f2fs_show_injection_info.

This also adds some missing newline terminations to formats.

---
 fs/f2fs/compress.c | 79 +++++++++++++++++++++++++-----------------------------
 fs/f2fs/dir.c      |  7 +++--
 fs/f2fs/f2fs.h     | 60 ++++++++++++++++++++++++++++-------------
 fs/f2fs/segment.c  |  6 ++---
 4 files changed, 83 insertions(+), 69 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 08987923513d..587dae6c0947 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -211,8 +211,8 @@ static int lzo_compress_pages(struct compress_ctx *cc)
 	ret = lzo1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
 					&cc->clen, cc->private);
 	if (ret != LZO_E_OK) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo compress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				     "lzo compress failed, ret:%d\n", ret);
 		return -EIO;
 	}
 	return 0;
@@ -225,17 +225,16 @@ static int lzo_decompress_pages(struct decompress_io_ctx *dic)
 	ret = lzo1x_decompress_safe(dic->cbuf->cdata, dic->clen,
 						dic->rbuf, &dic->rlen);
 	if (ret != LZO_E_OK) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo decompress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "lzo decompress failed, ret:%d\n", ret);
 		return -EIO;
 	}
 
 	if (dic->rlen != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo invalid rlen:%zu, "
-					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
-					dic->rlen,
-					PAGE_SIZE << dic->log_cluster_size);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "lzo invalid rlen:%zu, expected:%lu\n",
+				     dic->rlen,
+				     PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
 	return 0;
@@ -292,17 +291,16 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	ret = LZ4_decompress_safe(dic->cbuf->cdata, dic->rbuf,
 						dic->clen, dic->rlen);
 	if (ret < 0) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 decompress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "lz4 decompress failed, ret:%d\n", ret);
 		return -EIO;
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid rlen:%zu, "
-					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
-					dic->rlen,
-					PAGE_SIZE << dic->log_cluster_size);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "lz4 invalid rlen:%zu, expected:%lu\n",
+				     dic->rlen,
+				     PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
 	return 0;
@@ -336,9 +334,8 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 
 	stream = ZSTD_initCStream(params, 0, workspace, workspace_size);
 	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initCStream failed\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__);
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				     "%s ZSTD_initCStream failed\n", __func__);
 		kvfree(workspace);
 		return -EIO;
 	}
@@ -376,17 +373,17 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 
 	ret = ZSTD_compressStream(stream, &outbuf, &inbuf);
 	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				     "%s ZSTD_compressStream failed, ret: %d\n",
+				     __func__, ZSTD_getErrorCode(ret));
 		return -EIO;
 	}
 
 	ret = ZSTD_endStream(stream, &outbuf);
 	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_endStream returned %d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				     "%s ZSTD_endStream returned %d\n",
+				     __func__, ZSTD_getErrorCode(ret));
 		return -EIO;
 	}
 
@@ -418,9 +415,8 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 
 	stream = ZSTD_initDStream(max_window_size, workspace, workspace_size);
 	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initDStream failed\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
-				__func__);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "%s ZSTD_initDStream failed\n", __func__);
 		kvfree(workspace);
 		return -EIO;
 	}
@@ -455,18 +451,17 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 
 	ret = ZSTD_decompressStream(stream, &outbuf, &inbuf);
 	if (ZSTD_isError(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
-				__func__, ZSTD_getErrorCode(ret));
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "%s ZSTD_compressStream failed, ret: %d\n",
+				     __func__, ZSTD_getErrorCode(ret));
 		return -EIO;
 	}
 
 	if (dic->rlen != outbuf.pos) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD invalid rlen:%zu, "
-				"expected:%lu\n", KERN_ERR,
-				F2FS_I_SB(dic->inode)->sb->s_id,
-				__func__, dic->rlen,
-				PAGE_SIZE << dic->log_cluster_size);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				     "%s ZSTD invalid rlen:%zu, expected:%lu\n",
+				     __func__, dic->rlen,
+				     PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
 
@@ -492,8 +487,8 @@ static int lzorle_compress_pages(struct compress_ctx *cc)
 	ret = lzorle1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
 					&cc->clen, cc->private);
 	if (ret != LZO_E_OK) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo-rle compress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				     "lzo-rle compress failed, ret:%d\n", ret);
 		return -EIO;
 	}
 	return 0;
@@ -808,10 +803,10 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 		if (provided != calculated) {
 			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
 				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
-				printk_ratelimited(
-					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
-					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
-					provided, calculated);
+				f2fs_info_ratelimited(sbi,
+						      "checksum invalid, nid = %lu, %x vs %x\n",
+						      dic->inode->i_ino,
+						      provided, calculated);
 			}
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			WARN_ON_ONCE(1);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 82b58d1f80eb..184989dfc8a5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1008,10 +1008,9 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		if (de->name_len == 0) {
 			bit_pos++;
 			ctx->pos = start_pos + bit_pos;
-			printk_ratelimited(
-				"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
-				KERN_WARNING, sbi->sb->s_id,
-				le32_to_cpu(de->ino));
+			f2fs_warn_ratelimited(sbi,
+					      "invalid namelen(0), ino:%u, run fsck to fix\n",
+					      le32_to_cpu(de->ino));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			continue;
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5cd1b9f7cc53..c6cff897f886 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1573,12 +1573,48 @@ struct f2fs_private_dio {
 	bool write;
 };
 
+__printf(2, 3)
+void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...);
+
+#define f2fs_err(sbi, fmt, ...)						\
+	f2fs_printk(sbi, KERN_ERR fmt, ##__VA_ARGS__)
+#define f2fs_warn(sbi, fmt, ...)					\
+	f2fs_printk(sbi, KERN_WARNING fmt, ##__VA_ARGS__)
+#define f2fs_notice(sbi, fmt, ...)					\
+	f2fs_printk(sbi, KERN_NOTICE fmt, ##__VA_ARGS__)
+#define f2fs_info(sbi, fmt, ...)					\
+	f2fs_printk(sbi, KERN_INFO fmt, ##__VA_ARGS__)
+#define f2fs_debug(sbi, fmt, ...)					\
+	f2fs_printk(sbi, KERN_DEBUG fmt, ##__VA_ARGS__)
+
+/* Ratelimited variants of the above logging uses*/
+
+#define f2fs_printk_ratelimited(sbi, fmt, ...)				\
+({									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+									\
+	if (__ratelimit(&_rs))						\
+		f2fs_printk(sbi, fmt, ##__VA_ARGS__);			\
+})
+
+#define f2fs_err_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk_ratelimited(sbi, KERN_ERR fmt, ##__VA_ARGS__)
+#define f2fs_warn_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk_ratelimited(sbi, KERN_WARNING fmt, ##__VA_ARGS__)
+#define f2fs_notice_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk_ratelimited(sbi, KERN_NOTICE fmt, ##__VA_ARGS__)
+#define f2fs_info_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk_ratelimited(sbi, KERN_INFO fmt, ##__VA_ARGS__)
+#define f2fs_debug_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk_ratelimited(sbi, KERN_DEBUG fmt, ##__VA_ARGS__)
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-#define f2fs_show_injection_info(sbi, type)					\
-	printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",	\
-		KERN_INFO, sbi->sb->s_id,				\
-		f2fs_fault_name[type],					\
-		__func__, __builtin_return_address(0))
+#define f2fs_show_injection_info(sbi, type)				\
+	f2fs_info_ratelimited(sbi, "inject %s in %s of %pS\n",		\
+			      f2fs_fault_name[type],			\
+			      __func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
@@ -2027,20 +2063,6 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
-__printf(2, 3)
-void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...);
-
-#define f2fs_err(sbi, fmt, ...)						\
-	f2fs_printk(sbi, KERN_ERR fmt, ##__VA_ARGS__)
-#define f2fs_warn(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_WARNING fmt, ##__VA_ARGS__)
-#define f2fs_notice(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_NOTICE fmt, ##__VA_ARGS__)
-#define f2fs_info(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_INFO fmt, ##__VA_ARGS__)
-#define f2fs_debug(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_DEBUG fmt, ##__VA_ARGS__)
-
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
 						block_t count)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index deca74cb17df..cf500ce90b95 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1057,10 +1057,8 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 		dc->error = 0;
 
 	if (dc->error)
-		printk_ratelimited(
-			"%sF2FS-fs (%s): Issue discard(%u, %u, %u) failed, ret: %d",
-			KERN_INFO, sbi->sb->s_id,
-			dc->lstart, dc->start, dc->len, dc->error);
+		f2fs_info_ratelimited(sbi, "Issue discard(%u, %u, %u) failed, ret: %d\n",
+				      dc->lstart, dc->start, dc->len, dc->error);
 	__detach_discard_cmd(dcc, dc);
 }
 

