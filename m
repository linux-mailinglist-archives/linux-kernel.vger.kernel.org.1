Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF71FE96B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 05:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgFRD2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 23:28:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgFRD2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:28:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 519763C700A116FC05BF;
        Thu, 18 Jun 2020 11:28:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 18 Jun
 2020 11:28:22 +0800
Subject: Re: [PATCH v3] f2fs: use kfree() instead of kvfree() to free
 superblock data
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Denis Efremov <efremov@linux.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200605181533.73113-1-efremov@linux.com>
 <20200609221446.24537-1-efremov@linux.com>
 <20200609222546.GA24766@sol.localdomain> <20200615175800.GA117170@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <033a4854-5ebd-4db4-c60f-f0f6826d70ea@huawei.com>
Date:   Thu, 18 Jun 2020 11:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200615175800.GA117170@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/16 1:58, Jaegeuk Kim wrote:
> On 06/09, Eric Biggers wrote:
>> On Wed, Jun 10, 2020 at 01:14:46AM +0300, Denis Efremov wrote:
>>> Use kfree() instead of kvfree() to free super in read_raw_super_block()
>>> because the memory is allocated with kzalloc() in the function.
>>> Use kfree() instead of kvfree() to free sbi, raw_super in
>>> f2fs_fill_super() and f2fs_put_super() because the memory is allocated
>>> with kzalloc().
>>>
>>> Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
>>> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>>
>> I don't think "Fixes" is appropriate here.
> 
> Agreed. I queued this Cl without it. :)
> Thanks,
> 
>>
>> kvfree() still works on kmalloc'ed memory; it's just not preferred.
>>
>> So this is more a cleanup than a fix.
>>
>> - Eric
> .
> 
