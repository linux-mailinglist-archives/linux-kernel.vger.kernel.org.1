Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F12962A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901737AbgJVQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896986AbgJVQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:26:58 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:26:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y17so2278367ilg.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZFvf3Ldb3rFeZOwf1If8ODWGX8g/S9h9Con/ZQJhTY=;
        b=JtM0iJmE6RRrEXd+MT7jIZKLx0kAkZLPovF2TeerZFALAeroqqLSOZx4PrKi7hUI4g
         0yuWHR4xm/tThpgwo+RNiM8gVwLCvPyEsTLFQfRu3ZKkWLKShfIOoAGQ4n9o/cl3CEYA
         4BwklKnalgc8nHYmDPIvBgR/l97VhTaCwKmwt/58IfI/RFBlrcarYyAr+JOTWMMDI12X
         9i6zmQSr6okD6AsOvbYBJft619i0VdbZWL7pfDFqzj8y/o9fBMiVqZ2VlTYB6rmSHWxj
         170s+EUHyq4tNm5nmLaFUONUYWPbAvnHKBxNj38eR3E6eZdNIaUjFI4CDB8F6Z/WK6g4
         fM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZFvf3Ldb3rFeZOwf1If8ODWGX8g/S9h9Con/ZQJhTY=;
        b=HzhtZebf67I7SoGOLxhEK101LDn8RXL9m4/S40KHy90tVBLCSGEdQicjWvitZ9/oWf
         1LSfY+bTStB72Bl3IhThWY00Hs7VVqu3blLd4cs3X1UTnQJ/Ks/QRvOEMO7RCbtl5WTx
         W/eKHuwiQgiYD6xFxAlj4UxIUKn/GvhcZU/2BXoFvPdhazAKa8DEpYy/U1UViJ6LXQya
         3N8iUC9tbThvZ4q/hdk2YN8lSLSCbjjWeLpp3SAnDDAE7mAZ5TSG69h3luCV8UQR8Wdv
         jWYKSwc1XJSxcpj0GkhuWr+32zd5raSGTtElVo9YJpgeO1vK4a1cIXc4z10ZR2lSzqMy
         QeHQ==
X-Gm-Message-State: AOAM530RemGKdaSs4h82lXODtINopqGVM2MpIsAJj8W7YC6BbXpSBqc1
        PTRBIDokJK7IGJeewLi3f0lQk5hvUt8xDMSA8VMczA==
X-Google-Smtp-Source: ABdhPJw0PaEY23SWooD58Hk6Txf21V5SNFAkA1N1WbunJIPEbRw4F9u/rwglgWIKXyXVJqnuwKqwn0u6tH8TaSTeIkc=
X-Received: by 2002:a92:cf44:: with SMTP id c4mr1547289ilr.110.1603384016294;
 Thu, 22 Oct 2020 09:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com> <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com> <20201022150648.GH4077@smile.fi.intel.com>
In-Reply-To: <20201022150648.GH4077@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 22 Oct 2020 09:26:45 -0700
Message-ID: <CAGS_qxogKfYBr=5jPsON60NTAoqqSK2y+dQodnZ5r0Uo0ecJ3Q@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:
> > On Tue, Oct 20, 2020 at 8:40 PM David Gow <davidgow@google.com> wrote:
> > > On Tue, Oct 20, 2020 at 6:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > Add basic test coverage for files that don't require any config options:
> > > > * gcd.c
> > > > * lcm.c
> > > > * int_sqrt.c
> > > > * reciprocal_div.c
> > > > (Ignored int_pow.c since it's a simple textbook algorithm.)
> > > >
> > > I don't see a particular reason why int_pow.c being a simple algorithm
> > > means it shouldn't be tested. I'm not saying it has to be tested by
> > > this particular change -- and I doubt the test would be
> > > earth-shatteringly interesting -- but there's no real reason against
> > > testing it.
> >
> > Agreed on principle, but int_pow() feels like a special case.
> > I've written it the exact same way (modulo variable names+types)
> > several times in personal projects.
> > Even the spacing matched exactly in a few of those...
>
> But if you would like to *teach* somebody by this exemplary piece of code, you
> better do it close to ideal.
>
> > > > These tests aren't particularly interesting, but
> > > > * they're chosen as easy to understand examples of how to write tests
> > > > * provides a place to add tests for any new files in this dir
> > > > * written so adding new test cases to cover edge cases should be easy
> > >
> > > I think these tests can stand on their own merits, rather than just as
> > > examples (though I do think they do make good additional examples for
> > > how to test these sorts of functions).
> > > So, I'd treat this as an actual test of the maths functions (and
> > > you've got what seems to me a decent set of test cases for that,
> > > though there are a couple of comments below) first, and any use it
> > > gains as an example is sort-of secondary to that (anything that makes
> > > it a better example is likely to make it a better test anyway).
> > >
> > > In any case, modulo the comments below, this seems good to me.
> >
> > Ack.
> > I'll wait on Andy's input before deciding whether or not to push out a
> > v2 with the changes.
>
> You need to put detailed comments in the code to have it as real example how to
> create the KUnit test. But hey, it will mean that documentation sucks. So,

Out of curiosity
* By "it will mean that documentation sucks," do you mean that the
documentation will rot faster if people are using the existing in-tree
tests as their entrypoint?
* What level of detailed comments? On the level of kunit-example-test.c?
  * More concretely, then we'd have a comment block linking to the
example and then describing table driven unit testing?
  * And then maybe another block about invariants instead of the
perhaps too-terse /* gcd(a,b) == gcd(b,a) */ ?

> please update documentation to cover issues that you found and which motivated
> you to create these test cases.
>
> Summarize this, please create usable documentation first.

Sounds good.
I'm generally wary people not reading the docs, and of documentation
examples becoming bitrotted faster than actual code.
But so far KUnit seems to be doing relatively well on both fronts.

usage.rst is currently the best place for this, but it felt like it
would quickly become a dumping ground for miscellaneous tips and
tricks.
I'll spend some time thinking if we want a new file or not, based on
how much I want to write about the things this test demonstrated
(EXPECT_*MSG, table driven tests, testing invariants, etc).

In offline discussions with David, the idea had come up with having a
set of (relatively) simple tests in tree that the documentation could
point to as examples of these things. That would keep the line count
in usage.rst down a bit.
(But then it would necessitate more tests like this math_test.c)


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
