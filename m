Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1829FB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ3Ce5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJ3Ce4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:34:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC4C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:34:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y184so3986169lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4zsJilmnXZW0eu+m4r307rdh+7PtUGOoi3k7KzIK4s=;
        b=TJa4wI6TxOoXZos3Wi+I7LjR132HVQhiX+MfxZ6xBv+14hyDtRuv30xh0lBsaqg/YE
         BvOBTIV/fwNsSnb0/HVxg7hgtRj2CjDpx0rv3uqQAcwdq2y+eyy2y6MBNLn5HeQEvJPu
         Khpl07Qmlp+2NuNfGzI844MBmzfQPk6obWHghpk8XJgkmWMiHOjwkKItvi0h0Eu4X2rx
         EWWBuA9YBimGowNUBqyVLFX6w2Grhc4CldLStYrCkDLG8OMY+yiP5jZoMbOVUPDoMN6t
         lTVb2oRfwKYCVxxJQHI2jAXyBpq/+jav9EHAVboBROdV+k0bM69yBnwUT+/0WMRnNSZX
         OTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4zsJilmnXZW0eu+m4r307rdh+7PtUGOoi3k7KzIK4s=;
        b=FgLRZ71fpNWX0G8F/CSKDretkb3mCfKMLRFKaK+PLpnI4KrjCtcGE9Ih2XcpQYBTNt
         1ESd7nwyx6yqz1sQYA8ezJGJzKcVJSuqMrmbeWKjS87Io1Zc3lciDNnAGsIUfxp8dzE+
         /cNaR6QfJFU2Uogjp31DtKhHOoGSrh1JqIzqZjtKl+CIZKptsqsl59ckQ6okJoECdQIk
         F4SBtJJl0yzgN1VqHu4tIxY+6CMOXjDiSjIE+TJXPQQs/HfuYhRKBS9lG5diM1YlKMEI
         4zLaor3ILsGIYoW5t/TljzNFtL8yo86d5/rwmor1C3P07shXZRjpEU2m71I/AOlo055h
         aJDw==
X-Gm-Message-State: AOAM53274NAOwJ1ME3n1e4zYz6BHSccgrdbmDYTQ56GIoqt1hO2Zi7Mg
        2ewMmWA4ZVtcVHFugfRlNg87c4H1HNv2tcyTSXNx4Q==
X-Google-Smtp-Source: ABdhPJxwcHvtgbRR9bElBszsCcepwW9fiuSs9HIGe6x1GwF0S6O4nBT58V1TVMhlY1QihtnFyLyoYeoIyEGMKHzmGO4=
X-Received: by 2002:a19:6001:: with SMTP id u1mr2595lfb.277.1604025294372;
 Thu, 29 Oct 2020 19:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201020233219.4146059-1-dlatypov@google.com>
In-Reply-To: <20201020233219.4146059-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Oct 2020 10:34:43 +0800
Message-ID: <CABVgOSnPpC=j7MrcmDpvvG6i_voiFQe4137ieyYX+-9B4=G39w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix extra trailing \n in parsed test output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 7:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> For simplcity, strip all trailing whitespace from parsed output.
> I imagine no one is printing out meaningful trailing whitespace via
> KUNIT_FAIL() or similar, and that if they are, they really shouldn't.
>
> At some point, the lines from `isolate_kunit_output()` started having
> trailing \n, which results in artifacty output like this:
>
> $ ./tools/testing/kunit/kunit.py run
> [16:16:46] [FAILED] example_simple_test
> [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
>
> [16:16:46]     Expected 1 + 1 == 3, but
>
> [16:16:46]         1 + 1 == 2
>
> [16:16:46]         3 == 3
>
> [16:16:46]     not ok 1 - example_simple_test
>
> [16:16:46]
>
> After this change:
> [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> [16:16:46]     Expected 1 + 1 == 3, but
> [16:16:46]         1 + 1 == 2
> [16:16:46]         3 == 3
> [16:16:46]     not ok 1 - example_simple_test
> [16:16:46]
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks! This is a long-overdue fix, and it worked well for me.

Tested-by: David Gow <davidgow@google.com>

One comment below:

>  tools/testing/kunit/kunit_parser.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 8019e3dd4c32..e68b1c66a73f 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -342,7 +342,8 @@ def parse_run_tests(kernel_output) -> TestResult:
>         total_tests = 0
>         failed_tests = 0
>         crashed_tests = 0
> -       test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> +       test_result = parse_test_result(list(
> +            l.rstrip() for l in isolate_kunit_output(kernel_output)))

Could we do this inside isolate_kunit_output() instead? That seems
like it'd be a more logical place for it (removing the newline is a
sort of isolating the output), and it'd avoid making this line quite
as horrifyingly nested.

>         if test_result.status == TestStatus.NO_TESTS:
>                 print(red('[ERROR] ') + yellow('no tests run!'))
>         elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
>
> base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
