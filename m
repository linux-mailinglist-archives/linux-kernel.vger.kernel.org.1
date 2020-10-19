Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733402922FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgJSHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgJSHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:31:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F689C061755
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 00:31:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so10181674wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oxyUXQ2bhTcts6eK+RKa2UHLZ9th37dz3H9VJoRJ+nw=;
        b=PEJ462LavaXKCSxFbYT71XlFdHxA1yHiVzsrwSxrE9pf7+4iOdMwtp1A0u/eo0JspQ
         f0BDcRNhAEb69/3getFrZ7XXX4bvrCyV51qe0QbllWF39hT59JfbR36JtRUwynbHbtAN
         jaeYXZ24EJIoiWb17KA1t73xjj9+waZWlJK3NKwpDdhShNNhdZj54rpMO/Svtazy9v9T
         mRuJpVR3vP/66C2BAMgAOxFF6Uw8cVwkRY9kYcwtKL44VLiF+JRCljkT/RBb86QTeFMz
         sbKgAOaH1LWVaAxkUZuIQd9wB3puhDulV0p/skCv0s6ToNU3isSqtco3rZWtbxEGmXO0
         JOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oxyUXQ2bhTcts6eK+RKa2UHLZ9th37dz3H9VJoRJ+nw=;
        b=khA4q1Tpwt9JQCL/EfgQoaIQvKIocW2rWry0SEyHnwhH38MyiScTcVhGT2PUqhrcrG
         MOLq3bhUVTPLEjBIXlguH7Dk6xgmBSFvpu3T/wojK3ckkDTmhk7yc60dGvxdRGBgndqo
         W9tpIqypFLOQzE/BfFAQ0j5MnSETbY6WPKvAw4gu3lGv7k/eqPTPAMAeOGlAejS7rgdg
         DFt5e80AiQ82DV8IB/HgyPxgAAyOBhcgeOGllk982hH4NeNb3MrSPjNzY95nM0XzN+Cr
         MBGxxVIK8+pE9ZviTan7ckwh0HZ9s/pfEVMMAl7G7Vl7kOMl43GG9VXg88tg2jVmifcI
         WpFg==
X-Gm-Message-State: AOAM531pVRQ9q3OLprFKPP5+tgMSLODA3YR6m2O0qT44ZyvjLdAP1uvr
        e4sO3ZUhqt9NR3fE+lCNuTg=
X-Google-Smtp-Source: ABdhPJyEElzs5fN5/xHdG4CD1u84HiC+mOTuOdhdqyIsgXtCQw8Ni8Lx2Y9sc788QYxY7BtegUwzTw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr18096536wrt.314.1603092706302;
        Mon, 19 Oct 2020 00:31:46 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x10sm119588wrp.62.2020.10.19.00.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 00:31:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 19 Oct 2020 09:31:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
Message-ID: <20201019073143.GA3785787@gmail.com>
References: <20201012141451.GA3425471@gmail.com>
 <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Oct 12, 2020 at 7:14 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest core/rcu git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-10-12
> 
> I've pulled everything but that last merge and the PREEMPT_COUNT 
> stuff that came with it.
> 
> When Paul asked whether it was ok for RCU to use preempt_count() and 
> I answered in the affirmative, I didn't mean it in the sense of "RCU 
> wants to force it on everybody else too".
>
> I'm pretty convinced that the proper fix is to simply make sure that 
> rcu_free() and friends aren't run under any raw spinlocks. So even 
> if the cost of preempt-count isn't that noticeable, there just isn't 
> a reason for RCU to say "screw everybody else, I want this" when 
> there are other alternatives.

That's certainly true - thanks for catching this & sorting it out from 
the bigger pull request!

Thanks,

	Ingo
