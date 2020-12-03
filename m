Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5E2CCEBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLCFl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 00:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgLCFl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:41:28 -0500
Date:   Wed, 2 Dec 2020 21:40:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606974047;
        bh=7LtZmdGMNY3k6PtJS/X5eLZBXXaeBcYfEkFV4LSGCjM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0bpd62LTwZxgzsjVqRNHsYjsJx/UvTI6Ceg9q5EWMmn9tza6r7MYRYY/gLfCEzwa
         yUcVLh3UGh2wAbBjZ7VlaJS84afWgWKAerBp5vUMWMxQBOxoc8BUPgUzepGI5nBViT
         8yAYUWvr9zYwyQTOcw2ynJn/9vl2n16wxWOKB3V4aRWimdE233chhwoHMAEKx3cyIi
         gI3jF/NAGn7dWRjePq40H3RqtrR7/iELnYohI5/5frVse9+acBaYcCjhVmylx7D4bL
         xDWyvnI9huCQCMY/Lco6M8iGR9H0dZ+MkAFVsjwhImnySV2sT3zp9aetW0EaaVGFnV
         v4uvaBfmCTqXQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v7 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
Message-ID: <X8h6XK6cYwXqGnV7@google.com>
References: <20201030041035.394565-1-daeho43@gmail.com>
 <20201030041035.394565-2-daeho43@gmail.com>
 <dcf074e3-821c-6858-eb17-63dcc05e7039@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf074e3-821c-6858-eb17-63dcc05e7039@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Chao Yu wrote:
> Jaegeuk, not sure, is it too late to merge this cleanup into original patch?

Let me merge this on top of tree. Thanks. :)

> 
> From a5c63ec58e0cda6eb5d186b46942eea46422b7a9 Mon Sep 17 00:00:00 2001
> From: Chao Yu <yuchao0@huawei.com>
> Date: Thu, 3 Dec 2020 10:04:26 +0800
> Subject: [PATCH] f2fs: remove f2fs_is_compress_algorithm_valid() for cleanup
> 
> No logic changes.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 5 -----
>  fs/f2fs/f2fs.h     | 5 -----
>  fs/f2fs/file.c     | 2 +-
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index dfadbc78946c..869b047a4801 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -574,11 +574,6 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
>  	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>  }
> 
> -bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
> -{
> -	return f2fs_cops[algorithm] != NULL;
> -}
> -
>  static mempool_t *compress_page_pool;
>  static int num_compress_pages = 512;
>  module_param(num_compress_pages, uint, 0444);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b70c8d553439..17b45c2d2b04 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3882,7 +3882,6 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
>  int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
>  void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
>  bool f2fs_is_compress_backend_ready(struct inode *inode);
> -bool f2fs_is_compress_algorithm_valid(unsigned char algorithm);
>  int f2fs_init_compress_mempool(void);
>  void f2fs_destroy_compress_mempool(void);
>  void f2fs_do_decompress_pages(struct decompress_io_ctx *dic, bool verity);
> @@ -3927,10 +3926,6 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
>  	/* not support compression */
>  	return false;
>  }
> -static inline bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
> -{
> -	return false;
> -}
>  static inline struct page *f2fs_compress_control_page(struct page *page)
>  {
>  	WARN_ON_ONCE(1);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 300355fe25f0..0453b441228d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4016,7 +4016,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>  	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
>  	f2fs_mark_inode_dirty_sync(inode, true);
> 
> -	if (!f2fs_is_compress_algorithm_valid(option.algorithm))
> +	if (!f2fs_is_compress_backend_ready(inode))
>  		f2fs_warn(sbi, "compression algorithm is successfully set, "
>  			"but current kernel doesn't support this algorithm.");
>  out:
> -- 
> 2.26.2
> 
> 
> 
> 
> 
> On 2020/10/30 12:10, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Added a new F2FS_IOC_SET_COMPRESS_OPTION ioctl to change file
> > compression option of a file.
> > 
> > struct f2fs_comp_option {
> >      u8 algorithm;         => compression algorithm
> >                            => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
> >      u8 log_cluster_size;  => log scale cluster size
> >                            => 2 ~ 8
> > };
> > 
> > struct f2fs_comp_option option;
> > 
> > option.algorithm = 1;
> > option.log_cluster_size = 7;
> > 
> > ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > 
> > v6: changed the function name of checking compression algorithm validity.
> > v5: allowed to set algorithm which is not currently enabled by kernel.
> > v4: changed commit message.
> > v3: changed the error number more specific.
> >      folded in fix for build breakage reported by kernel test robot
> >      <lkp@intel.com> and Dan Carpenter <dan.carpenter@oracle.com>.
> > v2: added ioctl description.
> > ---
> >   fs/f2fs/compress.c |  5 +++++
> >   fs/f2fs/f2fs.h     |  7 ++++++
> >   fs/f2fs/file.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 66 insertions(+)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 7895186cc765..b0144670d320 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
> >   	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
> >   }
> > +bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
> > +{
> > +	return f2fs_cops[algorithm] != NULL;
> > +}
> > +
> >   static mempool_t *compress_page_pool;
> >   static int num_compress_pages = 512;
> >   module_param(num_compress_pages, uint, 0444);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a33c90cf979b..70a8a2196888 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -435,6 +435,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >   						struct f2fs_sectrim_range)
> >   #define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
> >   						struct f2fs_comp_option)
> > +#define F2FS_IOC_SET_COMPRESS_OPTION	_IOW(F2FS_IOCTL_MAGIC, 22,	\
> > +						struct f2fs_comp_option)
> >   /*
> >    * should be same as XFS_IOC_GOINGDOWN.
> > @@ -3915,6 +3917,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
> >   int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
> >   void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
> >   bool f2fs_is_compress_backend_ready(struct inode *inode);
> > +bool f2fs_is_compress_algorithm_valid(unsigned char algorithm);
> >   int f2fs_init_compress_mempool(void);
> >   void f2fs_destroy_compress_mempool(void);
> >   void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity);
> > @@ -3945,6 +3948,10 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
> >   	/* not support compression */
> >   	return false;
> >   }
> > +static inline bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
> > +{
> > +	return false;
> > +}
> >   static inline struct page *f2fs_compress_control_page(struct page *page)
> >   {
> >   	WARN_ON_ONCE(1);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index bd52df84219d..be56702e4939 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3963,6 +3963,57 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
> >   	return 0;
> >   }
> > +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> > +{
> > +	struct inode *inode = file_inode(filp);
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > +	struct f2fs_comp_option option;
> > +	int ret = 0;
> > +
> > +	if (!f2fs_sb_has_compression(sbi))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!(filp->f_mode & FMODE_WRITE))
> > +		return -EBADF;
> > +
> > +	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
> > +				sizeof(option)))
> > +		return -EFAULT;
> > +
> > +	if (!f2fs_compressed_file(inode) ||
> > +			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> > +			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
> > +			option.algorithm >= COMPRESS_MAX)
> > +		return -EINVAL;
> > +
> > +	file_start_write(filp);
> > +	inode_lock(inode);
> > +
> > +	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	if (inode->i_size != 0) {
> > +		ret = -EFBIG;
> > +		goto out;
> > +	}
> > +
> > +	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
> > +	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
> > +	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
> > +	f2fs_mark_inode_dirty_sync(inode, true);
> > +
> > +	if (!f2fs_is_compress_algorithm_valid(option.algorithm))
> > +		f2fs_warn(sbi, "compression algorithm is successfully set, "
> > +			"but current kernel doesn't support this algorithm.");
> > +out:
> > +	inode_unlock(inode);
> > +	file_end_write(filp);
> > +
> > +	return ret;
> > +}
> > +
> >   long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >   {
> >   	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> > @@ -4053,6 +4104,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >   		return f2fs_sec_trim_file(filp, arg);
> >   	case F2FS_IOC_GET_COMPRESS_OPTION:
> >   		return f2fs_ioc_get_compress_option(filp, arg);
> > +	case F2FS_IOC_SET_COMPRESS_OPTION:
> > +		return f2fs_ioc_set_compress_option(filp, arg);
> >   	default:
> >   		return -ENOTTY;
> >   	}
> > @@ -4224,6 +4277,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >   	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >   	case F2FS_IOC_SEC_TRIM_FILE:
> >   	case F2FS_IOC_GET_COMPRESS_OPTION:
> > +	case F2FS_IOC_SET_COMPRESS_OPTION:
> >   		break;
> >   	default:
> >   		return -ENOIOCTLCMD;
> > 
