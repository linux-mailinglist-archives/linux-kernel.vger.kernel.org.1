Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE62AD051
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgKJHVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgKJHVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:21:05 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:21:03 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id q19so11768144ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tJU1aurExwbUVBfccNutoeNpTC+zhOBLVOQA13GCzvQ=;
        b=uWHW9oTszJEYw3u2jb8lZirZrpGMCMF3U48lt0AqkK0OhZezRKOYV9HVeEnpJFhex/
         OpmsMu8Bupdi4p/aghHOUnyYeYeKPe5rAZg4ebJ+AiNYWzCYKm+e2bf6H757dByjt3B/
         7kS8XceUDbnC0/IxNVurLkcUHBYKe+ZxgiR/sv7/aKmQozHHcmNapD7fo4me52YgMpTB
         49JifLApZOxe26pMA5njEOo4UitVECzWWdbKZiUkUWXoB6C6WlHPhPaNHUSIiHkn93vP
         nCPRwlmWixCRZ0IfpE7BxjQ+cwxjiLfPwcPEbkhU7MLk0dkTovM9pUkf4PCwIk00lkmo
         X6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tJU1aurExwbUVBfccNutoeNpTC+zhOBLVOQA13GCzvQ=;
        b=cY4dMvknU2coPRtn06jtY6NIqD625VSbtrk9WYtsfMkkshq/0Ue6LnMtTXUt0+7X0a
         QYCn6TK3d/LwDyPUO7w2J+cvMYnf04jYkx8unCk1pGyq3tqjujpip6UaJcj5Bj6B0kNY
         FT6n/1/dFuP+j2eocDIV+j1XkSZRIevZk5QMfNsR/vKtOeOOorLvNDBNRxq5Hg04yZnt
         iXu/gmZXYffEpkjWDAJ3KitZaLwxVyKyPyFOywEkAs0Sln5ML7ufHJkWDAYegDQuEbWS
         xOKTPDLzHVtPal18aJiw2RYQl086EfjlSYzBJfgwbNOHEJ0MFKjn/hEK25gGDYq+CCWG
         HZIQ==
X-Gm-Message-State: AOAM533Ivw1gLG2OmNfXbh+Ey6N+kTmviZKVKKrzsurtgS+OdBcYPIk+
        g07t4KSTn/iSbw8UB4ILd90xTryqArOic/Ngmtpatg==
X-Google-Smtp-Source: ABdhPJz8GugbWn35s3Aee6iTYjwpUcVN9a/lKKSwllJpp9+hwk/dLsxsDsPk+0B1PsJbeu7p0y2fyN978Kkm/Yv+ir0=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr8042879ljj.270.1604992861337;
 Mon, 09 Nov 2020 23:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com> <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com>
In-Reply-To: <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 10 Nov 2020 15:20:49 +0800
Message-ID: <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 2:49 PM Arpitha Raghunandan <98.arpi@gmail.com> wrot=
e:
>
> On 07/11/20 3:36 pm, Marco Elver wrote:
> > On Sat, 7 Nov 2020 at 05:58, David Gow <davidgow@google.com> wrote:
> >> On Sat, Nov 7, 2020 at 3:22 AM Arpitha Raghunandan <98.arpi@gmail.com>=
 wrote:
> >>>
> >>> Implementation of support for parameterized testing in KUnit.
> >>> This approach requires the creation of a test case using the
> >>> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> >>> This generator function should return the next parameter given the
> >>> previous parameter in parameterized tests. It also provides
> >>> a macro to generate common-case generators.
> >>>
> >>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >>> Co-developed-by: Marco Elver <elver@google.com>
> >>> Signed-off-by: Marco Elver <elver@google.com>
> >>> ---
> >>
> >> This looks good to me! A couple of minor thoughts about the output
> >> format below, but I'm quite happy to have this as-is regardless.
> >>
> >> Reviewed-by: David Gow <davidgow@google.com>
> >>
> >> Cheers,
> >> -- David
> >>
> >>> Changes v5->v6:
> >>> - Fix alignment to maintain consistency
> >>> Changes v4->v5:
> >>> - Update kernel-doc comments.
> >>> - Use const void* for generator return and prev value types.
> >>> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> >>> - Rework parameterized test case execution strategy: each parameter i=
s executed
> >>>   as if it was its own test case, with its own test initialization an=
d cleanup
> >>>   (init and exit are called, etc.). However, we cannot add new test c=
ases per TAP
> >>>   protocol once we have already started execution. Instead, log the r=
esult of
> >>>   each parameter run as a diagnostic comment.
> >>> Changes v3->v4:
> >>> - Rename kunit variables
> >>> - Rename generator function helper macro
> >>> - Add documentation for generator approach
> >>> - Display test case name in case of failure along with param index
> >>> Changes v2->v3:
> >>> - Modifictaion of generator macro and method
> >>> Changes v1->v2:
> >>> - Use of a generator method to access test case parameters
> >>>
> >>>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
> >>>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-----------=
--
> >>>  2 files changed, 69 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >>> index db1b0ae666c4..16616d3974f9 100644
> >>> --- a/include/kunit/test.h
> >>> +++ b/include/kunit/test.h
> >>> @@ -107,6 +107,7 @@ struct kunit;
> > [...]
> >>> -       kunit_suite_for_each_test_case(suite, test_case)
> >>> -               kunit_run_case_catch_errors(suite, test_case);
> >>> +       kunit_suite_for_each_test_case(suite, test_case) {
> >>> +               struct kunit test =3D { .param_value =3D NULL, .param=
_index =3D 0 };
> >>> +               bool test_success =3D true;
> >>> +
> >>> +               if (test_case->generate_params)
> >>> +                       test.param_value =3D test_case->generate_para=
ms(NULL);
> >>> +
> >>> +               do {
> >>> +                       kunit_run_case_catch_errors(suite, test_case,=
 &test);
> >>> +                       test_success &=3D test_case->success;
> >>> +
> >>> +                       if (test_case->generate_params) {
> >>> +                               kunit_log(KERN_INFO, &test,
> >>> +                                         KUNIT_SUBTEST_INDENT
> >>> +                                         "# %s: param-%d %s",
> >>
> >> Would it make sense to have this imitate the TAP format a bit more?
> >> So, have "# [ok|not ok] - [name]" as the format? [name] could be
> >> something like "[test_case->name]:param-[index]" or similar.
> >> If we keep it commented out and don't indent it further, it won't
> >> formally be a nested test (though if we wanted to support those later,
> >> it'd be easy to add), but I think it would be nicer to be consistent
> >> here.
> >
> > The previous attempt [1] at something similar failed because it seems
> > we'd need to teach kunit-tool new tricks [2], too.
> > [1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.google.com
> > [2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.google.com
> >
> > So if we go with a different format, we might need a patch before this
> > one to make kunit-tool compatible with that type of diagnostic.
> >
> > Currently I think we have the following proposals for a format:
> >
> > 1. The current "# [test_case->name]: param-[index] [ok|not ok]" --
> > this works well, because no changes to kunit-tool are required, and it
> > also picks up the diagnostic context for the case and displays that on
> > test failure.
> >
> > 2. Your proposed "# [ok|not ok] - [test_case->name]:param-[index]".
> > As-is, this needs a patch for kunit-tool as well. I just checked, and
> > if we change it to "# [ok|not ok] - [test_case->name]: param-[index]"
> > (note the space after ':') it works without changing kunit-tool. ;-)
> >
> > 3. Something like "# [ok|not ok] param-[index] - [test_case->name]",
> > which I had played with earlier but kunit-tool is definitely not yet
> > happy with.
> >
> > So my current preference is (2) with the extra space (no change to
> > kunit-tool required). WDYT?
> >

Hmm=E2=80=A6 that failure in kunit_tool is definitely a bug: we shouldn't c=
are
what comes after the comment character except if it's an explicit
subtest declaration or a crash. I'll try to put a patch together to
fix it, but I'd rather not delay this just for that.

In any thought about this a bit more, It turns out that the proposed
KTAP spec[1] discourages the use of ':', except as part of a subtest
declaration, or perhaps an as-yet-unspecified fully-qualified test
name. The latter is what I was going for, but if it's actively
breaking kunit_tool, we might want to hold off on it.

If we were to try to treat these as subtests in accordance with that
spec, the way we'd want to use one of these options:
A) "[ok|not ok] [index] - param-[index]" -- This doesn't mention the
test case name, but otherwise treats things exactly the same way we
treat existing subtests.

B) "[ok|not ok] [index] - [test_case->name]" -- This doesn't name the
"subtest", just gives repeated results with the same name.

C) "[ok|not ok] [index] - [test_case->name][separator]param-[index]"
-- This is equivalent to my suggestion with a separator of ":", or 2
above with a separator of ": ". The in-progress spec doesn't yet
specify how these fully-qualified names would work, other than that
they'd use a colon somewhere, and if we comment it out, ": " is
required.

>
> Which format do we finally go with?
>

I'm actually going to make another wild suggestion for this, which is
a combination of (1) and (A):
"# [test_case->name]: [ok|not ok] [index] - param-[index]"

This gives us a KTAP-compliant result line, except prepended with "#
[test_case->name]: ", which makes it formally a diagnostic line,
rather than an actual subtest. Putting the test name at the start
matches what kunit_tool is expecting at the moment. If we then want to
turn it into a proper subtest, we can just get rid of that prefix (and
add the appropriate counts elsewhere).

Does that sound good?


> [...]

Thanks,
-- David

[1]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8=
163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/
