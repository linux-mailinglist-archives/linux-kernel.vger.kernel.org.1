Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376FF2FF9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAVA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:56:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11176 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAVA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:56:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DMLPF0bx9zl8J2;
        Fri, 22 Jan 2021 08:54:09 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 22 Jan
 2021 08:55:31 +0800
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: introduce checkpoint=merge mount
 option
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Sungjong Seo <sj1557.seo@samsung.com>,
        Daeho Jeong <daehojeong@google.com>
References: <20210121134529.1201249-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6e4996f8-fdf0-93dd-8253-9e8f5e6fca06@huawei.com>
Date:   Fri, 22 Jan 2021 08:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210121134529.1201249-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no update in v5, it will be better to include my Reviewed-by
tag, please note that. :)

Thanks,

On 2021/1/21 21:45, Daeho Jeong wrote:
> From: Daeho Jeong<daehojeong@google.com>
> 
> We've added a new mount option "checkpoint=merge", which creates a
> kernel daemon and makes it to merge concurrent checkpoint requests as
> much as possible to eliminate redundant checkpoint issues. Plus, we
> can eliminate the sluggish issue caused by slow checkpoint operation
> when the checkpoint is done in a process context in a cgroup having
> low i/o budget and cpu shares. To make this do better, we set the
> default i/o priority of the kernel daemon to "3", to give one higher
> priority than other kernel threads. The below verification result
> explains this.
> The basic idea has come fromhttps://opensource.samsung.com.
> 
> [Verification]
> Android Pixel Device(ARM64, 7GB RAM, 256GB UFS)
> Create two I/O cgroups (fg w/ weight 100, bg w/ wight 20)
> Set "strict_guarantees" to "1" in BFQ tunables
> 
> In "fg" cgroup,
> - thread A => trigger 1000 checkpoint operations
>    "for i in `seq 1 1000`; do touch test_dir1/file; fsync test_dir1;
>     done"
> - thread B => gererating async. I/O
>    "fio --rw=write --numjobs=1 --bs=128k --runtime=3600 --time_based=1
>         --filename=test_img --name=test"
> 
> In "bg" cgroup,
> - thread C => trigger repeated checkpoint operations
>    "echo $$ > /dev/blkio/bg/tasks; while true; do touch test_dir2/file;
>     fsync test_dir2; done"
> 
> We've measured thread A's execution time.
> 
> [ w/o patch ]
> Elapsed Time: Avg. 68 seconds
> [ w/  patch ]
> Elapsed Time: Avg. 48 seconds
> 
> Signed-off-by: Daeho Jeong<daehojeong@google.com>
> Signed-off-by: Sungjong Seo<sj1557.seo@samsung.com>
