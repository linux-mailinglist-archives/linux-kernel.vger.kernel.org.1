Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB22B294E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMXno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKMXnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:43:43 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C844D2225D;
        Fri, 13 Nov 2020 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605311023;
        bh=3z5520m298SYO6HQcYBi9VkTpKN/Hvj0NNjShpzvnfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4h6GOtqaalBIo8EqakxQrg1phm2NIm/Z6rsHZ58yKrWxKoHx7ltI0o/U09hmUmuK
         /+gido31OfnasvNe6GluTCqL0iQKgzMtvIeNG2YXRxIrFnA2eMmK/Lef3TNr8hfOOt
         7SrfOMUOSB25IY3jV73wCDFmBt0mUti5LqzI4fdA=
Date:   Sat, 14 Nov 2020 00:44:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     chenhc@lemote.com, Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
Message-ID: <X68aZ/Dgm7CObQmH@kroah.com>
References: <20201113205233.827493-1-rkir@google.com>
 <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 03:36:49PM -0800, Roman Kiryanov wrote:
> +Greg KH
> 
> On Fri, Nov 13, 2020 at 2:02 PM Roman Kiryanov <rkir@google.com> wrote:
> >
> > Hi Hancai,
> >
> > I see you added /arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts which
> > refers to goldfish-rtc in 39c1485c8baa47aa20caefc1ec0a3410fbad6c81.
> > We (Android Studio Emulator aka "goldfish") do not support MIPS anymore.
> > Do you know if goldfish-rtc still works and is assumed to be available?

I've dropped this patch from my trees now, please feel free to resend
when you have an updated version.

thanks,

greg k-h
