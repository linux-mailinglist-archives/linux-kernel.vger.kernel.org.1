Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FA288F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbgJIQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJIQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:55:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CE2C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:55:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t21so10056700eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3dq5GbdKcplLSZiBg3zGdwDEgH6yUbrdV2X8XFHGghg=;
        b=BGJnj0B1jzxn5JNY/W6myfH/cWzKWn902A9fiOUEADQge5Jzwj3NsTZabNZYJkPEMo
         8Eo0Gc9NzVapbXHPWfy+8OQGv92DnU+b6tH02nrzn8TlDS7sAbckYe4Okc6eXkVgzZas
         FHr8tmbUgX4pLROB5b5yyTVhXy8Icy8/iGyMyVUspqOtZ3vIgYKRFusI0xGmh+l6Wq9w
         0w1k1vFFnyNAUYzsttPywB/70hJ8gHXeBj/R++sQXmCpOaq/WmJSAsLgefXm6tGBllMO
         IDLSCTKynRhiCyFhF6X1UOCDY2j/IZuiW/S3f+b7gpsBEOh1MWF5ppkzfzAilFVyQ8qD
         N7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3dq5GbdKcplLSZiBg3zGdwDEgH6yUbrdV2X8XFHGghg=;
        b=MaRTev67EUAXS1w000LAzRyn8hPiYgWgRCsX9wJ/TousAf3vAufO45S6cAoF1ZhYum
         NIU4HunI1n6MM+DEpiM+rO5bGD7cn+XDvPyhnJMOrwsTQz7zKwcNdxBK/l5vV4TPJJb/
         SMmG7Co2Qwhv6+VUa7Lpasj6x58Yy4b2yAnu+aTrPJDORf3z1rdGQrhEsL05GrPGEcN2
         SpMuPBq3OBz23NnulkB5wAiQaaHXLMLXuAwkzyiyUvxpchnoiXbjiOwFTbMs0g0Nh1Zu
         HKCQ9RECO+I/B/GacPQGiBeDD0jgy7EPMO8JffY0X9PMNZk+KKNKUoR0cve4s+iEirER
         uwKQ==
X-Gm-Message-State: AOAM5327tTV/qeROuVNflUE1ZxHMV9h9wXDbeXvYe6Zm6r1fd7qQSAPu
        Q9wXFEd0mm98rby7Piqq8qo=
X-Google-Smtp-Source: ABdhPJxgDKJOz0mtX3EMlh/SjZwX98KHijDFzvR8bx6WZ1LN8+Rzl/V6LHftvJ63OOFYC3NlfWBUEQ==
X-Received: by 2002:a05:6402:754:: with SMTP id p20mr65539edy.109.1602262503107;
        Fri, 09 Oct 2020 09:55:03 -0700 (PDT)
Received: from gmail.com (563BAB65.dsl.pool.telekom.hu. [86.59.171.101])
        by smtp.gmail.com with ESMTPSA id bt16sm6660121ejb.89.2020.10.09.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:55:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 9 Oct 2020 18:55:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, urezki@gmail.com, lkp@intel.com,
        julia.lawall@inria.fr, mhocko@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, peterz@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [GIT PULL tip/core/rcu+preempt] Fix RT raw/non-raw lock ordering
Message-ID: <20201009165500.GA2904859@gmail.com>
References: <20201001210750.GA25287@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001210750.GA25287@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello!
> 
> This pull request contains Thomas Gleixner's "Make preempt count
> unconditional" series [1], but with the addition of a kvfree_rcu() bug-fix
> commit making use of this PREEMPT_COUNT addition.  This series reduces
> the size of the kernel by almost 100 lines of code and is intended for
> the upcoming v5.10 merge window.

> Thomas Gleixner (13):
>       lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
>       preempt: Make preempt count unconditional
>       preempt: Cleanup PREEMPT_COUNT leftovers
>       lockdep: Cleanup PREEMPT_COUNT leftovers
>       mm/pagemap: Cleanup PREEMPT_COUNT leftovers
>       locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
>       uaccess: Cleanup PREEMPT_COUNT leftovers
>       sched: Cleanup PREEMPT_COUNT leftovers
>       ARM: Cleanup PREEMPT_COUNT leftovers
>       xtensa: Cleanup PREEMPT_COUNT leftovers
>       drm/i915: Cleanup PREEMPT_COUNT leftovers
>       rcutorture: Cleanup PREEMPT_COUNT leftovers
>       preempt: Remove PREEMPT_COUNT from Kconfig
> 
> Uladzislau Rezki (Sony) (1):
>       rcu/tree: Allocate a page when caller is preemptible
> 
> kernel test robot (1):
>       kvfree_rcu(): Fix ifnullfree.cocci warnings

>  21 files changed, 44 insertions(+), 136 deletions(-)

Pulled into tip:core/rcu, thanks a lot guys!

	Ingo
