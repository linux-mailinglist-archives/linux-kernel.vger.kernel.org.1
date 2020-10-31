Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C92A1361
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 05:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgJaEB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 00:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaEB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 00:01:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772FC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 21:01:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so9051538ljg.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 21:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETtqSrQhvAh1kNurb1hmA5QcXFWk0AIhIay9EmRKULE=;
        b=mHiQjW815EHewCpRcXjUgBXggmms34FwzyqgZC7aIm7n7geiTuNeF6EswiM3Kc5kGl
         t2+6HJ8eps93bd1YNv9SKTmKsI7gyrbrjV28ZsxCY2v6ByoLzBiH+5jrmDxoxVMUqfvA
         Ffqe9ZoutlC3Ze5SJeQqUGtZEHclUOYjOtacm/IzhtsBN7OHXZmR4vs4r1sGhbmqoLJ2
         XnnGTLf7aWYLEytSagawhVKvtbd/AbZSBlRqHcuzK6NPY1judRZpwjNJ7YXQlzshiW6i
         XxtpqSKNUlJav9eXYp3QlnxgopIZIC8VUjtj+GJEhfa9C9/V1mLOEg8CubWdn830KE3O
         WSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETtqSrQhvAh1kNurb1hmA5QcXFWk0AIhIay9EmRKULE=;
        b=njWBTS92AUGQLICO+c5UZPD+DyiEBkbpySGnOoBihUVZ093A3Ggjau0zk3Jys08k7M
         Z57q9fpmnUXK/+4YPQI1VX5kITC96Yl4ab5q5MEq7oNFoV6qhMVzzvOsm7IJBg6SH7+5
         zNy30ILSJ4FmBNXmn6y5/Hc4PkHu8JsA6KGsv9SKGGimjmMsqVY1JrEqEern3PNBXJCP
         ng8Ksksvs7VdKeeCS0HBCdAq9E+kWXIiWiWZI39ekQaLKx40SrkP35KSUEqvW1z8hjo0
         fySiTGC6JesTxnYgIXaAoSu7ptCgC3IzkpO42lIL5UNBU+xqh9CkRdBgCfNT4uwjU+k0
         cj0A==
X-Gm-Message-State: AOAM531g8zSVsUoTzKTkXrFQndOrrn153T/jMUGSnsXviUoZXNRXJ7ek
        8N3S+zWkGf8S7EpSKXRx70oh++XAszSZKgzVh9n8dQ==
X-Google-Smtp-Source: ABdhPJwLljGjbuVkn45WqSFbkW+Y4oSPE4gIh9HxQfVQ2vX401iUH6Xg48APQHoBApEEU5fyzmueYps8M0P75O01c+Y=
X-Received: by 2002:a2e:7c0f:: with SMTP id x15mr2131261ljc.401.1604116915849;
 Fri, 30 Oct 2020 21:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201030223853.554597-1-dlatypov@google.com>
In-Reply-To: <20201030223853.554597-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 31 Oct 2020 12:01:44 +0800
Message-ID: <CABVgOSkTnBpvUGYFUmdrW=ouMsrG__BeU36YAo8D6Kco4NGMFA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix extra trailing \n in raw + parsed test output
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

On Sat, Oct 31, 2020 at 6:39 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> For simplcity, strip all trailing whitespace from parsed output.
> I imagine no one is printing out meaningful trailing whitespace via
> KUNIT_FAIL() or similar, and that if they are, they really shouldn't.
>
> `isolate_kunit_output()` yielded liens with trailing \n, which results
> in artifacty output like this:
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
> We should *not* be expecting lines to end with \n in kunit_tool_test.py
> for this reason.
>
> Do the same for `raw_output()` as well which suffers from the same
> issue.
>
> This is a followup to [1], but rebased onto kunit-fixes to pick up the
> other raw_output() fix and fixes for kunit_tool_test.py.
>
> [1] https://lore.kernel.org/linux-kselftest/20201020233219.4146059-1-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks!

I tried this out against everything I could (including the nastier
--alltests option), and didn't hit any problems, so it looks good to
go to me!

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
