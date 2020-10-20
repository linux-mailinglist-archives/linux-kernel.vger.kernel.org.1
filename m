Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D72293B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394098AbgJTMRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393919AbgJTMRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:17:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528C12222F;
        Tue, 20 Oct 2020 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603196232;
        bh=kwz329hHcdb3msU9zQOvS3B2J9Hwj2jzPLYLuDYZiNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+AtBJObIlriv82XKfONSPirGGGZJgUlCOf+6WNBKBqe3Ta8suLxnsp7egfhpCK5i
         1947v5+dD3jFxttlkavpKM1e4Li0kJjW5s/iX+F8fFPQrM1pFXDDuL8X4/YXBNea9i
         rzsLxP4PdiRHAmdmeLhXsdhqD8md1Y5RyQ3lz35U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2AA37403C2; Tue, 20 Oct 2020 09:17:10 -0300 (-03)
Date:   Tue, 20 Oct 2020 09:17:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf test: Implement skip_reason callback for watchpoint
 tests
Message-ID: <20201020121710.GF2294271@kernel.org>
References: <20201016131650.72476-1-tommi.t.rantala@nokia.com>
 <CAM9d7ciEBP-GMFR0xJqoqSaG2vBcXKxKv4HOR3mxzGxqji2yzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciEBP-GMFR0xJqoqSaG2vBcXKxKv4HOR3mxzGxqji2yzg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 20, 2020 at 03:07:15PM +0900, Namhyung Kim escreveu:
> Hello,
> On Fri, Oct 16, 2020 at 10:17 PM Tommi Rantala
> <tommi.t.rantala@nokia.com> wrote:
> >
> > Currently reason for skipping the read only watchpoint test is only seen
> > when running in verbose mode:
> >
> >   $ perf test watchpoint
> >   23: Watchpoint                                            :
> >   23.1: Read Only Watchpoint                                : Skip
> >   23.2: Write Only Watchpoint                               : Ok
> >   23.3: Read / Write Watchpoint                             : Ok
> >   23.4: Modify Watchpoint                                   : Ok
> >
> >   $ perf test -v watchpoint
> >   23: Watchpoint                                            :
> >   23.1: Read Only Watchpoint                                :
> >   --- start ---
> >   test child forked, pid 60204
> >   Hardware does not support read only watchpoints.
> >   test child finished with -2
> >
> > Implement skip_reason callback for the watchpoint tests, so that it's
> > easy to see reason why the test is skipped:
> >
> >   $ perf test watchpoint
> >   23: Watchpoint                                            :
> >   23.1: Read Only Watchpoint                                : Skip (missing hardware support)
> >   23.2: Write Only Watchpoint                               : Ok
> >   23.3: Read / Write Watchpoint                             : Ok
> >   23.4: Modify Watchpoint                                   : Ok
> >
> > Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
 
> 
> Thanks
> Namhyung
> 
> 
> > ---
> >  tools/perf/tests/builtin-test.c |  1 +
> >  tools/perf/tests/tests.h        |  1 +
> >  tools/perf/tests/wp.c           | 21 +++++++++++++++------
> >  3 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index d328caaba45d..3bfad4ee31ae 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -142,6 +142,7 @@ static struct test generic_tests[] = {
> >                         .skip_if_fail   = false,
> >                         .get_nr         = test__wp_subtest_get_nr,
> >                         .get_desc       = test__wp_subtest_get_desc,
> > +                       .skip_reason    = test__wp_subtest_skip_reason,
> >                 },
> >         },
> >         {
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 4447a516c689..0630301087a6 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -66,6 +66,7 @@ int test__bp_signal_overflow(struct test *test, int subtest);
> >  int test__bp_accounting(struct test *test, int subtest);
> >  int test__wp(struct test *test, int subtest);
> >  const char *test__wp_subtest_get_desc(int subtest);
> > +const char *test__wp_subtest_skip_reason(int subtest);
> >  int test__wp_subtest_get_nr(void);
> >  int test__task_exit(struct test *test, int subtest);
> >  int test__mem(struct test *test, int subtest);
> > diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> > index d262d6639829..9387fa76faa5 100644
> > --- a/tools/perf/tests/wp.c
> > +++ b/tools/perf/tests/wp.c
> > @@ -174,10 +174,12 @@ static bool wp_ro_supported(void)
> >  #endif
> >  }
> >
> > -static void wp_ro_skip_msg(void)
> > +static const char *wp_ro_skip_msg(void)
> >  {
> >  #if defined (__x86_64__) || defined (__i386__)
> > -       pr_debug("Hardware does not support read only watchpoints.\n");
> > +       return "missing hardware support";
> > +#else
> > +       return NULL;
> >  #endif
> >  }
> >
> > @@ -185,7 +187,7 @@ static struct {
> >         const char *desc;
> >         int (*target_func)(void);
> >         bool (*is_supported)(void);
> > -       void (*skip_msg)(void);
> > +       const char *(*skip_msg)(void);
> >  } wp_testcase_table[] = {
> >         {
> >                 .desc = "Read Only Watchpoint",
> > @@ -219,16 +221,23 @@ const char *test__wp_subtest_get_desc(int i)
> >         return wp_testcase_table[i].desc;
> >  }
> >
> > +const char *test__wp_subtest_skip_reason(int i)
> > +{
> > +       if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
> > +               return NULL;
> > +       if (!wp_testcase_table[i].skip_msg)
> > +               return NULL;
> > +       return wp_testcase_table[i].skip_msg();
> > +}
> > +
> >  int test__wp(struct test *test __maybe_unused, int i)
> >  {
> >         if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
> >                 return TEST_FAIL;
> >
> >         if (wp_testcase_table[i].is_supported &&
> > -           !wp_testcase_table[i].is_supported()) {
> > -               wp_testcase_table[i].skip_msg();
> > +           !wp_testcase_table[i].is_supported())
> >                 return TEST_SKIP;
> > -       }
> >
> >         return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
> >  }
> > --
> > 2.26.2
> >

-- 

- Arnaldo
