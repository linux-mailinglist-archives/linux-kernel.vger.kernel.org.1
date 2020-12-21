Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8062E01C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLUVDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:03:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A34C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:02:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a12so26954943lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQaIP8214td2Fw8zqpizBbZjrLunzVtr25D3aarGH/c=;
        b=t/AjbS/YQMdRFPMVafWWmFWkStCgCVmBa3cgHKONPUDg5+sY8x5NxJMA+tuXyvNaW7
         /NPyybg6sPYJnfTwvud1EZaF97julnUoMURZdA+pbYdwPKa/zBDfg8BH2WKij5gkiPLf
         J3ayUXNHgDtVtWjRl0FDSJ1UclI0a4Q6XtszUgCgths+x4ZOrXlipzuwgnwU9KzUa6Cr
         2ZNYMJn3CZNKpe2ZawjqIBYq6o4jUTmgXYJt5ug/tfH7ZlPoCDYKBeJPNpDW77RLeLpO
         wuRhdrlCREw/5v5bga7EqnGH6nV8sWLjXP4uINgSHD2/e3dfwDTIdQf+qnK/kB7QlU1W
         miJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQaIP8214td2Fw8zqpizBbZjrLunzVtr25D3aarGH/c=;
        b=J17i2mCJiWOg3V+NL+p/v7SWZZ0crdWw0BwVD5DFnPfTUPjJe0gVrGDIm1v83YWI2v
         adWuOyL0RGI70LymPzrKRwzWGwYseLLB6UBNwfdhDRcwPrncb6wUARRo5eM95AbNYVNH
         389rPPTjB+8N7BRB2Q/wjSnT8sK2XtiWBqeJYdrbZAGutjGNl3al/6cM/5rUi4B6nl4N
         hGUKQjROuaCq3K61gIC8yzdpe+Sygfo5Vo+Quri4LGxVdinuwUS+Y/DcBnecTyCDbu81
         vOX8dpcG4xwG63sp8NkWsQEk6W9PaqBX+v1QJ+lJTz+CD7ujEBx8u/29rkCo+s1fH/r3
         vWiA==
X-Gm-Message-State: AOAM5321/lb0xDQfnrmGT/jDdMAnBuvzjGUHgLNG1M31D1EBoGf6bllC
        rC26/OplMvlaw609y4sU+s3z1xMqeYfhNeKGDzLCug==
X-Google-Smtp-Source: ABdhPJzvK9Qa8Wi48Cr0SpbjxsdBDEFBfT9XJP++rHDi0B72CsYsRdTUELd9Ae81QmUcqO3NCJZduJ8DyWwAkmmHd4A=
X-Received: by 2002:ac2:46d4:: with SMTP id p20mr7102013lfo.299.1608584576264;
 Mon, 21 Dec 2020 13:02:56 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com> <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com>
In-Reply-To: <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Dec 2020 13:02:45 -0800
Message-ID: <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
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

On Mon, Dec 21, 2020 at 12:06 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Shakeel Butt [mailto:shakeelb@google.com]
> > Sent: Tuesday, December 22, 2020 8:50 AM
> > To: Vitaly Wool <vitaly.wool@konsulko.com>
> > Cc: Minchan Kim <minchan@kernel.org>; Mike Galbraith <efault@gmx.de>; LKML
> > <linux-kernel@vger.kernel.org>; linux-mm <linux-mm@kvack.org>; Song Bao Hua
> > (Barry Song) <song.bao.hua@hisilicon.com>; Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de>; NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > <akpm@linux-foundation.org>
> > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> >
> > On Mon, Dec 21, 2020 at 11:20 AM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > >
> > > On Mon, Dec 21, 2020 at 6:24 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> > > > > zsmalloc takes bit spinlock in its _map() callback and releases it
> > > > > only in unmap() which is unsafe and leads to zswap complaining
> > > > > about scheduling in atomic context.
> > > > >
> > > > > To fix that and to improve RT properties of zsmalloc, remove that
> > > > > bit spinlock completely and use a bit flag instead.
> > > >
> > > > I don't want to use such open code for the lock.
> > > >
> > > > I see from Mike's patch, recent zswap change introduced the lockdep
> > > > splat bug and you want to improve zsmalloc to fix the zswap bug and
> > > > introduce this patch with allowing preemption enabling.
> > >
> > > This understanding is upside down. The code in zswap you are referring
> > > to is not buggy.  You may claim that it is suboptimal but there is
> > > nothing wrong in taking a mutex.
> > >
> >
> > Is this suboptimal for all or just the hardware accelerators? Sorry, I
> > am not very familiar with the crypto API. If I select lzo or lz4 as a
> > zswap compressor will the [de]compression be async or sync?
>
> Right now, in crypto subsystem, new drivers are required to write based on
> async APIs. The old sync API can't work in new accelerator drivers as they
> are not supported at all.
>
> Old drivers are used to sync, but they've got async wrappers to support async
> APIs. Eg.
> crypto: acomp - add support for lz4 via scomp
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/crypto/lz4.c?id=8cd9330e0a615c931037d4def98b5ce0d540f08d
>
> crypto: acomp - add support for lzo via scomp
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/crypto/lzo.c?id=ac9d2c4b39e022d2c61486bfc33b730cfd02898e
>
> so they are supporting async APIs but they are still working in sync mode as
> those old drivers don't sleep.
>

Good to know that those are sync because I want them to be sync.
Please note that zswap is a cache in front of a real swap and the load
operation is latency sensitive as it comes in the page fault path and
directly impacts the applications. I doubt decompressing synchronously
a 4k page on a cpu will be costlier than asynchronously decompressing
the same page from hardware accelerators.
