Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10562A9CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgKFSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgKFSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:46:10 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96392C0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:46:10 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id a15so435569otf.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElN3AyTjh5aMXmGHUFTcrTsMazikTf7o2LtiuSniYZ4=;
        b=D5+Q8S8gQ/D72X/54r2aCENNdmG3qQ/uSOs4qlrC+meTGrBxWzyUhbGN5AcVRTbEoX
         aBSlJSl6MMdPmek/r8GTKw7FWl8xaY2+bPHhNZzTHG/0p2owpuWq/aKHsdju2u8Fnvzi
         vUDnyU57uiirO5PL4roeYjBl10DFZqt4pZ5UO/cJGeBRMCpUP0Hh/3nCf1LJ50MLGTOb
         1mRyWLZT4mNkiGXwj1Y4seayHJZR0/rogLS8o4xfuxPZsiC75TDzUe7IbEPkul49oP6t
         YZmd+0T8fWEzyfDN/uM1DegNmzRu9xJlEABocHUEQaG6ygy2Lvg9lKy3Vb+HQqWkvMXg
         lY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElN3AyTjh5aMXmGHUFTcrTsMazikTf7o2LtiuSniYZ4=;
        b=Mt/zpE4a6fzCC4K6TPJFe7b7XE8meVSARZkLV/r/pLjxe5WF/JSqF3OS0xpccR6ghw
         0MujZo+gJZOWuUa3x/tvPkx13eqSZRD8UKq17oHdelgTuxbA8YoGw4Z8L/g90vUe1QWU
         yNS2NUS3m4Q/QpAbQgf7Y5uiOSN+XyScPxIDS8QF40zomxq8EyLXGr55uqOQ4neJkBIS
         7/ZbN5j1ETC8syDjcTKdMu3MHRSwrezFUD58TepsST8d+gTV/7/1FuIkqO0H/2WCIcl2
         JJE/0WlKoTyc2LVOBxfNU5uuj7kIa7sZQWTnbgfZY6GOEErzSTBYeiU1uWd9huFo73yQ
         4hLw==
X-Gm-Message-State: AOAM531RQBLXTwd7IRfU2Zfo7RGcC0zFmUI1TLvKWsOuxgw6chkTR8Uu
        aLXR27HC9jZsqKjDTO+twkR53qndeCO2efEDXYe6MA==
X-Google-Smtp-Source: ABdhPJyh/Y4j/Wq2GsZz2D7bg/jo7/og/6yXxY6CRqxe+L0UEXv1UfKub2quFBwezIXP7sjaOGFzFmPQYxb0C85z3RU=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr1868950oth.251.1604688369657;
 Fri, 06 Nov 2020 10:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106182657.30492-1-98.arpi@gmail.com>
In-Reply-To: <20201106182657.30492-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 19:45:58 +0100
Message-ID: <CANpmjNPsACW1mZmkWiCSeXfvAGaxAS5sHtYMu0-DfE7ec2pFMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 19:28, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
[...]
> -       kunit_suite_for_each_test_case(suite, test_case)
> -               kunit_run_case_catch_errors(suite, test_case);
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               bool test_success = true;
> +
> +               if (test_case->generate_params)
> +                       test.param_value = test_case->generate_params(NULL);
> +
> +               do {
> +                       kunit_run_case_catch_errors(suite, test_case, &test);
> +                       test_success &= test_case->success;
> +
> +                       if (test_case->generate_params) {
> +                               kunit_log(KERN_INFO, &test,
> +                                       KUNIT_SUBTEST_INDENT
> +                                       "# %s: param-%d %s",
> +                                       test_case->name, test.param_index,
> +                                       kunit_status_to_string(test.success));

Sorry, I still found something. The patch I sent had this aligned with
the '(', whereas when I apply this patch it no longer is aligned. Why?

I see the rest of the file also aligns arguments with opening '(', so
I think your change is inconsistent.

Thanks,
-- Marco
