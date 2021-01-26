Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED0304395
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbhAZQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391163AbhAZQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611677766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPH6A9X8PrEZD2nbv28DbEJKiNaS6b1xe01NHgW9Weg=;
        b=L6AtRDLMOL+WFJwtEbew0O69CaYxo4PgwhZbDCvMy90vrkz4RyGvkiZ8aY+yUEtFqrd/ck
        mDOByYwHvp8vTxigLXV43+/BFyjyp7Ppk0N4vEU1eYEBrUduMaVwGDH4d1KV2FgTGuU1K0
        9N+IKMrODqQ6+Um2Mi0I4kNmpl+20DM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-LyYib1f1P7K67O9SZjk2lQ-1; Tue, 26 Jan 2021 11:16:05 -0500
X-MC-Unique: LyYib1f1P7K67O9SZjk2lQ-1
Received: by mail-wr1-f70.google.com with SMTP id x7so349828wrp.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPH6A9X8PrEZD2nbv28DbEJKiNaS6b1xe01NHgW9Weg=;
        b=QqyRnh7oH+kbKq1wVvLC+nfeudgfm5SKGH/V06pTMxFtZQBa6eb5PGXDY+WB0DweJd
         nvCM2F884VG2LVMHNf2+uirly8SQQyhuodBj+Zo6sOz0jI+8uBwq1X1kS6FJAcStB9Kt
         MIj0P+gynOU4o7IxpWm4/9E5TpUUUfAlOqrMzbiY0YV6fx0PhwaoX8prGje3xi80Wrke
         S8epa8Z9C7T2foWxcqGUbTVLmIcSjcUX1Z9Ng/Pleg7Zs2xzy+o1dFj/XBWJV7SZoukr
         T3cFDAOvKf939YafUPUM6T+QRvdb+zl6K1Gvni5FfDeoBqkIwSnlq6+JWjnPkH/CKD8I
         9dBA==
X-Gm-Message-State: AOAM531mRkZxH9eS8qhmJN77zi1iXbnid7wsH1zV8WkVJQoF98igEc5Y
        Nu+ZwonwIPkzBihcwH6zeOoN1Y17wEgJBU3Q0MUsMWHQBi3r4eWnRAddO8qyieydUh/B/q+Ud0q
        cV84TyUkBu7omdUX8dn+Zb9P4Ip+kqmMz5DOvTv/I
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr489654wmj.0.1611677763774;
        Tue, 26 Jan 2021 08:16:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFESzJuwOJNgjJnH36tGe1tHaJp46z4ljyXHLxa09sKPjBIoL1bzS4hAc8cAzE4Dsvp0+tYX1jQNuM0msvQIY=
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr489637wmj.0.1611677763530;
 Tue, 26 Jan 2021 08:16:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAS=uOi=8xJU=NiKnXQW2iCazbErg_TX0gL9oayBiDffiA@mail.gmail.com>
 <20210125212755.jfwlqogpcarmxdgt@treble> <CAK7LNAS+EG9doX3qUmu4M3=mRNmdybSv4180Xnuubiwmsq0Agw@mail.gmail.com>
 <20210125220757.vxdsf6sttpy46cq7@treble> <YA/PLdX5m9f4v+Yl@kroah.com>
 <CAFbkSA0m1pqmXh29j6wJ9fG05yC72T1kNC0QU3rF7Oh2NoMwYQ@mail.gmail.com>
 <YBAeYaDReAc9VscA@kroah.com> <20210126145155.kcfbnzfqg5qugvcl@treble>
 <YBAyGU7H8E98xKng@hirez.programming.kicks-ass.net> <20210126154651.itfrnhwfistia3ss@treble>
 <YBA9r13+1uuyDYuR@hirez.programming.kicks-ass.net>
In-Reply-To: <YBA9r13+1uuyDYuR@hirez.programming.kicks-ass.net>
From:   Justin Forbes <jforbes@redhat.com>
Date:   Tue, 26 Jan 2021 10:15:52 -0600
Message-ID: <CAFbkSA1CibJ6sp+LPLy3hpchLLH2B5__Lk31TLeVThXi5eZV7Q@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Greg KH <greg@kroah.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 26, 2021 at 09:46:51AM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 26, 2021 at 04:15:37PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 26, 2021 at 08:51:55AM -0600, Josh Poimboeuf wrote:
> > > > User space mixes compiler versions all the time.  The C ABI is stable.
> > > >
> > > > What specifically is the harder issue you're referring to?
> > >
> > > I don't think the C ABI captures nearly enough. Imagine trying to mix a
> > > compiler with and without asm-goto support (ok, we fail to build without
> > > by now, but just imagine).
> > >
> > > No C ABI violated, but having that GCC extention vs not having it
> > > radically changes the kernel ABI.
> > >
> > > I think I'm with Greg here, just don't do it.
> >
> > Ok, thank you for an actual example.  asm goto is a good one.
> >
> > But it's not a cut-and-dry issue.  Otherwise how could modversions
> > possibly work?
> >
> > So yes, we should enforce GCC versions, but I still haven't seen a
> > reason it should be more than just "same compiler and *major* version".
>
> Why bother? rebuilding the kernel and all modules is a matter of 10
> minutes at most on a decently beefy build box.
>
> What actual problem are we trying to solve here?



This is true for those of us used to working with source and building
by hand. For users who want everything packaged, rebuilding a kernel
package for install is considerably longer, and for distros providing
builds for multiple arches, we are looking at a couple of hours at
best.  From a Fedora standpoint, I am perfectly fine with it failing
if someone tries to build a module on gcc10 when the kernel was built
with gcc11.  It's tedious when the kernel was built with gcc11
yesterday, and a new gcc11 build today means that kernel needs to be
rebuilt.

