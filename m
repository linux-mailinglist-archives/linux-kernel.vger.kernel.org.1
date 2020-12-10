Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73C2D50A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgLJCLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:11:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9144 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgLJCLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:11:39 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cry725qY0z15ZRR;
        Thu, 10 Dec 2020 10:10:22 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 10:10:54 +0800
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
 <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1215c353-3c3f-0a61-00a3-021f0c2f0032@huawei.com>
Date:   Thu, 10 Dec 2020 10:10:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/10 10:00, Anant Thazhemadam wrote:
> 
> On 10/12/20 7:16 am, Chao Yu wrote:
>> Hi Anant,
>>
>> I've posted a patch a little earlier. :P
>>
>> https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
>>
> Ah well, that's alright, especially considering that your patch looks better.
> Glad that bug has been fixed nonetheless. :)

Anyway, thanks a lot for taking time to fix f2fs bug. :)

I prefer to add your Signed-off-by into "f2fs: fix shift-out-of-bounds
in sanity_check_raw_super()" if you don't mind.

Thanks,

> 
> Cheers,
> Anant
> .
> 
