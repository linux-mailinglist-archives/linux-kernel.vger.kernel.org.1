Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0999B2C11C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgKWRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKWRT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:19:29 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A752075A;
        Mon, 23 Nov 2020 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606151968;
        bh=mKs1DtKcf8HjLRb0oweQoRlyPQpUSnm6TGBgfwx66+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f35UDnNikB6cfMcAXZ0cTa/GRfC+gO2HW7r6CUe70hCVlbPLPjRc1M8yjUKWekIma
         xmjzmG9A3p3h0ig7OlTncWyjoYbK3t8QX9UyDo7AYP1UTR+p7nIKHYtK22PyZTpwKw
         45SAGi7t9tge+42zJo/unPnc+oQJlvcEvlDMwxoU=
Date:   Mon, 23 Nov 2020 09:19:26 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
Message-ID: <20201123171926.GC413620@google.com>
References: <20201123031751.36811-1-daeho43@gmail.com>
 <20201123031751.36811-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123031751.36811-2-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two ioctl to decompress/compress explicitly the compression
> enabled file in "compress_mode=user-based" mount option.
> 
> Using these two ioctls, the users can make a control of compression
> and decompression of their files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c            | 181 +++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/f2fs.h |   2 +
>  2 files changed, 182 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index be8db06aca27..e8f142470e87 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4026,6 +4026,180 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>  	return ret;
>  }
>  
> +static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
> +{
> +	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct address_space *mapping = inode->i_mapping;
> +	struct page *page;
> +	pgoff_t redirty_idx = page_idx;
> +	int i, page_len = 0, ret = 0;
> +
> +	page_cache_ra_unbounded(&ractl, len, 0);
> +
> +	for (i = 0; i < len; i++, page_idx++) {
> +		page = read_cache_page(mapping, page_idx, NULL, NULL);
> +		if (IS_ERR(page)) {
> +			ret = PTR_ERR(page);
> +			f2fs_warn(sbi, "%s: inode (%lu) : page_index (%lu) "
> +				"couldn't be read (errno:%d).\n",
> +				__func__, inode->i_ino, page_idx, ret);
> +			break;
> +		}
> +		page_len++;
> +	}
> +
> +	for (i = 0; i < page_len; i++, redirty_idx++) {
> +		page = find_lock_page(mapping, redirty_idx);
> +		if (!page) {
> +			ret = -ENOENT;
> +			f2fs_warn(sbi, "%s: inode (%lu) : page_index (%lu) "
> +				"couldn't be found (errno:%d).\n",
> +				__func__, inode->i_ino, redirty_idx, ret);
> +		}
> +		set_page_dirty(page);
> +		f2fs_put_page(page, 1);
> +		f2fs_put_page(page, 0);
> +	}
> +
> +	return ret;
> +}
> +
> +static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	pgoff_t page_idx = 0, last_idx;
> +	int cluster_size = F2FS_I(inode)->i_cluster_size;
> +	int count, ret;
> +
> +	if (!f2fs_sb_has_compression(sbi))
> +		return -EOPNOTSUPP;
> +
> +	if (!(filp->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (!f2fs_compressed_file(inode))
> +		return -EINVAL;
> +
> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> +
> +	file_start_write(filp);
> +	inode_lock(inode);
> +
> +	if (f2fs_is_mmap_file(inode)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> +	if (ret)
> +		goto out;
> +
> +	if (!atomic_read(&fi->i_compr_blocks))
> +		goto out;
> +
> +	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +
> +	count = last_idx - page_idx;
> +	while (count) {
> +		int len = min(cluster_size, count);
> +
> +		ret = redirty_blocks(inode, page_idx, len);
> +
> +		if (ret < 0)
> +			break;
> +
> +		page_idx += len;
> +		count -= len;
> +	}
> +
> +	if (!ret)
> +		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
> +							LLONG_MAX);
> +
> +	if (!ret) {
> +		stat_sub_compr_blocks(inode, atomic_read(&fi->i_compr_blocks));
> +		atomic_set(&fi->i_compr_blocks, 0);
> +		f2fs_mark_inode_dirty_sync(inode, true);
> +	} else {
> +		f2fs_warn(sbi, "%s: The file might be partially decompressed "
> +				"(errno=%d). Please delete the file.\n",
> +				__func__, ret);
> +	}
> +out:
> +	inode_unlock(inode);
> +	file_end_write(filp);
> +
> +	return ret;
> +}
> +
> +static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	pgoff_t page_idx = 0, last_idx;
> +	int cluster_size = F2FS_I(inode)->i_cluster_size;
> +	int count, ret;
> +
> +	if (!f2fs_sb_has_compression(sbi))
> +		return -EOPNOTSUPP;
> +
> +	if (!(filp->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (!f2fs_compressed_file(inode))
> +		return -EINVAL;
> +
> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> +
> +	file_start_write(filp);
> +	inode_lock(inode);
> +
> +	if (f2fs_is_mmap_file(inode)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> +	if (ret)
> +		goto out;
> +
> +	set_inode_flag(inode, FI_ENABLE_COMPRESS);
> +
> +	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +
> +	count = last_idx - page_idx;
> +	while (count) {
> +		int len = min(cluster_size, count);
> +
> +		ret = redirty_blocks(inode, page_idx, len);
> +
> +		if (ret < 0)
> +			break;
> +
> +		page_idx += len;
> +		count -= len;
> +	}
> +
> +	if (!ret)
> +		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
> +							LLONG_MAX);
> +
> +	clear_inode_flag(inode, FI_ENABLE_COMPRESS);
> +
> +	if (ret)
> +		f2fs_warn(sbi, "%s: The file might be partially compressed "
> +				"(errno=%d). Please delete the file.\n",
> +				__func__, ret);
> +out:
> +	inode_unlock(inode);
> +	file_end_write(filp);
> +
> +	return ret;
> +}
> +
>  static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	switch (cmd) {
> @@ -4113,6 +4287,10 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_get_compress_option(filp, arg);
>  	case F2FS_IOC_SET_COMPRESS_OPTION:
>  		return f2fs_ioc_set_compress_option(filp, arg);
> +	case F2FS_IOC_DECOMPRESS_FILE:
> +		return f2fs_ioc_decompress_file(filp, arg);
> +	case F2FS_IOC_COMPRESS_FILE:
> +		return f2fs_ioc_compress_file(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -4352,7 +4530,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_SEC_TRIM_FILE:
>  	case F2FS_IOC_GET_COMPRESS_OPTION:
>  	case F2FS_IOC_SET_COMPRESS_OPTION:
> -		break;
> +	case F2FS_IOC_DECOMPRESS_FILE:
> +	case F2FS_IOC_COMPRESS_FILE:

		break; ?

>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index f00199a2e38b..352a822d4370 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -40,6 +40,8 @@
>  						struct f2fs_comp_option)
>  #define F2FS_IOC_SET_COMPRESS_OPTION	_IOW(F2FS_IOCTL_MAGIC, 22,	\
>  						struct f2fs_comp_option)
> +#define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
> +#define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
>  
>  /*
>   * should be same as XFS_IOC_GOINGDOWN.
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
