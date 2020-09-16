Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065F26C7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgIPShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgIPShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:37:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:37:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so7960831wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JdUEKJbhGOQtJkj5RkA6Vy6ympc/FtO4ki7TxV0UEI=;
        b=kc7bZ1cVF77sJ9TtX4s+ADzuNPRC85H3VFVtIvjTYXDcqyhH5BpoEjdKpERLMUtkmM
         KFpEbxMwHoi/NKP+/76V6E0BZNOk5BmljSmdV83jfsfOI27csPI49Gaol23fFOrs0F6X
         U0c0xBdZAXeWVC+UNfEATDaKQC9lIvUfMPQSNsfJ7w7ZG4EuJg5vfMk9+cZLpFgJKZy7
         IqUq5BQ2VnYlgbzyKZ3nCmPuZpG/cyWHWaRTEBCbfAZIXT6HhdJHWdfHuVvvgcAIqyhz
         zTi1BAYg148P/YwcQHgkJTPsX9z7QTeZK1NP58sHJHZMDNvqqn+Nd9GmNccgM9zi6zJY
         uwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JdUEKJbhGOQtJkj5RkA6Vy6ympc/FtO4ki7TxV0UEI=;
        b=mTDpQT0uDCpBlWUY53RDgD7Flld3WI1vgI2W6Vlai7N5t5rmQP0NsgYqBSG/SoVV7P
         G5IAb4nA5MV61WblVuueSZ4wlxyCdruEedIJjdyuozcgnLa3KAlLKQ4m/wxu2DjQ4CHS
         9G9mP8Pscw8WrYtSgqmTX7LR7DtAI233u+/Q3+1UAkv2Uh9N7Y/cKgu+poh+tbLwRpcr
         vEWyzrol6rn0h3y8xu0nkZiLEqTDOloJbhc6kzdHqMEmNY+5VHdjB67XLdTlSbKf1ema
         RqrHKfmDA8whXFjSe5qgQMLUk3jVIqOC9SS3brf4/DWQe23BrI0N4b49+9P8jFfdBx3/
         AXmg==
X-Gm-Message-State: AOAM533LW1u7rWu2bPgI9NGH0phxlcgd0OlvEg+fSczuS91R2BS1PNaW
        /TybSey5vZQ/SJSlFeFeIMhwfafNQRIYoeIDMt/HXA==
X-Google-Smtp-Source: ABdhPJwtzbnhI1LZ9zUO4o4QfDzYbn6nFaUwTMYgB2wARoMx/Ri2iwZ2BkhB9EuneX5IZ16rqVYsX1of9VMpku9NCq0=
X-Received: by 2002:a5d:5583:: with SMTP id i3mr27246557wrv.119.1600281439193;
 Wed, 16 Sep 2020 11:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200915031819.386559-1-namhyung@kernel.org> <20200915031819.386559-6-namhyung@kernel.org>
 <20200915121912.GF720847@kernel.org> <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
 <0679eacce01f187037e726a45e6acdacde61f99d.camel@redhat.com> <CAM9d7cgtDq8yOFDEGEdTD9kN=Ko1gX=5o+tAB4+EDtN0WtGQPw@mail.gmail.com>
In-Reply-To: <CAM9d7cgtDq8yOFDEGEdTD9kN=Ko1gX=5o+tAB4+EDtN0WtGQPw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Sep 2020 11:37:03 -0700
Message-ID: <CAP-5=fWr0UVxp+JBcwzPV3=+EuUiBXuzHtaH5+1s1rCQb_dmdw@mail.gmail.com>
Subject: Re: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     David Malcolm <dmalcolm@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello Ian and David,
>
> Thank you for the good suggestions!
>
> On Wed, Sep 16, 2020 at 4:56 AM David Malcolm <dmalcolm@redhat.com> wrote:
> > Some ideas (with the caveat that I'm a GCC developer, and not a regular
> > on LKML): can you capture the ownership status in the type system?
> > I'm brainstorming here but how about:
> >   typedef char *owned_string_t;
> >   typedef const char *borrowed_string_t;
> > This would at least capture the intent in human-readable form, and
> > *might* make things more amenable to checking by a machine.  It's also
> > less macro cruft.
> > I take it that capturing the ownership status with a runtime flag next
> > to the pointer in a struct is too expensive for your code?
>
> Adding more random thoughts..
>
> I think we can make it more generic like __attribute__((owned))
> so that it can be applied to any pointers.  And we can use a
> conventional macro like '__owned' in the declaration..
>
> __owned char *name;
> __owned char *strdup(const char *);
> ...
>
> Thanks
> Namhyung

I have to say I like the idea of a __owned like "modifier" before
these names more than introducing types. David, do you think a patch
with something like the following is reasonable? I'm also throwing
this out there to see if somebody on the linux code side screams and
thinks this is the worst idea ever in existence :-)

compiler.h:
/* In the future __owned and __unowned will be an attribute to allow
static analysis to perform certain correctness checks. For now they
are placeholders to provide documentation. */
#define __owned
#define __unowned
..
evsel.h:
..
struct evsel {
  ..
  __owned char *name;
  ..
  __unowned const char *unit;
  ..

Thanks,
Ian
