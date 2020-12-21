Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71292E0260
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgLUWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLUWMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:12:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5211C061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:11:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 23so27273753lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBAt1RHYy1aqMRYFGaE3yHYI/8MQKnzdriZFqO7W7Ls=;
        b=kA5V2OlTwufddnTrHnWNieXRpJQxP8HBytYtM3xUnAyMronNistfPL6yokAgEAWxel
         EyvkAZUq5044dpTahW+xWsqmo+qcDypBXFhy2QZnC2BSJ6gYR5V7RVyoZOWEVEGYqGbr
         hR+XWJFyQbFts/HNnbsmkTByIEhGmQ61D5Zs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBAt1RHYy1aqMRYFGaE3yHYI/8MQKnzdriZFqO7W7Ls=;
        b=pXX6aRJJNGq+++IuF8rILbsrANpvnpsn+LUlHs1MLIV2MKb0SBvo8eBkSq5w7CLMAS
         nQTADXudQAE5qukq41Pe69dBTdOxb+HGck5izJIcQwjriaF/5ZBsTn2erMp+3BaNyBlU
         H3Tk+2echxH6HidgmUCpMZ4Zo3JkP0Z+yQnxdO6Ciud0W11QT58VNcW0ztp/xyC/HJwU
         4LZS8GGQJ9GH1tNqaRfxS7P9tc4NjdyOYf5PvhtHMJ1uNEiHP8L7Qy+cLt6KRghM7teL
         0pyjjRahuRWXZ9Z99m0o8UwmOxtubVX5WGpEfQBcodOCpKjxA7xEI4mz4PgInc2oXmg0
         Bnpw==
X-Gm-Message-State: AOAM530o9M/NWwDbZ47nCg99dHdJdPAHeNlSPmdmk7ulqiNw8KKYIXI5
        flUR859U+6t9vDmr75SCssXeA8qjxRUpA6md6+avBOE9ILs6bMKncJQ=
X-Google-Smtp-Source: ABdhPJwyzqUFoUSF/1NmjueMbe52ezVBGyvQwEQATI1oi6HEfbllTgf+rWMpGEBw4+kjq2xaHtVNL4qLTO2F5BtZ2ek=
X-Received: by 2002:a2e:154b:: with SMTP id 11mr8099534ljv.22.1608588710132;
 Mon, 21 Dec 2020 14:11:50 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com> <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com>
In-Reply-To: <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 21 Dec 2020 23:11:39 +0100
Message-ID: <CAM4kBB+xUa8zXSRSuB0z5FCdPNmUpDfcC4Vqu7wzAkf0b+RXqw@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 10:30 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Shakeel Butt [mailto:shakeelb@google.com]
> > Sent: Tuesday, December 22, 2020 10:03 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Vitaly Wool <vitaly.wool@konsulko.com>; Minchan Kim <minchan@kernel.org>;
> > Mike Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux-mm
> > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > <akpm@linux-foundation.org>
> > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> >
> > On Mon, Dec 21, 2020 at 12:06 PM Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Shakeel Butt [mailto:shakeelb@google.com]
> > > > Sent: Tuesday, December 22, 2020 8:50 AM
> > > > To: Vitaly Wool <vitaly.wool@konsulko.com>
> > > > Cc: Minchan Kim <minchan@kernel.org>; Mike Galbraith <efault@gmx.de>; LKML
> > > > <linux-kernel@vger.kernel.org>; linux-mm <linux-mm@kvack.org>; Song Bao
> > Hua
> > > > (Barry Song) <song.bao.hua@hisilicon.com>; Sebastian Andrzej Siewior
> > > > <bigeasy@linutronix.de>; NitinGupta <ngupta@vflare.org>; Sergey
> > Senozhatsky
> > > > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > > > <akpm@linux-foundation.org>
> > > > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> > > >
> > > > On Mon, Dec 21, 2020 at 11:20 AM Vitaly Wool <vitaly.wool@konsulko.com>
> > wrote:
> > > > >
> > > > > On Mon, Dec 21, 2020 at 6:24 PM Minchan Kim <minchan@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> > > > > > > zsmalloc takes bit spinlock in its _map() callback and releases it
> > > > > > > only in unmap() which is unsafe and leads to zswap complaining
> > > > > > > about scheduling in atomic context.
> > > > > > >
> > > > > > > To fix that and to improve RT properties of zsmalloc, remove that
> > > > > > > bit spinlock completely and use a bit flag instead.
> > > > > >
> > > > > > I don't want to use such open code for the lock.
> > > > > >
> > > > > > I see from Mike's patch, recent zswap change introduced the lockdep
> > > > > > splat bug and you want to improve zsmalloc to fix the zswap bug and
> > > > > > introduce this patch with allowing preemption enabling.
> > > > >
> > > > > This understanding is upside down. The code in zswap you are referring
> > > > > to is not buggy.  You may claim that it is suboptimal but there is
> > > > > nothing wrong in taking a mutex.
> > > > >
> > > >
> > > > Is this suboptimal for all or just the hardware accelerators? Sorry, I
> > > > am not very familiar with the crypto API. If I select lzo or lz4 as a
> > > > zswap compressor will the [de]compression be async or sync?
> > >
> > > Right now, in crypto subsystem, new drivers are required to write based on
> > > async APIs. The old sync API can't work in new accelerator drivers as they
> > > are not supported at all.
> > >
> > > Old drivers are used to sync, but they've got async wrappers to support async
> > > APIs. Eg.
> > > crypto: acomp - add support for lz4 via scomp
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> > crypto/lz4.c?id=8cd9330e0a615c931037d4def98b5ce0d540f08d
> > >
> > > crypto: acomp - add support for lzo via scomp
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> > crypto/lzo.c?id=ac9d2c4b39e022d2c61486bfc33b730cfd02898e
> > >
> > > so they are supporting async APIs but they are still working in sync mode
> > as
> > > those old drivers don't sleep.
> > >
> >
> > Good to know that those are sync because I want them to be sync.
> > Please note that zswap is a cache in front of a real swap and the load
> > operation is latency sensitive as it comes in the page fault path and
> > directly impacts the applications. I doubt decompressing synchronously
> > a 4k page on a cpu will be costlier than asynchronously decompressing
> > the same page from hardware accelerators.
>
> If you read the old paper:
> https://www.ibm.com/support/pages/new-linux-zswap-compression-functionality
> Because the hardware accelerator speeds up compression, looking at the zswap
> metrics we observed that there were more store and load requests in a given
> amount of time, which filled up the zswap pool faster than a software
> compression run. Because of this behavior, we set the max_pool_percent
> parameter to 30 for the hardware compression runs - this means that zswap
> can use up to 30% of the 10GB of total memory.
>
> So using hardware accelerators, we get a chance to speed up compression
> while decreasing cpu utilization.
>
> BTW, If it is not easy to change zsmalloc, one quick workaround we might do
> in zswap is adding the below after applying Mike's original patch:
>
> if(in_atomic()) /* for zsmalloc */
>         while(!try_wait_for_completion(&req->done);
> else /* for zbud, z3fold */
>         crypto_wait_req(....);

I don't think I'm going to ack this, sorry.

Best regards,
   Vitaly

> crypto_wait_req() is actually doing wait_for_completion():
> static inline int crypto_wait_req(int err, struct crypto_wait *wait)
> {
>         switch (err) {
>         case -EINPROGRESS:
>         case -EBUSY:
>                 wait_for_completion(&wait->completion);
>                 reinit_completion(&wait->completion);
>                 err = wait->err;
>                 break;
>         }
>
>         return err;
> }
>
> Thanks
> Barry
