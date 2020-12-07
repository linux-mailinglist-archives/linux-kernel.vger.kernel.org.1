Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7513D2D1E90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgLGXuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgLGXuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:50:39 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1547C0617B0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:49:58 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so22102363ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSGlDbhidPZDKDk+p1AfcvxJW+DI8YFPrPNCgK1gB9g=;
        b=jQPNXyyXDtq6FwskA2qiUp0rH3o00tsydXaWBYwhxrZzXwg6ROdBBhLAzLLbCOcEKn
         ks/K+L16TbmyD5D1MULfLAEpQ8l3ZHBFiXGQClAhKOKRpOkiXk88WPHTBuTQpDRNVGjh
         vaP7U+dJgj3qF+k5Gce4G3KQ2g3VyV0ttsOgok5JTlKhpS6QooayH9i/4rYhb/YdIxCB
         UE6jCjF0KiykMojJqV3SeOmaY1SC/pShZm3+bxyWl7p518IGZ11PcoDRP68hjib4xONH
         2M8Ii9WyCgcB8iT0jcarECaRrxt0jTam80xcl2NeSbYu4pBrgQ47xkuJfTjedmo0mQZ7
         3WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSGlDbhidPZDKDk+p1AfcvxJW+DI8YFPrPNCgK1gB9g=;
        b=rV5v3eCjGlflZPFZvA+bf4O5MLDNnh2+EZ2NfY/OGmwTelcm3e+TDlHOj2p5hv67d2
         BU57HyA4kFKF1c1umTDxw/q47DLiX6XobkFdHB3skEwrCICYDLizlC6PVH4jUL4v4YNK
         aeRKet8FjhCu25e+NWMSQJxfMmOz8MxSZUgTrqAslxuLOxJHudN+JfOlioLFwnlUtpuK
         JOwDdptubYyBpzJDB1kVs/MxCkuaGg0nPeONOXKaYzbRVyvmjYcdy7X9tDZXFbnPfGV1
         tyONWsNMSjgkg9nhNv5YOjcp8mydccA5q6hfJOM87G+DfzShRy+ZS8guFXthZV+6vv8I
         ZOvg==
X-Gm-Message-State: AOAM530DRB80breJKZBCpaAWtmskPpX1vmdPamB0valQUBq8/euV33SR
        vNcFGGrbKu/m949A6FNfTQ5+LW7XtzX/U8oa/gAF6Q==
X-Google-Smtp-Source: ABdhPJxwpm5K/zyXehTQMTg+eHtWfnno+Tx0iVa9ejlNQ9Q5/asDw3VufhH8JZFSKU2SYGwYJJWlwAAq1y62brv+cIU=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr20931926ejz.341.1607384997566;
 Mon, 07 Dec 2020 15:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20201207225703.2033611-1-ira.weiny@intel.com> <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org> <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org>
In-Reply-To: <20201207234008.GE7338@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Dec 2020 15:49:55 -0800
Message-ID: <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
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

On Mon, Dec 7, 2020 at 3:40 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> > On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > > +                            struct page *src_page, size_t src_off,
> > > > +                            size_t len)
> > > > +{
> > > > +     char *dst = kmap_local_page(dst_page);
> > > > +     char *src = kmap_local_page(src_page);
> > >
> > > I appreciate you've only moved these, but please add:
> > >
> > >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> >
> > I imagine it's not outside the realm of possibility that some driver
> > on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> > it because kmap_atomic() of contiguous pages "just works (TM)".
> > Shouldn't this WARN rather than BUG so that the user can report the
> > buggy driver and not have a dead system?
>
> As opposed to (on a HIGHMEM=y system) silently corrupting data that
> is on the next page of memory?

Wouldn't it fault in HIGHMEM=y case? I guess not necessarily...

> I suppose ideally ...
>
>         if (WARN_ON(dst_off + len > PAGE_SIZE))
>                 len = PAGE_SIZE - dst_off;
>         if (WARN_ON(src_off + len > PAGE_SIZE))
>                 len = PAGE_SIZE - src_off;
>
> and then we just truncate the data of the offending caller instead of
> corrupting innocent data that happens to be adjacent.  Although that's
> not ideal either ... I dunno, what's the least bad poison to drink here?

Right, if the driver was relying on "corruption" for correct operation.

If corruption actual were happening in practice wouldn't there have
been screams by now? Again, not necessarily...

At least with just plain WARN the kernel will start screaming on the
user's behalf, and if it worked before it will keep working.
