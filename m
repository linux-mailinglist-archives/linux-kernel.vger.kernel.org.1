Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213071D9911
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgESOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:11:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbgESOLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:11:20 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DA756E8C56956D7A7E34;
        Tue, 19 May 2020 22:11:17 +0800 (CST)
Received: from [10.166.215.145] (10.166.215.145) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 22:11:12 +0800
Subject: Re: [PATCH v2] kdb: Make the internal env 'KDBFLAGS' undefinable
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200516092606.41576-1-liwei391@huawei.com>
 <20200519114008.lmdf44zmgcmnf27c@holly.lan>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <b7b0b881-08b8-2b7d-fc09-3d9d79b90cea@huawei.com>
Date:   Tue, 19 May 2020 22:11:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200519114008.lmdf44zmgcmnf27c@holly.lan>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2020/5/19 19:40, Daniel Thompson wrote:
> On Sat, May 16, 2020 at 05:26:06PM +0800, Wei Li wrote:
>> 'KDBFLAGS' is an internal variable of kdb, it is combined by 'KDBDEBUG'
>> and state flags. But the user can define an environment variable named
>> 'KDBFLAGS' too, so let's make it undefinable to avoid confusion.
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I took a quick look at this and find myself thinking of KDBFLAGS as
> something of a misfeature.
> 
> I think I'd rather get kdb_env to show the value we wrote into
> KDBDEBUG.
> 
> Sure this means we cannot use KDBDEBUG to look at the least significant
> 16-bits but I think anyone who is debugging kdb itself should know
> enough to use `md4c1 kdb_flags` to read those anyway.
> 
> 

Agree. That will be more clear with no confusion. Currently,
KDBFLAGS will be shown only when KDBDEBUG is set, that is weird too.
So, let's just make it simple.
I can fix it as you suggested in the next post.

Thanks,
Wei
