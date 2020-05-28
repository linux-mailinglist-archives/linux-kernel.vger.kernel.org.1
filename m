Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3F1E52E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgE1BXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 21:23:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgE1BXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:23:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3C1F627917DD431B090D;
        Thu, 28 May 2020 09:23:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 09:23:44 +0800
Subject: Re: [PATCH 3/3] f2fs: fix to cover meta flush with cp_lock
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200527102753.15743-1-yuchao0@huawei.com>
 <20200527102753.15743-3-yuchao0@huawei.com>
 <20200527210233.GC206249@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <23245f6e-528d-43ab-57b6-4ca16db43fe5@huawei.com>
Date:   Thu, 28 May 2020 09:23:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200527210233.GC206249@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/28 5:02, Jaegeuk Kim wrote:
> On 05/27, Chao Yu wrote:
>> meta inode page should be flushed under cp_lock, fix it.
> 
> It doesn't matter for this case, yes?

It's not related to discard issue.

Now, I got some progress, I can reproduce that bug occasionally.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index f7de2a1da528..0fcae4d90074 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>  		break;
>>  	case F2FS_GOING_DOWN_METAFLUSH:
>> +		mutex_lock(&sbi->cp_mutex);
>>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
>> +		mutex_unlock(&sbi->cp_mutex);
>>  		f2fs_stop_checkpoint(sbi, false);
>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>  		break;
>> -- 
>> 2.18.0.rc1
> .
> 
