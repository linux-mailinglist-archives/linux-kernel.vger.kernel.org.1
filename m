Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827362A3EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKCI2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:28:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7579 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:28:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQNGm0GWrzLt4H;
        Tue,  3 Nov 2020 16:28:48 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 3 Nov 2020
 16:28:50 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change write_hint for hot/warm nodes
To:     <daejun7.park@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
CC:     yongmyung lee <ymhungry.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Mankyu PARK <manq.park@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Keoseong Park <keosung.park@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        "Jinyoung CHOI" <j-young.choi@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>
References: <CGME20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p3>
 <20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p3>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <609445f8-de3b-eb79-449c-020125799449@huawei.com>
Date:   Tue, 3 Nov 2020 16:28:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/3 14:40, Daejun Park wrote:
>>From 818a76a9aee5bf225565264274d211edb07bae7d Mon Sep 17 00:00:00 2001
> From: Daejun Park <daejun7.park@samsung.com>
> Date: Tue, 3 Nov 2020 15:30:26 +0900
> 
> 
> In the fs-based mode of F2FS, the mapping of hot/warm node to
> WRITE_LIFE_NOT_SET should be changed to WRITE_LIFE_SHORT.
> 
> As a result of analyzing the write pattern of f2fs using real workload,
> hot/warm nodes have high update ratio close to hot data.[*]
> However, F2FS passes write hints for hot/warm nodes as WRITE_LIFE_NOT_SET.
> 
> Furthermore, WRITE_LIFE_NOT_SET is a default value of write hint when it is
> not provided from the file system.
> In storage, write_hint is used to distinguish streams (e.g. NVMe).
> So, the hot/warm node of F2FS is not distinguished from other write_hints,
> which can make the wrong stream seperation.
> 
> * Liang, Yu, et al. "An empirical study of F2FS on mobile devices." 2017
> IEEE 23rd International Conference on Embedded and Real-Time Computing
> Systems and Applications (RTCSA).

Could you please update Documentation/filesystems/f2fs.rst as well?

Thanks,

> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   fs/f2fs/segment.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1596502f7375..7b42bb10c6c3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3208,7 +3208,7 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>   				return WRITE_LIFE_EXTREME;
>   		} else if (type == NODE) {
>   			if (temp == WARM || temp == HOT)
> -				return WRITE_LIFE_NOT_SET;
> +				return WRITE_LIFE_SHORT;
>   			else if (temp == COLD)
>   				return WRITE_LIFE_NONE;
>   		} else if (type == META) {
> 
