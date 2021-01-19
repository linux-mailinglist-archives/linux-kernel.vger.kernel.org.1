Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61A2FAED6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394290AbhASCi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:38:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11173 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394305AbhASChU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:37:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DKXnG4S31zl6Dj;
        Tue, 19 Jan 2021 10:35:14 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 19 Jan
 2021 10:36:34 +0800
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: introduce checkpoint=merge mount
 option
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Sungjong Seo <sj1557.seo@samsung.com>,
        Daeho Jeong <daehojeong@google.com>
References: <20210119000043.1206345-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c58c25bd-c76e-5371-1020-910ef0875560@huawei.com>
Date:   Tue, 19 Jan 2021 10:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210119000043.1206345-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/19 8:00, Daeho Jeong wrote:
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

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
