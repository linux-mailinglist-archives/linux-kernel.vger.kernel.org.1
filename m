Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D882F2C5E82
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 02:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392109AbgK0BBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 20:01:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8127 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392103AbgK0BBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 20:01:52 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChxCX3pvJz15SNK;
        Fri, 27 Nov 2020 09:01:28 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Nov
 2020 09:01:47 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: add compress_inode to cache
 compressed blocks
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126103709.80006-1-yuchao0@huawei.com>
 <X7/sCLnVPOjkC9DI@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7ecb947e-2f8c-abd7-c116-c82c474fded7@huawei.com>
Date:   Fri, 27 Nov 2020 09:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X7/sCLnVPOjkC9DI@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/27 1:55, Eric Biggers wrote:
> On Thu, Nov 26, 2020 at 06:37:09PM +0800, Chao Yu wrote:
>> Support to use address space of inner inode to cache compressed block,
>> in order to improve cache hit ratio of random read.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> If the file is also encrypted, are the compressed pages that are cached still
> encrypted, or are they decrypted?

In current implementation, they are decrypted in cache.

Thanks,

> 
> - Eric
> .
> 
