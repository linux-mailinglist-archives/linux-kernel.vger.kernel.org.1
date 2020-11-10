Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39222AD438
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgKJK6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:58:43 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED30C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:58:43 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id u127so13843497oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94tiZd4Xfo6idGbxmiXDVBxg8Gu69WxG80x6rMgUhQQ=;
        b=Wln8ylEoEHqFMf/a2BD4fDClafPZLlRCqtI8EEk95v6Uk78e1f/riTCVHWK31P16F7
         5t6Klxhxot3Cs6C1X2oMq2efacvNRcKpFgg3PRXj3kYQD2IUnm9SnAf2sNvCj+vbXvFF
         +A36dSgA1HYYcTumf5A/5mkM3skgc8kH6AkC23EtUMfLbd15h/3+NhbC1Lej3jiJ6+qy
         i93CJnmu54HKAE44JYDF5R4ZuruIvX8dTGklV2Sb1ovJd5eTnTsZ8hkl5TKLA4RzXj3M
         ckwRm8jh5HzzDtIP8D+FDYrzxL2Um+novRjUPQRK/16QFGRPWoGxqAQjxX03NfexO67B
         PSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94tiZd4Xfo6idGbxmiXDVBxg8Gu69WxG80x6rMgUhQQ=;
        b=nT6BQ1NYFqv85Y5ImH309J1Iaw2u5B6zaUiFx2gujwZ2UZMeqO3VAxYLRqEeuLhsC+
         8glIw49AOwXWLrHUkLZNtKUctsuENzMCGeJg6jJVgNRe6Z0af7dvNo/AiLaDG+B/czYn
         QvdPI8ii65xizkYOdkr/wV7q2/TcyljdH7J+v+z1ubRo7gRX901FzWZQMugxvE+UChKZ
         TonD4RIQqDH0GShXnazg0Sf/4DkSPxEDnrixfjgaZczW7rINSFNziJ/j6dfLjfXQHxA7
         +xhXs+IVDkHFQobayuFqNX2V1Cm3rgmFsXQRtGPt/be97W9Rb8jkxm8Ky1raZ9n6Cz5V
         olSw==
X-Gm-Message-State: AOAM531U/++YT+VYyybCURHhte7uJ4wWYtB1sFmwMlcXGfjORV4SQbG9
        OIP39GkVTYOxm/1MLb1//e6ZMxo4TCikiDWbULu+vw==
X-Google-Smtp-Source: ABdhPJwxeroz4djU/HfOYnlpWJSxXVwoptInlidQ6W6O3cU1eGTEiAgfeIUJ5t9PI8CAY9/biuXDB33G6ERM6TPfPPw=
X-Received: by 2002:aca:a988:: with SMTP id s130mr2454674oie.172.1605005922432;
 Tue, 10 Nov 2020 02:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20201110072936.1380718-1-davidgow@google.com>
In-Reply-To: <20201110072936.1380718-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Nov 2020 11:58:31 +0100
Message-ID: <CANpmjNPnB1ODuDqpMMO1horTV=3+NQv0gxEpnDwGDOV540cDhA@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_tool: Correctly parse diagnostic messages
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 08:29, David Gow <davidgow@google.com> wrote:
>
> Currently, kunit_tool expects all diagnostic lines in test results to
> contain ": " somewhere, as both the subtest header and the crash report
> do. Fix this to accept any line starting with (minus indent) "# " as
> being a valid diagnostic line.
>
> This matches what the TAP spec[1] and the draft KTAP spec[2] are
> expecting.
>
> [1]: http://testanything.org/tap-specification.html
> [2]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  tools/testing/kunit/kunit_parser.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 84a1af2581f5..dab4cfa05b74 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -134,8 +134,8 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
>         else:
>                 return False
>
> -SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
> -DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
> +SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
> +DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
>
>  def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
>         save_non_diagnositic(lines, test_case)
> @@ -145,7 +145,8 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
>         match = SUBTEST_DIAGNOSTIC.match(line)
>         if match:
>                 test_case.log.append(lines.pop(0))
> -               if match.group(1) == DIAGNOSTIC_CRASH_MESSAGE:
> +               crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
> +               if crash_match:
>                         test_case.status = TestStatus.TEST_CRASHED
>                 return True
>         else:
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
