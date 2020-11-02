Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FF2A2678
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgKBI5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgKBI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:57:05 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D76C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:57:04 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id l24so13533942edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKCEPkor6No1flCj3QWU99lT12Ofqcg/woCKr9EHkXQ=;
        b=TXECMQHkNsBfmgFt2gxrFfh4vBNWUehZ1RK0KVZZ2qhrEotFD6PFh//A43MxXimim8
         iERso2u35wSK3pP70nrVDySA901kUIWFQIyS98WPMG8LglluE3BeBhW64O32/Dw59QMg
         ObAfZsYC6V5y0bJSw92OSmGG8obieB9clG/kXRf3E22LufOs7IiKMlZa9G3YoHc0+GTU
         6sK3U6PIM/+1d8NiZ2SPzv56yQB9qOA/HGKd+WjLFlqombZcjLJEv6xB8j7y/oH+HhAr
         v0CDR9BiNbT5a8dH0H3KCaLFOpMkrdpIzF+TXjWOWw1T/yoFPv6TxTR9gJEBDov7qc3V
         q/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKCEPkor6No1flCj3QWU99lT12Ofqcg/woCKr9EHkXQ=;
        b=MtTcNpFP202HgZ95UFkBWKERA4mHQLbYY8NgCs3YL4LqOqAik/V9kL1RU6S87dwPTJ
         pN4TB4RRtZ0fsZ68oXGbFzb+NqaIEP7y69MAJP4vRPR4t6gB3p34496wDwymhjTu3ZV9
         jwdwOj5kEQNpZXMR41d3TFJkjEMvo5tk0uN6V1f2jzzydXp8M1fxVTQQMU89zPwK8Lnb
         8yeWpa/eCA6o1boFrF+on0xr6/Ikoind03VGtgNSurxt+F2y6kwVKbphaGov1pIJglbI
         gx30x2qyIfd7/toDwHPk2shURkv4YnZwg2rw2Ep9svcHeyEPyuPw0JMsHa0aZaFdaDWZ
         vNOw==
X-Gm-Message-State: AOAM5301A2IlKaSyBj8HVl2tlY2UVk77WyCY4cJ90yr4D3D+fGQJ1ROk
        fmJgcl4Bq7Ab9005z3MIp3n2Xuddz/0ppia/B3nYhg==
X-Google-Smtp-Source: ABdhPJwJRyYvDryN85I1qs2qcqeISMOByxvstsJx5XXG6KOYVJzGikvRvOM6d8fAroXMT2EXNqL4Czo/srFIXy71VQo=
X-Received: by 2002:a50:e442:: with SMTP id e2mr16213423edm.186.1604307422747;
 Mon, 02 Nov 2020 00:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20201014231158.34117-1-warthog618@gmail.com> <CACRpkdbTsN6p4n3f9SJrgAjdkzDu2S67rU3tLWwX0X50ekjctQ@mail.gmail.com>
 <20201028232211.GB4384@sol> <CAMpxmJX61dRE_d2Eyu2nXKx64rNrrTfScrdg=Cc-N-R_FKfUNg@mail.gmail.com>
 <CAMpxmJXiObcKyoE264oyiZOs08=uRYno6siMzz6BH+jmT_NKgQ@mail.gmail.com> <20201031000139.GA7042@sol>
In-Reply-To: <20201031000139.GA7042@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 2 Nov 2020 09:56:52 +0100
Message-ID: <CAMpxmJU+sq5Tq9NdCLyW54FN0_oFJXz4oLAHymuTaAHNSqGNLQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: cdev: allow edge event timestamps to be
 configured as REALTIME
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 1:01 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Fri, Oct 30, 2020 at 03:52:24PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Oct 30, 2020 at 3:49 PM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 12:22 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 28, 2020 at 05:01:49PM +0100, Linus Walleij wrote:
> > > > > On Thu, Oct 15, 2020 at 1:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > >
> > > > > > This patch set adds the option to select CLOCK_REALTIME as the source
> > > > > > clock for line events.
> > > > > >
> > > > > > The first patch is the core of the change, while the remaining two update
> > > > > > the GPIO tools to make use of the new option.
> > > > > >
> > > > > > Changes for v2:
> > > > > >  - change line_event_timestamp() return to u64 to avoid clipping to 32bits
> > > > > >    on 32bit platforms.
> > > > > >  - fix the line spacing after line_event_timestamp()
> > > > >
> > > > > Where are we standing with this patch set? Good to go so
> > > > > I should just try to merge it?
> > > > >
> > > >
> > > > I'm fine with it, especially now that I've tested it on 32bit platforms
> > > > as well as 64bit.
> > > >
> > > > Bart was ok with v1, and I doubt the changes for v2 would negatively
> > > > impact that, though I did overlook adding his review tag.
> > > >
> > > > Cheers,
> > > > Kent.
> > > >
> > > > > Yours,
> > > > > Linus Walleij
> > >
> > > I'll take it through my tree then.
> > >
> > > Bartosz
> >
> > The series no longer applies on top of v5.10-rc1. Could you rebase and resend?
> >
>
> Nuts, it relies on my doc tidy-up series that Linus has pulled into
> fixes, and so will likely go into v5.10-rc2??
>
> Specifically it is based over/conflicts with:
> 2cc522d3931b gpio: uapi: kernel-doc formatting improvements
>
> If I rebase it onto devel then you will get a conflict when those merge.
> Is that what you want?
>
> Cheers,
> Kent.

I'll let Linus take these through his tree then.

Bartosz
