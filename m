Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A642B4C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgKPRFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgKPRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:05:44 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:05:44 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 10so14730770pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTuYuV63+yBW0kW8JxGFY1sJgSfCPu5GuaysnpUoK7w=;
        b=Pbdno3U9skdxJU2HYZjaYZaIyyJrlfkF00S9lpEsWuGaInc8AwBaZNML21Rjex7NA2
         ARIGwLms1PUlU8XDQbkaBWQoGfOVp07k3jJZb373a/UwhRDXURIukJPGlK5eGSczI368
         BiyiO84y5ep5eHNpfurVxwv+IORfnqjdFpbaLaCq9H3FTApkhRTvHncm4K6L569DIZaw
         LlUhNuLDjYu8BEApgSzAuTmnL1XKvmJbvD/W4+wHhGh36EMnyIhZiYceNzuwbsRg+7Uu
         6jOZH3GuQ2cR/3RuQHNKlKIaSdutyxeurw+NWWXLL9+ofsWNe0DIgvIKhYDxv435w8ih
         /1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTuYuV63+yBW0kW8JxGFY1sJgSfCPu5GuaysnpUoK7w=;
        b=aiG1IAGqN8K9KFufnYPrwAwOA2WwaAKSfiNwFtxm95ZQkMnaBcudlJBhq4Hj0u46B4
         TGqkRzRIViBACdbsnnKIIBUgl1jbHpEesy5SoOMRKz/KUl6oLqWkkdr4ogyL5xTv/bl2
         DZ0xBsF/mIvW7GoD5+7KrTWauB0NYqxJFW9oVD/UfVs8dsx071WGFhJ98o8Sf3CH3T33
         ABaefwuhplYNtOTqDjrpp+62vfbOi2GLfmikDdGCvlETqM+/j+Y3yn2qe5p+pUkGPS90
         mniga94pkfFf/F0JGCiBPHWl4ZwZ0ywB++XVRLZ+fwRtIgYO+CFqrQ2wk7rzm8o55fxd
         q2ow==
X-Gm-Message-State: AOAM5327K0N2hgcqdMMNXbzvRQ4BMA7v0WNp2E21cfc52ZjHR8PotRpt
        dscnu0xC2bSsnDQPxgO0xVMYL9WQYLtxu7o0dNwS3g==
X-Google-Smtp-Source: ABdhPJyj713kfL24xFii/T870PJfKlyadSgV7TSIa3iOsbVdB6Pt9V0qOrGpxBu0K+75Py/JfEc12H+WvXfkPOXXuDc=
X-Received: by 2002:a62:cec6:0:b029:18a:d620:6b86 with SMTP id
 y189-20020a62cec60000b029018ad6206b86mr14118392pfg.2.1605546343488; Mon, 16
 Nov 2020 09:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20201116023846.awjtbzh2o2yj4fvn@mozz.bu.edu> <CACT4Y+bh_QfSNVKVE=zODNKL5_8RLdcLf-j2ky0FJE_1hUi_hw@mail.gmail.com>
In-Reply-To: <CACT4Y+bh_QfSNVKVE=zODNKL5_8RLdcLf-j2ky0FJE_1hUi_hw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Nov 2020 18:05:32 +0100
Message-ID: <CAAeHK+wxupr3kqnr69QphciLLp13+A_7CgU+o_J7xBBxnRdbMg@mail.gmail.com>
Subject: Re: Collecting both remote and "local" coverage with KCOV
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Bulekov <alxndr@bu.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 9:35 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Nov 16, 2020 at 3:39 AM Alexander Bulekov <alxndr@bu.edu> wrote:
> >
> > Hello,
> > I'm trying to collect coverage over the syscalls issued by my process,
> > as well as the kthreads spawned as a result of these syscalls
> > (eg coverage over vhost ioctls and the worker kthread). Is there a way
> > to collect coverage with both KCOV_REMOTE_ENABLE(with common_handle) and
> > KCOV_ENABLE, simultaneously?
> >
> > Based on the code it seems that these two modes are mutually
> > exclusive within a single task, but I don't think this is mentioned in
> > the Documentation, so I want to make sure I'm not missing something.
>
> Hi Alex,
>
> Yes, it's probably not supported within a single task. The easiest way
> to verify is to try it ;)
>
> It is possible to collect both coverages, but you will need 2 threads
> (one just to set up remote KCOV).
>
> Unless I am missing any fundamental limitations, I would say it would
> be reasonable to support this within a single task as well.

I think the reason we did that initially, is because we don't care
about normal coverage for USB emitting pseudo-syscalls. Filed a bug
for this: https://bugzilla.kernel.org/show_bug.cgi?id=210225
