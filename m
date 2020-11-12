Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAD2AFFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKLG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:57:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8067 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:57:29 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CWspy39nHzLxcb;
        Thu, 12 Nov 2020 14:57:14 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 12 Nov
 2020 14:57:22 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid race condition for shinker
 count
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Light Hsieh <Light.Hsieh@mediatek.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <20201112053414.GB3826485@google.com> <20201112054051.GA4092972@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4aae85c2-1829-06c0-8fd1-4148100dc0b9@huawei.com>
Date:   Thu, 12 Nov 2020 14:57:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201112054051.GA4092972@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/12 13:40, Jaegeuk Kim wrote:
> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
> wrong do_shinker work. Let's avoid to get stale data by using nat_tree_lock.
> 
> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v3:
>   - fix to use NM_I(sbi)
> 
>   fs/f2fs/shrinker.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index d66de5999a26..555712ba06d8 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -18,7 +18,11 @@ static unsigned int shrinker_run_no;
>   
>   static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
>   {
> -	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> +	long count;
> +
> +	down_read(&NM_I(sbi)->nat_tree_lock);
> +	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> +	up_read(&NM_I(sbi)->nat_tree_lock);
>   
>   	return count > 0 ? count : 0;

Minor thing,

Just return count is enough? since count should never be smaller than 0.

Anyway,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

Thanks,

>   }
> 
