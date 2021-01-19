Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF972FC4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhASXcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbhASX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:28:59 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38757C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:28:19 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n2so26082826iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppNFUDLkhvwlaQPg6siyPxeLAB8qizQSeUojeb9HOrU=;
        b=TVZewjEtoyESZPYnxCRKpHkFeVRlw0bH1Mom5CozNv+9gl7IO/aeV7eiAXaG42MWc1
         cQ4WgZ2Hx0wphYQmrwNEOkLQWibl7nZFbT55QlypCFm+I1DT7BI6DwVm0ldGhNd3vFJN
         cIBG2YsiogRvggUIX3gg2UHaNgKgG+9+d+Cwy6ZE06N0mfL/Yj2nZSe6DtQw+aVMAW2Z
         IPU4Nx5ZE07wAVlljGAIdusCaoJOHmHG7YzXLPmC+j+mhmKdXeThhKQoJbJeZIrt+Nj4
         Q0fnNV2lk5glMkwK92PjIcJhvMqgTxpscGyZ2LySPklc1E47n0Jc7hVTKJb5OHTt8TSP
         tUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppNFUDLkhvwlaQPg6siyPxeLAB8qizQSeUojeb9HOrU=;
        b=qSptK7GhRrasJ4w5KX5Jk2pMYnT5WwV6D+JS1g4d11f4oR8Zefhl2Kr1XpBM911Qj6
         l1ViYCVz7hbk4ODa+RAiU9P65Qpmw9wQ10L0DI+MGgIch6XrdRdiH/0CoXagEXT04tB/
         MxvWov45xDn1GyFFAvJ7qNd1XAd96r9UuFpJc1nI9uwZmgVvLlNvUbwGVClmyI/NM6or
         gPhhp1aYy/LcpmVPMrIuLllQ4EALQV0tN2MB9K+84hhASKuc4TCCxNNpvTSxP4I8jgUT
         CqIAy4KP7DyEnn3HrqHCaUMfs4KXK4KIMKC9lAMkZZ4ANIV+ehOqaESTq1cMtYuzgOJ0
         +ybA==
X-Gm-Message-State: AOAM533beXPaAKKtqaFjRhvL9JReZPej7uc6NtBl+UKMyA0a4SYDj3m4
        VKgJljRSn0W3mMvGBKfO6HqyEIyee+JhyrcNxGzByQ==
X-Google-Smtp-Source: ABdhPJwdMtwY5+ZTKb3YKBTBw+18+KnTl4ewr6eOgpYE/f7uMEjcNcPNiyfeI6tvVO98gafhWgrZSlks1l6PW/NnRAk=
X-Received: by 2002:a5d:980d:: with SMTP id a13mr4752861iol.168.1611098898454;
 Tue, 19 Jan 2021 15:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20210114182700.1298392-1-dlatypov@google.com> <20210118103653.GA4077@smile.fi.intel.com>
In-Reply-To: <20210118103653.GA4077@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 19 Jan 2021 15:28:07 -0800
Message-ID: <CAGS_qxojC-sw7kFdb_rDee9j_P91ccaaYhBY=Mju8i04-g53=A@mail.gmail.com>
Subject: Re: [PATCH v2] lib: add basic KUnit test for lib/math
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

On Mon, Jan 18, 2021 at 2:36 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 14, 2021 at 10:27:00AM -0800, Daniel Latypov wrote:
> > Add basic test coverage for files that don't require any config options:
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
> >
> > These tests aren't particularly interesting, but they
> > * provide a place to add tests for any new files in this dir
> > * are written so adding new test cases to cover edge cases should be easy
>
>
> >  lib/math/math_test.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>
> Can it have _kunit instead of _test?

Sounds good, will send a v3 shortly.

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
