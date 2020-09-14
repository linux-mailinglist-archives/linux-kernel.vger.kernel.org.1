Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1807268A65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgINL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgINLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:47:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E80C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:47:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so12408600pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJJFfsXoL3LK4g3p5cL7uzGgHtTaKv/IoQGqOUptDbk=;
        b=LMoGgSjo/62BmNodRWPJOdh8Q7bYP3tBTm1Td+5oc2sRIrUVS6tveSb3pEQ+9NoNMU
         fvMnZkauo2lzC5L+bKV27PfBYAsIAldo0wtm8s4znd1aebcNyMyCWGiEVYMzS7i8bWC3
         i5dCVawJOXVg0YuNR/pjmkLgZMz54RqOVNEjRHvNYTpRlpkeqQF5aqzg4ERgZBifoG7X
         Y4qo/2/M1Ntc37rVLnQVCJuTKcUnr510/+mScEEvSJgMPMtykWDAIAmOge68yAeSbERN
         Jd5kVxs3lzLjFhIpZv8gqRiaXIR76JQSY7fVL0Z5+xYW+LX8O5KnOC/FjhsrmMCyAqxz
         IeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJJFfsXoL3LK4g3p5cL7uzGgHtTaKv/IoQGqOUptDbk=;
        b=UiZLwp6r2/D/GPLYulmsY3xelxEF/mHmOvP1xb28OTzTLKd3S7EYGJuB0ULhrbILKP
         zVd0AUNEnu7WmjSPov0z+BxaGPWXp/Ta37HljtV5oLPfixjp8lad5JwH8BiE2gnNlEVl
         avBYiPWx37ZTOg8jldoFjWObjTDTVjgJCmGBpfEpd8yWD6Ml02+Hv7LssxInSHdhSyUw
         Y1ROphqzVMhv4AHC+v4FhzKSQcaynZlouOtczQRteg5dBdT79jh11iJ1RycPH6gNjpS+
         wPpGEIcvyAdlDzZZRQqMHuzbawu2FtK6mhY8Wjd/E0RvzxLByKkRNehF1GIZYOzdxIx+
         oU7A==
X-Gm-Message-State: AOAM533fAd0v5rTchsb//ujfFPhO461JpXSAK5hxsJlbkqlMR5bz9DSG
        vEF70ikcZ/UmnXOZ92MJjYOJaM5th/ba+GLHq86vYw==
X-Google-Smtp-Source: ABdhPJyjND+eSy82UJKuklU4sT9+Zf+lGuuR32yG+mG5u1LFcj1veM/R7jIcv7XuT1WF8+Qc6dxq4dxdcJqRrMgZJGA=
X-Received: by 2002:a63:3047:: with SMTP id w68mr10335591pgw.341.1600084032707;
 Mon, 14 Sep 2020 04:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200912155100.25578-1-songmuchun@bytedance.com>
 <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
 <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
 <20200914091844.GE16999@dhcp22.suse.cz> <CAMZfGtXd3DNrW5BPjDosHsz-FUYACGZEOAfAYLwyHdRSpOsqhQ@mail.gmail.com>
 <20200914103205.GI16999@dhcp22.suse.cz>
In-Reply-To: <20200914103205.GI16999@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 19:46:36 +0800
Message-ID: <CAMZfGtWBSCFWw7QN66-ZLTb8oT7UALkyaGONjcjB93DyeeXXTA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the
 buf returned by memory_stat_format
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:32 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 14-09-20 17:43:42, Muchun Song wrote:
> > On Mon, Sep 14, 2020 at 5:18 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 14-09-20 12:02:33, Muchun Song wrote:
> > > > On Sun, Sep 13, 2020 at 8:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > > The memory_stat_format() returns a format string, but the return buf
> > > > > > may not including the trailing '\0'. So the users may read the buf
> > > > > > out of bounds.
> > > > >
> > > > > That sounds serious.  Is a cc:stable appropriate?
> > > > >
> > > >
> > > > Yeah, I think we should cc:stable.
> > >
> > > Is this a real problem? The buffer should contain 36 lines which makes
> > > it more than 100B per line. I strongly suspect we are not able to use
> > > that storage up.
> >
> > Before memory_stat_format() return, we should call seq_buf_putc(&s, '\0').
> > Otherwise, the return buf string has no trailing null('\0'). But users treat buf
> > as a string(and read the string oob). It is wrong. Thanks.
>
> I am not sure I follow you. vsnprintf which is used by seq_printf will
> add \0 if there is a room for that. And I argue there is a lot of room
> in the buffer so a corner case where the buffer gets full doesn't happen
> with the current code.

Thanks for your explanation. Yeah, seq_printf will add \0 if there is a
room for that. So I agree with you that the "Fixes" tag is wrong. There
is nothing to fix. Sorry for the noise.

I think that if someone uses seq_buf_putc(maybe in the feature) at the
end of memory_stat_format(). It will break the rule and there is no \0.
So this patch can just make the code robust but need to change the
commit log and remove the Fixes tag.


> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
