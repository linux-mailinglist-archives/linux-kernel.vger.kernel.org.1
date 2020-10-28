Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932E129E12B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgJ2ByJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:54:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6564 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgJ1V5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLf5C09VYzhbBq;
        Wed, 28 Oct 2020 14:37:35 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 28 Oct
 2020 14:37:29 +0800
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION
 ioctl
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20201027053818.3291747-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a4d3f116-4090-8699-2973-b5a4933205ed@huawei.com>
Date:   Wed, 28 Oct 2020 14:37:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201027053818.3291747-1-daeho43@gmail.com>
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
> Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
> option of a file.
> 
> struct f2fs_comp_option {
>      u8 algorithm;         => compression algorithm
>                            => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
>      u8 log_cluster_size;  => log scale cluster size
>                            => 2 ~ 8

I prepare to change i_padding field to i_cflags, so I guess we need to update
struct f2fs_comp_option as well later.

BTW, i_cflags could be set to support more layout of compress inode, e.g.
like recently developed ckksum feature which need to struct compress_data layout
update.

> };
> 
> struct f2fs_comp_option option;
> 
> ioctl(fd, F2FS_IOC_GET_COMPRESS_OPTION, &option);
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> 
> v4: changed commit message.
> v3: changed the error number more specific.
> v2: added ioctl description.
> ---
>   fs/f2fs/f2fs.h |  7 +++++++
>   fs/f2fs/file.c | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 53fe2853579c..a33c90cf979b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -433,6 +433,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>   					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
>   #define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
>   						struct f2fs_sectrim_range)
> +#define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
> +						struct f2fs_comp_option)
>   
>   /*
>    * should be same as XFS_IOC_GOINGDOWN.
> @@ -481,6 +483,11 @@ struct f2fs_sectrim_range {
>   	u64 flags;
>   };
>   
> +struct f2fs_comp_option {
> +	u8 algorithm;
> +	u8 log_cluster_size;
> +};
> +
>   /* for inline stuff */
>   #define DEF_INLINE_RESERVED_SIZE	1
>   static inline int get_extra_isize(struct inode *inode);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ef5a844de53f..8922ab191a9d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3936,6 +3936,33 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>   	return ret;
>   }
>   
> +static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_comp_option option;
> +
> +	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> +		return -EOPNOTSUPP;
> +
> +	inode_lock(inode);
> +
> +	if (!f2fs_compressed_file(inode)) {
> +		inode_unlock(inode);
> +		return -ENODATA;
> +	}
> +
> +	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
> +	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
> +
> +	inode_unlock(inode);
> +
> +	if (copy_to_user((struct f2fs_comp_option __user *)arg, &option,
> +				sizeof(option)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
>   	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -4024,6 +4051,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		return f2fs_reserve_compress_blocks(filp, arg);
>   	case F2FS_IOC_SEC_TRIM_FILE:
>   		return f2fs_sec_trim_file(filp, arg);
> +	case F2FS_IOC_GET_COMPRESS_OPTION:
> +		return f2fs_ioc_get_compress_option(filp, arg);
>   	default:
>   		return -ENOTTY;
>   	}
> @@ -4194,6 +4223,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
>   	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
>   	case F2FS_IOC_SEC_TRIM_FILE:
> +	case F2FS_IOC_GET_COMPRESS_OPTION:
>   		break;
>   	default:
>   		return -ENOIOCTLCMD;
> 
