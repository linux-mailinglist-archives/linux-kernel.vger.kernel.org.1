Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362DA2B0E29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKLTil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgKLTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:38:41 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9788C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:38:40 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so3306638pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcGaGdNjvzbWsM/1VlFfBlGElmPXvO3Myj4l26gebaE=;
        b=UaHMcC73bqlweF20yyhuSOecd8L/pYt6mDoNZhyPNwm7NL0fx2MmHkrQAALHa3Gfk3
         3gEYco8Pg+cDJvbeDn/zphQtsjJvI0LFuUldxAOFqhsnzzFt5seRcliywEi4x30idZku
         HPwPRasVkNMOv92fTjGeR748hRxavgKX8gEniwRKqMGSi6i4WS+TvaGWrrxqQ14Wqayw
         oa6Uq42hSGMhSDMpECwlt2Ip272K9oIfQ+5OOEBscde11Lb39l+YDOD27zKc+IJY0OG6
         H5cTJ72+vuKTarQh/l2uVlrD0oPx9Wwox7PJwUpJ9asm1wqnayztd9ghHK6vmnPzDrMb
         ZOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcGaGdNjvzbWsM/1VlFfBlGElmPXvO3Myj4l26gebaE=;
        b=apnnPfx5x2ko+be4DfQH8iVtfxkYWRGacSwEVCyRxhSvpEaiIlmznU6NXcydSVQG5G
         CQTa4W2E4i7aD0VPYLDpB/YGe9yVmFyhTjfvOzWzwc7DdO/w1842vNU/CtOVc1SMQeXe
         6UR18BmEXsuyFpyJ8ekP5fX0Td1q0RRe5kb+clWO7tYET7+s3kPkWHVjdm03G0WtQC9M
         Yel2g5HWHvUIOWWdMYMgrAVj/NGmN2WeStEu3uhqY8XaD3mULGyiHpOi9S2DnxESe1zJ
         7uSjKyBA3Lf6KbdCUejHKkKv3EapcD1/xs5aJ+jwK0Mt9DAkUdotEOJKzvuBwjtbJrZd
         ok3Q==
X-Gm-Message-State: AOAM532VD+b7Nzr9pXlkuE4PJqo6fZii9oQgH2sZWQhJyFlHOJr6xf+J
        cy51W0nOwse68LDLr5ssMqyJdZxVxFy0piNpjE991Q==
X-Google-Smtp-Source: ABdhPJw3EggJuJym6L46mb4rsq/rHrQlrqJpcdplZS7f6XLN7t2N1sDujX0apEw8lwdtdOBo0+6BEaQTDI5inPJvc6E=
X-Received: by 2002:a17:902:bb95:b029:d7:db34:2ddb with SMTP id
 m21-20020a170902bb95b02900d7db342ddbmr742376pls.85.1605209920187; Thu, 12 Nov
 2020 11:38:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <7e95d4739f5617b2c1acf52f37e01f1ca83750b5.1605046662.git.andreyknvl@google.com>
 <20201112095134.GI29613@gaia>
In-Reply-To: <20201112095134.GI29613@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 20:38:29 +0100
Message-ID: <CAAeHK+wfzSjha_M88adfSE3qiOhJcCYeaAAu3YRXHpKqAK2L4Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 10:51 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20:08PM +0100, Andrey Konovalov wrote:
> > There's a config option CONFIG_KASAN_STACK that has to be enabled for
> > KASAN to use stack instrumentation and perform validity checks for
> > stack variables.
> >
> > There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> > Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> > enabled.
> >
> > Note, that CONFIG_KASAN_STACK is an option that is currently always
> > defined when CONFIG_KASAN is enabled, and therefore has to be tested
> > with #if instead of #ifdef.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> > ---
> >  arch/arm64/kernel/sleep.S        |  2 +-
> >  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
> >  include/linux/kasan.h            | 10 ++++++----
> >  mm/kasan/common.c                |  2 ++
> >  4 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> > index ba40d57757d6..bdadfa56b40e 100644
> > --- a/arch/arm64/kernel/sleep.S
> > +++ b/arch/arm64/kernel/sleep.S
> > @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
> >        */
> >       bl      cpu_do_resume
> >
> > -#ifdef CONFIG_KASAN
> > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> >       mov     x0, sp
> >       bl      kasan_unpoison_task_stack_below
> >  #endif
>
> I don't understand why CONFIG_KASAN_STACK is not a bool (do you plan to
> add more values to it?) but for arm64:

I don't remember if there's an actual reason. Perhaps this is
something that can be reworked later, but I don't want to get into
this in this series.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!
