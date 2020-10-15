Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE6628F809
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgJOR7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbgJOR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:59:43 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66599C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:59:42 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f140so2986453ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKh+0HzGrAAmsHpcRBa9cGPedjwN4QDV3FOpmLuMWLo=;
        b=nd45TYeMyASH3X2XxyTeQWZp5/vlwX5hzsc+o/t08Q0mcf3EzG7hfRG8B1D71kPDWv
         P4L/Y/FlKsu2tu7Hh7zScMTUyOH5KveObkxyPvPnTPo/3YQGSGWyzfTpdlC9qrqlWW80
         bU3Y+hf6NBmSUxGCm1Ea5ywrqXNTBbup7F7JrkVdmZ9fqWJaNqiiyv6oMVnxA0dD4DQW
         yvRptvHtkPZeT1eKFJzz8kFPSjeuXpok189ISDQrsKGL9r0maF+t4jH6/iC/BDeO+yfW
         0d/IgKhp2D1d8YfF4auBqFG/Y3OYKfTfzC5DI9/wE5eUDaA8XTJjRdP0Wmg7sWGTD/bd
         gHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKh+0HzGrAAmsHpcRBa9cGPedjwN4QDV3FOpmLuMWLo=;
        b=FAJl3SJ0GQB9/45voY3d4MV6fvXvoIlzwye33EXzQz6Z1HMc9rWw468KqRtp83xOhE
         vkESLFH8EdKO1yo9NVDk1+ptpLSC54+pTxNzu500vn/VqjhB/+AmFHh/5dMwjv6w2NMa
         oqvrxRwd76RmvOdCq7OvbosT/sDJYXIFgBkbZoQMbHx4Hl805hyM82OpPClOzcgZsRwi
         +WPV2yHoDQqwyl7MBzAIgcNMISJQ9bcK1NzL7AGCqMrcnHBk00qcTv+YirN4pb8BloFr
         H5HbuD7pLW3a5QAmkyY5cgBPd7TVbkd6bNsx+nAnsF4rfctmlRmBA7US/l+CD/AcmbKQ
         FGKw==
X-Gm-Message-State: AOAM533RAl2rPiGBOg01GkJ8z4GhHq8k4BjxVSccQZG/qRbsWQ4qAVGq
        cAABKzUN3dgYb/+ys45ouay+cupWotTHpz2yf4Phzw==
X-Google-Smtp-Source: ABdhPJwyxXAnCsEWQ2qq755UXIZ0LSyCvR1SxEYGrAYoLnYYwsalh/yzr9VPcTnFL7XmNsATtfKUXWEohcxiY4aMEDw=
X-Received: by 2002:a5b:1c4:: with SMTP id f4mr7199645ybp.205.1602784781497;
 Thu, 15 Oct 2020 10:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201015014616.309000-1-vitor@massaru.org> <20201015174823.GY4077@smile.fi.intel.com>
In-Reply-To: <20201015174823.GY4077@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 15 Oct 2020 14:59:05 -0300
Message-ID: <CADQ6JjVYiDQOJt1apsygEUK=530hfF9V+8QSZ_ntgvwYYoYqfQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 2:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 14, 2020 at 10:46:16PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_list_sort,
> > from `lib/test_list_sort.c` to KUnit tests.
>
> >  rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)
>
> One more thing. The documentation [1] doesn't specify any name conventions.
> So, please leave file name untouched.
>
> [1]: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html

This convention hasn't yet entered the Torvaldos tree, but it is in
the Shuah tree: [1]

+Test File and Module Names
+==========================
+
+KUnit tests can often be compiled as a module. These modules should be named
+after the test suite, followed by ``_test``. If this is likely to conflict with
+non-KUnit tests, the suffix ``_kunit`` can also be used.
+
+The easiest way of achieving this is to name the file containing the test suite
+``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
+placed next to the code under test.
+
+If the suite name contains some or all of the name of the test's parent
+directory, it may make sense to modify the source filename to reduce
redundancy.
+For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
+file.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=2a41fc52c21b6ece49921716bd289bfebaadcc04

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20201015174823.GY4077%40smile.fi.intel.com.
