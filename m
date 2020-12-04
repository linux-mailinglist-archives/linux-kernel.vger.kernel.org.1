Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792DE2CE691
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgLDD2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgLDD2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:28:54 -0500
Date:   Thu, 3 Dec 2020 19:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607052494;
        bh=LSn0KRD2PS55Qfjku+L9Oy5ZlN/QdMdDyNZ36/PvM8A=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLeUlRdAtr+nikQ+ES2mOIYMNJGkWvOzBmDFyNC892TJlrKZdsVj4vfLcSyJvg9sl
         BcyeCqHDSNu7rqDCe8wpVvbDXaEYytfQOVerM1PaxTqB7ZvunIovK9FVW2zXMeLwRS
         55DIGZbygCp8SkmaB+nUKttwOrSH76v+ZlzBXxTDlCq6gL/ujLCUkQdsvl0jNT09xw
         Q+3cRlLy9Sx0RNNA26UfSExxx9KyLxeK0qGq28Kfzc+m0ZL7vengtRB2H7fKjS0QOC
         V6fQ9I94EPQGnrsbVq9SLHda0mkdR+wgljgai4YX5pkcCq6fELK5+ZnGgfdDA5tyGF
         hOM2/VZSNNOrA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X8msy1T8uqZ4Z/iR@sol.localdomain>
References: <20201204005847.654074-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204005847.654074-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:58:47AM +0900, Daeho Jeong wrote:
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 87090da8693d..cdf72e153da0 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -803,8 +803,6 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
>  	if (cops->destroy_decompress_ctx)
>  		cops->destroy_decompress_ctx(dic);
>  out_free_dic:
> -	if (verity)
> -		atomic_set(&dic->pending_pages, dic->nr_cpages);
>  	if (!verity)
>  		f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
>  								ret, false);
> @@ -1498,6 +1496,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
>  	dic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
>  	dic->inode = cc->inode;
>  	atomic_set(&dic->pending_pages, cc->nr_cpages);
> +	if (fsverity_active(cc->inode))
> +		atomic_set(&dic->verity_pages, cc->nr_cpages);
>  	dic->cluster_idx = cc->cluster_idx;
>  	dic->cluster_size = cc->cluster_size;
>  	dic->log_cluster_size = cc->log_cluster_size;

The check for fsverity_active() is wrong.  It looks like you need to know
whether the bio needs to go through the fs-verity data verification.  The
correct way to determine that is to check whether STEP_VERITY is enabled in the
bio's bio_post_read_ctx.  It's set by f2fs_grab_read_bio() when needed.

- Eric
