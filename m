Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA52EB767
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbhAFBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:03:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbhAFBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D9WKh0WRbzMFxr;
        Wed,  6 Jan 2021 09:02:00 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 6 Jan 2021
 09:03:08 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix null page reference in
 redirty_blocks
To:     Daeho Jeong <daehojeong@google.com>
CC:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-janitors@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>
References: <20210105041630.1393157-1-daeho43@gmail.com>
 <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6c8e6561-8a5d-010f-3d7c-8c051b4027e6@huawei.com>
Date:   Wed, 6 Jan 2021 09:03:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daeho,

FYI

https://www.spinics.net/lists/kernel/msg3595944.html

On 2021/1/5 20:04, Markus Elfring wrote:
>> Fixed null page reference when find_lock_page() fails in
>> redirty_blocks().
> 
> I suggest to choose an other imperative wording for this change description.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=36bbbd0e234d817938bdc52121a0f5473b3e58f5#n89
> 
> 
>> v2: changed error value and break the loop when error occurs
> 
> I propose to use a return statement instead of a break in the second if branch
> for this function implementation.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=36bbbd0e234d817938bdc52121a0f5473b3e58f5#n481
> 
> Regards,
> Markus
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
