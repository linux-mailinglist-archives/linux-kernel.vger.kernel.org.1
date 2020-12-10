Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E762D61C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392324AbgLJQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbgLJQ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:26:24 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:25:44 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id x13so5393863oto.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIX8H1T5vlOhy5P+c3dep3UC5lsSHIUYZ7wdp/u5aJM=;
        b=dqrF4PCXYaQJIYTpF8jNTR7Gi32tmNtFJL8aP/jSV91cL/C89OBVEuz9IRiBfjoEjq
         J0hf4ZN7He+rh+osgU70Lhi7J5IkEnqgkRkPLcWNe5Qq6mccSvIRDm5H7KHvlnnX08+X
         6giihla2aiJDacVzBXxrGMmD5GHs3Dic9GYcEe3EFc+CCeJXJiKi5QbXdfM9R8phSa+u
         4mTAYhYB7wCCTulAnQgyNDmLIHbd9vLVLxu3EvnBWmbreNl0yD7/9uClv0JRGXvw+xCW
         ATae53rfvEBRP4cFO8o9kq2mOr1NJ/pQf5aHNQhyE6vaCsbYqFjMjthWJ6OOfGerD/sn
         FQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIX8H1T5vlOhy5P+c3dep3UC5lsSHIUYZ7wdp/u5aJM=;
        b=I6zcgC1894sq1FTXT11N8vCEmFCqY9f9FAEb1HxPUGRkVznk1aO6fxE6rymcFuqJiu
         lsDvk4TZ/4dUSTdc+6ZJOKTd8oNzMCOY8OrEAViT+C+JL6BfVTrDLJZLTCSS7UfDGF99
         GfrtXz6p2OCvr7K0lfLytRGZVrS75KIjsaCfIyWuDo5fVfp4Pietl+C2DmEjunOjKIi/
         /3NFVsAhxehZT70B3wHyV+9Ba9HME8765DtdDcFiTmKkBL+1snnIXe1dodd6QcvJIuRO
         zNzhZ6/g42YLRRE+5UhDUStNAaPOVKkX3GEgIZu+3d1IWm3cUq9dEDGW5oChtqy8B/5e
         7LmQ==
X-Gm-Message-State: AOAM5338XnfWDNcp4VmJyOEqjLRxVhYH35n0xOU4HfIj2ZxeA3/YOoO2
        jIR4tso4EPzvN8EyGRFN4zquRIaP++8W6v81+3ONXQ==
X-Google-Smtp-Source: ABdhPJxdkFivw9jbb4XaFzRCxiFNzpjjfYvTL/nlcdoNks1vm3VExyWLwZQosejcTlGadRvr52FR+FcB/eW6cCumtEU=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr6466658otn.233.1607617542402;
 Thu, 10 Dec 2020 08:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
 <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
 <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com> <CANiq72kwZtBn-YtWhZmewVNXNbjEXwqeWSpU1iLx45TNoLLOUg@mail.gmail.com>
In-Reply-To: <CANiq72kwZtBn-YtWhZmewVNXNbjEXwqeWSpU1iLx45TNoLLOUg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 10 Dec 2020 17:25:30 +0100
Message-ID: <CANpmjNN3akp+Npf6tqJR44kn=85WpkRh89Z4BQtBh0nGJEiGEQ@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 at 14:29, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Thu, Dec 10, 2020 at 11:35 AM Marco Elver <elver@google.com> wrote:
> >
> > It looks like there's no clear MAINTAINER for this. :-/
> > It'd still be good to fix this for 5.11.
>
> Richard seems to be the author, not sure if he picks patches (CC'd).
>
> I guess Masahiro or akpm (Cc'd) would be two options; otherwise, I
> could pick it up through compiler attributes (stretching the
> definition...).

Thanks for the info. I did find that there's an alternative patch to
fix _Static_assert() with genksyms that was sent 3 days after mine
(it's simpler, but might miss cases). I've responded there (
https://lkml.kernel.org/r/X9JI5KpWoo23wkRg@elver.google.com ).

Now we have some choice. I'd argue for this patch, because it's not
doing preprocessor workarounds, but in the end I won't make that call.
:-)

Thanks,
-- Marco
