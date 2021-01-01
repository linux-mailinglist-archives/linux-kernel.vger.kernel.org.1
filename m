Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B62E8430
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAAQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 11:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbhAAQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 11:29:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A3C061573
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=7xQylDOU8gMh95fJFNlktBR/duZbHGaSP/VvUN5281c=; b=gTtZ481gvdHqHOiFuQwWixUvsg
        ZDB3bCrTYYQqjsOCLWBu/PkrBU/vGyUzQ9l4q5XWoKFMuib3jAJj4as4H4OtZYyZgWkUCVQ2o1bQf
        QqX2xVTVVgTeKMcyMAietovOFtFo6lTxbBDJ0agnMX1RvLqLKhoEy4y3A9On4fYjxQ6HZCtwaGdiY
        jJHWjEkEvJ0HplIt/J82rcveE86CybvBrNKVpmyzuTPzqJTJGxpcOWNsQTGFgWwDfHBQn/lpMGSGc
        Z5dm9cLCK4tOFtBAT6F3ATMR9k4ULGWfdzRwDJLCZe0FlMcoxp7q25QuJRZUkRfZh9E15wYnWenXd
        mh2YF7iw==;
Received: from [2601:1c0:6280:3f0::2c43]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kvNIH-0007vD-3i; Fri, 01 Jan 2021 16:28:49 +0000
Subject: Re: Generate the config file for kernel compilation non-interactively
 in script.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
 <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org>
 <CAGP6PO+JjF0iDXHqUD31cBtNASqbik_iEb3DguqVhUBG+q4LYQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <75ee2c40-6a23-9a28-157e-72018faf0925@infradead.org>
Date:   Fri, 1 Jan 2021 08:28:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAGP6PO+JjF0iDXHqUD31cBtNASqbik_iEb3DguqVhUBG+q4LYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/1/21 1:55 AM, Hongyi Zhao wrote:
> On Fri, Jan 1, 2021 at 2:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 12/31/20 8:51 PM, Hongyi Zhao wrote:
>>> Hi,
>>>
>>> I want to build the realtime Linux for ROS 2 according to the
>>> guidelines here:
>>> <https://index.ros.org/doc/ros2/Tutorials/Building-Realtime-rt_preempt-kernel-for-ROS-2/>.
>>>
>>> For this purpose, I must enable the rt_preempt relative options in the
>>> kernel withe the following method interactively:
>>>
>>> $ make menuconfig
>>>
>>> and set the following
>>>
>>> # Enable CONFIG_PREEMPT_RT
>>>  -> General Setup
>>>   -> Preemption Model (Fully Preemptible Kernel (Real-Time))
>>>    (X) Fully Preemptible Kernel (Real-Time)
>>>
>>> # Enable CONFIG_HIGH_RES_TIMERS
>>>  -> General setup
>>>   -> Timers subsystem
>>>    [*] High Resolution Timer Support
>>>
>>> # Enable CONFIG_NO_HZ_FULL
>>>  -> General setup
>>>   -> Timers subsystem
>>>    -> Timer tick handling (Full dynticks system (tickless))
>>>     (X) Full dynticks system (tickless)
>>>
>>> # Set CONFIG_HZ_1000 (note: this is no longer in the General Setup
>>> menu, go back twice)
>>>  -> Processor type and features
>>>   -> Timer frequency (1000 HZ)
>>>    (X) 1000 HZ
>>>
>>> # Set CPU_FREQ_DEFAULT_GOV_PERFORMANCE [=y]
>>>  ->  Power management and ACPI options
>>>   -> CPU Frequency scaling
>>>    -> CPU Frequency scaling (CPU_FREQ [=y])
>>>     -> Default CPUFreq governor (<choice> [=y])
>>>      (X) performance
>>>
>>> But this is very inconvenient for doing the above job in script. Is
>>> there an alternative method to generate the above configurations for
>>> kernel compilation  non-interactively in script.
>>
>> Hi,
>> You can use scripts/config in the kernel source tree.
>> Something like this (I don't have RT kernel sources):
>>
>>
>> scripts/config -e PREEMPT_RT
>> scripts/config -e HIGH_RES_TIMERS
>> scripts/config -e NO_HZ_FULL
>> scripts/config -e HZ_1000
>> scripts/config -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> 
> Wonderful. Thanks a lot for your instructions. I really have noticed
> this tool but failed to figure out the corresponding translation rules
> for the options used by menuconfig and this script.
> 
> BTW, how do you figure out the above options/arguments corresponding
> to the ones I've mentioned previously?
> 

Oh, I just took the ones that you had listed and removed the leading
"CONFIG_" from them.

>>
>> Note that if any of those have other Kconfig dependencies, those Kconfig
>> symbols will also have to be enabled for this to work.
> 
> How to know whether an option has other Kconfig dependencies and find
> the corresponding symbols/arguments for feeding to scripts/config?

Use one of the interactive config tools (nconfig, xconfig).
They will show you dependencies, but you may have to enable other
symbols first.

Maybe it would be easier to do a temporary 'make allmodconfig'
to have the symbols that you are interested in be enabled, then
you can find them and look at their dependencies.

Or you could just read the Kconfig files, but that would probably
be painful.

>> And then run 'make oldconfig' to update the kernel .config file.
> 
> Thanks again.


-- 
~Randy

