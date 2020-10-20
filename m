Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D029293494
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbgJTGH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:07:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44731 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbgJTGH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:07:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id t9so573312wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmnB5cihsvzz/SD4fj9YHw94bXES2kz3taYcsBdS8n4=;
        b=Uszr05IVkwKJ133mPxTgYZrWT+ur+2YLmP9fhKivcwlFG1LsmivAFPSFXlj6/KesxL
         vevXWCVkYYGzEtZb+uLEenMsDrQICJzueaFhluCTn+Dyay52hHDwhnAw5+sKu6VKpEXf
         cEXHlcaEbuc4U1aInSH9GigzlH6892x+DAUIkI8cyV91QdMEi1/U6xJc2lxrOMM5/QHv
         1XL/df93bLPzHpbZy4Sw3UlClpbTzjcCjP0FDx30TqkrSDbCH4FXLUK82nvKxiyH4Ac7
         u8rbGyb0FUouY5kr66phjp5uADVvAFl3SRi3Ke/LQx7ZrvosUbXeHWByJKgjpvMGFFpH
         2JAw==
X-Gm-Message-State: AOAM532oqYOSv6o5+hXOb/kch0ONFvH2cJlj4+gbjDLcD0cZPY2THQ1V
        cUiKzL7ZojBwDjnISyXNjHlKZYOA0DU8E/lJUBU=
X-Google-Smtp-Source: ABdhPJzcr7hAdefp+NOC9Ax3YU3LgMj6bfmxGKqYKJSvd8JLrJhqGUs8QnZWhcLlRuB7BhIMF461nsdomA+1r/2/fCk=
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr1447674wrx.76.1603174046049;
 Mon, 19 Oct 2020 23:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201016131650.72476-1-tommi.t.rantala@nokia.com>
In-Reply-To: <20201016131650.72476-1-tommi.t.rantala@nokia.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Oct 2020 15:07:15 +0900
Message-ID: <CAM9d7ciEBP-GMFR0xJqoqSaG2vBcXKxKv4HOR3mxzGxqji2yzg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Implement skip_reason callback for watchpoint tests
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 16, 2020 at 10:17 PM Tommi Rantala
<tommi.t.rantala@nokia.com> wrote:
>
> Currently reason for skipping the read only watchpoint test is only seen
> when running in verbose mode:
>
>   $ perf test watchpoint
>   23: Watchpoint                                            :
>   23.1: Read Only Watchpoint                                : Skip
>   23.2: Write Only Watchpoint                               : Ok
>   23.3: Read / Write Watchpoint                             : Ok
>   23.4: Modify Watchpoint                                   : Ok
>
>   $ perf test -v watchpoint
>   23: Watchpoint                                            :
>   23.1: Read Only Watchpoint                                :
>   --- start ---
>   test child forked, pid 60204
>   Hardware does not support read only watchpoints.
>   test child finished with -2
>
> Implement skip_reason callback for the watchpoint tests, so that it's
> easy to see reason why the test is skipped:
>
>   $ perf test watchpoint
>   23: Watchpoint                                            :
>   23.1: Read Only Watchpoint                                : Skip (missing hardware support)
>   23.2: Write Only Watchpoint                               : Ok
>   23.3: Read / Write Watchpoint                             : Ok
>   23.4: Modify Watchpoint                                   : Ok
>
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/tests/builtin-test.c |  1 +
>  tools/perf/tests/tests.h        |  1 +
>  tools/perf/tests/wp.c           | 21 +++++++++++++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index d328caaba45d..3bfad4ee31ae 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -142,6 +142,7 @@ static struct test generic_tests[] = {
>                         .skip_if_fail   = false,
>                         .get_nr         = test__wp_subtest_get_nr,
>                         .get_desc       = test__wp_subtest_get_desc,
> +                       .skip_reason    = test__wp_subtest_skip_reason,
>                 },
>         },
>         {
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 4447a516c689..0630301087a6 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -66,6 +66,7 @@ int test__bp_signal_overflow(struct test *test, int subtest);
>  int test__bp_accounting(struct test *test, int subtest);
>  int test__wp(struct test *test, int subtest);
>  const char *test__wp_subtest_get_desc(int subtest);
> +const char *test__wp_subtest_skip_reason(int subtest);
>  int test__wp_subtest_get_nr(void);
>  int test__task_exit(struct test *test, int subtest);
>  int test__mem(struct test *test, int subtest);
> diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> index d262d6639829..9387fa76faa5 100644
> --- a/tools/perf/tests/wp.c
> +++ b/tools/perf/tests/wp.c
> @@ -174,10 +174,12 @@ static bool wp_ro_supported(void)
>  #endif
>  }
>
> -static void wp_ro_skip_msg(void)
> +static const char *wp_ro_skip_msg(void)
>  {
>  #if defined (__x86_64__) || defined (__i386__)
> -       pr_debug("Hardware does not support read only watchpoints.\n");
> +       return "missing hardware support";
> +#else
> +       return NULL;
>  #endif
>  }
>
> @@ -185,7 +187,7 @@ static struct {
>         const char *desc;
>         int (*target_func)(void);
>         bool (*is_supported)(void);
> -       void (*skip_msg)(void);
> +       const char *(*skip_msg)(void);
>  } wp_testcase_table[] = {
>         {
>                 .desc = "Read Only Watchpoint",
> @@ -219,16 +221,23 @@ const char *test__wp_subtest_get_desc(int i)
>         return wp_testcase_table[i].desc;
>  }
>
> +const char *test__wp_subtest_skip_reason(int i)
> +{
> +       if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
> +               return NULL;
> +       if (!wp_testcase_table[i].skip_msg)
> +               return NULL;
> +       return wp_testcase_table[i].skip_msg();
> +}
> +
>  int test__wp(struct test *test __maybe_unused, int i)
>  {
>         if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
>                 return TEST_FAIL;
>
>         if (wp_testcase_table[i].is_supported &&
> -           !wp_testcase_table[i].is_supported()) {
> -               wp_testcase_table[i].skip_msg();
> +           !wp_testcase_table[i].is_supported())
>                 return TEST_SKIP;
> -       }
>
>         return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
>  }
> --
> 2.26.2
>
