Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958552ACAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgKJByM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:54:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7509 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:54:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CVWB14tvvzhjvx;
        Tue, 10 Nov 2020 09:54:01 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 Nov
 2020 09:54:08 +0800
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201106065331.76236-1-yuchao0@huawei.com>
 <20201106180324.GA78548@sol.localdomain>
 <a7e78b61-021a-444d-eb36-68ce7aae133e@kernel.org>
 <20201107171635.GA841@sol.localdomain>
 <63efaa5c-bc19-4b16-653d-840bc6a6d9d1@huawei.com>
 <20201109181204.GA1232946@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f5ce8331-3297-7e38-42a0-0a6c73c30ff2@huawei.com>
Date:   Tue, 10 Nov 2020 09:54:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201109181204.GA1232946@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/10 2:12, Eric Biggers wrote:
> On Mon, Nov 09, 2020 at 10:29:25AM +0800, Chao Yu wrote:
>>> Oh I see, the cp-related checks are at the beginning of f2fs_ioctl() too.
>>>
>>> In that case a much better approach would be to add __f2fs_ioctl() which is
>>> called by f2fs_ioctl() and f2fs_compat_ioctl(), and have f2fs_ioctl() and
>>> f2fs_compat_ioctl() do the cp-related checks but not __f2fs_ioctl().
>>
>> Will this cleanup make sense to you?
> 
> I think it would be better to do it the way I suggested.

Updated in v5.

Thanks,

> 
> - Eric
> .
> 
