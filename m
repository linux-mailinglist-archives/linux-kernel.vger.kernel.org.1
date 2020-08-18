Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09011248F25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHRT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:57:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3189C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:57:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so64579wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Z4r92eghHfjUZjZIQSRYab2MsQQwQr8sHxL2zxeLTw=;
        b=BX341iTDG5bRb5HoTnI6iaCWsPcD3AfZMdu+o9syAc3cWp7zDhqrq6S0FEbQE35Ak7
         1AVv0UqL21mbXs19iIuQRxBivn+cldL27DushF3v1X98OPaQmy9lF7fx0kKnCo4HBI8U
         WsiDKURPJwT+e7Gmpx1YFXT9bvbvwpUv0RlK1bDy0nPyYELkGt3/zF6R87Bp5wZHQAwZ
         9TuhHtFpi6JvjZB/DLz29zY/NCXQPGWVLOjtIMD1kH5oyl0+trVjRN/ktuktHgmN9ZI8
         CEnd5BzbGkx7GLnpAXykw1WvO092BuPY3AGQz/9v0QvYyl1daG+EWHmrZUG6Kg+sSOAF
         4Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Z4r92eghHfjUZjZIQSRYab2MsQQwQr8sHxL2zxeLTw=;
        b=PbFIP/WZncePvzvJFBxH0QnBGy3O1JYCC4l4BPHn56mmYF/aiN2eywPYFTOfUpmIcX
         5MsWGRqq08ci0O/6xF5v5o2XRZTaivNz7drvcIG6Y4h11g/KZ3vmLW0gRcCGf2aBOO6U
         RVWXcJ4pwlEFl3E92ueYCgd9Mk0VP4Wpnzmc5huRxtjUyat8rBlg9RvJ0TmEf0ydvIyv
         SkGR8oEb14NS447SHBLzkg5VLizBjvbrkIGdRWhwaGwQrAn7Zt209/moNhay/dDfWnMn
         doElkn6CxCl5HVl9Wk2d2QYZLqcsdiNF22+w3JgxVNoqdnxrSnSCvyqaAnAU34wrzMIZ
         FrDA==
X-Gm-Message-State: AOAM530mQ2yOnnx45K4Y8IB5mT2gkXqT0/lEvYoOpIXu6dFNBoVpAc6A
        JKqmk94qNfB7ysAJHinzbEg=
X-Google-Smtp-Source: ABdhPJyY6XOjCdquPYVIDw/6dfKtiOWfuHy72GyxkTt3MNO4x9cGb+ALtlgMngWsMc53Ag5QaYP06g==
X-Received: by 2002:a1c:720d:: with SMTP id n13mr1412706wmc.103.1597780669429;
        Tue, 18 Aug 2020 12:57:49 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id z15sm37289369wrn.89.2020.08.18.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:57:48 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Tue, 18 Aug 2020 20:57:46 +0100
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] sched/cputime: Mark function as __maybe_unused
Message-ID: <20200818195746.scpjm3dlg7cfst53@medion>
References: <20200818170337.805624-1-alex.dewar90@gmail.com>
 <CAKwvOdk2fynn=-FGUniYLG+hCOkEFppRnAaTYe8DW=YRrT-siQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk2fynn=-FGUniYLG+hCOkEFppRnAaTYe8DW=YRrT-siQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:13:10AM -0700, Nick Desaulniers wrote:
> On Tue, Aug 18, 2020 at 10:04 AM Alex Dewar <alex.dewar90@gmail.com> wrote:
> >
> > Depending on config options, account_other_time() may not be called
> > anywhere. Add __maybe_unused flag to fix clang warning.
> 
> Just curious, would moving this definition to be within an existing
> preprocessor guard for a particular config also fix the issue? If so,
> prefer that. If not, __maybe_unused is the way to go.

I don't think that'd work here: it's used within an "#ifdef
CONFIG_IRQ_TIME_ACCOUNTING" block and a separate "#ifdef
CONFIG_VIRT_CPU_ACCOUNTING_GEN" one. We could do:
	#if defined(CONFIG_IRQ_TIME_ACCOUNTING) ||
	    defined(CONFIG_VIRT_CPU_ACCOUNTING)
		...
... but that might be a bit ugly.

> 
> >
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > ---
> >  kernel/sched/cputime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 5a55d2300452..43ede0d6661c 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
> >  /*
> >   * Account how much elapsed time was spent in steal, irq, or softirq time.
> >   */
> > -static inline u64 account_other_time(u64 max)
> > +static inline u64 __maybe_unused account_other_time(u64 max)
> >  {
> >         u64 accounted;
> >
> > --
> > 2.28.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200818170337.805624-1-alex.dewar90%40gmail.com.
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
