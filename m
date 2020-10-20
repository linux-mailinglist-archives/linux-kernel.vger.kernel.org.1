Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD1294046
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394498AbgJTQNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394489AbgJTQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:13:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DCCC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:13:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b8so4221842ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaxRi7kvLJ1FskAsBPACru6r029rXEomACB+lv9Amw4=;
        b=H6B1qgktg82wnkl+cqaDJxP6x4cwURPzrKMC2/ZRrfV7jmpUXZVjsxoNuPjLXYE5gv
         MRY3sOsHBClN5xYEmq7QiZAgyFKmQvRmA2vghUiXlxKfkhNqp23TOn/oHwY6ApVFC4ai
         xRIDXhzLA3PFm1QkE42bJAeSWkQwRlgZu3ObCxLWCWhmRzPMZNyx0Vndk1EO471xelCj
         Q5xotjOPGRnbYA5hLpjmsz7uuTxs5b1P8FR99/2iyKzrTm39eOkBzBPTQmXbYUjXAQEU
         GQzlqlGp1FUVuudby0dvbb4U9yh9NqtVSd25D1CmS9sC4hmzTKd3Q32ScK8evBykBxEI
         p8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaxRi7kvLJ1FskAsBPACru6r029rXEomACB+lv9Amw4=;
        b=iBUTr1aQBUOerhQE+h49e0336eZgOvTYBoQ8M2J9E+s6Naz7LDjbhlHbdS9hysom65
         p6JiVsZek2JUZxdLq06Xwl5WyEcQ7lMFDk5NbPiV03xKoOG4GcJ6L/gLycia7jS7DIHo
         9WAYmSWuPFsTg4TeUFYNjO1WyIw8mZtlw42336SrszuK/4fLEt0l5lCpcrak0Z6A33Dm
         rsRe0H0LM8cNkq1SgyHO9D/bgS17rvd6tZr53IrghMfq7QHE5Yzrp+/sh4BHDKyUTfld
         a/X+LhxXSFnr9eWT4JOYz7KtC+2i3Kx+lL16nyKaduAc/HSx+3GvU2v2je2BQ+RQ0H/m
         vO9g==
X-Gm-Message-State: AOAM530mim2Yct90jx/q5afDQAbCt7z7tpWO+/08ATH5GqzBTsWcdL4T
        JKC92wSippoMZLUILbOAMdNnTDJCyQ/l5qeac0cXNw==
X-Google-Smtp-Source: ABdhPJyr5FuIimEj3h/NbXNgXiQl7kbObhHVPO2vIADQz81HzFwgSvEapxqytCPNdPED3Ofk7V1LQWRF/FPZS5eY4HQ=
X-Received: by 2002:a02:a60f:: with SMTP id c15mr2775749jam.48.1603210412874;
 Tue, 20 Oct 2020 09:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com> <20201020080943.GY4077@smile.fi.intel.com>
In-Reply-To: <20201020080943.GY4077@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 20 Oct 2020 09:13:21 -0700
Message-ID: <CAGS_qxpPJJXa_fzeaapyAwjWKFdyzHgN7ZZgLE5V=6YR5VD1Sg@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 1:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 19, 2020 at 03:45:56PM -0700, Daniel Latypov wrote:
> > Add basic test coverage for files that don't require any config options:
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
> >
> > These tests aren't particularly interesting, but
> > * they're chosen as easy to understand examples of how to write tests
> > * provides a place to add tests for any new files in this dir
> > * written so adding new test cases to cover edge cases should be easy
>
> Is documentation not enough?
>
> I have recently wrote my first KUnit test and I found documentation pretty good
> for the start. I think we actually need more complex examples in the code (and
> useful).

I should have been more clear.
The documentation clearly covers the mechanics of how to set up a test
suite with some test cases and KUNIT_EXPECT_* calls.

But it doesn't provide much guidance in the way of _how_ to structure tests.
Or how to use more advanced features, e.g. there are only two files
tree-wide using the _MSG variants of macros:
$ ag KUNIT_.*MSG -l --ignore include/kunit/test.h
fs/ext4/inode-test.c
lib/bitfield_kunit.c
(And both happen to be written by people working on/with KUnit).

While the _MSG macros are not perfect, they add some context when
calling KUNIT_* in a loop.
I already see some tests merged that probably would benefit from using it.
Considering the perspective of an outsider whose change broke one of
those tests, they'd need to first edit the test to add more debug info
to even understand what failed.

But I can see a case for mentioning the _MSG variants in the example
test or Documentation/kunit instead of this patch.
There doesn't seem to be any mention of them at present in the docs.

To put it in kunit_example_test.c (and have the value be clear), we'd
need something like
@@ -27,6 +28,9 @@ static void example_simple_test(struct kunit *test)
         * behavior matched what was expected.
         */
        KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+
+       for (x = 0; x < 2; ++x)
+               KUNIT_EXPECT_EQ_MSG(test, 42, myfunc(x), "myfunc(%d)", x);
 }

Using and testing an actual function like gcd() et al. felt a bit
better than adding a trivial function there.

>
> So, I'm in doubt these test are a good point to start with.

If the above still seems too contrived, I can take a look at where to
update kunit/usage.rst instead.




>
> --
> With Best Regards,
> Andy Shevchenko
>
>
