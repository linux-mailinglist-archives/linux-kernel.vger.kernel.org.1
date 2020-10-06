Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1081284365
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgJFAet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:34:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB396C0613CE;
        Mon,  5 Oct 2020 17:34:48 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so11500834qtq.10;
        Mon, 05 Oct 2020 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BC+Sg9HWCWkWpUC1Bzc2G/+Jd/qZ/kelvEvSs6pcygY=;
        b=ibuCy+u5v9dpSLfj0DVMWS2aVgXgFfYmW+QLQ5dkIRbF1qDIy6Knwo0swgB8sAwJU1
         8v3VTWh8RAcxV3imLQ3oc09SZMBU2ooOsr634pzNjjEPweSltVZdWeZ2Q77y/8NQBTfe
         Ypl7bQP00/I88eNQgof4aby7AuiAMutsnVyXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BC+Sg9HWCWkWpUC1Bzc2G/+Jd/qZ/kelvEvSs6pcygY=;
        b=cQHU98oGuKeuobVl7HiHWvGSXLt4fZX0lGbyK59Ojz7nllA7JLKzvYExG2vnwsGfB0
         32rE8gPrYh7yc6lWRjCG4j15Ap23UWUOkW99W4HW7ao7AOLY42wfM6IAOMJ8XDrqRJUP
         SVaI8kd6itx/2QeQIUpxINZEicC3WKf0lM7XxFF+wOfRlStT7NaNHYWNKvSv2+OOmIXV
         bMt9ihhvPtmtRZAjQOSdFY1erW2RYhU1GNRjo7Tdk/jtwfEnOxHsKXu5ajE/96Y+W2h4
         iJp2xneyPllrW+RkHImjk46M1DLT55BwZk8xxsExvY5+y2y8lFkH0MlWpPSwbX6xZnKM
         pi1Q==
X-Gm-Message-State: AOAM5312UXGcOF2jXWfJn1o88Lq4cEdntkkXXRKeu/S4/RhD+9LwACcW
        746QPmFKeNaJKwOdkhEhkQm8G4zprVYmybLjBJo=
X-Google-Smtp-Source: ABdhPJzgP3hgjixz3aD2KNSFT9xsH6N9pOYQ2fTX0rS0HIiHOh5cIG9MdVHCKM+lkeXQGNgCcrV+6WHi4MIcxkqgBFw=
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr2722902qta.176.1601944487836;
 Mon, 05 Oct 2020 17:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200929192549.501516-1-ndesaulniers@google.com>
 <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
 <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
 <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
 <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
 <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
 <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
 <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
 <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
 <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
 <20201001193937.GM28786@gate.crashing.org> <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
In-Reply-To: <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 6 Oct 2020 00:34:35 +0000
Message-ID: <CACPK8XdwX=1T8WrsVYurL+JedEsb1ZTyrWtJXDLXycu-qu4UTg@mail.gmail.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 at 20:19, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-01 at 14:39 -0500, Segher Boessenkool wrch/ote:
> > Hi!
> >
> > On Thu, Oct 01, 2020 at 12:15:39PM +0200, Miguel Ojeda wrote:
> > > > So it looks like the best option is to exclude these
> > > > 2 files from conversion.
> > >
> > > Agreed. Nevertheless, is there any reason arch/powerpc/* should not be
> > > compiling cleanly with compiler.h? (CC'ing the rest of the PowerPC
> > > reviewers and ML).
> >
> > You need to #include compiler_types.h to get this #define?
>
> Actually no, you need to add
>
> #include <linux/compiler_attributes.h>
>
> to both files and then it builds properly.
>
> Ideally though nothing should include this file directly.

arch/powerpc/boot is the powerpc wrapper, and it's not built with the
same includes or flags as the rest of the kernel. It doesn't include
any of the headers in the top level include/ directory for hysterical
raisins.

The straightforward fix would be to exclude this directory from your script.

Cheers,

Joel
