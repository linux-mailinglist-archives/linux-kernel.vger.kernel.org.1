Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AF2EB8F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAFEaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbhAFEaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:30:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC5C06134D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 20:29:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s26so3711603lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 20:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGZhC2xpsnbKpiPKTbZzapmNsqmvVzf26wtQMSLPyWQ=;
        b=WmbMaBma2vnpsj9xAF30KVT18cCjMeLuG7vfriPQMmwK8sB0MvVJ4z4RPVS97rpY4z
         gmREnPnEA2NkXFxS4U69YgtlUmEHfQEQ5HAvevDdoDukSuxkQZ16FZK6DIXAsb+5o+Co
         mtzgFQj29uh6YiekvBcMW/sAULb6CcBFpTN859M5KykxkGos9f/I0UyPRBs45+1pe81t
         5QbXH75MeTlMT3E9/5EAwouwjUPsWTTiv+xZH/ErBifwWwi3m3ba1f3BQkaI7ENlC3gm
         3+0wjJpbJKlOtCVU6sM+4nbegwDbImIucxGnJtgIHyohFs/LXgbLufB1ZrCpS9RwnWqC
         mZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGZhC2xpsnbKpiPKTbZzapmNsqmvVzf26wtQMSLPyWQ=;
        b=PJuxrEmMGR/1zht4/uX4jGrp6NxUvviEkfRiHp5PyVkGMZgEayT4VUGuZx6m2QnrSS
         LAcDQAoMWukuU74VaDsb/0Ixv99Di7AVpRbe828ZUbOTJV08J73c9QU6+gNPgwSl/u15
         xrvvx5o8S2KuJdzEv1k8ApDSXX5vf1krv2bmaqXoyGFsoSL2rt99XB/oPV72oFxbgzFP
         bfCpYo/iVxDZja6KWBRZ8D4GjO2pxz9BAjmE7L6C3ggaf+8NKFLd3Z0ma42p8+K1U4F7
         BSuIIF2uyAA4KxaJPor0VvHlPW+0VfzYeinLwwlK6c0Bw5oNArzhyT8EL9RG2Rb7An2i
         llSA==
X-Gm-Message-State: AOAM530ldjj+dB+edzWC29SHRnavc8rYHhDDph6yuwWwY8tX1Ak0g6Qe
        W3Xhag0ewPbzdQPPlVxuKzsEoTXliGxOS1qFm1JUXQ==
X-Google-Smtp-Source: ABdhPJx736G6yw9RZc8ju06zfmwq/PVcFsrW7WQukA6RjbAHMDNBIk36nt1cDn2TEDsJkiGoWrv97NeWbUJBA2V4aPk=
X-Received: by 2002:ac2:46cf:: with SMTP id p15mr1079796lfo.628.1609907364076;
 Tue, 05 Jan 2021 20:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20201222073900.3490607-1-davidgow@google.com> <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
 <X/SSJQ+I5zEMaYYJ@alley> <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
 <20210105185731.GT4077@smile.fi.intel.com> <918b2d05-f51b-0866-89b3-19a016abdaa3@linuxfoundation.org>
In-Reply-To: <918b2d05-f51b-0866-89b3-19a016abdaa3@linuxfoundation.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 Jan 2021 12:29:12 +0800
Message-ID: <CABVgOS=DZjv4-68fEweZwB1-=KB7Tb71iQEfHKHt46OTVWC94w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 3:52 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 1/5/21 11:57 AM, Andy Shevchenko wrote:
> > On Tue, Jan 05, 2021 at 09:34:33AM -0700, Shuah Khan wrote:
> >> On 1/5/21 9:21 AM, Petr Mladek wrote:
> >>> On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
> >>>> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
> >>>>> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
> >>>>>> kunit_tool relies on the UML console outputting printk() output to the
> >>>>>> tty in order to get results. Since the default console driver could
> >>>>>> change, pass 'console=tty' to the kernel.
> >>>>>>
> >>>>>> This is triggered by a change[1] to use ttynull as a fallback console
> >>>>>> driver which -- by chance or by design -- seems to have changed the
> >>>>>> default console output on UML, breaking kunit_tool. While this may be
> >>>>>> fixed, we should be less fragile to such changes in the default.
> >>>>>>
> >>>>>> [1]:
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
> >>>>>
> >>>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>>>
> >>>>
> >>>> Thank you all. Now in linux-kselftest kunit-fixes branch.
> >>>>
> >>>> Will send this up for rc3.
> >>>>
> >>>> Sorry for the delay - have been away from the keyboard for a
> >>>> bit.
> >>>
> >>> JFYI, I am not sure that this is the right solution. I am
> >>> looking into it, see
> >>> https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
> >>> for more details.
> >>>
> >>
> >> Thanks Petr. I will hold off on sending the patch up to Linus and
> >> let you find a the right solution.
> >
> > Please. leave it in Linux Next at least. Otherwise kunit will be broken for a
> > long time which is not good.
> >
> >
>
> Yes. That is the plan. It will be in there until real fix comes in.
>

Thanks, Shuah.

Personally, I think that this patch makes some sense to keep even if
the underlying issue with ttynull is resolved. Given that kunit.py
requires the console output, explicitly stating we want console=tty
set is probably worth doing rather than relying on it being the
default. That being said, I definitely agree that this patch doesn't
fix the underlying issue with UML/ttynull: it just makes the kunit.py
script less sensitive to such changes (which, while unlikely, could
potentially occur legitimately down the track).

Cheers,
-- David
