Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B672F6758
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbhANRQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbhANRQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:16:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A4C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:15:21 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o19so9107351lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRpbugOzzcD4vWdxqQSiB7WPu9j6z6Mr66iAcSSwJZc=;
        b=YFsUaEXzE7PwG8/PiSPYv+xFcwhW6um3lZ+PQtUVk7nx4B1GE1smOkJPyTLcP8iUKL
         24F+TGLfPFfcEFUEZruZ28RvSZp3DbPwD2BG5twLXzcZp2xHP/pDyV9ItDSp5eY4gSP0
         0G4TsA7FGmmSnnoUN80m74Agih4U2RgekH4+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRpbugOzzcD4vWdxqQSiB7WPu9j6z6Mr66iAcSSwJZc=;
        b=IvNCHvleFzfsXN+mABNTiRc89nCMZ/4kop0KSXceK+vR8Z2c3mpsyXW9XaBXMCEhDq
         bGWctfllftW0lg6njt1e2B2+a2Ru70E4Z60VMT38Kr6j75/W3p/wNcLy7LDC5L/RQPAK
         0ZAmmIppLyhjo8DtmpnF2YTALPhVfSXeQv7MDtfzMkp8OV3GKPVW4SpceRD7tovYF2Sq
         ijJyi14ePepQQ5p4TrwT1E01yuOI+zCCTY8XVysc5xx+w/zSZbeH5PQJbEneRVaOKcTF
         PKjnRswMII+Z9HaVwyZPX3z7I1JbLBvb9wY3E0SH+tWZa6cvk9zvQ7aFNwRf249dr6zk
         QYBQ==
X-Gm-Message-State: AOAM531kA9DaK1VfZPF06RCSwye5LEiN8S6NuMPTW+bCB+OgR/6IcIiN
        hnUzAoK2aGEGMKgHEdRihMjK2apx/B8J14NG1NxQBw==
X-Google-Smtp-Source: ABdhPJw98wVFP/xXJJyWVqxebD2K8/3IKxc6BaafZzZCj+GPq53hclI4p29ibHEaPZZ65JbG9eLIXGPKMIczkIj5qA0=
X-Received: by 2002:a05:6512:2009:: with SMTP id a9mr3491536lfb.575.1610644519634;
 Thu, 14 Jan 2021 09:15:19 -0800 (PST)
MIME-Version: 1.0
References: <4490cb6a7e2243fba374e40652979e46@hisilicon.com>
 <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com> <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com> <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
 <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com> <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
 <20210114161850.zjcfhsgtmojjjqba@linutronix.de> <CAM4kBBKcj+ZVEv8mkh+rWc0xbomKsyc60UNuuRem_iWPf9YxVA@mail.gmail.com>
 <20210114165645.czqpsk3lacmiyiik@linutronix.de>
In-Reply-To: <20210114165645.czqpsk3lacmiyiik@linutronix.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 14 Jan 2021 18:15:08 +0100
Message-ID: <CAM4kBBLqgh=ymq4pg6URB3OhjhRSH3O=4AEMRBuaC3Z0-hZ4Lg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 5:56 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-01-14 17:29:37 [+0100], Vitaly Wool wrote:
> > On Thu, 14 Jan 2021, 17:18 Sebastian Andrzej Siewior,
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2020-12-23 19:25:02 [+0100], Vitaly Wool wrote:
> > > > > write the following patch according to your idea, what do you think ?
> > > >
> > > > Yep, that is basically what I was thinking of. Some nitpicks below:
> > >
> > > Did this go somewhere? The thread just ends here on my end.
> > > Mike, is this patch fixing / helping your case in anyway?
> >
> > Please see
> > * https://marc.info/?l=linux-mm&m=160889419514019&w=2
> > * https://marc.info/?l=linux-mm&m=160889418114011&w=2
> > * https://marc.info/?l=linux-mm&m=160889448814057&w=2
>
> Thank you, that would be
>    1608894171-54174-1-git-send-email-tiantao6@hisilicon.com
>
> for b4 compatibility :)
>
> > Haven't had time to test these yet but seem to be alright.
>
> So zs_map_object() still disables preemption but the mutex part is
> avoided by the patch?

Basically, yes. Minchan was very clear that he didn't want to remove
that inter-function locking, so be it.
I wouldn't really advise to use zsmalloc with zswap because zsmalloc
has no support for reclaim, nevertheless I wouldn't like this
configuration to stop working for those who are already using it.

Would you or Mike be up for testing Tian Taos's patchset?

Best regards,
   Vitaly
