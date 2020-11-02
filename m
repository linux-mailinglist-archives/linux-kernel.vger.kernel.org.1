Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C82A2B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgKBNYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgKBNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:24:10 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C915C061A48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:24:10 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t143so3045990oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGM5iJVe1/YS3RI7Ox6P0c/NeEFHo7I8woI64ttdcHw=;
        b=Redsc76//XOqhmrR47LrRhhRKZfVgrPgcKjaj3flUUV05IMeYYgYI96W5nS3FoZvN7
         n0yN3r95mirzqxFiZdIGicTdRpE+APj1YYPKDXlNxKd2lAM4+mMT2WniX47hjE9Yln3I
         Y2p0Ua++jSUdgHYquFbAF5VAHeKUIvWvGxWx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGM5iJVe1/YS3RI7Ox6P0c/NeEFHo7I8woI64ttdcHw=;
        b=qk/IMnZJcOVhxTAR4Sp9YvmntUwTm62RS8bAt0J4lV8j8Ucb7ykqk+tZBMYIWPbQm7
         tiMTpBAFMQMLl+p7cql6iI/P0RTO8Sl/EhULzTtBa5WJbEbdwXKq6oditD9Ti8IDOgX7
         QYp8fmuNRHOghHpCh8uHs/rCE0nHkv3E22o7h7koBMS56E8l/Zwc1BjXzpm/f3V1B76C
         tsKaaaSRsBWoTugblP3lYNcbfdtQcN37lk4xeHCEhV8jW+zi/sH+30XxNmo81VUjBgpC
         lxD2QrVA8QQ+SnfPXyz43gS8avRv81FSOB5GHn/ifWekum4ymWx7LuBsvf1elW0LhRik
         /Udw==
X-Gm-Message-State: AOAM532zo0XNkXS17re9eID3zEq9b5YIqGDgnegrvC+PfQ8/BIue3/cg
        dmTcuADX9uDNDHpcvZHuTeKCVb96K4J9PEOBVoiASA==
X-Google-Smtp-Source: ABdhPJz6z2w7hj9FcAzqiJvVAZYDEwQ1hz51TSyVs1UuhBMkzKJELH0Nji35ZsSbH8nvJRYlHjcaT+TvGc3KsVWMNe0=
X-Received: by 2002:aca:b141:: with SMTP id a62mr9289032oif.101.1604323449305;
 Mon, 02 Nov 2020 05:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20201030100815.2269-1-daniel.vetter@ffwll.ch> <20201030100815.2269-9-daniel.vetter@ffwll.ch>
 <20201102072931.GA16419@infradead.org> <CAKMK7uEe5FQuukYU7RhL90ttC9XyWw6wvdQrZ2JpP0jpbYTO6g@mail.gmail.com>
 <20201102130115.GC36674@ziepe.ca>
In-Reply-To: <20201102130115.GC36674@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 2 Nov 2020 14:23:58 +0100
Message-ID: <CAKMK7uHeL=w7GoBaY4XrbRcpJabR9UWnP+oQ9Fg51OzL7=KxiA@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] mm: Add unsafe_follow_pfn
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "J??r??me Glisse" <jglisse@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Nov 02, 2020 at 01:56:10PM +0100, Daniel Vetter wrote:
> > On Mon, Nov 2, 2020 at 8:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Oct 30, 2020 at 11:08:08AM +0100, Daniel Vetter wrote:
> > > > Also mark up follow_pfn as EXPORT_SYMBOL_GPL. The only safe way to use
> > > > that by drivers/modules is together with an mmu_notifier, and that's
> > > > all _GPL stuff.
> > >
> > > I also think it also needs to be renamed to explicitly break any existing
> > > users out of tree or int the submission queue.
> >
> > Ok I looked at the mmu notifier locking again and noticed that
> > mm->subscriptions has its own spinlock. Since there usually shouldn't
> > be a huge pile of these I think it's feasible to check for the mmu
> > notifier in follow_pfn. And that would stuff this gap for good. I'll
> > throw that on top as a final patch and see what people think.
>
> Probably the simplest is to just check mm_has_notifiers() when in
> lockdep or something very simple like that

lockdep feels wrong, was locking more at CONFIG_DEBUG_VM. And since
generally you only have 1 mmu notifier (especially for kvm) I think we
can also pay the 2nd cacheline miss and actually check the right mmu
notifier is registered.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
