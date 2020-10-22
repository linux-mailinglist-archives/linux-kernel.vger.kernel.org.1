Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7232964E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369787AbgJVSyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902353AbgJVSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:54:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD35C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:54:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e10so1739268pfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kgzi+g1ki8/8D0IVfdBW9d0VukE2gz0oMmxOEAh2jy0=;
        b=RLsEyXfQqINT56bd+1ghDSJy/112xAsquJHcPYpL8rpw6gfrYXws7WLQf3HRsb46HW
         9kfE6Ss/NsZd/+pqBGNuDdOBEGOo/tJ99p/1P3aylPmASezmvMrXGj5x/yVHwUK74P20
         LevQtLmGQcK5svBypPaci4LQCMU1uVX0SoMO/R+SFiMvqkAbMJXvYj/jyIaHcbo2oDbK
         70AzOyunOzKb1tUQAyuqIuddZCw3KA/2dzhUt4+oRm9pcAFz4z4XxHnYjn6DngMvO6v2
         67MUAdJ0k4cubC08bM79nUadhQzqwqqZNSvhnKQV1NcGaKJDuG/WO8bQldQsrBtvCy4z
         l+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kgzi+g1ki8/8D0IVfdBW9d0VukE2gz0oMmxOEAh2jy0=;
        b=Aqihi/dI58EPUq1eMB5ScBpXQ58GVJXgn8xtatC07Ig8aB9R4P/8OBwcky4QYagcG4
         sOkzYLXSuqB6TsuE2FmCj6L9pKdl6Uv5DtdV2YCBztgVfj4aZEjStphI5qrPAZEHl9AP
         6hEl0jesHfqKywY6kxUFlagpvQgjf5TuMsyAwLn4c5EekP5tLnM/dhFcqDJMT86P/A+9
         oFY6fLV49pwH14ab00I9opUugD16Gyj+qgfLRrorVjLG/yXe0wF5J0zP5QeZae5l52ox
         4lfJIk2GKKL4D4oRc9kMUbNf883gAKYEbD2XZG6KXC10u2DNqHBt38jLXLiHM1Lo143I
         vJQw==
X-Gm-Message-State: AOAM5324w7+9hfqS8hNGVl6ujTAAxp0qtAqXO44Kp76FLsoUUEy1dhI/
        K/BOsvg2BwArrFzsmAV5eTWeHfm0RydswKRD4AdIYQ==
X-Google-Smtp-Source: ABdhPJztuiJc4LFHMI3/T4e2afibm+hWy2ErB/jBpMUMTHX73yqhbl+YzrOi/hNiNzxGw6rXhip6gAwQJy45WiGD7GY=
X-Received: by 2002:a17:90a:3e4e:: with SMTP id t14mr3665884pjm.217.1603392841690;
 Thu, 22 Oct 2020 11:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com> <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com> <20201022150648.GH4077@smile.fi.intel.com>
In-Reply-To: <20201022150648.GH4077@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Oct 2020 11:53:50 -0700
Message-ID: <CAFd5g45o2G-bUvHNk2ehNuCsK6zVjN+rp88TyNmuJpfLbQi07g@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
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
> please update documentation to cover issues that you found and which motivated
> you to create these test cases.

I don't entirely disagree; leaning too heavily on code examples can be
detrimental to docs. That being said, when I use other people's code,
I often don't even look at the docs. So, I think the ideal is to have
both.

> Summarize this, please create usable documentation first.
