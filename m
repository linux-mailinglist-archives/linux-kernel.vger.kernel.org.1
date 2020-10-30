Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6A2A0577
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgJ3McE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJ3MbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:31:02 -0400
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7DB520731;
        Fri, 30 Oct 2020 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604061061;
        bh=uAWtvTnGeRiAQGBeXWhiZ6TXWdrmX/qYwMYe3mrDHPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBZTvoofelM4iQ+RhR13m5AOlKzbdlWmqdzG6DRERIpYia2MuTcE12Vx9G+UlskjD
         FbSEQ5MSFHn/sHO5CMEtlymrrw4PSjhuFIkzCbiDXwHJIG1R5dczaI3zxpmG930+7Z
         vqevVQfiuSD7ep30JWzzPQbUK+KT4gSJ3V3gSjtE=
Date:   Fri, 30 Oct 2020 05:30:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: move ioctl interface definitions to separated
 file
Message-ID: <20201030123059.GA1877745@google.com>
References: <20201030072610.57155-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030072610.57155-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Can we make a documentation for this in f2fs.rst?

Thanks,

On 10/30, Chao Yu wrote:
> Like other filesystem does, we introduce a new file f2fs.h in path of
> include/uapi/linux/, and move f2fs-specified ioctl interface definitions
> to that file, after then, in order to use those definitions, userspace
> developer only need to include the new header file rather than
> copy & paste definitions from fs/f2fs/f2fs.h.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2: add missing "WITH Linux-syscall-note" for SPDX-License-Identifier
>  MAINTAINERS                 |  1 +
>  fs/f2fs/f2fs.h              | 79 ----------------------------------
>  fs/f2fs/file.c              |  1 +
>  include/trace/events/f2fs.h |  1 +
>  include/uapi/linux/f2fs.h   | 86 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 79 deletions(-)
>  create mode 100644 include/uapi/linux/f2fs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1d4e49a695a..b79a911f1e32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6686,6 +6686,7 @@ F:	Documentation/filesystems/f2fs.rst
>  F:	fs/f2fs/
>  F:	include/linux/f2fs_fs.h
>  F:	include/trace/events/f2fs.h
> +F:	include/uapi/linux/f2fs.h
>  
>  F71805F HARDWARE MONITORING DRIVER
>  M:	Jean Delvare <jdelvare@suse.com>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index cb700d797296..99bcf4b44a9c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -402,85 +402,6 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  	return size <= MAX_SIT_JENTRIES(journal);
>  }
>  
> -/*
> - * f2fs-specific ioctl commands
> - */
> -#define F2FS_IOCTL_MAGIC		0xf5
> -#define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
> -#define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
> -#define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
> -#define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
> -#define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
> -#define F2FS_IOC_GARBAGE_COLLECT	_IOW(F2FS_IOCTL_MAGIC, 6, __u32)
> -#define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
> -#define F2FS_IOC_DEFRAGMENT		_IOWR(F2FS_IOCTL_MAGIC, 8,	\
> -						struct f2fs_defragment)
> -#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
> -						struct f2fs_move_range)
> -#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
> -						struct f2fs_flush_device)
> -#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
> -						struct f2fs_gc_range)
> -#define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
> -#define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
> -#define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
> -#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> -#define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
> -#define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
> -#define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
> -					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
> -#define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
> -					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
> -#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
> -						struct f2fs_sectrim_range)
> -
> -/*
> - * should be same as XFS_IOC_GOINGDOWN.
> - * Flags for going down operation used by FS_IOC_GOINGDOWN
> - */
> -#define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
> -#define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
> -#define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
> -#define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
> -#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
> -#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
> -
> -/*
> - * Flags used by F2FS_IOC_SEC_TRIM_FILE
> - */
> -#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
> -#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
> -#define F2FS_TRIM_FILE_MASK		0x3
> -
> -struct f2fs_gc_range {
> -	u32 sync;
> -	u64 start;
> -	u64 len;
> -};
> -
> -struct f2fs_defragment {
> -	u64 start;
> -	u64 len;
> -};
> -
> -struct f2fs_move_range {
> -	u32 dst_fd;		/* destination fd */
> -	u64 pos_in;		/* start position in src_fd */
> -	u64 pos_out;		/* start position in dst_fd */
> -	u64 len;		/* size to move */
> -};
> -
> -struct f2fs_flush_device {
> -	u32 dev_num;		/* device number to flush */
> -	u32 segments;		/* # of segments to flush */
> -};
> -
> -struct f2fs_sectrim_range {
> -	u64 start;
> -	u64 len;
> -	u64 flags;
> -};
> -
>  /* for inline stuff */
>  #define DEF_INLINE_RESERVED_SIZE	1
>  static inline int get_extra_isize(struct inode *inode);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ee861c6d9ff0..d898f1e2764b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -31,6 +31,7 @@
>  #include "gc.h"
>  #include "trace.h"
>  #include <trace/events/f2fs.h>
> +#include <uapi/linux/f2fs.h>
>  
>  static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>  {
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index f8f1e85ff130..56b113e3cd6a 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -6,6 +6,7 @@
>  #define _TRACE_F2FS_H
>  
>  #include <linux/tracepoint.h>
> +#include <uapi/linux/f2fs.h>
>  
>  #define show_dev(dev)		MAJOR(dev), MINOR(dev)
>  #define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long)entry->ino
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> new file mode 100644
> index 000000000000..ad25786feaa1
> --- /dev/null
> +++ b/include/uapi/linux/f2fs.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_F2FS_H
> +#define _UAPI_LINUX_F2FS_H
> +
> +#include <linux/ioctl.h>
> +
> +/*
> + * f2fs-specific ioctl commands
> + */
> +#define F2FS_IOCTL_MAGIC		0xf5
> +#define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
> +#define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
> +#define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
> +#define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
> +#define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
> +#define F2FS_IOC_GARBAGE_COLLECT	_IOW(F2FS_IOCTL_MAGIC, 6, __u32)
> +#define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
> +#define F2FS_IOC_DEFRAGMENT		_IOWR(F2FS_IOCTL_MAGIC, 8,	\
> +						struct f2fs_defragment)
> +#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
> +						struct f2fs_move_range)
> +#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
> +						struct f2fs_flush_device)
> +#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
> +						struct f2fs_gc_range)
> +#define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
> +#define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
> +#define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
> +#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> +#define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
> +#define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
> +#define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
> +					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
> +#define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
> +					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
> +#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
> +						struct f2fs_sectrim_range)
> +
> +/*
> + * should be same as XFS_IOC_GOINGDOWN.
> + * Flags for going down operation used by FS_IOC_GOINGDOWN
> + */
> +#define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
> +#define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
> +#define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
> +#define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
> +#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
> +#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
> +
> +/*
> + * Flags used by F2FS_IOC_SEC_TRIM_FILE
> + */
> +#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
> +#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
> +#define F2FS_TRIM_FILE_MASK		0x3
> +
> +struct f2fs_gc_range {
> +	u32 sync;
> +	u64 start;
> +	u64 len;
> +};
> +
> +struct f2fs_defragment {
> +	u64 start;
> +	u64 len;
> +};
> +
> +struct f2fs_move_range {
> +	u32 dst_fd;		/* destination fd */
> +	u64 pos_in;		/* start position in src_fd */
> +	u64 pos_out;		/* start position in dst_fd */
> +	u64 len;		/* size to move */
> +};
> +
> +struct f2fs_flush_device {
> +	u32 dev_num;		/* device number to flush */
> +	u32 segments;		/* # of segments to flush */
> +};
> +
> +struct f2fs_sectrim_range {
> +	u64 start;
> +	u64 len;
> +	u64 flags;
> +};
> +
> +#endif /* _UAPI_LINUX_F2FS_H */
> -- 
> 2.26.2
