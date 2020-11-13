Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617B82B286F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMWVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKMWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:21:04 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:21:02 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id 91so4482040wrk.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eyOrtcKen7fgrfwARq8tGqpWknv3CPxMtmzrBg32L54=;
        b=O0Kwm8Q+s44JcGB/AtbKCNpR/VG8oK5sOrln2Ln/mpjlt/J5f19GFlvre+tKbwhytY
         eJk8paW3Ggm34w8sSwTinp4wMEdtG9WBBLm+el5gAyOVTq5rXVOu9Wmldbgi+6doOooA
         /YBSmmqDzJadJlZb12kBHqkNWf1ae+E+4T9HYhVUiPxlUvU2bc4UFXMEeQYl4Fv6Z5sI
         j82jVra71cMq42coFmwruTBcl2+KpUDo32GQcg/wDr5xZ6wE1W/uieh0/qiMZRZRvQLV
         sPYpMtxafq9Re7uK5aG85xPt8RNC3crN9GedGBUhAdVy7yA/X9WL82N7mqqEh1kv+YZ4
         ABvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eyOrtcKen7fgrfwARq8tGqpWknv3CPxMtmzrBg32L54=;
        b=pz9AbQLPRk2F8u0szErLPJETiz8dxm6iLKIyAdBhxLlL40CqVFuhxpqHGgmozfJ7PM
         ONrbSjbthvNL2NnjtVXnbNPGm4NBW0E9ySgxyLQB/znMNqlqDzYSBArEHy47vwvW7rWW
         mjChcIR05RiCma5cC2GSu2dwUh4Y7MsIxrXwGs2EhlulAgaxdUYpK9jrz4pa/o4hKdCu
         ln7JSGOXJVz0vWzoreowrd0omTsSSZ0NGQab+u/p8BMSaSDFk8qi7KFtCaxIgelLgmfO
         PQR/wel25Sujxr2Ihw7R0uvb/DR0BSjIfm1LDOo02dUJ7Krr0cBqPw54xYG90hpg/f8z
         4E1A==
X-Gm-Message-State: AOAM533YswA+AIvog3H/q3+Dt6fu0J7djuOKhopJON9HvzyIafitpgJ4
        p7fi90i4T8aj5qttZ1OaCqmDGPFoyzN2F5lj
X-Google-Smtp-Source: ABdhPJzcSLgrfEHEsnxNSacjzJpW5iTQm/d7cUrxxvowHRiIiVk33HEA3Z6rKplR2mcWiPF/pgEiyAiPhNzDdAei
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:dc0a:: with SMTP id
 t10mr4712946wmg.5.1605306060823; Fri, 13 Nov 2020 14:21:00 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:09 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <1668fc1d020f9c1f2b8bf57467f0433bfd74d0a3.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 19/19] kasan: update documentation
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change updates KASAN documentation to reflect the addition of boot
parameters and also reworks and clarifies some of the existing sections,
in particular: defines what a memory granule is, mentions quarantine,
makes Kunit section more readable.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ib1f83e91be273264b25f42b04448ac96b858849f
---
 Documentation/dev-tools/kasan.rst | 186 +++++++++++++++++++-----------
 1 file changed, 116 insertions(+), 70 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index ffbae8ce5748..0d5d77919b1a 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -4,8 +4,9 @@ The Kernel Address Sanitizer (KASAN)
 Overview
 --------
 
-KernelAddressSANitizer (KASAN) is a dynamic memory error detector designed to
-find out-of-bound and use-after-free bugs. KASAN has three modes:
+KernelAddressSANitizer (KASAN) is a dynamic memory safety error detector
+designed to find out-of-bound and use-after-free bugs. KASAN has three modes:
+
 1. generic KASAN (similar to userspace ASan),
 2. software tag-based KASAN (similar to userspace HWASan),
 3. hardware tag-based KASAN (based on hardware memory tagging).
@@ -39,23 +40,13 @@ CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
 The former produces smaller binary while the latter is 1.1 - 2 times faster.
 
 Both software KASAN modes work with both SLUB and SLAB memory allocators,
-hardware tag-based KASAN currently only support SLUB.
-For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
+while the hardware tag-based KASAN currently only support SLUB.
+
+For better error reports that include stack traces, enable CONFIG_STACKTRACE.
 
 To augment reports with last allocation and freeing stack of the physical page,
 it is recommended to enable also CONFIG_PAGE_OWNER and boot with page_owner=on.
 
-To disable instrumentation for specific files or directories, add a line
-similar to the following to the respective kernel Makefile:
-
-- For a single file (e.g. main.o)::
-
-    KASAN_SANITIZE_main.o := n
-
-- For all files in one directory::
-
-    KASAN_SANITIZE := n
-
 Error reports
 ~~~~~~~~~~~~~
 
@@ -140,22 +131,75 @@ freed (in case of a use-after-free bug report). Next comes a description of
 the accessed slab object and information about the accessed memory page.
 
 In the last section the report shows memory state around the accessed address.
-Reading this part requires some understanding of how KASAN works.
-
-The state of each 8 aligned bytes of memory is encoded in one shadow byte.
-Those 8 bytes can be accessible, partially accessible, freed or be a redzone.
-We use the following encoding for each shadow byte: 0 means that all 8 bytes
-of the corresponding memory region are accessible; number N (1 <= N <= 7) means
-that the first N bytes are accessible, and other (8 - N) bytes are not;
-any negative value indicates that the entire 8-byte word is inaccessible.
-We use different negative values to distinguish between different kinds of
-inaccessible memory like redzones or freed memory (see mm/kasan/kasan.h).
+Internally KASAN tracks memory state separately for each memory granule, which
+is either 8 or 16 aligned bytes depending on KASAN mode. Each number in the
+memory state section of the report shows the state of one of the memory
+granules that surround the accessed address.
+
+For generic KASAN the size of each memory granule is 8. The state of each
+granule is encoded in one shadow byte. Those 8 bytes can be accessible,
+partially accessible, freed or be a part of a redzone. KASAN uses the following
+encoding for each shadow byte: 0 means that all 8 bytes of the corresponding
+memory region are accessible; number N (1 <= N <= 7) means that the first N
+bytes are accessible, and other (8 - N) bytes are not; any negative value
+indicates that the entire 8-byte word is inaccessible. KASAN uses different
+negative values to distinguish between different kinds of inaccessible memory
+like redzones or freed memory (see mm/kasan/kasan.h).
 
 In the report above the arrows point to the shadow byte 03, which means that
 the accessed address is partially accessible.
 
 For tag-based KASAN this last report section shows the memory tags around the
-accessed address (see Implementation details section).
+accessed address (see `Implementation details`_ section).
+
+Boot parameters
+~~~~~~~~~~~~~~~
+
+Hardware tag-based KASAN mode (see the section about different mode below) is
+intended for use in production as a security mitigation. Therefore it supports
+boot parameters that allow to disable KASAN competely or otherwise control
+particular KASAN features.
+
+The things that can be controlled are:
+
+1. Whether KASAN is enabled at all.
+2. Whether KASAN collects and saves alloc/free stacks.
+3. Whether KASAN panics on a detected bug or not.
+
+The ``kasan.mode`` boot parameter allows to choose one of three main modes:
+
+- ``kasan.mode=off`` - KASAN is disabled, no tag checks are performed
+- ``kasan.mode=prod`` - only essential production features are enabled
+- ``kasan.mode=full`` - all KASAN features are enabled
+
+The chosen mode provides default control values for the features mentioned
+above. However it's also possible to override the default values by providing:
+
+- ``kasan.stacktrace=off`` or ``=on`` - enable alloc/free stack collection
+					(default: ``on`` for ``mode=full``,
+					 otherwise ``off``)
+- ``kasan.fault=report`` or ``=panic`` - only print KASAN report or also panic
+					 (default: ``report``)
+
+If ``kasan.mode`` parameter is not provided, it defaults to ``full`` when
+``CONFIG_DEBUG_KERNEL`` is enabled, and to ``prod`` otherwise.
+
+For developers
+~~~~~~~~~~~~~~
+
+Software KASAN modes use compiler instrumentation to insert validity checks.
+Such instrumentation might be incompatible with some part of the kernel, and
+therefore needs to be disabled. To disable instrumentation for specific files
+or directories, add a line similar to the following to the respective kernel
+Makefile:
+
+- For a single file (e.g. main.o)::
+
+    KASAN_SANITIZE_main.o := n
+
+- For all files in one directory::
+
+    KASAN_SANITIZE := n
 
 
 Implementation details
@@ -164,10 +208,10 @@ Implementation details
 Generic KASAN
 ~~~~~~~~~~~~~
 
-From a high level, our approach to memory error detection is similar to that
-of kmemcheck: use shadow memory to record whether each byte of memory is safe
-to access, and use compile-time instrumentation to insert checks of shadow
-memory on each memory access.
+From a high level perspective, KASAN's approach to memory error detection is
+similar to that of kmemcheck: use shadow memory to record whether each byte of
+memory is safe to access, and use compile-time instrumentation to insert checks
+of shadow memory on each memory access.
 
 Generic KASAN dedicates 1/8th of kernel memory to its shadow memory (e.g. 16TB
 to cover 128TB on x86_64) and uses direct mapping with a scale and offset to
@@ -194,7 +238,10 @@ function calls GCC directly inserts the code to check the shadow memory.
 This option significantly enlarges kernel but it gives x1.1-x2 performance
 boost over outline instrumented kernel.
 
-Generic KASAN prints up to 2 call_rcu() call stacks in reports, the last one
+Generic KASAN is the only mode that delays the reuse of freed object via
+quarantine (see mm/kasan/quarantine.c for implementation).
+
+Generic KASAN prints up to two call_rcu() call stacks in reports, the last one
 and the second to last.
 
 Software tag-based KASAN
@@ -304,15 +351,15 @@ therefore be wasteful. Furthermore, to ensure that different mappings
 use different shadow pages, mappings would have to be aligned to
 ``KASAN_GRANULE_SIZE * PAGE_SIZE``.
 
-Instead, we share backing space across multiple mappings. We allocate
+Instead, KASAN shares backing space across multiple mappings. It allocates
 a backing page when a mapping in vmalloc space uses a particular page
 of the shadow region. This page can be shared by other vmalloc
 mappings later on.
 
-We hook in to the vmap infrastructure to lazily clean up unused shadow
+KASAN hooks into the vmap infrastructure to lazily clean up unused shadow
 memory.
 
-To avoid the difficulties around swapping mappings around, we expect
+To avoid the difficulties around swapping mappings around, KASAN expects
 that the part of the shadow region that covers the vmalloc space will
 not be covered by the early shadow page, but will be left
 unmapped. This will require changes in arch-specific code.
@@ -323,24 +370,31 @@ architectures that do not have a fixed module region.
 CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
 --------------------------------------------------
 
-``CONFIG_KASAN_KUNIT_TEST`` utilizes the KUnit Test Framework for testing.
-This means each test focuses on a small unit of functionality and
-there are a few ways these tests can be run.
+KASAN tests consist on two parts:
+
+1. Tests that are integrated with the KUnit Test Framework. Enabled with
+``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
+automatically in a few different ways, see the instructions below.
 
-Each test will print the KASAN report if an error is detected and then
-print the number of the test and the status of the test:
+2. Tests that are currently incompatible with KUnit. Enabled with
+``CONFIG_TEST_KASAN_MODULE`` and can only be run as a module. These tests can
+only be verified manually, by loading the kernel module and inspecting the
+kernel log for KASAN reports.
 
-pass::
+Each KUnit-compatible KASAN test prints a KASAN report if an error is detected.
+Then the test prints its number and status.
+
+When a test passes::
 
         ok 28 - kmalloc_double_kzfree
 
-or, if kmalloc failed::
+When a test fails due to a failed ``kmalloc``::
 
         # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
         Expected ptr is not null, but is
         not ok 4 - kmalloc_large_oob_right
 
-or, if a KASAN report was expected, but not found::
+When a test fails due to a missing KASAN report::
 
         # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
         Expected kasan_data->report_expected == kasan_data->report_found, but
@@ -348,46 +402,38 @@ or, if a KASAN report was expected, but not found::
         kasan_data->report_found == 0
         not ok 28 - kmalloc_double_kzfree
 
-All test statuses are tracked as they run and an overall status will
-be printed at the end::
+At the end the cumulative status of all KASAN tests is printed. On success::
 
         ok 1 - kasan
 
-or::
+Or, if one of the tests failed::
 
         not ok 1 - kasan
 
-(1) Loadable Module
-~~~~~~~~~~~~~~~~~~~~
+
+There are a few ways to run KUnit-compatible KASAN tests.
+
+1. Loadable module
+~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
-a loadable module and run on any architecture that supports KASAN
-using something like insmod or modprobe. The module is called ``test_kasan``.
+a loadable module and run on any architecture that supports KASAN by loading
+the module with insmod or modprobe. The module is called ``test_kasan``.
 
-(2) Built-In
-~~~~~~~~~~~~~
+2. Built-In
+~~~~~~~~~~~
 
 With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
-on any architecure that supports KASAN. These and any other KUnit
-tests enabled will run and print the results at boot as a late-init
-call.
+on any architecure that supports KASAN. These and any other KUnit tests enabled
+will run and print the results at boot as a late-init call.
 
-(3) Using kunit_tool
-~~~~~~~~~~~~~~~~~~~~~
+3. Using kunit_tool
+~~~~~~~~~~~~~~~~~~~
 
-With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, we can also
-use kunit_tool to see the results of these along with other KUnit
-tests in a more readable way. This will not print the KASAN reports
-of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
-information on kunit_tool.
+With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it's also
+possible use ``kunit_tool`` to see the results of these and other KUnit tests
+in a more readable way. This will not print the KASAN reports of the tests that
+passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
+for more up-to-date information on ``kunit_tool``.
 
 .. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
-
-``CONFIG_TEST_KASAN_MODULE`` is a set of KASAN tests that could not be
-converted to KUnit. These tests can be run only as a module with
-``CONFIG_TEST_KASAN_MODULE`` built as a loadable module and
-``CONFIG_KASAN`` built-in. The type of error expected and the
-function being run is printed before the expression expected to give
-an error. Then the error is printed, if found, and that test
-should be interpretted to pass only if the error was the one expected
-by the test.
-- 
2.29.2.299.gdc1121823c-goog

