Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7A294808
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440702AbgJUGIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:08:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408114AbgJUGIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:08:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0E811B3B115AF6520308;
        Wed, 21 Oct 2020 14:08:06 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 21 Oct
 2020 14:08:04 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add compr_inode and compr_blocks sysfs
 nodes
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20201016051455.1913795-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f8359dde-7e0c-b2fc-451f-2984c50fa552@huawei.com>
Date:   Wed, 21 Oct 2020 14:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201016051455.1913795-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/16 13:14, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added compr_inode to show compressed inode count and compr_blocks to
> show compressed block count in sysfs.

As there are so many entries in ../f2fs/<disk>/ directory, it looks a mess
there, I suggest that we can add a new directory 'stats' in ../f2fs/<disk>/,
in where we can store all readonly stats related entries there later.

How do you think?

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
>   fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 834d0becae6d..a01c26484c69 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -350,3 +350,13 @@ Date:		April 2020
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
>   Description:	Give a way to change iostat_period time. 3secs by default.
>   		The new iostat trace gives stats gap given the period.
> +
> +What:		/sys/fs/f2fs/<disk>/compr_inode
> +Date:		October 2020
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show compressed inode count
> +
> +What:		/sys/fs/f2fs/<disk>/compr_blocks
> +Date:		October 2020
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show compressed block count
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 94c98e412aa1..7139a29a00d3 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -223,6 +223,19 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *a,
>   	f2fs_update_sit_info(sbi);
>   	return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vblocks));
>   }
> +
> +static ssize_t compr_inode_show(struct f2fs_attr *a,
> +				struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%u\n", atomic_read(&sbi->compr_inode));
> +}
> +
> +static ssize_t compr_blocks_show(struct f2fs_attr *a,
> +				struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n", atomic64_read(&sbi->compr_blocks));
> +}
> +
>   #endif
>   
>   static ssize_t main_blkaddr_show(struct f2fs_attr *a,
> @@ -591,6 +604,8 @@ F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_background_calls, bg_gc);
>   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
>   F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
>   F2FS_GENERAL_RO_ATTR(avg_vblocks);
> +F2FS_GENERAL_RO_ATTR(compr_inode);
> +F2FS_GENERAL_RO_ATTR(compr_blocks);
>   #endif
>   
>   #ifdef CONFIG_FS_ENCRYPTION
> @@ -675,6 +690,8 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(moved_blocks_foreground),
>   	ATTR_LIST(moved_blocks_background),
>   	ATTR_LIST(avg_vblocks),
> +	ATTR_LIST(compr_inode),
> +	ATTR_LIST(compr_blocks),
>   #endif
>   	NULL,
>   };
> 
