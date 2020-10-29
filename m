Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C959129E427
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgJ2HY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:24:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgJ2HYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMH505H8Sz15LKj;
        Thu, 29 Oct 2020 15:24:36 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 29 Oct
 2020 15:24:33 +0800
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION
 ioctl
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20201029041538.4165209-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <861e569d-feae-c521-35b7-dcb8b79cdfba@huawei.com>
Date:   Thu, 29 Oct 2020 15:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201029041538.4165209-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/29 12:15, Daeho Jeong wrote:
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

It's minor,

inode_lock_shared()?

> +
> +	if (!f2fs_compressed_file(inode)) {
> +		inode_unlock(inode);

inode_unlock_shared()?

> +		return -ENODATA;
> +	}
> +
> +	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
> +	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
> +
> +	inode_unlock(inode);

ditto.

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
