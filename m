Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09664271351
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITKZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 06:25:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FE1C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 03:25:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w11so10896241lfn.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bms3XLIcJiiOd/siUyxxcwUISQM0dhJ8X1yH852QRvQ=;
        b=N3rdOE9+4X4464esehQiyYHznusJQQj1v+bf93OmmqptsEQDATM20Fu0nIz/GCfIv8
         /hqsKQGBLpAb4dnEZ8AuoE+4PZXlzdjr1RVHaCHkeROt3R8mVdEE+APbwXqFgKdSNduJ
         xHjP5N/SlR4ZAqps48mMVPaPaVMK7OfWJbXt5JR4aEg74wiSBl0RWxPmMm9fRTdV3JK2
         T5FH7fbOeRtd4SLzu096ZbnY2lrXToDM+5xTzCM73RiQeqabNcuJasy++OynaFE1Yx/7
         sY184jcHqGE/1I32jJxMU9AZJMaZy5OpJKRnrtgf1maWjcm3XVOcMvhjeryzOPnTUji9
         Ng1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bms3XLIcJiiOd/siUyxxcwUISQM0dhJ8X1yH852QRvQ=;
        b=lY4AUQ3U0JdlwfYHD9kymlJdqhmOV4u2sBkWNRWiQ+TbgjdOXShbxeoO0NKtx9BSlq
         zpawwb+5HUcmds5muKW6xXx4Z64WJPMViCm/FetQC4HesLZPmIKDtWkwRzPklPw65QXX
         2DZ1HbFoManh9km8dIewevmOTRwm1F6DYrSVXQkdozSI64YEEiCgIRSsZXnAlOGbTmTL
         21Gkcu/lBg5BND6ksCswty0DX5Ds9ppjh6MGQVq933p5KvlLwMFSIiQ8/cpulJstyIEm
         /G1QnoJKUPD6v7vtNIT48VjUeXRe1CsgDTRvTaZpbqM/xl3ZaYqQlXXolv7Z7MeTicJJ
         JeEQ==
X-Gm-Message-State: AOAM530v/LudJhqnQc+YEO1jbdCpQl1yQbJ7Hl4T8wiyIMI3L4OhafbR
        /eYPkLPwIOcBT7w+3IomUmxiXAVd9Vj4/pmjhmnJ+MAzuk8oKzQ=
X-Google-Smtp-Source: ABdhPJzbeIwVWRc0plOUzm8nW92RweOhCqAjvaUf2CpE5Nz5HMGI19k+wvduQSuP5oP6PskPIEGPiOKnoujWJd18T6k=
X-Received: by 2002:a05:6512:5cd:: with SMTP id o13mr15386945lfo.171.1600597534527;
 Sun, 20 Sep 2020 03:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200717110532.238533-1-asteinhauser@google.com> <20200907171825.GB13281@willie-the-truck>
In-Reply-To: <20200907171825.GB13281@willie-the-truck>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Sun, 20 Sep 2020 03:25:23 -0700
Message-ID: <CAN_oZf29J-DMF04EhQf=29CzV5zrPT+L6HchZcG-CDt=MjFf4A@mail.gmail.com>
Subject: Re: [PATCH] PR_SPEC_DISABLE_NOEXEC support for arm64.
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, catalin.marinas@arm.com,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As a heads up: I'm currently reworking most of this, and hope to post
> something within the next two weeks.

Sure. Let me know whether you want to implement the
PR_SPEC_DISABLE_NOEXEC support directly or whether this patch would be
relevant even after your rework.
>
> > diff --git a/arch/arm64/include/asm/ssbd.h b/arch/arm64/include/asm/ssbd.h
> > new file mode 100644
> > index 000000000000..68c716dc5811
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/ssbd.h
...
> > +}
>
> I'd prefer to keep these where they are and have an out-of-line call if
> necessary. We should try to keep the SSBD stuff in one place.

OK.
>
> > +
> > +#endif       /* __ASM_SSBD_H */
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 6089638c7d43..ad3c67c86c4c 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -54,6 +54,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/processor.h>
> >  #include <asm/pointer_auth.h>
> > +#include <asm/ssbd.h>
> >  #include <asm/stacktrace.h>
> >
> >  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
> > @@ -588,6 +589,18 @@ void arch_setup_new_exec(void)
> >       current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
> >
> >       ptrauth_thread_init_user(current);
> > +
> > +     /*
> > +      * Don't inherit TIF_SSBD across exec boundary when
> > +      * PR_SPEC_DISABLE_NOEXEC is used.
> > +      */
> > +     if (test_thread_flag(TIF_SSBD) &&
> > +         task_spec_ssb_noexec(current)) {
> > +             clear_thread_flag(TIF_SSBD);
> > +             task_clear_spec_ssb_disable(current);
> > +             task_clear_spec_ssb_noexec(current);
> > +             ssbd_ssbs_enable(current);
> > +     }
>
> How is this supposed to work with CPUs that expose SSBS directly to
> userspace? I suppose we should be using PR_SPEC_DISABLE_NOEXEC to decide
> what we set the SSBS bit to on exec, but the logic here requires TIF_SSBD
> to be set and so won't trigger afaict.
>

You're right. The SSBS support is incomplete. I guess
"test_thread_flag(TIF_SSBD)" can be replaced just with
"arm64_get_ssbd_state() == ARM64_SSBD_KERNEL".
Thanks,
Anthony
