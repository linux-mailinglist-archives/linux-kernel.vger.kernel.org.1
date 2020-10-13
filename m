Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9001F28C96C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbgJMHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgJMHcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:32:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD872C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:32:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so26821142ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBnPOk6UkZ2F+SuQHIFBXLKygxskZgQmYn6+lyWYOcc=;
        b=dl63OWGsBErXB8vhxdL5BHnoiQE4nvGXw7ahxuIvjvwkSxo0rIJfmh2HbQmuDqobZD
         O79faqGLXUxQWMqnkLDupX3Qlcnm5KbmLrc9ndqebz/yVDu/mVztar6ZEU8ghhy3FIdp
         zcYyqwQ2S9zAmoCB/0PWwneKEvF0dsUufVnfHCPOtM2crSWKEvkf4lUrtJCW6d5PmYlp
         cXaTyKiTdcT2juPh/21pwYRTXorTnGspxb8U+TXV8rNiYCyYMok7eE6vlVpa6FECPfBw
         FsFh+Re0pHVfiT80c7yNGwh5joA3i7Gdmjd0XtPuEhYo1R5HK8qFM2ZhI1nZRu83piWC
         T2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EBnPOk6UkZ2F+SuQHIFBXLKygxskZgQmYn6+lyWYOcc=;
        b=Vq4B6cd1HnsRBH2lazBGICubY4/oL+D9j5Q48WdP/AWjH/eUYh8eBw7hzrXB4fGezn
         e5SGTZujsYY7zg3m9D/sJvvxXoJzmXGdGQl50DHc9bLC3qVdh4lxPu8SGQ9WJLJQTDXE
         4edqwqsfQzT9CSYcFWm0PEIDd0k9qwcUTkypUE0qp+yv57+0KW/OFoBPvZdjp+RyezFj
         gSkGHifVhykp8b4eVqi/Kz3P+KqBBTXo263jQRA20hlV5zunq4kx2GQw2HTUGpn7+Wy0
         CaFMFyjCnKUoZsTpuGmwYQBg70mx2GjsgsmG4dk7k7eFBL8RHJsn21K3YWxSZW+NlJzy
         4iZg==
X-Gm-Message-State: AOAM532J7twkQImz59GJ17R6dZ42ymvz5JU96YosUrpOydKTK6k4xO8+
        eKvZ/Zd0U4BSKdFSFS7eViIhDd2azI4=
X-Google-Smtp-Source: ABdhPJxXyK/mmNFTgKRYyJWZTihQCUR+hTSWvVLKgkMg/UGB9Ooy3bpEKO2UTya014w9KJ1OuB3uzA==
X-Received: by 2002:a17:906:7857:: with SMTP id p23mr32006664ejm.61.1602574329498;
        Tue, 13 Oct 2020 00:32:09 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id p24sm11790530edq.35.2020.10.13.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 00:32:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 13 Oct 2020 09:32:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
Message-ID: <20201013073207.GA3173210@gmail.com>
References: <20201012141451.GA3425471@gmail.com>
 <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Oct 12, 2020 at 7:14 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest core/rcu git tree from:
> >
> > RCU changes for v5.10:
> >
> >  - Debugging for smp_call_function()
> >  - RT raw/non-raw lock ordering fixes
> >  - Strict grace periods for KASAN
> >  - New smp_call_function() torture test
> >  - Torture-test updates
> >  - Documentation updates
> >  - Miscellaneous fixes
> 
> I am *very* unhappy with this pull request.
> 
> It doesn't even mention the big removal of CONFIR_PREEMPT, that I felt 
> was still under discussion.

Not mentioning the unconditional PREEMPT_COUNT enabling aspect was 100% my 
fault in summarizing the changes insufficiently, as I (mistakenly) thought 
them to be uncontroversial. My apologies for that!

Here's a second attempt to properly justify these changes:

Regarding the performance aspect of the change, I was relying on these 
performance measurements:

  "Freshly conducted benchmarks did not reveal any measurable impact from 
   enabling preempt count unconditionally. On kernels with 
   CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY the preempt count is only 
   incremented and decremented but the result of the decrement is not 
   tested. Contrary to that enabling CONFIG_PREEMPT which tests the result 
   has a small but measurable impact due to the conditional branch/call."

FWIW, to inject some hard numbers into this discussion, here's also the 
code generation impact of an unconditional PREEMPT_COUNT, on x86-defconfig:

      text       data        bss    filename
  19675937    5591036    1433672    vmlinux.ubuntu.vanilla          # 856deb866d16: ("Linux 5.9-rc5")
  19682382    5590964    1425480    vmlinux.ubuntu.PREEMPT_COUNT=y  # 7681205ba49d: ("preempt: Make preempt count unconditional")

So this is a pretty small, +0.03% increase (+6k) in generated code in the 
core kernel, and it doesn't add widespread new control dependencies either.

I also measured the core kernel code generation impact on the kernel config 
from a major Linux distribution that uses PREEMPT_VOLUNTARY=y (Ubuntu):

  kepler:~/tip> grep PREEMPT .config
  # CONFIG_PREEMPT_NONE is not set
  CONFIG_PREEMPT_VOLUNTARY=y
  # CONFIG_PREEMPT is not set
  CONFIG_PREEMPT_COUNT=y
  CONFIG_PREEMPT_NOTIFIERS=y

     text       data        bss      filename
  15754341    13790786    5242880    vmlinux.ubuntu.vanilla          # 856deb866d16: ("Linux 5.9-rc5")
  15754790    13791018    5242880    vmlinux.ubuntu.PREEMPT_COUNT=y  # 7681205ba49d: ("preempt: Make preempt count unconditional")
  15754771    13791018    5242880    vmlinux.ubuntu.full_cleanups    # 849b9c5446cc: ("kvfree_rcu(): Fix ifnullfree.cocci warnings")

In this test the changes result in very little generated code increase in 
the core kernel, just +449 bytes, or +0.003%.

In fact the impact was so low on this config that I initially disbelieved 
it and double-checked the result and re-ran the build with all =m's turned 
into =y's, to get a whole-kernel measurement of the generated code impact:

      text       data        bss      filename
  84594448    61819613    42000384    vmlinux.ubuntu.vanilla          # 856deb866d16: ("Linux 5.9-rc5")
  84594129    61819777    42000384    vmlinux.ubuntu.PREEMPT_COUNT=y  # 7681205ba49d: ("preempt: Make preempt count unconditional")

Note how the full ~84 MB image actually *shrunk*, possibly due to random 
function & section alignment noise.

So to get a truly sensitive measurement of the impact of the PREEMPT_COUNT 
change I built with CONFIG_CC_OPTIMIZE_FOR_SIZE=y, to get tight instruction 
packing and no alignment padding artifacts:

      text        data         bss    filename
  69460329    60932573    40411136    vmlinux.ubuntu.vanilla          # 856deb866d16: ("Linux 5.9-rc5")
  69460739    60936853    40411136    vmlinux.ubuntu.PREEMPT_COUNT=y  # 7681205ba49d: ("preempt: Make preempt count unconditional")

This shows a 410 bytes (+0.0005%) increase.

  ( Side note: it's rather impressive that -Os saves 21% of text size - if 
    only GCC wasn't so stupid with the final 2-3% size optimizations... )

So there's even less relative impact on the whole 84 MB kernel image - 
modules don't do much direct preempt_count manipulation.

Just for completeness' sake I re-ran the original defconfig build as well, 
this time with -Os:

     text       data        bss     filename
  16091696    5565988    2928696    vmlinux.defconfig.Os.vanilla          # 856deb866d16: ("Linux 5.9-rc5")
  16095525    5570156    2928696    vmlinux.defconfig.Os.PREEMPT_COUNT=y  # 7681205ba49d: ("preempt: Make preempt count unconditional")

3.8k, or +0.025% - similar to the initial +0.03% result.

So even though I'm normally fiercely anti-bloat, if we combine the 
performance and code generation measurements with these maintainability 
arguments:

   "It's about time to make essential functionality of the kernel consistent 
    across the various preemption models.

    Enable CONFIG_PREEMPT_COUNT unconditionally. Follow up changes will 
    remove the #ifdeffery and remove the config option at the end."

I think the PREEMPT_COUNT=y change to reduce the schizm between the various 
preemption models is IMHO justified - and reducing the code base distance 
to -rt is the icing on the cake.

Thanks,

	Ingo
