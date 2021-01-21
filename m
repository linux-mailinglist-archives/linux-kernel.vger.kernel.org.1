Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474F02FEB10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbhAUNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:05:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11561 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbhAUKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:17 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DLzC02YL9zMNH7;
        Thu, 21 Jan 2021 18:29:00 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 21 Jan
 2021 18:30:23 +0800
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: add ckpt_thread_ioprio sysfs node
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20210114062302.3809664-1-daeho43@gmail.com>
 <20210114062302.3809664-2-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d4c12d47-db33-7e76-b7ad-4d80ced1aba9@huawei.com>
Date:   Thu, 21 Jan 2021 18:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210114062302.3809664-2-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/14 14:23, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added "ckpt_thread_ioprio" sysfs node to give a way to change checkpoint
> merge daemon's io priority. Its default value is "be,3", which means
> "BE" I/O class and I/O priority "3". We can select the class between "rt"
> and "be", and set the I/O priority within valid range of it.
> "," delimiter is necessary in between I/O class and priority number.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2:
> - adapt to inlining ckpt_req_control of f2fs_sb_info
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
>   fs/f2fs/checkpoint.c                    |  2 +-
>   fs/f2fs/f2fs.h                          |  1 +
>   fs/f2fs/sysfs.c                         | 51 +++++++++++++++++++++++++
>   4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 3dfee94e0618..0c48b2e7dfd4 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -377,3 +377,11 @@ Description:	This gives a control to limit the bio size in f2fs.
>   		Default is zero, which will follow underlying block layer limit,
>   		whereas, if it has a certain bytes value, f2fs won't submit a
>   		bio larger than that size.
> +What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
> +Date:		January 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Give a way to change checkpoint merge daemon's io priority.
> +		Its default value is "be,3", which means "BE" I/O class and
> +		I/O priority "3". We can select the class between "rt" and "be",
> +		and set the I/O priority within valid range of it. "," delimiter
> +		is necessary in between I/O class and priority number.
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index e0668cec3b80..62bd6f449bb7 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1840,7 +1840,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
>   	if (IS_ERR(cprc->f2fs_issue_ckpt))
>   		return PTR_ERR(cprc->f2fs_issue_ckpt);
>   
> -	set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO);
> +	set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);

Where do we set default value of cprc->ckpt_thread_ioprio? I guess it should
be f2fs_init_ckpt_req_control()?

Thanks,
