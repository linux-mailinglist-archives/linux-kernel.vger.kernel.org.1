Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0D2B07FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgKLO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgKLO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:59:27 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D8C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 06:59:27 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c129so5593101yba.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aq79DpetUFuuK65Uh9fN+Pnrdo4oqkEr2aH1RwjOWw=;
        b=BfHScOOkZw5r7fB4Az1/LlAJ8NbGXZyG6LY4rzveZG7wfFqzY+9gS/tPysDo3UCk+8
         KYQLbSReMdpguY3xMJRtDHNodNDTSfh2sPO3104eTjj482sZlt3f2MP2XVA0NxBMVQjn
         awbmnTOUou3xxTjLvdkk3/pk06mjNuoIZdQCVpRwL3muNt12C06Ps34V+AKA0VTssvYu
         PTPJ6JdOzQ96TToUUaOgMNmMBXbJObBTR9w0fH1qZcY83J9RCkf5C17muol91EXtXieW
         sUFfoBbvI1zhTx2Y7tYc1H2nxG5FT7Rc+oP2nzCk/WppjdgdaFbz6hH9CFWhtYeF03oX
         6YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aq79DpetUFuuK65Uh9fN+Pnrdo4oqkEr2aH1RwjOWw=;
        b=V09/q/nh8ajTN+r9q79MMgSAzLG1oT2J+JIKQ11tgsuarNlh2eupXHD/qmBYUr2Tc2
         BgCRv4G/mZ/7UNvHnUdE4Tg9hAo5aqQuXrCwi5c8IOwOS6rGnUfmCpQA5NCik8jvE8Ag
         HuiG/8JDCNpFiMqLo6ufyPsC/UQLL/jmbxPalLtCnXP5WE2Pcx4a6rT62j4axvPSXDMc
         zsbrl7asBb6NMLD1r9srzw7fbvxmEDP6iNlgthDrYbROG14J2UFZ/Etzh9f0a+kXLfVn
         BAn5QQL581Xvzak+4N96QwbZVsop/8dcIZ24xoJ5eNx5li8ALjGR79v+RgGCvqh4WIAf
         e0lA==
X-Gm-Message-State: AOAM532FbFheqBYVMFf0mcoodPAs6wQV6tybpAKh5JbT11zd3Pna6oJP
        L1nmj2a4j7TxnRlUfQroEPmbm8bbi19sfimb0BY=
X-Google-Smtp-Source: ABdhPJweIaWEl6XP6QiDqPCtipou67R/lwxsPMGbRtiMJ9ugkTM51IT+eQw81x6rSIC+9785iHkqdiPsiHsMdL7D4zE=
X-Received: by 2002:a25:7e82:: with SMTP id z124mr42621241ybc.388.1605193166392;
 Thu, 12 Nov 2020 06:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20201111050559.GA24438@X58A-UD3R> <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home> <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R> <20201112092612.00a19239@gandalf.local.home>
In-Reply-To: <20201112092612.00a19239@gandalf.local.home>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 12 Nov 2020 23:58:44 +0900
Message-ID: <CANrsvRNr=JG=-oyYZxn+AXTMX9Ly4OJB0xY5F2Lmqo+1Q_S4fA@mail.gmail.com>
Subject: Re: [RFC] Are you good with Lockdep?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        alexander.levin@microsoft.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, willy@infradead.org,
        david@fromorbit.com, Amir Goldstein <amir73il@gmail.com>,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team <kernel-team@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 12 Nov 2020 17:10:30 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
>
> > 2. Does Lockdep do what a deadlock detection tool should do? From
> >    internal engine to APIs, all the internal data structure and
> >    algotithm of Lockdep is only looking at lock(?) acquisition order.
> >    Fundamentally Lockdep cannot work correctly with all general cases,
> >    for example, read/write/trylock and any wait/event.
>
> But lockdep does handle read/write/trylock and can handle wait/event (just
> needs better wrappers to annotate this). Perhaps part of the confusion here
> is that we believe that lockdep already does what you are asking for.
>
> >
> >    This can be done by re-introducing cross-release but still partially.
> >    A deadlock detector tool should thoroughly focus on *waits* and
> >    *events* to be more perfect at detecting deadlock because the fact is
> >    *waits* and their *events* that never reach cause deadlock.
> >
> >    With the philosophy of Lockdep, we can only handle partial cases
> >    fundamently. We have no choice but to do various work-around or adopt
> >    tricky ways to cover more cases if we keep using Lockdep.
> >
> > > That said, I'm not at all interested in a wholesale replacement of
> > > lockdep which will take exactly the same amount of time to stabilize and
> > > weed out the shortcomings again.
> >
> > I don't want to bother ones who don't want to be bothered from the tool.
> > But I think some day we need a new tool doing exactly what it should do
> > for deadlock detection for sure.
> >
> > I'm willing to make it matured on my own, or with ones who need a
> > stronger tool or willing to make it matured together - I wish tho.
> > That's why I suggest to make both there until the new tool gets
> > considered stable.
> >
> > FYI, roughly Lockdep is doing:
> >
> >    1. Dependency check
> >    2. Lock usage correctness check (including RCU)
> >    3. IRQ related usage correctness check with IRQFLAGS
> >
> > 2 and 3 should be there forever which is subtle and have gotten matured.
> > But 1 is not. I've been talking about 1. But again, it's not about
> > replacing it right away but having both for a while. I'm gonna try my
> > best to make it better.
>
> And I believe lockdep does handle 1. Perhaps show some tangible use case
> that you want to cover that you do not believe that lockdep can handle. If
> lockdep cannot handle it, it will show us where lockdep is lacking. If it
> can handle it, it will educate you on other ways that lockdep can be
> helpful in your development ;-)

Yes. That's the best thing I can do for all of us. I will.

I already did exactly the same thing while I was developing cross-release.
But I'm willing to do it again with the current Lockdep code.

But not today. It's over mid-night. Good night~

-- 
Thanks,
Byungchul
