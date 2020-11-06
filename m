Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360FD2A910A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgKFILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgKFILi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:11:38 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BDBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:11:37 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i18so551887ots.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qv+2fhKomPyM/Arm56dvQoUMdEAVFc/83vyB1HdFckk=;
        b=q/n2tTky7OkAqP8C6pWfwUzofJAe1/aH2LP6nRy8e86QEOAggOB2RABoWjxSqYs44w
         qiIby2q8K4FhstReXQ6XkcFr9tWdN0X6NV50+6/UqHfxtceRcfWAvIrZZ2ETjDWbQBRC
         LwzbC79eYqSOJV8XQTOzXRspkiTzY5nfYqOuo+TnW2BMmy0eAbGAke985JGk3hdcYdEo
         2UifHWiv+Z1Bj1bZqjfYYEbkXmLbhMTyGF6gmXReU2yayfvwesZ7H0R8ysw78y+UJisu
         oPWhbTXcAhmd6+XpKTS+IuhvQMAwO1Hl/dHQUiHZJiduF8KveOG+BkMNYS1MP76sb4CN
         k1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv+2fhKomPyM/Arm56dvQoUMdEAVFc/83vyB1HdFckk=;
        b=TZWq50uDDOyscZYkCJxkRqueJO8bCIDnaxWxqi0dh8B+mxMaM5hCRnAhD31dBMLvsF
         dwsWBdo4SM7tWeGf9st4VeuyUzmKcQpALTKH/liHUY+1rWGbNgRzAeIFpJRenNnTtkEP
         pb0rBLNkHu0VObwRQqYx7h3rTdWY8kVEo10HXt6piZ1Og0w+AP8uJ85WtaA8IPGJ4VdH
         JIxy8V8ppEILaJm6wYnMWppppOXehPhgx0I2nsinYenraj83yx7yED7WzALa/KaTz+ws
         dU/Sea/NXHIOnojM0WdOL3F4El3xLL3YSRI3vkyJivImmpx9jMBBHp8V2QDTvU2NGWsT
         EosQ==
X-Gm-Message-State: AOAM531wq8X9eSJ7+yjCIdY9mojqTpuBJ4wAKbm5gvjgQKlyJbwIE9K2
        6jPt/0DZ/1eQFmVnD4z8WCwCW4o9tFFtFl0S/88xdA==
X-Google-Smtp-Source: ABdhPJxC97FTLyOYcZyRpKP24T4PE7eX1pOb+QJrOBjrg70qARJkigVK455YCAtXpI2MxrBmhKX6SAd/yLl4g04HNo8=
X-Received: by 2002:a9d:f44:: with SMTP id 62mr426221ott.17.1604650296929;
 Fri, 06 Nov 2020 00:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20201027174630.85213-1-98.arpi@gmail.com> <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
 <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com> <CANpmjNPxqQM0_f14ZwV3rHZzwhCtqx2fbOhHmXmiJawou6=z6Q@mail.gmail.com>
 <77d6dc66-1086-a9ae-ccbc-bb062ff81437@gmail.com> <CANpmjNORLJ4b_uwBB8v2h5cxoZF2SMTaz5K6QP37PxdUJDZUDA@mail.gmail.com>
 <20201105195503.GA2399621@elver.google.com> <f7e04221-607c-dd05-24a6-27c26d86919d@gmail.com>
In-Reply-To: <f7e04221-607c-dd05-24a6-27c26d86919d@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 09:11:25 +0100
Message-ID: <CANpmjNMH9v3RE9xCh9nS=ZmBboxAsMvhfgby+QEO=Q3-oEyiNA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: Support for Parameterized Testing
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

On Fri, 6 Nov 2020 at 06:54, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 06/11/20 1:25 am, Marco Elver wrote:
> > On Thu, Nov 05, 2020 at 04:02PM +0100, Marco Elver wrote:
> >> On Thu, 5 Nov 2020 at 15:30, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> > [...]
> >>>>> I tried adding support to run each parameter as a distinct test case by
> >>>>> making changes to kunit_run_case_catch_errors(). The issue here is that
> >>>>> since the results are displayed in KTAP format, this change will result in
> >>>>> each parameter being considered a subtest of another subtest (test case
> >>>>> in KUnit).
> >>>>
> >>>> Do you have example output? That might help understand what's going on.
> >>>>
> >>>
> >>> The change that I tried can be seen here (based on the v4 patch):
> >>> https://gist.github.com/arpi-r/4822899087ca4cc34572ed9e45cc5fee.
> >>>
> >>> Using the kunit tool, I get this error:
> >>>
> >>> [19:20:41] [ERROR]  expected 7 test suites, but got -1
> >>> [ERROR] no tests run!
> >>> [19:20:41] ============================================================
> >>> [19:20:41] Testing complete. 0 tests run. 0 failed. 0 crashed.
> >>>
> >>> But this error is only because of how the tool displays the results.
> >>> The test actually does run, as can be seen in the dmesg output:
> >>>
> >>> TAP version 14
> >>> 1..7
> >>>     # Subtest: ext4_inode_test
> >>>     1..1
> >>>     ok 1 - inode_test_xtimestamp_decoding 1
> >>>     ok 1 - inode_test_xtimestamp_decoding 2
> >>>     ok 1 - inode_test_xtimestamp_decoding 3
> >>>     ok 1 - inode_test_xtimestamp_decoding 4
> >>>     ok 1 - inode_test_xtimestamp_decoding 5
> >>>     ok 1 - inode_test_xtimestamp_decoding 6
> >>>     ok 1 - inode_test_xtimestamp_decoding 7
> >>>     ok 1 - inode_test_xtimestamp_decoding 8
> >>>     ok 1 - inode_test_xtimestamp_decoding 9
> >>>     ok 1 - inode_test_xtimestamp_decoding 10
> >>>     ok 1 - inode_test_xtimestamp_decoding 11
> >>>     ok 1 - inode_test_xtimestamp_decoding 12
> >>>     ok 1 - inode_test_xtimestamp_decoding 13
> >>>     ok 1 - inode_test_xtimestamp_decoding 14
> >>>     ok 1 - inode_test_xtimestamp_decoding 15
> >>>     ok 1 - inode_test_xtimestamp_decoding 16
> >>> ok 1 - ext4_inode_test
> >>> (followed by other kunit test outputs)
> >>
> >> Hmm, interesting. Let me play with your patch a bit.
> >>
> >> One option is to just have the test case number increment as well,
> >> i.e. have this:
> >> |    ok 1 - inode_test_xtimestamp_decoding#1
> >> |    ok 2 - inode_test_xtimestamp_decoding#2
> >> |    ok 3 - inode_test_xtimestamp_decoding#3
> >> |    ok 4 - inode_test_xtimestamp_decoding#4
> >> |    ok 5 - inode_test_xtimestamp_decoding#5
> >> ...
> >>
> >> Or is there something else I missed?
> >
> > Right, so TAP wants the exact number of tests it will run ahead of time.
> > In which case we can still put the results of each parameterized test in
> > a diagnostic. Please see my proposed patch below, which still does
> > proper initialization/destruction of each parameter case as if it was
> > its own test case.
> >
> > With it the output looks as follows:
> >
> > | TAP version 14
> > | 1..6
> > |     # Subtest: ext4_inode_test
> > |     1..1
> > |     # ok param#0 - inode_test_xtimestamp_decoding
> > |     # ok param#1 - inode_test_xtimestamp_decoding
> > |     # ok param#2 - inode_test_xtimestamp_decoding
> > |     # ok param#3 - inode_test_xtimestamp_decoding
> > |     # ok param#4 - inode_test_xtimestamp_decoding
> > |     # ok param#5 - inode_test_xtimestamp_decoding
> > |     # ok param#6 - inode_test_xtimestamp_decoding
> > |     # ok param#7 - inode_test_xtimestamp_decoding
> > |     # ok param#8 - inode_test_xtimestamp_decoding
> > |     # ok param#9 - inode_test_xtimestamp_decoding
> > |     # ok param#10 - inode_test_xtimestamp_decoding
> > |     # ok param#11 - inode_test_xtimestamp_decoding
> > |     # ok param#12 - inode_test_xtimestamp_decoding
> > |     # ok param#13 - inode_test_xtimestamp_decoding
> > |     # ok param#14 - inode_test_xtimestamp_decoding
> > |     # ok param#15 - inode_test_xtimestamp_decoding
> > |     ok 1 - inode_test_xtimestamp_decoding
> > | ok 1 - ext4_inode_test
> >
> > Would that be reasonable? If so, feel free to take the patch and
> > test/adjust as required.
> >
> > I'm not sure on the best format -- is there is a recommended format for
> > parameterized test result output? If not, I suppose we can put anything
> > we like into the diagnostic.
> >
>
> I think this format of output should be fine for parameterized tests.
> But, this patch has the same issue as earlier. While, the tests run and
> this is the output that can be seen using dmesg, it still causes an issue on
> using the kunit tool. It gives a similar error:
>
> [11:07:38] [ERROR]  expected 7 test suites, but got -1
> [11:07:38] [ERROR] expected_suite_index -1, but got 2
> [11:07:38] [ERROR] got unexpected test suite: kunit-try-catch-test
> [ERROR] no tests run!
> [11:07:38] ============================================================
> [11:07:38] Testing complete. 0 tests run. 0 failed. 0 crashed.
>

I'd suggest testing without these patches and diffing the output.
AFAIK we're not adding any new non-# output, so it might be a
pre-existing bug in some parsing code. Either that, or the parsing
code does not respect the # correctly?

Thanks,
-- Marco
