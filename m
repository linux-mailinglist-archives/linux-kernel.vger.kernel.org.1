Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632192C9556
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgLACkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:40:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8892 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgLACkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:40:02 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ClRB729kwz761J;
        Tue,  1 Dec 2020 10:38:55 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 1 Dec 2020
 10:39:16 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: add compress_inode to cache
 compressed blocks
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126103709.80006-1-yuchao0@huawei.com>
 <X7/sCLnVPOjkC9DI@sol.localdomain>
 <7ecb947e-2f8c-abd7-c116-c82c474fded7@huawei.com>
 <X8U1zbBa4IaaSYXV@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <11c11980-1cef-eac5-d42a-4acd4d87565c@huawei.com>
Date:   Tue, 1 Dec 2020 10:39:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X8U1zbBa4IaaSYXV@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/1 2:11, Eric Biggers wrote:
> On Fri, Nov 27, 2020 at 09:01:47AM +0800, Chao Yu wrote:
>> On 2020/11/27 1:55, Eric Biggers wrote:
>>> On Thu, Nov 26, 2020 at 06:37:09PM +0800, Chao Yu wrote:
>>>> Support to use address space of inner inode to cache compressed block,
>>>> in order to improve cache hit ratio of random read.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>
>>> If the file is also encrypted, are the compressed pages that are cached still
>>> encrypted, or are they decrypted?
>>
>> In current implementation, they are decrypted in cache.
>>
> 
> One of the things the FS_IOC_REMOVE_ENCRYPTION key ioctl is supposed to
> accomplish is evicting all the pagecache pages for all encrypted files that were
> using a particular key.  This happens as a consequence of the ioctl evicting the
> inodes that were using that key.  If the user is also using the init_on_free=1
> kernel command-line option to enable automatic zeroing of all freed memory, that
> should cause those inode's pagecache pages (which contain decrypted data) to be
> zeroed, so that they can't be compromised later by an online attack.
> 
> This new filesystem-wide cache containing decrypted pages might break that.  It
> sounds like when an inode is evicted, its cached pages won't necessarily be
> evicted from this new filesystem-wide cache.

Correct.

> 
> Can you ensure that pages get evicted from this new cache when the inode to
> which they belong is evicted?

Not yet with current implementation, let me consider to find a way to make sure
all cached compressed pages being evicted during f2fs_evict_inode().

Thanks,

> 
> - Eric
> .
> 
