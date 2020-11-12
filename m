Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA82AFC98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgKLBkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgKLAvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:51:16 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5089C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:51:14 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e7so2876058pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rS3LSGNvGpE3/HRnihmkueblCSGMw78UyqxkdR2g20=;
        b=CRNOrmU+qtuY/AlNbJys6uKLX7EgbDDTxxfhnITtoGV6w796npdCWg7mhdWJa1Qdsm
         AnxeWZr0bZDpNBhyYM1MBceGAn8vJji+w+WdBgstoXpBkyl1WXHXh1JLr1mgpmhJqJGN
         mEdWlJ/f7odE+I01kdHUu1D4ROSLycHJrtBtDo/ZwN6fAB81QUIWliYlxXcm53lVeY2M
         wMjUm0ZTFzsFQowRgOJOxpBKikCPQWc9Qj0m5bWN0IgGTjMf/UPiUIWVYI9W/Z5JOcXZ
         EVsR8hWxEDrrnXA6AN2Wg6YOUuJ00SUqh86gPJuo6zUCPf0zlpGDm7kpzfiX4IFqFCyn
         LQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rS3LSGNvGpE3/HRnihmkueblCSGMw78UyqxkdR2g20=;
        b=MqYGfuW4AjeMO4D31za/6mrdtw9QCdJxbonhw2lJ8r1lpEx+Jp3sabn1kZv5LFVlJS
         USAzeTf18XOuT/L6Ti42h+2pvkehX++HVGNbMACwjzQdb4WQ3gFNHhhXV9Doo1acp3Gz
         L6OVe+VVQEivio3226nekzTQg77FADrKT6arv5gaZc07G5El4pzZpOg92V0N/sRRtW9L
         GClS/4e2RDa7oAY8bLIazJeCs4CWVG8/Ck2IgqnTKpws5VY7hgoqqV1d9kP3938dC7YN
         1N+1msGcjY7IUMks1nKiTWCg+NFrpXRUZKaE1gs3TeRLsnWVgakZUtrhidibKnQLBORA
         Qv3A==
X-Gm-Message-State: AOAM531e8vZblUmzCCeGnu4Gf2rKmvZAtL+5aF2mXf/ZemHcR4xMA5j4
        J6ia5KGiCebLUTxkJ5ukuS7GS8AGebc6YJuwzxKp1g==
X-Google-Smtp-Source: ABdhPJzNs8ax+ETSNIPfU2+lniSpY9B6zzkq2WqxD013DGY7olztCOFVZ4PMs+nY51fQ1nBKSPv93DP+yVTFBXbboAU=
X-Received: by 2002:a63:4c10:: with SMTP id z16mr24030555pga.440.1605142273809;
 Wed, 11 Nov 2020 16:51:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <6103d1aaacea96a94ca4632f78bcd801e4fbc9c4.1605046662.git.andreyknvl@google.com>
 <20201111160311.GB517454@elver.google.com>
In-Reply-To: <20201111160311.GB517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 01:51:02 +0100
Message-ID: <CAAeHK+xWvHK2SH3ZEqnJ97ArjkuAB4Hrpu34AhQiruUyo1h6dw@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] kasan: update documentation
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:03 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > This change updates KASAN documentation to reflect the addition of boot
> > parameters and also reworks and clarifies some of the existing sections,
> > in particular: defines what a memory granule is, mentions quarantine,
> > makes Kunit section more readable.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  Documentation/dev-tools/kasan.rst | 180 +++++++++++++++++++-----------
> >  1 file changed, 113 insertions(+), 67 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index 422f8ee1bb17..f2da2b09e5c7 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -6,6 +6,7 @@ Overview
> >
> >  KernelAddressSANitizer (KASAN) is a dynamic memory error detector designed to
>
> s/memory error/memory safety error/
>
> to be precise and consistent with various other docs and literature we
> have, if you deem it appropriate to change in this patch.
>
> >  find out-of-bound and use-after-free bugs. KASAN has three modes:
> > +
> >  1. generic KASAN (similar to userspace ASan),
> >  2. software tag-based KASAN (similar to userspace HWASan),
> >  3. hardware tag-based KASAN (based on hardware memory tagging).
> > @@ -39,23 +40,13 @@ CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
> >  The former produces smaller binary while the latter is 1.1 - 2 times faster.
> >
> >  Both software KASAN modes work with both SLUB and SLAB memory allocators,
> > -hardware tag-based KASAN currently only support SLUB.
> > -For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
> > +while the hardware tag-based KASAN currently only support SLUB.
> > +
> > +For better error reports that include stack traces, enable CONFIG_STACKTRACE.
> >
> >  To augment reports with last allocation and freeing stack of the physical page,
> >  it is recommended to enable also CONFIG_PAGE_OWNER and boot with page_owner=on.
> >
> > -To disable instrumentation for specific files or directories, add a line
> > -similar to the following to the respective kernel Makefile:
> > -
> > -- For a single file (e.g. main.o)::
> > -
> > -    KASAN_SANITIZE_main.o := n
> > -
> > -- For all files in one directory::
> > -
> > -    KASAN_SANITIZE := n
> > -
> >  Error reports
> >  ~~~~~~~~~~~~~
> >
> > @@ -140,16 +131,20 @@ freed (in case of a use-after-free bug report). Next comes a description of
> >  the accessed slab object and information about the accessed memory page.
> >
> >  In the last section the report shows memory state around the accessed address.
> > -Reading this part requires some understanding of how KASAN works.
> > -
> > -The state of each 8 aligned bytes of memory is encoded in one shadow byte.
> > -Those 8 bytes can be accessible, partially accessible, freed or be a redzone.
> > -We use the following encoding for each shadow byte: 0 means that all 8 bytes
> > -of the corresponding memory region are accessible; number N (1 <= N <= 7) means
> > -that the first N bytes are accessible, and other (8 - N) bytes are not;
> > -any negative value indicates that the entire 8-byte word is inaccessible.
> > -We use different negative values to distinguish between different kinds of
> > -inaccessible memory like redzones or freed memory (see mm/kasan/kasan.h).
> > +Internally KASAN tracks memory state separately for each memory granule, which
> > +is either 8 or 16 aligned bytes depending on KASAN mode. Each number in the
> > +memory state section of the report shows the state of one of the memory
> > +granules that surround the accessed address.
> > +
> > +For generic KASAN the size of each memory granule is 8. The state of each
> > +granule is encoded in one shadow byte. Those 8 bytes can be accessible,
> > +partially accessible, freed or be a part of a redzone. KASAN uses the following
> > +encoding for each shadow byte: 0 means that all 8 bytes of the corresponding
> > +memory region are accessible; number N (1 <= N <= 7) means that the first N
> > +bytes are accessible, and other (8 - N) bytes are not; any negative value
> > +indicates that the entire 8-byte word is inaccessible. KASAN uses different
> > +negative values to distinguish between different kinds of inaccessible memory
> > +like redzones or freed memory (see mm/kasan/kasan.h).
> >
> >  In the report above the arrows point to the shadow byte 03, which means that
> >  the accessed address is partially accessible.
> > @@ -157,6 +152,55 @@ the accessed address is partially accessible.
> >  For tag-based KASAN this last report section shows the memory tags around the
> >  accessed address (see Implementation details section).
>
> I think ReST automatically creates a link if you write it as
>
>         ... (see `Implementation details`_ section).
>
> >
> > +Boot parameters
> > +~~~~~~~~~~~~~~~
> > +
> > +Hardware tag-based KASAN mode (see the section about different mode below) is
> > +intended for use in production as a security mitigation. Therefore it supports
> > +boot parameters that allow to disable KASAN competely or otherwise control
> > +particular KASAN features.
> > +
> > +The things that can be controlled are:
> > +
> > +1. Whether KASAN is enabled at all.
> > +2. Whether KASAN collects and saves alloc/free stacks.
> > +3. Whether KASAN panics on a detected bug or not.
> > +
> > +The ``kasam.mode`` boot parameter allows to choose one of three main modes:
>
> s/kasam/kasan/
>
> > +- ``kasan.mode=off`` - KASAN is disabled, no tag checks are performed
> > +- ``kasan.mode=prod`` - only essential production features are enabled
> > +- ``kasan.mode=full`` - all KASAN features are enabled
> > +
> > +The chosen mode provides default control values for the features mentioned
> > +above. However it's also possible to override the default values by providing:
> > +
> > +- ``kasan.stacktrace=off`` or ``=on`` - enable alloc/free stack collection
> > +                                        (default: ``on`` for ``mode=full``,
> > +                                         otherwise ``off``)
> > +- ``kasan.fault=report`` or ``=panic`` - only print KASAN report or also panic
> > +                                      (default: ``report``)
>
> This is indented with tabs instead of spaces.
>
> > +
> > +If ``kasan.mode parameter`` is not provided, it defaults to ``full`` when
>
> s/``kasan.mode parameter``/``kasan.mode`` parameter/  ?
>
> > +``CONFIG_DEBUG_KERNEL`` is enabled, and to ``prod`` otherwise.
> > +
> > +For developers
> > +~~~~~~~~~~~~~~
> > +
> > +Software KASAN modes use compiler instrumentation to insert validity checks.
> > +Such instrumentation might be incompatible with some part of the kernel, and
> > +therefore needs to be disabled. To disable instrumentation for specific files
> > +or directories, add a line similar to the following to the respective kernel
> > +Makefile:
> > +
> > +- For a single file (e.g. main.o)::
> > +
> > +    KASAN_SANITIZE_main.o := n
> > +
> > +- For all files in one directory::
> > +
> > +    KASAN_SANITIZE := n
> > +
> >
> >  Implementation details
> >  ----------------------
> > @@ -164,10 +208,10 @@ Implementation details
> >  Generic KASAN
> >  ~~~~~~~~~~~~~
> >
> > -From a high level, our approach to memory error detection is similar to that
> > -of kmemcheck: use shadow memory to record whether each byte of memory is safe
> > -to access, and use compile-time instrumentation to insert checks of shadow
> > -memory on each memory access.
> > +From a high level perspective, KASAN's approach to memory error detection is
> > +similar to that of kmemcheck: use shadow memory to record whether each byte of
> > +memory is safe to access, and use compile-time instrumentation to insert checks
> > +of shadow memory on each memory access.
> >
> >  Generic KASAN dedicates 1/8th of kernel memory to its shadow memory (e.g. 16TB
> >  to cover 128TB on x86_64) and uses direct mapping with a scale and offset to
> > @@ -194,7 +238,10 @@ function calls GCC directly inserts the code to check the shadow memory.
> >  This option significantly enlarges kernel but it gives x1.1-x2 performance
> >  boost over outline instrumented kernel.
> >
> > -Generic KASAN prints up to 2 call_rcu() call stacks in reports, the last one
> > +Generic KASAN is the only mode that delays the reuse of freed object via
> > +quarantine (see mm/kasan/quarantine.c for implementation).
> > +
> > +Generic KASAN prints up to two call_rcu() call stacks in reports, the last one
> >  and the second to last.
> >
> >  Software tag-based KASAN
> > @@ -302,15 +349,15 @@ therefore be wasteful. Furthermore, to ensure that different mappings
> >  use different shadow pages, mappings would have to be aligned to
> >  ``KASAN_GRANULE_SIZE * PAGE_SIZE``.
> >
> > -Instead, we share backing space across multiple mappings. We allocate
> > +Instead, KASAN shares backing space across multiple mappings. It allocates
> >  a backing page when a mapping in vmalloc space uses a particular page
> >  of the shadow region. This page can be shared by other vmalloc
> >  mappings later on.
> >
> > -We hook in to the vmap infrastructure to lazily clean up unused shadow
> > +KASAN hooks in to the vmap infrastructure to lazily clean up unused shadow
>
> s/in to/into/
>
> >  memory.
> >
> > -To avoid the difficulties around swapping mappings around, we expect
> > +To avoid the difficulties around swapping mappings around, KASAN expects
> >  that the part of the shadow region that covers the vmalloc space will
> >  not be covered by the early shadow page, but will be left
> >  unmapped. This will require changes in arch-specific code.
> > @@ -321,24 +368,31 @@ architectures that do not have a fixed module region.
> >  CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
> >  --------------------------------------------------
> >
> > -``CONFIG_KASAN_KUNIT_TEST`` utilizes the KUnit Test Framework for testing.
> > -This means each test focuses on a small unit of functionality and
> > -there are a few ways these tests can be run.
> > +KASAN tests consist on two parts:
> > +
> > +1. Tests that are integrated with the KUnit Test Framework. Enabled with
> > +``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
> > +automatically in a few different ways, see the instructions below.
> >
> > -Each test will print the KASAN report if an error is detected and then
> > -print the number of the test and the status of the test:
> > +2. Tests that are currently incompatible with Kunit. Enabled with
>
> s/Kunit/KUnit/
>
> > +``CONFIG_TEST_KASAN_MODULE`` and can only be run as a module. These tests can
> > +only be verified manually, by loading the kernel module and inspecting the
> > +kernel log for KASAN reports.
> >
> > -pass::
> > +Each KUNIT-compatible KASAN test prints a KASAN report if an error is detected.
>
> s/KUNIT/KUnit/  like elsewhere.
>
> > +Then the test prints its number and status.
> > +
> > +When a test passes::
> >
> >          ok 28 - kmalloc_double_kzfree
> >
> > -or, if kmalloc failed::
> > +When a test fails due to a failed ``kmalloc``::
> >
> >          # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
> >          Expected ptr is not null, but is
> >          not ok 4 - kmalloc_large_oob_right
> >
> > -or, if a KASAN report was expected, but not found::
> > +When a test fails due to a missing KASAN report::
> >
> >          # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
> >          Expected kasan_data->report_expected == kasan_data->report_found, but
> > @@ -346,46 +400,38 @@ or, if a KASAN report was expected, but not found::
> >          kasan_data->report_found == 0
> >          not ok 28 - kmalloc_double_kzfree
> >
> > -All test statuses are tracked as they run and an overall status will
> > -be printed at the end::
> > +At the end the cumulative status of all KASAN tests is printed. On success::
> >
> >          ok 1 - kasan
> >
> > -or::
> > +Or, if one of the tests failed::
> >
> >          not ok 1 - kasan
> >
> > -(1) Loadable Module
> > -~~~~~~~~~~~~~~~~~~~~
> > +
> > +There are a few ways to run Kunit-compatible KASAN tests.
>
> s/Kunit/KUnit/

Will fix all in v10/v3.

>
> > +
> > +1. Loadable module
> > +~~~~~~~~~~~~~~~~~~
> >
> >  With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
> > -a loadable module and run on any architecture that supports KASAN
> > -using something like insmod or modprobe. The module is called ``test_kasan``.
> > +a loadable module and run on any architecture that supports KASAN by loading
> > +the module with insmod or modprobe. The module is called ``test_kasan``.
> >
> > -(2) Built-In
> > -~~~~~~~~~~~~~
> > +2. Built-In
> > +~~~~~~~~~~~
> >
> >  With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
> > -on any architecure that supports KASAN. These and any other KUnit
> > -tests enabled will run and print the results at boot as a late-init
> > -call.
> > +on any architecure that supports KASAN. These and any other KUnit tests enabled
> > +will run and print the results at boot as a late-init call.
> >
> > -(3) Using kunit_tool
> > -~~~~~~~~~~~~~~~~~~~~~
> > +3. Using kunit_tool
> > +~~~~~~~~~~~~~~~~~~~
> >
> > -With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, we can also
> > -use kunit_tool to see the results of these along with other KUnit
> > -tests in a more readable way. This will not print the KASAN reports
> > -of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
> > -information on kunit_tool.
> > +With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it's also
> > +possible use ``kunit_tool`` to see the results of these and other KUnit tests
> > +in a more readable way. This will not print the KASAN reports of the tests that
> > +passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
> > +for more up-to-date information on ``kunit_tool``.
> >
> >  .. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> > -
> > -``CONFIG_TEST_KASAN_MODULE`` is a set of KASAN tests that could not be
> > -converted to KUnit. These tests can be run only as a module with
> > -``CONFIG_TEST_KASAN_MODULE`` built as a loadable module and
> > -``CONFIG_KASAN`` built-in. The type of error expected and the
> > -function being run is printed before the expression expected to give
> > -an error. Then the error is printed, if found, and that test
> > -should be interpretted to pass only if the error was the one expected
> > -by the test.
> > --
> > 2.29.2.222.g5d2a92d10f8-goog
> >
