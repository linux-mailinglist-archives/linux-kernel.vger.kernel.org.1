Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA82D3627
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgLHWWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbgLHWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:22:31 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1FBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:21:51 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so19235947edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZNiPYw40sliX0Vf+8f1KPJclmOw/mEiiXP4YtA29os=;
        b=cv+f7gaz46kk7+ocM3oe/Fbj9/1I2zmrfAcfNRRUhiAcMaOX/RyI5qDVXBNajsq866
         T7Bf5XKsHfrdiIEy9Ecm6eex7PG20lRkpAd02JCI9Pu4/ZjtEDHhGnxwT1jUuFoASz0H
         COk5A/u261XhJNpyB/xgdw6WEnURwZelkDETT7tEynUoriEpoNIE3KfHlXJ4XcIUVX1l
         nsojHvZjDSetRE8/DhI2ie7yz7F/p2PYGQyt550IL19r9795pYcS1K1gDeeOxs/5jAqg
         27sHcZyUz7F+7bF9ta4sTvzsG+BCu1A/K5tQY1kn9pepIt/2BGjNcM/ACgMlq3tDWQAk
         Gy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZNiPYw40sliX0Vf+8f1KPJclmOw/mEiiXP4YtA29os=;
        b=AKO7f4ga8BZ8lWB0F9gVt1PuqVP1Z4fnmmFDEjTjAKlzaxSGMcd4kvXIudDe7+lRTB
         HCHQ7Jk2xoztxF2GzrhR9vHusSkQWexLOPbM6g98GrmfaDwpla9k08CkHKcZf3O5Rf0G
         TTiOPz5FdAXz/OGqAOCTUe9tshGtD5ER1opoGephthlIIpu54FYIJnP6RN6TImZJZ4Rn
         vqoSw1BPSJhaTQwaS46IDgngZ5uMYOkN41FgWgLvUytdHnR0idMxjkYPNcylNH7VaIzr
         lEksLK9aqnIMsdW531xNY3nX1X3cWE0+bzaqxuZGeqKMJKv0f6Oz9Aivtd2ioKjBCM3s
         Jc6w==
X-Gm-Message-State: AOAM532AQyrhVxEQEUIUSDwgaLy8g6VUvxcZvRa7wsbHQmSks48VdNgm
        lVI2hnzAcZLP5jcxiC8Up2AQqCyPgi/uVVa1oEglxQ==
X-Google-Smtp-Source: ABdhPJxXqQNvQXf//rdUY9kLzwwTupXx80nYQR7XUYVJh3px8dDLa7NIWw5qZWMxmWKdX0nr9dwPX/0pRvtwU4EOoJ0=
X-Received: by 2002:a50:e00f:: with SMTP id e15mr125619edl.210.1607466110060;
 Tue, 08 Dec 2020 14:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20201207225703.2033611-1-ira.weiny@intel.com> <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org> <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org> <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Dec 2020 14:21:48 -0800
Message-ID: <CAPcyv4hwQvPj7BYzzwgp8K_BB=fXmm=pYp7sL42h5OmLnSLvNg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 1:33 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Dec 07, 2020 at 03:49:55PM -0800, Dan Williams wrote:
> > On Mon, Dec 7, 2020 at 3:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> > > > On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > > > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > > > > +                            struct page *src_page, size_t src_off,
> > > > > > +                            size_t len)
> > > > > > +{
> > > > > > +     char *dst = kmap_local_page(dst_page);
> > > > > > +     char *src = kmap_local_page(src_page);
> > > > >
> > > > > I appreciate you've only moved these, but please add:
> > > > >
> > > > >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> > > >
> > > > I imagine it's not outside the realm of possibility that some driver
> > > > on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> > > > it because kmap_atomic() of contiguous pages "just works (TM)".
> > > > Shouldn't this WARN rather than BUG so that the user can report the
> > > > buggy driver and not have a dead system?
> > >
> > > As opposed to (on a HIGHMEM=y system) silently corrupting data that
> > > is on the next page of memory?
> >
> > Wouldn't it fault in HIGHMEM=y case? I guess not necessarily...
> >
> > > I suppose ideally ...
> > >
> > >         if (WARN_ON(dst_off + len > PAGE_SIZE))
> > >                 len = PAGE_SIZE - dst_off;
> > >         if (WARN_ON(src_off + len > PAGE_SIZE))
> > >                 len = PAGE_SIZE - src_off;
> > >
> > > and then we just truncate the data of the offending caller instead of
> > > corrupting innocent data that happens to be adjacent.  Although that's
> > > not ideal either ... I dunno, what's the least bad poison to drink here?
> >
> > Right, if the driver was relying on "corruption" for correct operation.
> >
> > If corruption actual were happening in practice wouldn't there have
> > been screams by now? Again, not necessarily...
> >
> > At least with just plain WARN the kernel will start screaming on the
> > user's behalf, and if it worked before it will keep working.
>
> So I decided to just sleep on this because I was recently told to not introduce
> new WARN_ON's[1]
>
> I don't think that truncating len is worth the effort.  The conversions being
> done should all 'work'  At least corrupting users data in the same way as it
> used to...  ;-)  I'm ok with adding the WARN_ON's and I have modified the patch
> to do so while I work through the 0-day issues.  (not sure what is going on
> there.)
>
> However, are we ok with adding the WARN_ON's given what Greg KH told me?  This
> is a bit more critical than the PKS API in that it could result in corrupt
> data.

That situation was a bit different in my mind because the default
fallback stub path has typically never had WARN_ON even if it's never
supposed to be called.
