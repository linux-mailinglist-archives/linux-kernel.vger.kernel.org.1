Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2072709AD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgISBay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 21:30:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISBay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 21:30:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 32022B859BFF745D94BE;
        Sat, 19 Sep 2020 09:30:53 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 09:30:51 +0800
Subject: Re: [PATCH -next] m68k/amiga: missing platform_device_unregister() on
 error in amiga_init_devices()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200728022746.87612-1-miaoqinglang@huawei.com>
 <CAMuHMdWfqh_AKyE+od_0yVPP6Lkv8LUAR1dWf8Df94W7b4qxLA@mail.gmail.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <613d3a43-4fb0-48d5-93d6-bf0d8f0bd671@huawei.com>
Date:   Sat, 19 Sep 2020 09:30:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWfqh_AKyE+od_0yVPP6Lkv8LUAR1dWf8Df94W7b4qxLA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/26 17:07, Geert Uytterhoeven 写道:
> Hi Qinglang,
> 
> On Tue, Jul 28, 2020 at 4:24 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>> Add the missing platform_device_unregister() before return
>> from amiga_init_devices() in the error handling case.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/amiga/platform.c
>> +++ b/arch/m68k/amiga/platform.c
>> @@ -188,8 +188,10 @@ static int __init amiga_init_devices(void)
>>                          return PTR_ERR(pdev);
>>                  error = platform_device_add_data(pdev, &a1200_ide_pdata,
>>                                                   sizeof(a1200_ide_pdata));
> 
> The only reason why platform_device_add_data() can fail is because the
> system ran out of memory.  If that's the case this early, the whole
> system will fail to work anyway, and it doesn't matter that the IDE
> driver will crash later due to missing platform data.
> 
> So I don't think it helps to increase kernel size by adding more error
> handling.
> 
Hi Geert,

Glad to know your opnions, it sounds resonable to me.

Thanks.

>> -               if (error)
>> +               if (error) {
>> +                       platform_device_unregister(pdev);
>>                          return error;
>> +               }
>>          }
>>
>>          if (AMIGAHW_PRESENT(A4000_IDE)) {
>> @@ -199,8 +201,10 @@ static int __init amiga_init_devices(void)
>>                          return PTR_ERR(pdev);
>>                  error = platform_device_add_data(pdev, &a4000_ide_pdata,
>>                                                   sizeof(a4000_ide_pdata));
>> -               if (error)
>> +               if (error) {
>> +                       platform_device_unregister(pdev);
> 
> Likewise.
> 
>>                          return error;
>> +               }
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
