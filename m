Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7252F2C90EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgK3WXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbgK3WXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:23:14 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65739C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:22:34 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v1so473062pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BCfceYCUFklibw9iNkTt59HaVog15eTd5t3bjImEAQ=;
        b=k/30DKaxucqttsaNv21BmbQpUbdkRX7IMney19Y1tduMHegrd/CAjDqpTb9VTFLiSc
         JqiSt1G74qTGBZcEKSlxJ3gJK12B3E3iHH2TkQ386cz2gWsDVBigYwZFoef+nSblQlY7
         vIjHZZOj2b+qYVwg/ALqtsiYPXxaMndHgWKkyqKNkkUHOY8rTSZnXReUBjG0DsTxevL5
         GAx6LHBjgvSZcDtU9E+J/BDB76C5mmp4rEuUJfLwxLF0W9SH4BjGOb/2GUKNsqowvZfX
         9qfR75HzCN2naDEWguSo9CMRLL1bN2myTp7V7364O6gnZ9SkzLRpu782zs587e5todSD
         IosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BCfceYCUFklibw9iNkTt59HaVog15eTd5t3bjImEAQ=;
        b=LzHatm+Y+thm/UUyC3Wb3fQNW+UCNWfKQ37Evm5DVkJ88ZucVrxN7wZAZ0uAjJ9nxG
         N0K3sYC0Tuosng1gr5dZPm3DQm3xIELySPh3X9P1Ik2TSFif67jnM8jp2GViY8FVKcW2
         d9bc2FEpAGSIIzOyDkCZC8ZcHwGGWdFg0ttib61cBHsr9qyN6V7+5PQU4Giyz6lrsXH3
         W6m6KsjuMeSMM6UbZ4xydX0FGIoWhgWEBKPMyQark4KvFFn8vRPWCeKNXgtXCUp2f3O6
         2YMA4vn3ARn/Y7bU1d09cQ2qxBtuQwlH2K2b5uf0vGF6edwMtTR1s08jTLTe4uVlhDeX
         WKxw==
X-Gm-Message-State: AOAM530/QKG+cI6QgSENNj+pVK+5avUjYGkCOTcNgd78CCdu91l/q1WL
        kFwZTD1IY5n/jdIX+jGEoEkgWVVOCeCqx5GiBh+Nnw==
X-Google-Smtp-Source: ABdhPJymnzMjQYaV36tfcsaWeQNndkZiyZt8GSPuPs9LDVcg2/Mtb4fw9vRNDoGfuR+OgWdHmwqJAxuCgSpXcv55qPY=
X-Received: by 2002:a17:90b:3658:: with SMTP id nh24mr1090414pjb.80.1606774953049;
 Mon, 30 Nov 2020 14:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com> <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
In-Reply-To: <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Nov 2020 14:22:22 -0800
Message-ID: <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:25 PM David Gow <davidgow@google.com> wrote:
>
> On Mon, Nov 23, 2020 at 9:08 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 17 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
> > > On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> > > >
> > > > Implementation of support for parameterized testing in KUnit. This
> > > > approach requires the creation of a test case using the
> > > > KUNIT_CASE_PARAM() macro that accepts a generator function as input.
> > > >
> > > > This generator function should return the next parameter given the
> > > > previous parameter in parameterized tests. It also provides a macro to
> > > > generate common-case generators based on arrays. Generators may also
> > > > optionally provide a human-readable description of parameters, which is
> > > > displayed where available.
> > > >
> > > > Note, currently the result of each parameter run is displayed in
> > > > diagnostic lines, and only the overall test case output summarizes
> > > > TAP-compliant success or failure of all parameter runs. In future, when
> > > > supported by kunit-tool, these can be turned into subsubtest outputs.
> > > >
> > > > Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> > > > Co-developed-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > [Resending this because my email client re-defaulted to HTML! Aarrgh!]
> > >
> > > This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
> > > both worked fine.
> > >
> > > Reviewed-by: David Gow <davidgow@google.com>
> > > Tested-by: David Gow <davidgow@google.com>
> >
> > Thank you!
> >
> > > Thanks for sticking with this!
> >
> > Will these patches be landing in 5.11 or 5.12?
> >
>
> I can't think of any reason not to have these in 5.11. We haven't
> started staging things in the kselftest/kunit branch for 5.11 yet,
> though.
>
> Patch 2 will probably need to be acked by Ted for ext4 first.
>
> Brendan, Shuah: can you make sure this doesn't get lost in patchwork?

Looks good to me. I would definitely like to pick this up. But yeah,
in order to pick up 2/2 we will need an ack from either Ted or Iurii.

Ted seems to be busy right now, so I think I will just ask Shuah to go
ahead and pick this patch up by itself and we or Ted can pick up patch
2/2 later.

Cheers
