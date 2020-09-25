Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8097A2785DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgIYLcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:32:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:32:01 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h17so1979111otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L8pDz+HxatuOD/RjMAAdgwqh+b4jciwbLlL8vlXkeA=;
        b=qyHbJgNndjOJTaIgRnJQ6gdz3KVViOFrAgXDGuXJJIRD74pqZXl32ezx/nLKfU26eO
         4Sswiyv+wYx+68aCOYEcsAZf3hLxli00w3yhK/RaeNtOxUrc10pokEGeU+s1NS9L342a
         f/3qUcxxVICL9wVpKmpyDNMssvgh9Q51lddnuQkfdLh0ATuhFv3NzEnuvvXUTsOLsvgO
         YJLBGwF8305u0itBfxkYCF5CDWafOUXiMyTZvcIvDk2rDy10zKMmhaH5F/2Ze2kOAEPI
         at+QdWNp6iNyaX5chYaA3CG+ThU646hbW4DslUpQHdVbrXIUHwwyE7WKMgtzG5rLJb2I
         29cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L8pDz+HxatuOD/RjMAAdgwqh+b4jciwbLlL8vlXkeA=;
        b=JvUGoifaVABy9lcyRg3j8F0/BZ7aTEJbJ90TOHklEdLKLeqVCVgqzGk0dewkbV5j+c
         3VJSy7k5fc8tZ0ORWLjlOaSv5f0fXeiAQc8uVjWWciAXmyOdMIDvXKUgt7UZGGzVn3Iz
         Pvp7WvIymr9xeobiZV+tdY771+tMOP9eGgYzLQ4pSQum7TCMGgfPWALJ9hyrd/ZMAVcZ
         ajO8LqjQS9nMFojiRiOYgP639WxNA0ppO/I2Y+9KwHwE4bE9pI1RjsWrELbkSJb7acTO
         aoEKwNWZIRMLYfTEslC/WtcY/VdHbGxJ+t8/wuVaML26Xs6l76kz6X5rMkklBdH4RaEj
         QY0w==
X-Gm-Message-State: AOAM5311atymf527VByB7u6KXF56zKWpJUH83PmAW1XgYzHl/HidHIbt
        vPqjeem80Xkw6lSfojdzAYX3HoIqsuM3raVnIIX+9g==
X-Google-Smtp-Source: ABdhPJyormovoExEyKquxcPkW3fXKMFM7xowV9E55jiL8kHHZvbTZiiejygZobwfWQwB8aFC0qqx0h8nfjkvgKtV6TA=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr2621626otn.233.1601033519970;
 Fri, 25 Sep 2020 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-2-elver@google.com> <20200925112328.10057-1-sjpark@amazon.com>
In-Reply-To: <20200925112328.10057-1-sjpark@amazon.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 25 Sep 2020 13:31:48 +0200
Message-ID: <CANpmjNMG+1Fiff+_PMFanRVc9SRoTKa-Z9SMM9eKTRL9MsoD0w@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Lameter <cl@linux.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 at 13:24, 'SeongJae Park' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Mon, 21 Sep 2020 15:26:02 +0200 Marco Elver <elver@google.com> wrote:
>
> > From: Alexander Potapenko <glider@google.com>
> >
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.
> >
> > KFENCE is designed to be enabled in production kernels, and has near
> > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > for precision. The main motivation behind KFENCE's design, is that with
> > enough total uptime KFENCE will detect bugs in code paths not typically
> > exercised by non-production test workloads. One way to quickly achieve a
> > large enough total uptime is when the tool is deployed across a large
> > fleet of machines.
> >
> > KFENCE objects each reside on a dedicated page, at either the left or
> > right page boundaries. The pages to the left and right of the object
> > page are "guard pages", whose attributes are changed to a protected
> > state, and cause page faults on any attempted access to them. Such page
> > faults are then intercepted by KFENCE, which handles the fault
> > gracefully by reporting a memory access error. To detect out-of-bounds
> > writes to memory within the object's page itself, KFENCE also uses
> > pattern-based redzones. The following figure illustrates the page
> > layout:
> >
> >   ---+-----------+-----------+-----------+-----------+-----------+---
> >      | xxxxxxxxx | O :       | xxxxxxxxx |       : O | xxxxxxxxx |
> >      | xxxxxxxxx | B :       | xxxxxxxxx |       : B | xxxxxxxxx |
> >      | x GUARD x | J : RED-  | x GUARD x | RED-  : J | x GUARD x |
> >      | xxxxxxxxx | E :  ZONE | xxxxxxxxx |  ZONE : E | xxxxxxxxx |
> >      | xxxxxxxxx | C :       | xxxxxxxxx |       : C | xxxxxxxxx |
> >      | xxxxxxxxx | T :       | xxxxxxxxx |       : T | xxxxxxxxx |
> >   ---+-----------+-----------+-----------+-----------+-----------+---
> >
> > Guarded allocations are set up based on a sample interval (can be set
> > via kfence.sample_interval). After expiration of the sample interval, a
> > guarded allocation from the KFENCE object pool is returned to the main
> > allocator (SLAB or SLUB). At this point, the timer is reset, and the
> > next allocation is set up after the expiration of the interval.
> >
> > To enable/disable a KFENCE allocation through the main allocator's
> > fast-path without overhead, KFENCE relies on static branches via the
> > static keys infrastructure. The static branch is toggled to redirect the
> > allocation to KFENCE. To date, we have verified by running synthetic
> > benchmarks (sysbench I/O workloads) that a kernel compiled with KFENCE
> > is performance-neutral compared to the non-KFENCE baseline.
> >
> > For more details, see Documentation/dev-tools/kfence.rst (added later in
> > the series).
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > v3:
> > * Reports by SeongJae Park:
> >   * Remove reference to Documentation/dev-tools/kfence.rst.
> >   * Remove redundant braces.
> >   * Use CONFIG_KFENCE_NUM_OBJECTS instead of ARRAY_SIZE(...).
> >   * Align some comments.
> > * Add figure from Documentation/dev-tools/kfence.rst added later in
> >   series to patch description.
> >
> > v2:
> > * Add missing __printf attribute to seq_con_printf, and fix new warning.
> >   [reported by kernel test robot <lkp@intel.com>]
> > * Fix up some comments [reported by Jonathan Cameron].
> > * Remove 2 cases of redundant stack variable initialization
> >   [reported by Jonathan Cameron].
> > * Fix printf format [reported by kernel test robot <lkp@intel.com>].
> > * Print (in kfence-#nn) after address, to more clearly establish link
> >   between first and second stacktrace [reported by Andrey Konovalov].
> > * Make choice between KASAN and KFENCE clearer in Kconfig help text
> >   [suggested by Dave Hansen].
> > * Document CONFIG_KFENCE_SAMPLE_INTERVAL=0.
> > * Shorten memory corruption report line length.
> > * Make /sys/module/kfence/parameters/sample_interval root-writable for
> >   all builds (to enable debugging, automatic dynamic tweaking).
> > * Reports by Dmitry Vyukov:
> >   * Do not store negative size for right-located objects
> >   * Only cache-align addresses of right-located objects.
> >   * Run toggle_allocation_gate() after KFENCE is enabled.
> >   * Add empty line between allocation and free stacks.
> >   * Add comment about SLAB_TYPESAFE_BY_RCU.
> >   * Also skip internals for allocation/free stacks.
> >   * s/KFENCE_FAULT_INJECTION/KFENCE_STRESS_TEST_FAULTS/ as FAULT_INJECTION
> >     is already overloaded in different contexts.
> >   * Parenthesis for macro variable.
> >   * Lower max of KFENCE_NUM_OBJECTS config variable.
> > ---
> >  MAINTAINERS            |  11 +
> >  include/linux/kfence.h | 174 ++++++++++
> >  init/main.c            |   2 +
> >  lib/Kconfig.debug      |   1 +
> >  lib/Kconfig.kfence     |  63 ++++
> >  mm/Makefile            |   1 +
> >  mm/kfence/Makefile     |   3 +
> >  mm/kfence/core.c       | 733 +++++++++++++++++++++++++++++++++++++++++
> >  mm/kfence/kfence.h     | 102 ++++++
> >  mm/kfence/report.c     | 219 ++++++++++++
> >  10 files changed, 1309 insertions(+)
> >  create mode 100644 include/linux/kfence.h
> >  create mode 100644 lib/Kconfig.kfence
> >  create mode 100644 mm/kfence/Makefile
> >  create mode 100644 mm/kfence/core.c
> >  create mode 100644 mm/kfence/kfence.h
> >  create mode 100644 mm/kfence/report.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b5cfab015bd6..863899ed9a29 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9673,6 +9673,17 @@ F:     include/linux/keyctl.h
> >  F:   include/uapi/linux/keyctl.h
> >  F:   security/keys/
> >
> > +KFENCE
> > +M:   Alexander Potapenko <glider@google.com>
> > +M:   Marco Elver <elver@google.com>
> > +R:   Dmitry Vyukov <dvyukov@google.com>
> > +L:   kasan-dev@googlegroups.com
> > +S:   Maintained
> > +F:   Documentation/dev-tools/kfence.rst
>
> This patch doesn't introduce this file yet, right?  How about using a separate
> final patch for MAINTAINERS update?

Sure.

> Other than that,
>
> Reviewed-by: SeongJae Park <sjpark@amazon.de>

Thanks!
