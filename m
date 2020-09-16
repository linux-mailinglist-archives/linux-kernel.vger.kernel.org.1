Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42B526BD22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIPGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:31:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgIPGbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:31:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C6394148A0213A195E8;
        Wed, 16 Sep 2020 14:31:07 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 16 Sep
 2020 14:31:06 +0800
Subject: Re: [PATCH 6/9] f2fs: zstd: Switch to the zstd-1.4.6 API
To:     Nick Terrell <nickrterrell@gmail.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-9-nickrterrell@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <28bf92f1-1246-a840-6195-0e230e517e6d@huawei.com>
Date:   Wed, 16 Sep 2020 14:31:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200916034307.2092020-9-nickrterrell@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

remove not related mailing list.

On 2020/9/16 11:43, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Move away from the compatibility wrapper to the zstd-1.4.6 API. This
> code is more efficient because it uses the single-pass API instead of
> the streaming API. The streaming API is not necessary because the whole
> input and output buffers are available. This saves memory because we
> don't need to allocate a buffer for the window. It is also more
> efficient because it saves unnecessary memcpy calls.
> 
> I've had problems testing this code because I see data truncation before
> and after this patchset. Help testing this patch would be much
> appreciated.

Can you please explain more about data truncation? I'm a little confused...

Do you mean that f2fs doesn't allocate enough memory for zstd compression,
so that compression is not finished actually, the compressed data is truncated
at dst buffer?

Thanks,

> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>   fs/f2fs/compress.c | 102 +++++++++++++++++----------------------------
>   1 file changed, 38 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index e056f3a2b404..b79efce81651 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -11,7 +11,8 @@
>   #include <linux/backing-dev.h>
>   #include <linux/lzo.h>
>   #include <linux/lz4.h>
> -#include <linux/zstd_compat.h>
> +#include <linux/zstd.h>
> +#include <linux/zstd_errors.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -298,21 +299,21 @@ static const struct f2fs_compress_ops f2fs_lz4_ops = {
>   static int zstd_init_compress_ctx(struct compress_ctx *cc)
>   {
>   	ZSTD_parameters params;
> -	ZSTD_CStream *stream;
> +	ZSTD_CCtx *ctx;
>   	void *workspace;
>   	unsigned int workspace_size;
>   
>   	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, cc->rlen, 0);
> -	workspace_size = ZSTD_CStreamWorkspaceBound(params.cParams);
> +	workspace_size = ZSTD_estimateCCtxSize_usingCParams(params.cParams);
>   
>   	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
>   					workspace_size, GFP_NOFS);
>   	if (!workspace)
>   		return -ENOMEM;
>   
> -	stream = ZSTD_initCStream(params, 0, workspace, workspace_size);
> -	if (!stream) {
> -		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initCStream failed\n",
> +	ctx = ZSTD_initStaticCCtx(workspace, workspace_size);
> +	if (!ctx) {
> +		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_inittaticCStream failed\n",
>   				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
>   				__func__);
>   		kvfree(workspace);
> @@ -320,7 +321,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
>   	}
>   
>   	cc->private = workspace;
> -	cc->private2 = stream;
> +	cc->private2 = ctx;
>   
>   	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>   	return 0;
> @@ -335,65 +336,48 @@ static void zstd_destroy_compress_ctx(struct compress_ctx *cc)
>   
>   static int zstd_compress_pages(struct compress_ctx *cc)
>   {
> -	ZSTD_CStream *stream = cc->private2;
> -	ZSTD_inBuffer inbuf;
> -	ZSTD_outBuffer outbuf;
> -	int src_size = cc->rlen;
> -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> -	int ret;
> -
> -	inbuf.pos = 0;
> -	inbuf.src = cc->rbuf;
> -	inbuf.size = src_size;
> -
> -	outbuf.pos = 0;
> -	outbuf.dst = cc->cbuf->cdata;
> -	outbuf.size = dst_size;
> -
> -	ret = ZSTD_compressStream(stream, &outbuf, &inbuf);
> -	if (ZSTD_isError(ret)) {
> -		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
> -				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
> -				__func__, ZSTD_getErrorCode(ret));
> -		return -EIO;
> -	}
> -
> -	ret = ZSTD_endStream(stream, &outbuf);
> +	ZSTD_CCtx *ctx = cc->private2;
> +	const size_t src_size = cc->rlen;
> +	const size_t dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	ZSTD_parameters params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, src_size, 0);
> +	size_t ret;
> +
> +	ret = ZSTD_compress_advanced(
> +			ctx, cc->cbuf->cdata, dst_size, cc->rbuf, src_size, NULL, 0, params);
>   	if (ZSTD_isError(ret)) {
> -		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_endStream returned %d\n",
> +		/*
> +		 * there is compressed data remained in intermediate buffer due to
> +		 * no more space in cbuf.cdata
> +		 */
> +		if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall)
> +			return -EAGAIN;
> +		/* other compression errors return -EIO */
> +		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compress_advanced failed, err: %s\n",
>   				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
> -				__func__, ZSTD_getErrorCode(ret));
> +				__func__, ZSTD_getErrorName(ret));
>   		return -EIO;
>   	}
>   
> -	/*
> -	 * there is compressed data remained in intermediate buffer due to
> -	 * no more space in cbuf.cdata
> -	 */
> -	if (ret)
> -		return -EAGAIN;
> -
> -	cc->clen = outbuf.pos;
> +	cc->clen = ret;
>   	return 0;
>   }
>   
>   static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
>   {
> -	ZSTD_DStream *stream;
> +	ZSTD_DCtx *ctx;
>   	void *workspace;
>   	unsigned int workspace_size;
>   
> -	workspace_size = ZSTD_DStreamWorkspaceBound(MAX_COMPRESS_WINDOW_SIZE);
> +	workspace_size = ZSTD_estimateDCtxSize();
>   
>   	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
>   					workspace_size, GFP_NOFS);
>   	if (!workspace)
>   		return -ENOMEM;
>   
> -	stream = ZSTD_initDStream(MAX_COMPRESS_WINDOW_SIZE,
> -					workspace, workspace_size);
> -	if (!stream) {
> -		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initDStream failed\n",
> +	ctx = ZSTD_initStaticDCtx(workspace, workspace_size);
> +	if (!ctx) {
> +		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initStaticDCtx failed\n",
>   				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
>   				__func__);
>   		kvfree(workspace);
> @@ -401,7 +385,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
>   	}
>   
>   	dic->private = workspace;
> -	dic->private2 = stream;
> +	dic->private2 = ctx;
>   
>   	return 0;
>   }
> @@ -415,28 +399,18 @@ static void zstd_destroy_decompress_ctx(struct decompress_io_ctx *dic)
>   
>   static int zstd_decompress_pages(struct decompress_io_ctx *dic)
>   {
> -	ZSTD_DStream *stream = dic->private2;
> -	ZSTD_inBuffer inbuf;
> -	ZSTD_outBuffer outbuf;
> -	int ret;
> -
> -	inbuf.pos = 0;
> -	inbuf.src = dic->cbuf->cdata;
> -	inbuf.size = dic->clen;
> -
> -	outbuf.pos = 0;
> -	outbuf.dst = dic->rbuf;
> -	outbuf.size = dic->rlen;
> +	ZSTD_DCtx *ctx = dic->private2;
> +	size_t ret;
>   
> -	ret = ZSTD_decompressStream(stream, &outbuf, &inbuf);
> +	ret = ZSTD_decompressDCtx(ctx, dic->rbuf, dic->rlen, dic->cbuf->cdata, dic->clen);
>   	if (ZSTD_isError(ret)) {
> -		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_compressStream failed, ret: %d\n",
> +		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_decompressDCtx failed, err: %s\n",
>   				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
> -				__func__, ZSTD_getErrorCode(ret));
> +				__func__, ZSTD_getErrorName(ret));
>   		return -EIO;
>   	}
>   
> -	if (dic->rlen != outbuf.pos) {
> +	if (dic->rlen != ret) {
>   		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD invalid rlen:%zu, "
>   				"expected:%lu\n", KERN_ERR,
>   				F2FS_I_SB(dic->inode)->sb->s_id,
> 
