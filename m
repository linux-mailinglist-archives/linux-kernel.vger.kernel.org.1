Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33682F6D86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbhANVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbhANVv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:51:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E6AA23A5C;
        Thu, 14 Jan 2021 21:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610661046;
        bh=EoVs7P6a1ZPCpDdPeXmDB8ngGOywLZzN1o1+cP4CMgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8Vu8jrhOS8fSKadFV+xLuzbYhBi9yfaL5GXlL22vPnK1aBn9O/haQXO6r5Prb7EK
         nALe/uQ7fMb7HduD8bCcaRHz5EHA9l8KkUq+T5rYguVApQEv5ahO5LCtsO4HJPlIxB
         3ZlWfImXPcYVm1TVZV2SFLCnJP5uJlgvYWkuD5ytIUPXBuJdH6v7VggRGWWAW2ryQl
         f+yqa/7ruJ6Pd9jGE2fd81zJRgpwQyJ1ogCZFCCBenm+013yi2Hx9HSCprV4oHIlNq
         yayPLzht9D5UngXoCrV8uFpb7A0OgedrAqrPJY7i7TtzgtMC9reuGgFOuUPjixJsvw
         H1yNb7JHzhN+g==
Date:   Thu, 14 Jan 2021 22:50:41 +0100
From:   Robert Richter <rric@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] drivers: Remove oprofile and dcookies
Message-ID: <YAC8sf6v8+QAXHD3@rric.localdomain>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610622251.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.21 17:04:24, Viresh Kumar wrote:
> Hello,
> 
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove oprofile and dcookies (whose only user is oprofile) support from
> the kernel.
> 
> This was suggested here [1] earlier.
> 
> This is build/boot tested by kernel test robot (Intel) and Linaro's
> Tuxmake[2] for a lot of architectures and no failures were reported.
> 
> --
> Viresh
> 
> [1] https://lore.kernel.org/lkml/CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com/
> [2] https://lwn.net/Articles/841624/
> 
> Viresh Kumar (18):
>   arch: alpha: Remove CONFIG_OPROFILE support
>   arch: arm: Remove CONFIG_OPROFILE support
>   arch: arc: Remove CONFIG_OPROFILE support
>   arch: hexagon: Don't select HAVE_OPROFILE
>   arch: ia64: Remove CONFIG_OPROFILE support
>   arch: ia64: Remove rest of perfmon support
>   arch: microblaze: Remove CONFIG_OPROFILE support
>   arch: mips: Remove CONFIG_OPROFILE support
>   arch: parisc: Remove CONFIG_OPROFILE support
>   arch: powerpc: Stop building and using oprofile
>   arch: powerpc: Remove oprofile
>   arch: s390: Remove CONFIG_OPROFILE support
>   arch: sh: Remove CONFIG_OPROFILE support
>   arch: sparc: Remove CONFIG_OPROFILE support
>   arch: x86: Remove CONFIG_OPROFILE support
>   arch: xtensa: Remove CONFIG_OPROFILE support
>   drivers: Remove CONFIG_OPROFILE support
>   fs: Remove dcookies support

After oprofile userland moved to version 1.x, the kernel support for
it isn't needed anymore. The switch was back in 2014 when oprofile
started using the perf syscall:

 https://sourceforge.net/p/oprofile/oprofile/ci/ba9edea2bdfe2c9475749fc83105632bd916b96c

Since then I haven't received any significant patches to implement new
features or add support for newer platforms in the kernel. There
haven't been bug reports sent or questions asked on the mailing list
for quite a while, which indicates there are no or less users. Users
(if any) should switch to oprofile 1.x or the perf tool. No need to
carry kernel support any longer with us.

So time to get rid of it. For the whole series:

Acked-by: Robert Richter <rric@kernel.org>
