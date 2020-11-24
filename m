Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9C2C1BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgKXDVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgKXDVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:21:00 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 19:20:59 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so19302993edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 19:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOFdXpPojtFxAkRRVy2a27OlESY/0UPc735Z8yMOHvs=;
        b=YyKeNNvxn95DWg2JLjBKJkTAq6qlCu0TyOmgr1fzeGtebwZ16cEPxrTnSiL1Rwn+Fj
         wYbYskw8d8UKsNw6fBHsSkGqlc8DUt2LfXZ7JcBjin/wQPYEDC0ddUk5wGa89VCF5L2f
         kNTBXyI4WgcbgCQksTttWAoQWHZ99p/AGvY9t9TYiRD7/aHZGmQF7awW4fX3MsuJah+V
         MtRZjitMGeq8hULKfVSl2Kd6pu1rrGYy7KnDgIHqyUc7vIsBDF5v9T8h2jjL1IG92FY1
         XEmTU5WtvNpDp8fR+p6gI4TJU5GyTrDs6ICCC5+kSzInnngSw3p7Kp9Kz4pWsBUyO0z/
         E6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOFdXpPojtFxAkRRVy2a27OlESY/0UPc735Z8yMOHvs=;
        b=KVlO9tk9gJliMlr+Qmkdy51dc0RRvIBh1QBqAJtWb63pGWjusoHhh6gOYiAEqjMJYz
         fq37MVwzEy3JVjpFZstkHS8cifV84/WciS3CgoCGNpS/doDjPJgFRxnvw5t1IrzjlcBK
         mVqF6CUs+c8SCVoCrFFySvUJdge77CJv/MovBUldcS7O2T1kZEbf0Oday6DvwiBh95oR
         u7qeqGL78ndEid0+yQDSee4m+GjShmZiI5e4zQK/2Bm6Ts33TB5v1FrWiQo9C+wS0muo
         lJKPunx97GgVfRtGFiTUkXr/bPBWbwhlDGE3lI4ulth16JmeqqwpAnD4xKtJbkDlagUe
         obYw==
X-Gm-Message-State: AOAM530s1N17yGyTiRPeOfKvjlTv8CghtEl7sll+6kyHbK1EBYJATyQ4
        iDqYEF2smYJCV/pvwsrZ13GxHWFs5ARD9SV7FQ+HXg/WnS4=
X-Google-Smtp-Source: ABdhPJxup72wmh2dDp5FH+iPEX+j2uRyCznCBfy2lMmXyTvHgCmTH3QxKVwiWaGquIzd9s4eRhx4oR5O9Bhw+6Dusos=
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr2181280edx.300.1606188058656;
 Mon, 23 Nov 2020 19:20:58 -0800 (PST)
MIME-Version: 1.0
References: <202011241003.eYk8XbNj-lkp@intel.com>
In-Reply-To: <202011241003.eYk8XbNj-lkp@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Nov 2020 19:20:46 -0800
Message-ID: <CAPcyv4hoGYDro_JKUtKv+A69u=+2rKdfkACmNR6ndb-ZXGJsDw@mail.gmail.com>
Subject: Re: arch/powerpc/mm/book3s64/pgtable.c:174:15: error: no previous
 prototype for 'create_section_mapping'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:13 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
> commit: a927bd6ba952d13c52b8b385030943032f659a3e mm: fix phys_to_target_node() and memory_add_physaddr_to_nid() exports
> date:   31 hours ago
> config: powerpc-randconfig-r024-20201123 (attached as .config)
> compiler: powerpc64le-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a927bd6ba952d13c52b8b385030943032f659a3e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a927bd6ba952d13c52b8b385030943032f659a3e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> arch/powerpc/mm/book3s64/pgtable.c:174:15: error: no previous prototype for 'create_section_mapping' [-Werror=missing-prototypes]
>      174 | int __meminit create_section_mapping(unsigned long start, unsigned long end,
>          |               ^~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/mm/book3s64/pgtable.c:405:6: error: no previous prototype for 'arch_report_meminfo' [-Werror=missing-prototypes]
>      405 | void arch_report_meminfo(struct seq_file *m)
>          |      ^~~~~~~~~~~~~~~~~~~
>    arch/powerpc/mm/book3s64/pgtable.c:461:5: error: no previous prototype for 'pmd_move_must_withdraw' [-Werror=missing-prototypes]
>      461 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>          |     ^~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
>
> vim +/create_section_mapping +174 arch/powerpc/mm/book3s64/pgtable.c

The whack-a-mole continues... the kbuild-robot success report I
received gave me too much confidence.
