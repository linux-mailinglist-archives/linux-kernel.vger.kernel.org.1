Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297182F7FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbhAOPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbhAOPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610725474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUKZWLTTSl2Yn8XOp/LDxkSHznbyRPG2DpGK5co76Kk=;
        b=K99CgHt2qA7TQg0i9duUppGWsX+gpXNBJMgX4mlxNYUj/dg5SU0GB+0Id0S+zWqck0HMPw
        pw76IY/UX/EBoK7c23UOhHgtwKOdBeWsoXvKcUKNN/SUm6TKSaVBpgebDqTOQUGRICQ+c0
        zyQEymR4X+pUBgWlLHv/c4XIl7ocfh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-ImxyA3izMi6-MMh599JmYA-1; Fri, 15 Jan 2021 10:44:31 -0500
X-MC-Unique: ImxyA3izMi6-MMh599JmYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06498144E1;
        Fri, 15 Jan 2021 15:44:29 +0000 (UTC)
Received: from [10.10.114.127] (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3CA65D756;
        Fri, 15 Jan 2021 15:44:28 +0000 (UTC)
Subject: Re: [PATCH 00/18] drivers: Remove oprofile and dcookies
To:     Robert Richter <rric@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        oprofile-list@lists.sf.net,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <YAC8sf6v8+QAXHD3@rric.localdomain>
From:   William Cohen <wcohen@redhat.com>
Message-ID: <927ed742-914c-bbc2-d397-dabaaa6643e7@redhat.com>
Date:   Fri, 15 Jan 2021 10:44:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAC8sf6v8+QAXHD3@rric.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 4:50 PM, Robert Richter wrote:
> On 14.01.21 17:04:24, Viresh Kumar wrote:
>> Hello,
>>
>> The "oprofile" user-space tools don't use the kernel OPROFILE support
>> any more, and haven't in a long time. User-space has been converted to
>> the perf interfaces.
>>
>> Remove oprofile and dcookies (whose only user is oprofile) support from
>> the kernel.
>>
>> This was suggested here [1] earlier.
>>
>> This is build/boot tested by kernel test robot (Intel) and Linaro's
>> Tuxmake[2] for a lot of architectures and no failures were reported.
>>
>> --
>> Viresh
>>
>> [1] https://lore.kernel.org/lkml/CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com/
>> [2] https://lwn.net/Articles/841624/
>>
>> Viresh Kumar (18):
>>   arch: alpha: Remove CONFIG_OPROFILE support
>>   arch: arm: Remove CONFIG_OPROFILE support
>>   arch: arc: Remove CONFIG_OPROFILE support
>>   arch: hexagon: Don't select HAVE_OPROFILE
>>   arch: ia64: Remove CONFIG_OPROFILE support
>>   arch: ia64: Remove rest of perfmon support
>>   arch: microblaze: Remove CONFIG_OPROFILE support
>>   arch: mips: Remove CONFIG_OPROFILE support
>>   arch: parisc: Remove CONFIG_OPROFILE support
>>   arch: powerpc: Stop building and using oprofile
>>   arch: powerpc: Remove oprofile
>>   arch: s390: Remove CONFIG_OPROFILE support
>>   arch: sh: Remove CONFIG_OPROFILE support
>>   arch: sparc: Remove CONFIG_OPROFILE support
>>   arch: x86: Remove CONFIG_OPROFILE support
>>   arch: xtensa: Remove CONFIG_OPROFILE support
>>   drivers: Remove CONFIG_OPROFILE support
>>   fs: Remove dcookies support
> 
> After oprofile userland moved to version 1.x, the kernel support for
> it isn't needed anymore. The switch was back in 2014 when oprofile
> started using the perf syscall:
> 
>  https://sourceforge.net/p/oprofile/oprofile/ci/ba9edea2bdfe2c9475749fc83105632bd916b96c
> 
> Since then I haven't received any significant patches to implement new
> features or add support for newer platforms in the kernel. There
> haven't been bug reports sent or questions asked on the mailing list
> for quite a while, which indicates there are no or less users. Users
> (if any) should switch to oprofile 1.x or the perf tool. No need to
> carry kernel support any longer with us.
> 
> So time to get rid of it. For the whole series:
> 
> Acked-by: Robert Richter <rric@kernel.org>

The oprofile daemon that used the older oprofile kernel support was removed before OProfile 1.0 release by the following commit in August 2014:

https://sourceforge.net/p/oprofile/oprofile/ci/0c142c3a096d3e9ec42cc9b0ddad994fea60d135

At this point it makes sense to clean up the kernel and remove this unused code.

Acked-by: William Cohen <wcohen@redhat.com>

> 
> 
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
> 

