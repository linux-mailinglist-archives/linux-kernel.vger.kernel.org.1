Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631602C1ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgKXHZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbgKXHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:25:44 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909FCC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:25:44 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id o24so20853024ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7wcsVmiRBzdbzaU1jn2/D4v2W6wjtxUE3QJby9ONMo=;
        b=TI1qEy3TmyLIzdKNdJQqeiqUMl+2ELnq3995chqivPaCfj/AzhaKQ+2bIqEmn9sxy8
         z0YAtzsPF5XTcrRhQA+dIpONHcVgDybgufVR0123dzPsZB0K5a8zKSbMjCp3dBAMVdz8
         qIBxDVo6WQz/LlL+YPoMbaWnug+TJfBTk0es6P72sznSVQnOIILfWRNOU99HrCWhuBgR
         602f2fTKn4Cse62ikNeOCdK8TvLEWJh9EBmw3xh5GloadBKmmCpn5hR4SuBxjCfDbi8E
         q95ub1mUdRvnIs+qIg1wEkdX699lQEAyFKH67Gvm33GRj6e0tZcAjzmE+RrgTTaxgMpP
         pogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7wcsVmiRBzdbzaU1jn2/D4v2W6wjtxUE3QJby9ONMo=;
        b=OeW6Tv5JqZevwaXNr/B+jWqVNg+hVY791WuC17lWSptjZTJOr8lCZ4xza6WZPsOp1I
         y51HQ6X73Xl5fbJfT/LkhFwvQ0R4+McBTREyBMR6X+LggZYboFywLPodzoY5rctUP7zA
         K90UQJVaIA5tBihiZ8PQgTx7gZUquO9kZifMmH2S7B/b/rec2102nYT9fmP46ZfyBRG7
         tV3C0JV7MdFlFcptcmVf+GMryT+dVT0lazciLVq+NqW7o1Rt3nRYa1xkI/RgV+DSS9Ee
         FxO+xLyXN2Lw3DZVwGiBKj6ztQo0mAyuII2r4+Akcfw/sh/dLmJHC92b8tBToLDrjS83
         /9mA==
X-Gm-Message-State: AOAM532C6vqx8a6OUOYc/zJ+3O/14DaHGcRdsGodndpI/ROOhspxTR0L
        FF6s/pGq65Rf1S1tW/65wH3FPRtIQut8aNnk70t5qA==
X-Google-Smtp-Source: ABdhPJyUBQdiFImnRxdqaR3qJ7rkDjgJVrH1lMWvXVptsR0064IC5JnBZyuU/OCbvVnd19TaTo3BuNVsIX88yf/i3EA=
X-Received: by 2002:a2e:b54b:: with SMTP id a11mr1355573ljn.40.1606202742772;
 Mon, 23 Nov 2020 23:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
In-Reply-To: <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 24 Nov 2020 15:25:30 +0800
Message-ID: <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
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

On Mon, Nov 23, 2020 at 9:08 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 17 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
> > On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> > >
> > > Implementation of support for parameterized testing in KUnit. This
> > > approach requires the creation of a test case using the
> > > KUNIT_CASE_PARAM() macro that accepts a generator function as input.
> > >
> > > This generator function should return the next parameter given the
> > > previous parameter in parameterized tests. It also provides a macro to
> > > generate common-case generators based on arrays. Generators may also
> > > optionally provide a human-readable description of parameters, which is
> > > displayed where available.
> > >
> > > Note, currently the result of each parameter run is displayed in
> > > diagnostic lines, and only the overall test case output summarizes
> > > TAP-compliant success or failure of all parameter runs. In future, when
> > > supported by kunit-tool, these can be turned into subsubtest outputs.
> > >
> > > Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> > > Co-developed-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > [Resending this because my email client re-defaulted to HTML! Aarrgh!]
> >
> > This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
> > both worked fine.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> > Tested-by: David Gow <davidgow@google.com>
>
> Thank you!
>
> > Thanks for sticking with this!
>
> Will these patches be landing in 5.11 or 5.12?
>

I can't think of any reason not to have these in 5.11. We haven't
started staging things in the kselftest/kunit branch for 5.11 yet,
though.

Patch 2 will probably need to be acked by Ted for ext4 first.

Brendan, Shuah: can you make sure this doesn't get lost in patchwork?

Cheers,
-- David

> > -- David
>
> Thanks,
> -- Marco
