Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353E2303E66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391907AbhAZNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391624AbhAZMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611665098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNJERmT7Vuz6QxflZTnA+auIcqBlbQ/3RdflYOHk/Tk=;
        b=ITlDy8fEY8yrxCCmqQq5zel1zkmrbCy8mlKTSWoyJ26O/DQp40o2f5uVNV+iUp0A7H733H
        GBkVmZSE4JjqzqbBPN3uhtcxQiKrENcbYPPSV58erinhwymwAeKHWUhDl42BZEnvOf9uwU
        epwNoU3ndf2ruv53QCnkHrgWBbBoWWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-1zGM5JogMHa-VFnrsMalzQ-1; Tue, 26 Jan 2021 07:44:56 -0500
X-MC-Unique: 1zGM5JogMHa-VFnrsMalzQ-1
Received: by mail-wr1-f70.google.com with SMTP id l13so11031546wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNJERmT7Vuz6QxflZTnA+auIcqBlbQ/3RdflYOHk/Tk=;
        b=OmSwtwdu9oUUZur5C9zjcsVO95RhYxUsjCaN7Z3Bu4+8wDqWlUfh1852J3KXJrJVet
         KMBTzACTrUgbh/UunYR+ltmU44NG1x8TbdYzibOGXISl1SOR8xi6I9yaW7PZV6Z7+zbx
         b1WhimKEM+Ruk+WB2Q1U42qw2hJKlxYfoVvFxtS305sKM7LzdTw43UL7woZy9eCbtqyc
         PnxfdBZkIzvFraqpGsUYw2hBJkbSd/XAqSdzDc/+/jBzwPGZJEAG9c7iHlPs2nJSgAtm
         gbZ5kFe862qaQBIusiF4HOoG0F/XqdQ4VKcS/vjMOedC+0keQHQjpI+cRQVpSpRUQIjh
         9G9A==
X-Gm-Message-State: AOAM532UXjOJOSFm3wWh67yBeImiOTZuiARXuDboOYeA8233UW6E+3ym
        C3VVzwqmdEli/3CpcuYt8ndAe6ZH6mAwYWVaEIwZ4PmXK5vWDigB9sVg6xEaeg5ziXDxkmYi8YJ
        ImA6Puob/ZngOT4BJyA5uka+DqSkpcE6Lt8QMbxfb
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr6052889wrd.33.1611665095174;
        Tue, 26 Jan 2021 04:44:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwidMAkaJwMIbKsfh4oZmDF/v+rGyEjI2VgDeYGU4BuvgYrjHrnFErK1GdiavCeAFABamnHBsxDCBqo39sR5jg=
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr6052870wrd.33.1611665095013;
 Tue, 26 Jan 2021 04:44:55 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <CAK7LNAS=uOi=8xJU=NiKnXQW2iCazbErg_TX0gL9oayBiDffiA@mail.gmail.com>
 <20210125212755.jfwlqogpcarmxdgt@treble> <CAK7LNAS+EG9doX3qUmu4M3=mRNmdybSv4180Xnuubiwmsq0Agw@mail.gmail.com>
 <20210125220757.vxdsf6sttpy46cq7@treble> <YA/PLdX5m9f4v+Yl@kroah.com>
In-Reply-To: <YA/PLdX5m9f4v+Yl@kroah.com>
From:   Justin Forbes <jforbes@redhat.com>
Date:   Tue, 26 Jan 2021 06:44:44 -0600
Message-ID: <CAFbkSA0m1pqmXh29j6wJ9fG05yC72T1kNC0QU3rF7Oh2NoMwYQ@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Greg KH <greg@kroah.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 2:21 AM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jan 25, 2021 at 04:07:57PM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 26, 2021 at 06:44:35AM +0900, Masahiro Yamada wrote:
> > > > > If people use a different compiler, they must be
> > > > > prepared for any possible problem.
> > > > >
> > > > > Using different compiler flags for in-tree and out-of-tree
> > > > > is even more dangerous.
> > > > >
> > > > > For example, CONFIG_GCC_PLUGIN_RANDSTRUCT is enabled
> > > > > for in-tree build, and then disabled for out-of-tree modules,
> > > > > the struct layout will mismatch, won't it?
> > > >
> > > > If you read the patch you'll notice that it handles that case, when it's
> > > > caused by GCC mismatch.
> > > >
> > > > However, as alluded to in the [1] footnote, it doesn't handle the case
> > > > where the OOT build system doesn't have gcc-plugin-devel installed.
> > > > Then CONFIG_GCC_PLUGIN_RANDSTRUCT gets silently disabled and the build
> > > > succeeds!  That happens even without a GCC mismatch.
> > >
> > >
> > > Ah, sorry.
> > >
> > > I responded too early before reading the patch fully.
> > >
> > > But, I do not like to make RANDSTRUCT a special case.
> > >
> > > I'd rather want to stop building for any plugin.
> >
> > Other than RANDSTRUCT there doesn't seem to be any problem with
> > disabling them (and printing a warning) in the OOT build.  Why not give
> > users that option?  It's harmless, and will make distro's (and their
> > users') lives easier.
> >
> > Either GCC mismatch is ok, or it's not.  Let's not half-enforce it.
>
> As I said earlier, it's not ok, we can not support it at all.
>

Support and enforce are 2 completely different things.  To shed a bit
more light on this, the real issue that prompted this was breaking CI
systems.  As we enabled gcc plugins in Fedora, and the toolchain folks
went through 3 different snapshots of gcc 11 in a week. Any CI process
that built an out of tree module failed. I don't think this is nearly
as much of a concern for stable distros, as it is for CI in
development cycles.

Justin

