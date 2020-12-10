Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD82D53B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbgLJGRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:17:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8975 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgLJGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:17:55 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cs3bK5Sfqzhq80;
        Thu, 10 Dec 2020 14:16:45 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 14:17:08 +0800
Subject: Re: [PATCH -next] fs/ntfs: fix set but not used variable
 'log_page_mask'
To:     Anton Altaparmakov <anton@tuxera.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200312041353.19877-1-zhengzengkai@huawei.com>
 <94ED375C-C57C-464B-A1CA-BFB1EEF71BB2@tuxera.com>
 <20201209183623.b26e90de3d0aa92a72010ff0@linux-foundation.org>
 <C1D18C59-3E1B-4825-881C-B7AE6FACF4D7@tuxera.com>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <3b12e860-273e-c915-cd18-637668762107@huawei.com>
Date:   Thu, 10 Dec 2020 14:17:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <C1D18C59-3E1B-4825-881C-B7AE6FACF4D7@tuxera.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton and Andrew,

> Hi Andrew,
>
> Ah, oops!  Thank you and apologies.  Quite right the alternative patch was even better.  No need to apply this patch after all...
>
> Zheng, the log_page_mask variable was removed altogether so your patch no longer makes sense.
>
> Best regards,
>
> 	Anton
>
>> On 10 Dec 2020, at 02:36, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 8 Dec 2020 08:24:02 +0000 Anton Altaparmakov <anton@tuxera.com> wrote:
>>
>>> Can you please apply this?
>>>
>>> ...
>>>
>>>> --- a/fs/ntfs/logfile.c
>>>> +++ b/fs/ntfs/logfile.c
>>>> @@ -507,7 +507,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
>>>> 	 * optimize log_page_size and log_page_bits into constants.
>>>> 	 */
>>>> 	log_page_bits = ntfs_ffs(log_page_size) - 1;
>>>> -	size &= ~(s64)(log_page_size - 1);
>>>> +	size &= ~(s64)(log_page_mask);
>>>> 	/*
>>>> 	 * Ensure the log file is big enough to store at least the two restart
>>>> 	 * pages and the minimum number of log record pages.
>> https://lore.kernel.org/lkml/1604821092-54631-1-git-send-email-alex.shi@linux.alibaba.com/
>> addressed this?
>>
It's ok, thank you all the same!

