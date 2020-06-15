Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F01FA331
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFOWGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgFOWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:06:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:06:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so525538pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EV7dxD7fMr+Ylyvl9y5nlIzLH4Zik3ewFcRfV+P+MWk=;
        b=bIn9HOmBE9lzqITss2TaKh1dCiNXoqI+Ce9AWodfQl/pZNdV9SbWrV3A4vzm0VJEV6
         /4zsXV9jYwFsf4bWz85G5vQCR0LPB3oLRphrn/+KHDVtzTOP/kPg0cHDr0ouZE7QnsgF
         WsfOfZLiVMKbfTs3mgMfui+xEhl3dVcjvy2iabUAJ7GaECHBtQ0BEMivJGb+WcrDPt5y
         shxj9hDQwSJDgTVBZ3LvbVYrl0i96XZy0uFqS7HXZeU6RxUklHtPBKKnzmAzgGCUoWQ2
         hcYrLeaJrzGv3ckw4Nj06zzqnTeQunEQm6cGtOZ3rObUT+AEKsSIkM99wdvZg1HQjRNS
         MP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV7dxD7fMr+Ylyvl9y5nlIzLH4Zik3ewFcRfV+P+MWk=;
        b=SYfx5ueVEGcQ7RszxWlhq5okHUDseU0Pu+7iwASxlYmxjHVdno/tOyedhThCyTKuDr
         1hoMzEsR0V5q+QYYkhbYQ2LjTc57ELEfav8hFE5OzBU4n0f8lF/KtFIe365DgnNw+EfV
         KOk0iLkeeq9ds36TdDqxurtrLjp6Hb/Ef7dHFTQ5YApGVm3m9OtmvDMxRXnMwXZiJWfB
         FzDWzY7KkefIvPxJkauCWUTvssF/MZR5l+JwZJtSQQPnx4XYujBP1cduc/hXMyKFxPxZ
         4i0dtLLef3Ha9M7Te3Ju9hq4OXb1kV3OHS6Ylkxx18Uu9LjxA7koxtZKDSrTlJ7ER68S
         JOMg==
X-Gm-Message-State: AOAM531NzkoxRwWLnJVUiKj6DIMYwzfTp5OJMmsjCgIklHNlFtRJN02+
        iVSvLIAwSsb1SjfRzl4JUCmaFPzd98SmryC7yq+nrA==
X-Google-Smtp-Source: ABdhPJyEzSaghFv56LKhrCRQppzXCy8b/BtKziqLVpkF6KGTMySM9LnQi4bDWrGBI2O6s0i457/o4qR8p4F4ccZ6DtI=
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr48171pjb.32.1592258807433;
 Mon, 15 Jun 2020 15:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615062520.GK12456@shao2-debian> <CANn89i+s=oFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g@mail.gmail.com>
 <CAKwvOdkv=L=QKQc7HtOi5ZNdao35m18PMr7ep+4sKv5iogVDLg@mail.gmail.com>
 <CANn89iJYCHqvCTvzommOL4RHtKLT5wyXMzpWKNfrBFTgs4kNAw@mail.gmail.com>
 <CANn89iLnmKaa30tPoyK_GrJr-_ALYBwjcJ0pBcvmckA9PAvrgA@mail.gmail.com>
 <CAKwvOd=shEiDQZxZPyUCC=CJLrzmP5FHr04cE-KVN_-6+qz1jQ@mail.gmail.com>
 <CANn89i+sQTXxvMOujdCO_dUb06AXPns8EcLN6OjnccwaFm+M3A@mail.gmail.com>
 <CAKwvOd=CmgMLvNBbfZ6tQPk-dRhunPDOwL-NGDNiNvU6pV8TJQ@mail.gmail.com> <CAKwvOdme9sUqrz8yd0zTyAapTWA4ugtsR4ebUO48wFFZF5Ug8w@mail.gmail.com>
In-Reply-To: <CAKwvOdme9sUqrz8yd0zTyAapTWA4ugtsR4ebUO48wFFZF5Ug8w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Jun 2020 15:06:35 -0700
Message-ID: <CAKwvOdn=zedhsAk9n7hG5ndZP9Pvgexyra2Q+t8TZiqTZaR7=A@mail.gmail.com>
Subject: Re: net/sched/sch_fq.c:966:12: warning: stack frame size of 1400
 bytes in function 'fq_dump'
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 1:37 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 15, 2020 at 1:36 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 11:45 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Mon, Jun 15, 2020 at 11:07 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Mon, Jun 15, 2020 at 10:59 AM 'Eric Dumazet' via Clang Built Linux
> > > > <clang-built-linux@googlegroups.com> wrote:
> > > > >
> > > > > On Mon, Jun 15, 2020 at 10:54 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 15, 2020 at 10:44 AM Nick Desaulniers
> > > > > > <ndesaulniers@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 15, 2020 at 9:17 AM 'Eric Dumazet' via Clang Built Linux
> > > > > > > <clang-built-linux@googlegroups.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Jun 14, 2020 at 11:26 PM kernel test robot <lkp@intel.com> wrote:
> > > > > > > > >
> > > > > > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > > > > > > head:   96144c58abe7ff767e754b5b80995f7b8846d49b
> > > > > > > > > commit: 39d010504e6b4485d7ceee167743620dd33f4417 net_sched: sch_fq: add horizon attribute
> > > > > > > > > date:   6 weeks ago
> > > > > > > > > :::::: branch date: 3 hours ago
> > > > > > > > > :::::: commit date: 6 weeks ago
> > > > > > > > > config: arm-randconfig-r006-20200614 (attached as .config)
> > > > > > > > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project c669a1ed6386d57a75a602b53266466dae1e1d84)
> > > > > > > > > reproduce (this is a W=1 build):
> > > > > > > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > > > > > >         chmod +x ~/bin/make.cross
> > > > > > > > >         # install arm cross compiling tool for clang build
> > > > > > > > >         # apt-get install binutils-arm-linux-gnueabi
> > > > > > > > >         git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> > > > > > > > >         # save the attached .config to linux build tree
> > > > > > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> > > > > > > > >
> > > > > > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > > >
> > > > > > > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > > > > > > >
> > > > > > > > > >> net/sched/sch_fq.c:966:12: warning: stack frame size of 1400 bytes in function 'fq_dump' [-Wframe-larger-than=]
> > > > > > > > > static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
> > > > > > > > > ^
> > > > > > > >
> > > > > > > >
> > > > > > > > This looks like a bug in CLANG on ARM, there is no way fq_dump() could
> > > > > > > > consume so much stack space.
> > > > > > >
> > > > > > > You can use
> > > > > > > https://github.com/ClangBuiltLinux/frame-larger-than
> > > > > > > to help debug these.  You might be surprised who's doing larger stack
> > > > > > > allocations than expected.
> > > > > >
> > > > > > What is wrong with scripts/checkstack.pl  ?
> > > > >
> > > > > After using CLANG on x86 I get :
> > > > >
> > > > > $ objdump -d net/sched/sch_fq.o | scripts/checkstack.pl
> > > > > 0x00001136 fq_change [sch_fq.o]: 192
> > > > > 0x00000016 __direct_call_Qdisc_enqueue1 [sch_fq.o]: 112
> > > > > 0x000019e0 fq_dump_stats [sch_fq.o]: 112
> > > > > 0x00001b43 fq_dump_stats [sch_fq.o]: 112
> > > > >
> > > > > So CLANG on x86 seems fine.
> > > > >
> > > > > I said : " this looks like a bug in CLANG on ARM"
> > > >
> > > > This is a randconfig, so some option is turning on something that's
> > > > causing excessive stack usage with your patch on ARM.  Building who
> > > > knows what config with x86 and claiming it works doesn't really cut
> > > > it.  You looked at fq_dump and claimed it should be fine.  Did you
> > > > verify each called function that was inlined?
> > >
> > > Nick, my patch added exactly _one_ u64 variable in the stack.
> > > That's a whooping  8 bytes, right ?
> >
> > What if I add a single byte of stack usage, and that's enough to trip
> > this warning?  Not my problem?
> >
> > >
> > > We should be able to use as many nla_put_u32() calls in a function,
> > > without changing stack sizes.
> >
> > That's good to know, see below. (That not be the case here).
> >
> > >
> > > If CLANG can not do that, then this is a CLANG problem, I have no
> > > intention of fixing it,
> > > I hope this is very clear ;)
> >
> > At least you tested it with Clang, so I appreciate you taking the time
> > to do that.  Here's how we might go about debugging this further:
> >
> > $ git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> > $ wget https://lore.kernel.org/lkml/20200615062520.GK12456@shao2-debian/2-a.bin
> > -O .config.gz
> > $ gunzip .config.gz

Also, it looks like CONFIG_UBSAN=y was set in this randconfig, so that
may play a part in the excessive stack usage.  We've definitely seen
that with CONFIG_KASAN=y.

> > $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CC=clang -j71
> > net/sched/sch_fq.o
> > ...
> > net/sched/sch_fq.c:966:12: warning: stack frame size of 1400 bytes in
> > function 'fq_dump' [-Wframe-larger-than=]
> > $ python3 /path/to/frame_larger_than.py net/sched/sch_fq.o fq_dump
> > fq_dump:
> >         8       u64                             horizon
> >         8       u64                             ce_threshold
> >         4       struct fq_sched_data*           q
> >         4       struct nlattr*                  opts
> > qdisc_priv:
> > nla_nest_start_noflag:
> >         4       struct nlattr*                  start
> >         4       struct nlattr*                  start
> > skb_tail_pointer:
> >         4       uint32_t                        __base
> >         4       uint32_t                        __rem
> > is_power_of_2:
> >         4       uint32_t                        __n_lo
> >         4       uint32_t                        __res_lo
> >         8       uint64_t                        ___n
> >         8       uint64_t                        ___m
> >         4       uint32_t                        ___bias
> >         8       uint64_t                        ___res
> >         8       uint64_t                        ___t
> >         8       uint64_t                        ___x
> >         4       uint32_t                        ___p
> > __arch_xprod_64:
> >         4       unsigned int                    tmp
> >         8       long long unsigned int          res
> >         4       unsigned int                    tmp
> >         8       long long unsigned int          res
> >         4       uint32_t                        __base
> >         4       uint32_t                        __rem
> > is_power_of_2:
> >         4       uint32_t                        __n_lo
> >         4       uint32_t                        __res_lo
> >         8       uint64_t                        ___n
> >         8       uint64_t                        ___res
> >         8       uint64_t                        ___t
> >         8       uint64_t                        ___x
> >         8       uint64_t                        ___m
> >         4       uint32_t                        ___p
> >         4       uint32_t                        ___bias
> > __arch_xprod_64:
> >         4       unsigned int                    tmp
> >         8       long long unsigned int          res
> >         4       unsigned int                    tmp
> >         8       long long unsigned int          res
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> >         4       long unsigned int               __UNIQUE_ID___y256
> >         4       long unsigned int               __UNIQUE_ID___x255
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u32:
> >         4       u32                             tmp
> >         4       u32                             tmp
> > nla_put_u8:
> >         1       u8                              tmp
> >         1       u8                              tmp
> > nla_nest_end:
> > skb_tail_pointer:
> >
> > So is_power_of_2/__arch_xprod_64 looks excessively large, and the
> > nla_put_u* routines seem to have 2 temporary variables?
> >
> > (I should update the tool to better denote the end of an inlined
> > frame; I don't think is_power_of_2 is the source, it looks like
> > do_div() calls with 64b non-integer constant expressions. Having those
> > be macros vs noinline_for_stack might be of interest for the non-ICE
> > case, cc Arnd).
> >
> > Let me see if I can extend the tool to print file+line numbers so we
> > can see if those `tmp`s are one in the same or not.
> >
> > >
> > > >
> > > >
> > > > And the issue with checkstack is it tells you the depth, but not *what
> > > > variables* and from which inlined function may be the cause.
> > >
> > >
> > > OK. Thank you.
> > >
> > >
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > 1 warning generated.
> > > > > > > > >
> > > > > > > > > # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39d010504e6b4485d7ceee167743620dd33f4417
> > > > > > > > > git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > > > > > git remote update linus
> > > > > > > > > git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> > > > > > > > > vim +/fq_dump +966 net/sched/sch_fq.c
> > > > > > > > >
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   965
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  @966  static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   967  {
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   968          struct fq_sched_data *q = qdisc_priv(sch);
> > > > > > > > > 48872c11b77271 Eric Dumazet   2018-11-11   969          u64 ce_threshold = q->ce_threshold;
> > > > > > > > > 39d010504e6b44 Eric Dumazet   2020-05-01   970          u64 horizon = q->horizon;
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   971          struct nlattr *opts;
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   972
> > > > > > > > > ae0be8de9a53cd Michal Kubecek 2019-04-26   973          opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   974          if (opts == NULL)
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   975                  goto nla_put_failure;
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   976
> > > > > > > > > 65c5189a2b57b9 Eric Dumazet   2013-11-15   977          /* TCA_FQ_FLOW_DEFAULT_RATE is not used anymore */
> > > > > > > > > 65c5189a2b57b9 Eric Dumazet   2013-11-15   978
> > > > > > > > > 48872c11b77271 Eric Dumazet   2018-11-11   979          do_div(ce_threshold, NSEC_PER_USEC);
> > > > > > > > > 39d010504e6b44 Eric Dumazet   2020-05-01   980          do_div(horizon, NSEC_PER_USEC);
> > > > > > > > > 48872c11b77271 Eric Dumazet   2018-11-11   981
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   982          if (nla_put_u32(skb, TCA_FQ_PLIMIT, sch->limit) ||
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   983              nla_put_u32(skb, TCA_FQ_FLOW_PLIMIT, q->flow_plimit) ||
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   984              nla_put_u32(skb, TCA_FQ_QUANTUM, q->quantum) ||
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   985              nla_put_u32(skb, TCA_FQ_INITIAL_QUANTUM, q->initial_quantum) ||
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   986              nla_put_u32(skb, TCA_FQ_RATE_ENABLE, q->rate_enable) ||
> > > > > > > > > 76a9ebe811fb3d Eric Dumazet   2018-10-15   987              nla_put_u32(skb, TCA_FQ_FLOW_MAX_RATE,
> > > > > > > > > 76a9ebe811fb3d Eric Dumazet   2018-10-15   988                          min_t(unsigned long, q->flow_max_rate, ~0U)) ||
> > > > > > > > > f52ed89971adbe Eric Dumazet   2013-11-15   989              nla_put_u32(skb, TCA_FQ_FLOW_REFILL_DELAY,
> > > > > > > > > f52ed89971adbe Eric Dumazet   2013-11-15   990                          jiffies_to_usecs(q->flow_refill_delay)) ||
> > > > > > > > > 06eb395fa9856b Eric Dumazet   2015-02-04   991              nla_put_u32(skb, TCA_FQ_ORPHAN_MASK, q->orphan_mask) ||
> > > > > > > > > 77879147a3481b Eric Dumazet   2016-09-19   992              nla_put_u32(skb, TCA_FQ_LOW_RATE_THRESHOLD,
> > > > > > > > > 77879147a3481b Eric Dumazet   2016-09-19   993                          q->low_rate_threshold) ||
> > > > > > > > > 48872c11b77271 Eric Dumazet   2018-11-11   994              nla_put_u32(skb, TCA_FQ_CE_THRESHOLD, (u32)ce_threshold) ||
> > > > > > > > > 583396f4ca4d6e Eric Dumazet   2020-03-16   995              nla_put_u32(skb, TCA_FQ_BUCKETS_LOG, q->fq_trees_log) ||
> > > > > > > > > 39d010504e6b44 Eric Dumazet   2020-05-01   996              nla_put_u32(skb, TCA_FQ_TIMER_SLACK, q->timer_slack) ||
> > > > > > > > > 39d010504e6b44 Eric Dumazet   2020-05-01   997              nla_put_u32(skb, TCA_FQ_HORIZON, (u32)horizon) ||
> > > > > > > > > 39d010504e6b44 Eric Dumazet   2020-05-01   998              nla_put_u8(skb, TCA_FQ_HORIZON_DROP, q->horizon_drop))
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29   999                  goto nla_put_failure;
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  1000
> > > > > > > > > d59b7d8059ddc4 Yang Yingliang 2014-03-12  1001          return nla_nest_end(skb, opts);
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  1002
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  1003  nla_put_failure:
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  1004          return -1;
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  1005  }
> > > > > > > > > afe4fd062416b1 Eric Dumazet   2013-08-29  1006
> > > > > > > > >
> > > > > > > > > :::::: The code at line 966 was first introduced by commit
> > > > > > > > > :::::: afe4fd062416b158a8a8538b23adc1930a9b88dc pkt_sched: fq: Fair Queue packet scheduler
> > > > > > > > >
> > > > > > > > > :::::: TO: Eric Dumazet <edumazet@google.com>
> > > > > > > > > :::::: CC: David S. Miller <davem@davemloft.net>
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > > > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > > > > > > > _______________________________________________
> > > > > > > > > kbuild mailing list -- kbuild@lists.01.org
> > > > > > > > > To unsubscribe send an email to kbuild-leave@lists.01.org
> > > > > > > >
> > > > > > > > --
> > > > > > > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > > > > > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > > > > > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CANn89i%2Bs%3DoFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g%40mail.gmail.com.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > > ~Nick Desaulniers
> > > > >
> > > > > --
> > > > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CANn89iLnmKaa30tPoyK_GrJr-_ALYBwjcJ0pBcvmckA9PAvrgA%40mail.gmail.com.
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
