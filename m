Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778932F7682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbhAOKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbhAOKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:19:32 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1817C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:18:52 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id h1so3688768qvy.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccivHPXPZm7za6CxMewEAR4fuE99UUFG/9IwgtB77NU=;
        b=uo1dSCvmZPsHPZ6jxqO+IuQMcCL2/T9xiHyCoBb8ZMS3+fpZaU+iTpCFsP6JW0JCOn
         1vyQf5tFXjOw0KXULmXDNkqQZAZ5uAEeEqiHwQx11N3zAd/4tBg0mhhToIxKE8QnMUlo
         pB2jkgOHCuic0ucyT9tMYSeo2qyWZ96+F85aVXlDdFc+35Odo7YP6PHOZoCF9xDbXnhq
         cdT8x9x2RZVIjOoNg4DrtnC+k48yaOz6WAmc0/YGQVhw+uvgfoiVrlfJ7YR0QBVrH8hQ
         6GZ7Q1w6VxFpC/PHfzDfISQv4W8uzeVSh/jI66OVa/L717sjASAJGLmxZn+xJUoqSuvh
         ny1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccivHPXPZm7za6CxMewEAR4fuE99UUFG/9IwgtB77NU=;
        b=bHjSd+Qo21kJtP81Ueyt52PB3g2mJLNS4Nw099szYeRilzANgkMtFQrK9BU2upwZZ8
         /UywyyjExUMPFu2BmX+FQnvje2VM8a/F/X710xmoXElvn/IhlNGAUJ2MvlK+yDgFGDIK
         YqI/bhtzPTyNYaN75KBqUkK9IM9aMRSZqunimyT4l3ZGvc5tBcJSst1M0LgZGJaJyI7a
         sigDM4louj8SR4BPCJB2XorUpR1XbSV1V1XypEQOtzokJ31izhi8x7Qcfe3G5T7nkwKa
         msfjMC0fqzmNsADC876G6gvFMFLIIt2nzjCh4hH5DRHf6K24x6WHTv2YZTlzMWyl1sTU
         6ZkA==
X-Gm-Message-State: AOAM5311HyJ01dcELsNG/kGaufjBth6Ine3CpiaKSLuT9RBOV2xOLRZZ
        0OiKt7MN9EHfQuOciCc5IJVgHyOENCrQFZK4lsq1dfbQbA7ru6um
X-Google-Smtp-Source: ABdhPJyL4bnK7DqSx1oVKrhp+leBeNzcqxbQ7JPj4EaChQSuBbxh1MheeX7oEcc4IwuO2Qo6PaEmUeXoqDKtBK+VzdQ=
X-Received: by 2002:a0c:e90a:: with SMTP id a10mr11514765qvo.38.1610705930918;
 Fri, 15 Jan 2021 02:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com> <20210113091657.1456216-3-glider@google.com>
 <20210113160612.32f8b67494521ce23cc9cba5@linux-foundation.org> <CAG_fn=Uazu=RTW_-TizPU89KpHUR6akeTSvfhxJVJDSGuHJHLA@mail.gmail.com>
In-Reply-To: <CAG_fn=Uazu=RTW_-TizPU89KpHUR6akeTSvfhxJVJDSGuHJHLA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 11:18:39 +0100
Message-ID: <CAG_fn=WkhAvnz66czojXdWt4DNSSfo-H_2Fnm1N+NTvj10Lk8A@mail.gmail.com>
Subject: Re: [PATCH 2/4] lib: add error_report_notify to collect debugging
 tools' reports
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:51 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 1:06 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 13 Jan 2021 10:16:55 +0100 Alexander Potapenko <glider@google.com> wrote:
> >
> > > With the introduction of various production error-detection tools, such as
> > > MTE-based KASAN and KFENCE, the need arises to efficiently notify the
> > > userspace OS components about kernel errors. Currently, no facility exists
> > > to notify userspace about a kernel error from such bug-detection tools.
> > > The problem is obviously not restricted to the above bug detection tools,
> > > and applies to any error reporting mechanism that does not panic the
> > > kernel; this series, however, will only add support for KASAN and KFENCE
> > > reporting.
> > >
> > > All such error reports appear in the kernel log. But, when such errors
> > > occur, userspace would normally need to read the entire kernel log and
> > > parse the relevant errors. This is error prone and inefficient, as
> > > userspace needs to continuously monitor the kernel log for error messages.
> > > On certain devices, this is unfortunately not acceptable. Therefore, we
> > > need to revisit how reports are propagated to userspace.
> > >
> > > The library added, error_report_notify (CONFIG_ERROR_REPORT_NOTIFY),
> > > solves the above by using the error_report_start/error_report_end tracing
> > > events and exposing the last report and the total report count to the
> > > userspace via /sys/kernel/error_report/last_report and
> > > /sys/kernel/error_report/report_count.
> > >
> > > Userspace apps can call poll(POLLPRI) on those files to get notified about
> > > the new reports without having to watch dmesg in a loop.
> >
> > It would be nice to see some user-facing documentation for this, under
> > Documentation/.  How to use it, what the shortcomings are, etc.
>
> Good point, will do.
Added in v2.

> > For instance...  what happens when userspace is slow reading
> > /sys/kernel/error_report/last_report?  Does that file buffer multiple
> > reports?  Does the previous one get overwritten?  etc.  Words on how
> > this obvious issue is handled...
>
> Yes, there can be issues with overwriting, and the recommended way to
> handle them would be to check the value in
> /sys/kernel/error_report/report_count before and after reading the
> report.

After looking closer it occurs to me that sysfs retains the buffer
returned by the attribute's show() method, so that one can read the
whole report up to the end even if the file contents change.

> > There's really nothing "memory" specific about this?  Any kernel
> > subsystem could use it?
>
> Indeed. Perhaps it's better to emphasize "production" here, because
> users of debugging tools are more or less happy with dmesg output.

Changed to "error reports from debugging tools".
