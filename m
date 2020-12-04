Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31672CE64A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLDDLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:11:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8682 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgLDDLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:11:53 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnHlG3KL7zkkj7;
        Fri,  4 Dec 2020 11:10:34 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 11:11:04 +0800
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Eric Biggers <ebiggers@kernel.org>, <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com> <20201204003119.GA1957051@xiangao.remote.csb>
 <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
 <20201204020659.GB1963435@xiangao.remote.csb>
 <3041968d-87d0-d2dc-822b-0bb4a94a365b@huawei.com>
 <20201204024746.GC1963435@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <15afffcc-636d-b678-0c01-b2fad98d9311@huawei.com>
Date:   Fri, 4 Dec 2020 11:11:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201204024746.GC1963435@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 10:47, Gao Xiang wrote:
> On Fri, Dec 04, 2020 at 10:38:08AM +0800, Chao Yu wrote:
>> On 2020/12/4 10:06, Gao Xiang wrote:
>>> On Fri, Dec 04, 2020 at 09:56:27AM +0800, Chao Yu wrote:
> 
> ...
> 
>>
>>>
>>> Keep lz4hc dirty data under writeback could block writeback, make kswapd
>>> busy, and direct memory reclaim path, I guess that's why rare online
>>> compression chooses it. My own premature suggestion is that it'd better
>>> to show the CR or performance benefits in advance, and prevent unprivileged
>>> users from using high-level lz4hc algorithm (to avoid potential system attack.)
>>> either from mount options or ioctl.
>>
>> Yes, I guess you are worry about destop/server scenario, as for android scenario,
>> all compression related flow can be customized, and I don't think we will use
>> online lz4hc compress; for other scenario, except the numbers, I need to add the
>> risk of using lz4hc algorithm in document.
> 
> Yes, I was saying the general scenario. My overall premature thought is that
> before releasing some brand new algorithm, it may be better to evaluate first
> it'd benefit to some scenarios first (either on CR or performance side, or
> why adding this?), or it would might cause lzo-rle likewise situation in the

Yeah, got your point.

> future (and add more dependency to algorithms, you might see BWT-based bzip2
> removal patch

Oops, is that really allowed? I don't this is a good idea...and I don't see there
are deletions from fs/ due to similar reason...

Thanks,

> https://lore.kernel.org/r/20201117223253.65920-1-alex_y_xu@yahoo.ca
> (since I personally don't think BWT is a good algorithm as well)... Just FYI
> ... If i'm wrong, kindly ignore me :)
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
> 
> .
> 
