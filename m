Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1822C28907A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbgJISDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbgJISDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:03:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA19C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 11:03:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so11595844lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Lsa+VrdIIaNe2ujx6Lfhhnsp4QDDMgH5thLRuc8G3w=;
        b=pvwChY6pTOuemQAJx7OvzqioRKXpCpjyLzy4OcPO9R0Be1APVEPoWFBeL/k9dHXhrB
         zZSbr1xYkuSP/gsVPS0BoYQNLunGP0e421DEBKOc19Y45r0gEfRxiL/LMTCXs8X+T9V+
         DEwmY1KRNKpBSnYg0s7zRsZ3ukXSkBI9EafIDUX93qhXp7BMP5MYSiYXHl215vHu9l+S
         z2HMAaindgoMtlPy1SmbL+FPRNCOmq+vQzzucmqEHBvS/LGrm0gN3iKEsYIBNMm0JxmT
         vxe2YnV/rK9nPMOVzHrAraIIQIrAIPHtlKPY3L5+JSFyT9xHQxuINEQkx4Ng1hnbSqXx
         ma8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Lsa+VrdIIaNe2ujx6Lfhhnsp4QDDMgH5thLRuc8G3w=;
        b=iD7d/OzuPtfVp706OOepbuE0zHov9r0DWm251yJAElCHZl86ezqVRw6zF4ehIzmdVq
         lOrPpYS610cfP8dKaf3ZiB3gH/8HYUdR2fPIPg1vq9Q6mhG5jedlbZ4kib8LePMOQlRn
         2Olx7nlCRnmG1IIAnYwp42HiBU1iTDgcllTfj5y+hqeZiLOb7qmjoMoTtue9+SZuwaaJ
         SLeYGnxya80wJuMX56obpU+60iB44Ou6d8axzFuu5JkkFb7Pb1hwec+qwHegYzyA7ybI
         jJwGtu3zq5wY1qrgL1YpvhMZ3BnMLMSajpR63WoRHDdln1K+XS8tBp5U6++PvCEMbUmD
         ehhg==
X-Gm-Message-State: AOAM532j7s++dBZ+eobenkIfk38kl1vaRXp6GW0LlMODeRB4J9f+dCvn
        HrJtB0QeUVpwxgODWOU7kVU=
X-Google-Smtp-Source: ABdhPJwOQKKbzfUbYSc+94C56UvkjvhiI6RurXpn6HtM44tzeiKfzvkn8Ep3EvyYatZ3mARnJleJeQ==
X-Received: by 2002:a19:7f4d:: with SMTP id a74mr4910971lfd.533.1602266586175;
        Fri, 09 Oct 2020 11:03:06 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a1sm1601653lfg.63.2020.10.09.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:03:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 9 Oct 2020 20:03:02 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, urezki@gmail.com,
        lkp@intel.com, julia.lawall@inria.fr, mhocko@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, peterz@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [GIT PULL tip/core/rcu+preempt] Fix RT raw/non-raw lock ordering
Message-ID: <20201009180302.GA22222@pc636>
References: <20201001210750.GA25287@paulmck-ThinkPad-P72>
 <20201009165500.GA2904859@gmail.com>
 <20201009171313.GI29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009171313.GI29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 10:13:13AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 09, 2020 at 06:55:00PM +0200, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > > Hello!
> > > 
> > > This pull request contains Thomas Gleixner's "Make preempt count
> > > unconditional" series [1], but with the addition of a kvfree_rcu() bug-fix
> > > commit making use of this PREEMPT_COUNT addition.  This series reduces
> > > the size of the kernel by almost 100 lines of code and is intended for
> > > the upcoming v5.10 merge window.
> > 
> > > Thomas Gleixner (13):
> > >       lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
> > >       preempt: Make preempt count unconditional
> > >       preempt: Cleanup PREEMPT_COUNT leftovers
> > >       lockdep: Cleanup PREEMPT_COUNT leftovers
> > >       mm/pagemap: Cleanup PREEMPT_COUNT leftovers
> > >       locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
> > >       uaccess: Cleanup PREEMPT_COUNT leftovers
> > >       sched: Cleanup PREEMPT_COUNT leftovers
> > >       ARM: Cleanup PREEMPT_COUNT leftovers
> > >       xtensa: Cleanup PREEMPT_COUNT leftovers
> > >       drm/i915: Cleanup PREEMPT_COUNT leftovers
> > >       rcutorture: Cleanup PREEMPT_COUNT leftovers
> > >       preempt: Remove PREEMPT_COUNT from Kconfig
> > > 
> > > Uladzislau Rezki (Sony) (1):
> > >       rcu/tree: Allocate a page when caller is preemptible
> > > 
> > > kernel test robot (1):
> > >       kvfree_rcu(): Fix ifnullfree.cocci warnings
> > 
> > >  21 files changed, 44 insertions(+), 136 deletions(-)
> > 
> > Pulled into tip:core/rcu, thanks a lot guys!
> 
> Thank you, Ingo!!!
> 
> 							Thanx, Paul
Thank you!

--
Vlad Rezki
