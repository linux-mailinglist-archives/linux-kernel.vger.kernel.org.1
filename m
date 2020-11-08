Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D22AA88E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKHAYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKHAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:24:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 16:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sty88BTrt0VXwPAWmqAUVdIEgTvdFE2qJcVGa0SOig0=; b=AMgxF4iYOk4ux680wMCOcVrbzS
        KXrdCYDRM0j9qXR4YtFmzByg2LNQgYlayu8PWaZVVTPOgM7PqaIQiEgAdayoKFqww+zg71eDatb8v
        Mf/AHlCB+sZzJsxNeEz0Re8KXMSRL/aoF9+D1960JUcrpToqkoYoCwcnG/OdmTL3O17ejAU/8JsbV
        BWtlTG2c1YVR+MWDm3p1xidMrlad+DdNINzbRP/3HY3WPowuZ+1PlTHoifEWUkBHObCIwiAx+1oHl
        9T2HauPE8D5CicpyZ+tydu8p/J7LHwc+f4X/QrNfr81ikXVx5wVD67WlfVqIiJPUSQ/l47QWa4/yf
        dH5TlEww==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbYVa-00047U-O6; Sun, 08 Nov 2020 00:24:39 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c8b6d14-7d14-4bd6-0eac-c60fa98aec0b@infradead.org>
Date:   Sat, 7 Nov 2020 16:24:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 4:03 PM, John Hubbard wrote:
> On 11/7/20 2:20 PM, Randy Dunlap wrote:
>> On 11/7/20 11:16 AM, John Hubbard wrote:
>>> On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
>>>>> -----Original Message-----
>>>>> From: John Hubbard [mailto:jhubbard@nvidia.com]
>>> ...
>>>>>>     config GUP_BENCHMARK
>>>>>>         bool "Enable infrastructure for get_user_pages() and related calls
>>>>> benchmarking"
>>>>>> +    depends on DEBUG_FS
>>>>>
>>>>>
>>>>> I think "select DEBUG_FS" is better here. "depends on" has the obnoxious
>>>>> behavior of hiding the choice from you, if the dependencies aren't already met.
>>>>> Whereas what the developer *really* wants is a no-nonsense activation of the
>>>>> choice: "enable GUP_BENCHMARK and the debug fs that it requires".
>>>>>
>>>>
>>>> To some extent, I agree with you. But I still think here it is better to use "depends on".
>>>> According to
>>>> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
>>>>
>>>>      select should be used with care. select will force
>>>>      a symbol to a value without visiting the dependencies.
>>>>      By abusing select you are able to select a symbol FOO even
>>>>      if FOO depends on BAR that is not set.
>>>>      In general use select only for non-visible symbols
>>>>      (no prompts anywhere) and for symbols with no dependencies.
>>>>      That will limit the usefulness but on the other hand avoid
>>>>      the illegal configurations all over.
>>>>
>>>> On the other hand, in kernel there are 78 "depends on DEBUG_FS" and
>>>> only 14 "select DEBUG_FS".
>>>>
>>>
>>> You're not looking at the best statistics. Go look at what *already* selects
>>> DEBUG_FS, and you'll find about 50 items.
>>
>> Sorry, I'm not following you. I see the same 14 "select DEBUG_FS" as Barry.
> 
> I ran make menuconfig, and looked at it. Because I want to see the true end result,
> and I didn't trust my grep use, given that the system has interlocking dependencies,
> and I think one select could end up activating others (yes?).
> 
> And sure enough, there are 42 items listed, here they are, cleaned up so that there
> is one per line:
> 
> ZSMALLOC_STAT [=n]
> ZSMALLOC [=m]
> BCACHE_CLOSURES_DEBUG [=n]
> MD [=y]
> BCACHE [=n]
> DVB_C8SECTPFE [=n]
> MEDIA_SUPPORT [=m]
> MEDIA_PLATFORM_SUPPORT [=y]
> DVB_PLATFORM_DRIVERS [=n]
> PINCT
> DRM_I915_DEBUG [=n]
> HAS_IOMEM [=y]
> EXPERT [=y]
> DRM_I915 [=m]
> EDAC_DEBUG [=n]
> EDAC [=y]
> SUNRPC_DEBUG [=n]
> NETWORK_FILESYSTEMS [=y]
> SUNRPC [=m]
> SYSCTL [=y]
> PAGE_OWNER [=n]
> DEBUG_KERNEL [=y]
> STACKTRACE_SUPPORT [=y]
> DEBUG_KMEMLEAK [=n]
> DEBUG_KERNEL [=y]
> HAVE_DEBUG_KMEMLEAK [=y]
> BLK_DEV_IO_TRACE [=n]
> TRACING_SUPPORT [=y]
> FTRACE [=y]
> SYSFS [=y]
> BLOCK [=y]
> PUNIT_ATOM_DEBUG [=n]
> PCI [=y]
> NOTIFIER_ERROR_INJECTION [=n]
> DEBUG_KERNEL [=y]
> FAIL_FUTEX [=n]
> FAULT_INJECTION [=n]
> FUTEX [=y]
> KCOV [=n]
> ARCH_HAS_KCOV [=y]
> CC_HAS_SANCOV_TRACE_PC [=y]
> GCC_PLUGINS
> 

OK, thanks, I see how you get that list now.

JFTR, those are not 42 independent users of DEBUG_FS. There are lots of &&s
and a few ||s in that list.


xconfig shows this for DEBUG_FS: (13 selects for x86_64 allmodconfig)

Selected by [y]:
- PAGE_OWNER [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y]
- DEBUG_KMEMLEAK [=y] && DEBUG_KERNEL [=y] && HAVE_DEBUG_KMEMLEAK [=y]
- BLK_DEV_IO_TRACE [=y] && TRACING_SUPPORT [=y] && FTRACE [=y] && SYSFS [=y] && BLOCK [=y]
- FAIL_FUTEX [=y] && FAULT_INJECTION [=y] && FUTEX [=y]
- KCOV [=y] && ARCH_HAS_KCOV [=y] && (CC_HAS_SANCOV_TRACE_PC [=y] || GCC_PLUGINS [=n])
Selected by [m]:
- ZSMALLOC_STAT [=y] && ZSMALLOC [=m]
- BCACHE_CLOSURES_DEBUG [=y] && MD [=y] && BCACHE [=m]
- DVB_C8SECTPFE [=m] && MEDIA_SUPPORT [=m] && MEDIA_PLATFORM_SUPPORT [=y] && DVB_PLATFORM_DRIVERS [=y] && PINCTRL [=y] && DVB_CORE [=m] && I2C [=y] && (ARCH_STI || ARCH_MULTIPLATFORM || COMPILE_TEST [=y])
- DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && EXPERT [=y] && DRM_I915 [=m]
- EDAC_DEBUG [=y] && EDAC [=m]
- SUNRPC_DEBUG [=y] && NETWORK_FILESYSTEMS [=y] && SUNRPC [=m] && SYSCTL [=y]
- PUNIT_ATOM_DEBUG [=m] && PCI [=y]
- NOTIFIER_ERROR_INJECTION [=m] && DEBUG_KERNEL [=y]

Some other $ARCH could be more...

>>
>> In general we don't want any one large "feature" (or subsystem) to be enabled
>> by one driver. If someone has gone to the trouble to disable DEBUG_FS (or whatever),
>> then a different Kconfig symbol shouldn't undo that.
>>
> 
> I agree with the "in general" point, yes. And my complaint is really 80% due to the
> very unhappy situation with Kconfig, where we seem to get a choice between *hiding*
> a feature, or forcing a dependency break. What we really want is a way to indicate
> a dependency that doesn't hide entire features, unless we want that. (Maybe I should
> attempt to get into the implementation, although I suspect it's harder than I
> realize.)
> 
> But the other 20% of my complaint is, given what we have, I think the appropriate
> adaptation for GUP_BENCHMARK's relationship to DEBUG_FS *in particular*, is: select.
> 
> And 42 other committers have chosen the same thing, for their relationship to
> DEBUG_FS. I'm in good company.
> 
> But if you really disagree, then I'd go with, just drop the patch entirely, because
> it doesn't really make things better as written...IMHO anyway. :)
> 
> thanks,

thanks.
-- 
~Randy

