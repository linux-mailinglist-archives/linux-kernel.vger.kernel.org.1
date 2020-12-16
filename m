Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D772DB740
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLPACh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgLPACa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:02:30 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC043C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:01:49 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id o19so18281781lfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVSflnXiXntLq5/ch4bF1VXq0KaR1oi2x5u9KZC75HY=;
        b=wFlnJun9/XeRHTFC3ffowldAtj2OYQoZOqEqbFt0GxKEitHna5YUFlO9ckHneRijcC
         rsPeSVE5P5iBnwnHPkTVYhfuYj8GGYiZfAA/HpZuxmf+OhKakVfFKXy/FBOeGxfp8T1V
         sSzfui3K6B7iGio2YU4PJbdxSaDX/hhzmkLzBmCE+ZWyQbuj0RTXdTOqUsKFrX/NLzdg
         MyGkA9D+Z88r0au13X8snMSJSoLdwWyQJHAFhdwQvyY0ufXzydXSrt9Fjr30FPlyXuem
         i3UPF0fsmekFZVw2TqyrdJYDwpuT1uX8c3/3oimBqsDhdicXPVh0L93R5u3aOr9HhQLD
         CYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVSflnXiXntLq5/ch4bF1VXq0KaR1oi2x5u9KZC75HY=;
        b=W2EPDIJEDVDDn/DHk2eFQCBoj37/iOXlMFlvFnYHqz/aFDBc6nnvC95lk8xy3Y/a9r
         QSSYqWsSNW/osjRg4oBdIyaQcf75eUAFYiLHhJYEoKfms4keXw/eHVmClG3sBR7xhGoM
         8Ftc98FXsAnsAtlYcZaJ6EGp6of8u/ICcFbZO2agmewHKYKd1hi+XR0zQxwz0BEWXHoK
         pHaSc64PxnvtAM+djf+w8B7WdV1q0wDNF8OtWpL5EPLmMqBI/YGxziByurVbtwlwA2a4
         mVmY5RmQnL6rSWGIau6BJ7Ile5q79o9W3x7V3as7JMG1hj8IYmVOPFn2vcHy4NF8CzcV
         52pg==
X-Gm-Message-State: AOAM530ggHiu+Agz5RYFKq3bgtXaKlxReEobxvFiLHMKYBWYqqNBXequ
        wdFnIWwKMfLPYTJLy6yKGwdyGlunT7l2ZtQLOeMxJg==
X-Google-Smtp-Source: ABdhPJx5ka9p/v0c5aLtvlF2Z/Wk9Lnh4hiWxuZhF3Sihug+3JdyMHc6JXCZXIdDlwoctBMkCUQqrwcqrbMcvgeCjcg=
X-Received: by 2002:a19:4c84:: with SMTP id z126mr11269539lfa.69.1608076908063;
 Tue, 15 Dec 2020 16:01:48 -0800 (PST)
MIME-Version: 1.0
References: <feef4f9a-4ed8-8a2e-d330-88e7f516faae@gmail.com>
 <X9lBp3BHbwcTmDqb@pc.thejh.net> <0e5189c0-9e9b-ac34-825c-619a9a6ef682@gmail.com>
 <d38c5e8b-1653-d89a-a0c8-b95cb1844fba@gmail.com>
In-Reply-To: <d38c5e8b-1653-d89a-a0c8-b95cb1844fba@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 16 Dec 2020 01:01:21 +0100
Message-ID: <CAG48ez0y21uWBDuaczLMxLPpFTKABrgm+-aqLb-0a4rHuOCX-g@mail.gmail.com>
Subject: Re: [Bug 210655] ptrace.2: documentation is incorrect about access
 checking threads in same thread group
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Jann Horn <jann@thejh.net>, Pavel Emelyanov <xemul@openvz.org>,
        Oleg Nesterov <oleg@tv-sign.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ted Estes <ted@softwarecrafters.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:25 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
> On 12/16/20 12:23 AM, Alejandro Colomar (man-pages) wrote:
> > On 12/16/20 12:07 AM, Jann Horn wrote:
> >> Am Tue, Dec 15, 2020 at 06:01:25PM +0100 schrieb Alejandro Colomar (man-pages):
> >>> There's a bug report: https://bugzilla.kernel.org/show_bug.cgi?id=210655
> >>>
> >>> [[
> >>> Under "Ptrace access mode checking", the documentation states:
> >>>   "1. If the calling thread and the target thread are in the same thread
> >>> group, access is always allowed."
> >>>
> >>> This is incorrect. A thread may never attach to another in the same group.
> >>
> >> No, that is correct. ptrace-mode access checks do always short-circuit for
> >> tasks in the same thread group:
> >>
> >> /* Returns 0 on success, -errno on denial. */
> >> static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
> >> {
> >> [...]
> >>         /* May we inspect the given task?
> >>          * This check is used both for attaching with ptrace
> >>          * and for allowing access to sensitive information in /proc.
> >>          *
> >>          * ptrace_attach denies several cases that /proc allows
> >>          * because setting up the necessary parent/child relationship
> >>          * or halting the specified task is impossible.
> >>          */
> >>
> >>         /* Don't let security modules deny introspection */
> >>         if (same_thread_group(task, current))
> >>                 return 0;
> >> [...]
> >> }
> >
> > AFAICS, that code always returns non-zero,
>
> Sorry, I should have said "that code never returns 0".
>
> > at least when called from ptrace_attach().

Yes.

> > As you can see below,
> > __ptrace_may_access() is called some lines after
> > the code pointed to by the bug report.
> >
> >
> > static int ptrace_attach(struct task_struct *task, long request,
> >                        unsigned long addr,
> >                        unsigned long flags)
> > {
> > [...]
> >       if (same_thread_group(task, current))
> >               goto out;
> >
> >       /*
> >        * Protect exec's credential calculations against our interference;
> >        * SUID, SGID and LSM creds get determined differently
> >        * under ptrace.
> >        */
> >       retval = -ERESTARTNOINTR;
> >       if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
> >               goto out;
> >
> >       task_lock(task);
> >       retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> > [...]
> > }

I said exactly that in my last mail:

> >> As the comment explains, you can't actually *attach*
> >> to another task in the same thread group; but that's
> >> not because of the ptrace-style access check rules,
> >> but because specifically *attaching* to another task
> >> in the same thread group doesn't work.

As I said, attaching indeed doesn't work. But that's not what "Ptrace
access mode checking" means. As the first sentence of that section
says:

| Various parts of the kernel-user-space API (not just ptrace()
| operations), require so-called "ptrace access mode" checks,
| whose outcome determines whether an operation is
| permitted (or, in a  few cases,  causes  a "read" operation
| to return sanitized data).

You can find these places by grepping for \bptrace_may_access\b -
operations like e.g. the get_robust_list() syscall will always succeed
when inspecting other tasks in the caller's thread group thanks to
this rule.
