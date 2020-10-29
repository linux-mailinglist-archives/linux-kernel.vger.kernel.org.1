Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5664729E093
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgJ2BXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:23:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6701 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgJ1WD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:58 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLfJ71JDxzkbRv;
        Wed, 28 Oct 2020 14:47:03 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 28 Oct
 2020 14:46:58 +0800
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20201027053818.3291747-1-daeho43@gmail.com>
 <20201027053818.3291747-2-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <290cd375-704e-9315-a035-ab4c1ce1f6f2@huawei.com>
Date:   Wed, 28 Oct 2020 14:46:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201027053818.3291747-2-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/27 13:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new F2FS_IOC_SET_COMPRESS_OPTION ioctl to change file
> compression option of a file.
> 
> struct f2fs_comp_option {
>      u8 algorithm;         => compression algorithm
>                            => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
>      u8 log_cluster_size;  => log scale cluster size
>                            => 2 ~ 8
> };
> 
> struct f2fs_comp_option option;
> 
> option.algorithm = 1;
> option.log_cluster_size = 7;
> 
> ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> 
> v4: changed commit message.
> v3: changed the error number more specific.
>      folded in fix for build breakage reported by kernel test robot
>      <lkp@intel.com> and Dan Carpenter <dan.carpenter@oracle.com>.
> v2: added ioctl description.
> ---
>   fs/f2fs/compress.c |  5 +++++
>   fs/f2fs/f2fs.h     |  7 +++++++
>   fs/f2fs/file.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 64 insertions(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7895186cc765..816d7adc914c 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
>   	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>   }
>   
> +bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
> +{
> +	return algorithm < COMPRESS_MAX && f2fs_cops[algorithm] != NULL;
> +}
> +
>   static mempool_t *compress_page_pool;
>   static int num_compress_pages = 512;
>   module_param(num_compress_pages, uint, 0444);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a33c90cf979b..cc38afde6c04 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -435,6 +435,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>   						struct f2fs_sectrim_range)
>   #define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
>   						struct f2fs_comp_option)
> +#define F2FS_IOC_SET_COMPRESS_OPTION	_IOW(F2FS_IOCTL_MAGIC, 22,	\
> +						struct f2fs_comp_option)
>   
>   /*
>    * should be same as XFS_IOC_GOINGDOWN.
> @@ -3915,6 +3917,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
>   int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
>   void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
>   bool f2fs_is_compress_backend_ready(struct inode *inode);
> +bool f2fs_is_compress_algorithm_ready(unsigned char algorithm);
>   int f2fs_init_compress_mempool(void);
>   void f2fs_destroy_compress_mempool(void);
>   void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity);
> @@ -3945,6 +3948,10 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
>   	/* not support compression */
>   	return false;
>   }
> +static inline bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
> +{
> +	return false;
> +}
>   static inline struct page *f2fs_compress_control_page(struct page *page)
>   {
>   	WARN_ON_ONCE(1);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8922ab191a9d..8048b150e43b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3963,6 +3963,55 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
>   	return 0;
>   }
>   
> +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_comp_option option;
> +	int ret = 0;
> +
> +	if (!f2fs_sb_has_compression(sbi))
> +		return -EOPNOTSUPP;
> +
> +	if (!(filp->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
> +				sizeof(option)))
> +		return -EFAULT;
> +
> +	if (!f2fs_compressed_file(inode) ||
> +			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE)
> +		return -EINVAL;
> +
> +	if (!f2fs_is_compress_algorithm_ready(option.algorithm))
> +		return -ENOPKG;

As we allow to mount image with different kernel which supports different compress
algorithms, so I guess we can support to change algorithm to one other which current
kernel doesn't support, since we have add f2fs_is_compress_backend_ready() in all
foreground operations to disallow user to operate such inode's data.

IMO, just add to print one warnning message is fine.

Thanks,

> +
> +	file_start_write(filp);
> +	inode_lock(inode);
> +
> +	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (inode->i_size != 0) {
> +		ret = -EFBIG;
> +		goto out;
> +	}
> +
> +	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
> +	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
> +	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
> +	f2fs_mark_inode_dirty_sync(inode, true);
> +out:
> +	inode_unlock(inode);
> +	file_end_write(filp);
> +
> +	return ret;
> +}
> +
>   long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
>   	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -4053,6 +4102,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		return f2fs_sec_trim_file(filp, arg);
>   	case F2FS_IOC_GET_COMPRESS_OPTION:
>   		return f2fs_ioc_get_compress_option(filp, arg);
> +	case F2FS_IOC_SET_COMPRESS_OPTION:
> +		return f2fs_ioc_set_compress_option(filp, arg);
>   	default:
>   		return -ENOTTY;
>   	}
> @@ -4224,6 +4275,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
>   	case F2FS_IOC_SEC_TRIM_FILE:
>   	case F2FS_IOC_GET_COMPRESS_OPTION:
> +	case F2FS_IOC_SET_COMPRESS_OPTION:
>   		break;
>   	default:
>   		return -ENOIOCTLCMD;
> 
