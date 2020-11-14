Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0552B2CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKNKWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 05:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgKNKWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:22:36 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D902A22252;
        Sat, 14 Nov 2020 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605349355;
        bh=DTAwl0hTrgRNPZ3g+vwkAlwE0PTRvx4ZwzKkvuUCxr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C18I0LTVOcMsZtu/D5bylPumO8f8Nv2DLt9F8OyjoeMYwBWEyrvkd9nZ3U42ecTAP
         dKZ4KKAddKzsHAn6n6EomSTPCaozy0YPoORQspiNxwEmDJzHKZ/Gr7JWWi0ifU4f+s
         p+IHjEs9d3zGxrcCBXfQq5cZdDPfxpiFsOMD5Lv8=
Date:   Sat, 14 Nov 2020 11:23:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Roman Kiryanov <rkir@google.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>,
        anup.patel@wdc.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Subject: Re: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
Message-ID: <X6+wGMUCCpu2liYR@kroah.com>
References: <20201113205233.827493-1-rkir@google.com>
 <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com>
 <tencent_3801BEAE39670E174105E007@qq.com>
 <X6+SKQS6QJr25kF0@kroah.com>
 <d1d47715-482c-f598-a958-499d9fde21e0@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1d47715-482c-f598-a958-499d9fde21e0@flygoat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 05:47:47PM +0800, Jiaxun Yang wrote:
> 
> 
> 在 2020/11/14 下午4:15, Greg KH 写道:
> 
> + qemu-riscv list and QEMU device maintainers of goldfish_rtc
> 
> > On Sat, Nov 14, 2020 at 04:06:24PM +0800, 陈华才 wrote:
> > > Hi, All,
> > > 
> > > Goldfish RTC works well on MIPS, and QEMU RISC-V emulator use Goldfish
> > > as well, so I think  we should keep it in kernel.
> > But does anyone actually use it for anything?  Having something in qemu
> > is nice, but not required if it doesn't provide something that is
> > already there for other virtual devices, right?
> 
> Hi all,
> 
> Both QEMU MIPS loongson3-virt and riscv virt machine are using goldfish_rtc
> as sole RTC
> device, it have been hardcoded in QEMU for a long while and sudden drop in
> kernel would
> break these machines.
> RTC is essential for virt machines to keep time synchronized with host.
> 
> Given that it is the simplest RTC implementation for now, it won't give us
> much maintenance
> overhead.
> 
> Thus I do think it shouldn't be retired as for now. If nobody comes in I'd
> also willing to maintain
> it.

Ok, can someone submit a patch to update the MAINTAINERS file for this
so we know who to route issues to over time?

thanks,

greg k-h
