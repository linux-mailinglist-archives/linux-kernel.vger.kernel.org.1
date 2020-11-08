Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58A42AA90A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 05:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKHEMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 23:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKHEMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:12:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 20:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=S1QfwEXZWERFh3dXVORoV4Y0CO9ZM//Q2y9Wr8MwW70=; b=pcPyqBTbOetFrKo483fZE9mqVq
        4xPY/Ydi6mciY63F3eOZK9IcDto1mHGAGJ4LXw+6ftYnWgmtwyYpk3PavPVzKTXwDVCRmLpjLjWNb
        QqPdF6IUGppT+9IyBEi5LziLBuZoHht10Zg/M43UsMWsX860108W+xasMdvhHvRfOMe6MIRJf13/o
        DLkwhHc82CHbltd7LSfeLREcScP58tUB3s7NCrwm3ck/yn6jfFQ9iD3voGYTMQdMpHaXGyj1EPD/v
        /uU+1k5CKGaBs09slzYS1p36JyAaJYapQixWh5zikftwMFIEiVdKp3e3g09ShVjMTJ3Pm6pYQEWq1
        C+x8mutg==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbc3c-0005Dg-Kt; Sun, 08 Nov 2020 04:12:01 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     John Hubbard <jhubbard@nvidia.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
 <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
 <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
 <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
 <869059977c224a3aa31bfb42a4a8148d@hisilicon.com>
 <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
 <8eaa47c0-a62d-46da-4fd6-93f2b5b2910d@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e08c812d-80bf-12ec-794e-a726a1b37433@infradead.org>
Date:   Sat, 7 Nov 2020 20:11:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8eaa47c0-a62d-46da-4fd6-93f2b5b2910d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 7:22 PM, John Hubbard wrote:
> On 11/7/20 7:14 PM, John Hubbard wrote:
>> On 11/7/20 6:58 PM, Song Bao Hua (Barry Song) wrote:
>>>> On 11/7/20 2:20 PM, Randy Dunlap wrote:
>>>>> On 11/7/20 11:16 AM, John Hubbard wrote:
>>>>>> On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
>>>>>>>> From: John Hubbard [mailto:jhubbard@nvidia.com]
>>>>>> ...
>>>> But if you really disagree, then I'd go with, just drop the patch entirely, because
>>>> it doesn't really make things better as written...IMHO anyway. :)
>>>
>>> Just imagine a case, we don't enable DEBUG_FS but we enable GUP_TEST, we will
>>> get an image with totally useless code section since GUP_TEST depends on debugfs
>>> entry to perform any useful functionality.
>>>
>>
>> Looking at the choices, from the user's (usually kernel developer's) experience:
>>
>> a) The user enables GUP_TEST, then boots up, runs, and is briefly surprised by a
>> runtime failure. But it's a very quick diagnosis: "open: No such file or directory",
>> when trying to make that ioctl call. The path indicates that it's a debug fs path,
>> so the solution is pretty clear, at least for the main audience.
>>
>> b) The other choice: the user *never even sees* GUP_TEST as a choice. This especially
>> bothers me because sometimes you find things by poking around in the menu, although
>> of course "you should already know about it"...but there's a lot to "already know"
>> in a large kernel.
>>
>>  From a user experience, it's way better to simply see what you want, and select it
>> in the menu. Or, at least get some prompt that you need to pre-select something else.
>>
> 
> ...and again, this is all fallout from Kconfig. I might be missing some advanced
> feature, because it seems surprising to only be allowed to choose between
> missing dependencies (which this patch would correct), or a poorer user experience
> (which I argue that this patch would also provide).
> 
> Ideally, we'd just set up the dependencies, and then have some options for
> visibility, but I'm not aware of any way to do that...and after a quick peek
> at Documentation/kbuild/kconfig-macro-language.rst it looks pretty bare bones.

Look at kconfig-language.rst instead.

One thing that could be done (and is done in a few places for other reasons) is to add
a Kconfig comment if DEBUG_FS is not enabled:

comment "GUP_TEST needs to have DEBUG_FS enabled"
	depends on !GUP_TEST && !DEBUG_FS

e.g. drivers/hid/usbhid/Kconfig:

comment "Input core support is needed for USB HID input layer or HIDBP support"
	depends on USB_HID && INPUT=n


-- 
~Randy

