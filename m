Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0028E355
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgJNPbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgJNPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:31:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEBEC061755;
        Wed, 14 Oct 2020 08:31:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k1so2416086ilc.10;
        Wed, 14 Oct 2020 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=y6L9dnyH9qjChqMXOLeU2OeYrzI2QqyeRonFJkp6Mw0=;
        b=LEVlwthTSz17/B7pjGComi0D7NiB4aOWa2yhyi0nAKS7Ht+IlrBG4FrqDKEeHbBq2g
         vyXWaEXglf488LQqoBD7Nceghs8WkzUGz3eVpK3cuvY7rHy9ByK6WnorJGb+u4TlNjGb
         KgF+xR6gb6WtUtwv/4ZaZvzR5M9s2fEXkXQLVmEGcmI8bqAxqnUvh77qnzJZrbnylxAf
         QzfG8SgqmjEDhkDcBSsGg69hVcNnEeNhfLlG/e1sdZ7SvaFU+utkUlusw5OIa18bJSzA
         WPH84UctX0DfFAymtc67Ljxu9b/aKJPaJdxluvfR7ZIxVnzEqqOfHt45W1zB63qUM+n4
         MT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=y6L9dnyH9qjChqMXOLeU2OeYrzI2QqyeRonFJkp6Mw0=;
        b=F5gQF/waBKcB2e4U95PtGUnuGyWvfdThT6aMY+Z/LzM0zstiDxxKJ/yX1lBy2x32Ah
         7EsxDHUM0CiVhkN0/HqAzJQHwjUjawSBTG0GvVhGXPUjBY1zLuYdzSZcoiaXBEH9f06D
         R7FMFoLiEA7TUQRn3c54eAeB+n5G1w6WkBzDwFJ3TzPgr+OY3FNf1vfPGv8COIn4ZlZx
         0qxX1O15AYxmZJEUvzqT2yuTBhPAhqa11p1RBBjXFRRNTzmhjjVp6nOWd+9LoVK2WQEB
         QgiD45rsVSTDAEaVpfWw3Rzh4tfgizyn4wXNuy81Si2yx/jfe8YcSXpGUrl2cK47Xr31
         DgPQ==
X-Gm-Message-State: AOAM5305RcemsAeH1qAzxTwRitIT71qCeSFz0zEkpOqfmeMAvtnitOam
        OFtmPan5/P8ECGR1rGUMPPk5DF1ESXnm9ANWx3s=
X-Google-Smtp-Source: ABdhPJzywwnLk2/KInPqkQ+p+k8uxidWq5TG4qXLH4ewxB4lPCqPkD5zL5akFlar1En0dGf3kXolR3yiwoaeS5Cymlo=
X-Received: by 2002:a92:7f05:: with SMTP id a5mr4614410ild.112.1602689510501;
 Wed, 14 Oct 2020 08:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201010215135.GB2666@wildebeest.org> <20201010220712.5352-1-mark@klomp.org>
 <CAP-5=fUT-1-CR-KMMsrpzgw9b3nBooeY05=YU9XKa5enO9SK+A@mail.gmail.com>
 <CAKwvOdnLrgVRmkXLK-OoQsDTcAMZx4RfrTQXEASnJVroAZBdkQ@mail.gmail.com> <f3a1cd68a3f8f83e9e78a6ac1e5b74ceccbdc8be.camel@klomp.org>
In-Reply-To: <f3a1cd68a3f8f83e9e78a6ac1e5b74ceccbdc8be.camel@klomp.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 14 Oct 2020 17:31:39 +0200
Message-ID: <CA+icZUUp3LWYc67E_XNRMQkUtVkmUAv2udZ0tJMvpeRCNnP8yA@mail.gmail.com>
Subject: Re: [PATCH] Only add -fno-var-tracking-assignments workaround for old
 GCC versions.
To:     Mark Wielaard <mark@klomp.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 9:12 PM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Mon, 2020-10-12 at 11:59 -0700, Nick Desaulniers wrote:
> > On Sat, Oct 10, 2020 at 3:57 PM Ian Rogers <irogers@google.com>
> > wrote:
> > > On Sat, Oct 10, 2020 at 3:08 PM Mark Wielaard <mark@klomp.org>
> > > wrote:
> > > > -DEBUG_CFLAGS   := $(call cc-option, -fno-var-tracking-
> > > > assignments)
> > > > +# Workaround https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
> > > > +# for old versions of GCC.
> > > > +DEBUG_CFLAGS   := $(call cc-ifversion, -lt, 0500, $(call cc-
> > > > option, -fno-var-tracking-assignments))
> >
> > Should this be wrapped in: `ifdef CONFIG_CC_IS_GCC`/`endif`?
>
> I don't think so. It wasn't before. And call cc-option makes sure to
> only add the flag if the compiler supports it (clang doesn't and it
> also has a much higher version).
>

I am also in favour of `ifdef CONFIG_CC_IS_GCC` to clearly say this is
a GCC bug.

For the comment something like:

# Workaround for GCC version <= 5.0
# GCC Bug: <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801>

Think of people grepping in the Linux source code for supported or
broken compiler (versions)...
As a reference see ClangBuiltLinux issue #427 "audit use of __GNUC__".
[2] says:
"There's also a ton of __GNUC_MINOR__ checks against unsupported GCC versions."

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/427
[2] https://github.com/ClangBuiltLinux/linux/issues/427#issuecomment-700935241
