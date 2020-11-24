Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAD2C1F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgKXICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgKXICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:02:38 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:02:34 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f12so7085174oto.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a594DHYDSH28ozJvU6Q2cBNN/U0tDhb9dpOOY+Zf8ek=;
        b=ZLeC2pXRxS7ioJzWcYY9jJ/Np48Q6UGh5Gsvxkyd73LF4tfwf8TLhewXJTemf3Jwxx
         X7jKioju8zjZw6KC2hyAUQh8KdjAn4BYilk4LZ/TOyVQ+LIb/HsCOe7kNkmXNOQO/Uyb
         jyr5vgrWK7sjx0NieksUlsASyKp5d6OXcUEjq6XnPDaVpGoS8nfJdjr4IGJQzY2zI5GP
         z2ItB7Jz1rRzgJpb3exTUoZBnhzLOIGzzVGjfJyrPogi4RD9ZMM16HePxM3y3aKLFRWc
         /mvwIDbPN6GAHDYH+pChgCdXtyxsUGeS1RxxYqjZ6AEiNKpVKwoCrPcQPsFaSR6seUcq
         sJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a594DHYDSH28ozJvU6Q2cBNN/U0tDhb9dpOOY+Zf8ek=;
        b=od/O+ktHmuhCATLtsK/STwLho5ZiKRMIO5FRBlrDmWnBi2iMen7U1kRlN5ScGiisRn
         ibioNiq/jcz40rQixTQzzsTT93ZEXpqO/dL3pNDrYA7c4HAd65ujj/ebHAq34WISIfRH
         zrlmUeeSwesesMRVWXWqDebiNJWJKFnt43iJ4Xp2BIwTW6ZxdmBhcV4Gvr/2/Km8Gs01
         5wrjSAglrr4j2P2kzOTeGq62AVSANGJUf1KlfJWmsMtcxaJyaUEGpxoLuhrnpIc88l3X
         qysYhezpw2Wf3fxlUm9b6mnvPcy6cJDApIjCrMdD8qZBCzpoQw9faUiS8ba/XcAFzB0w
         JLpw==
X-Gm-Message-State: AOAM531O65sHmxTdn9lYGw/sNhFSJ0PNSuxMOlDRhEpj/dXeGXQM8/C+
        YHMNdJIkKSYTkTF52+ARLf+P0MAZC8+5KJt9XA087A==
X-Google-Smtp-Source: ABdhPJyhU4UCNA5E8Kwo//NGX/pFWA9xTcgIEzo/Ro/rMxJ7ogdtEI+hGnzxmYgfdxM9qtIEZmZxaNzNJ3xe/7hYKPw=
X-Received: by 2002:a05:6830:1c76:: with SMTP id s22mr2516951otg.233.1606204953329;
 Tue, 24 Nov 2020 00:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com> <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
In-Reply-To: <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 24 Nov 2020 09:02:21 +0100
Message-ID: <CANpmjNNfNJWJ7avZrRkwvtx2Vv7oR9V8=dmcWW_irotmKWQWGw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
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

On Tue, 24 Nov 2020 at 08:25, David Gow <davidgow@google.com> wrote:
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

Patch 2 had already had 1 Reviewed-by on v3 that got lost. The core
bits of that test haven't changed since then, but I can't tell if it
needs a re-review.

https://lkml.kernel.org/r/CAAXuY3o9Xe-atK0Mja6qXLncUhmmVf4pR7hsANsqaoUX71RXVg@mail.gmail.com

Thanks,
-- Marco

> Brendan, Shuah: can you make sure this doesn't get lost in patchwork?
>
> Cheers,
> -- David
>
> > > -- David
> >
> > Thanks,
> > -- Marco
