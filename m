Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFE268C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgINNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:39:12 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33322 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgINNeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:34:21 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 08EDX3O9012871
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:33:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 08EDX3O9012871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600090384;
        bh=xWftbWFvEeTv++1lO4mLb7Bfqvhd3CwG/NSYhB9uc54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=px8asxT9zwIUTNG4Q7M/yBIJBffaXrrajjojhqTTuWqzcK6tWCN6SPJ3mT06BMNIe
         DUKgYohaV6rIkYZdbSWzCI4nOpEj8K4Bdjyi0ZhsOIEvQ5ZCGuBC7SSnJ4FbAFwVN9
         L0X/rAXkSNfbxQkVdT4AiSygeH19iBZCcPCjX/Bvccd+ByQAL/mLoayD43EzSWyQin
         nYKA1RNToNn/aI/te/DDyw8fPzSwJX+LlDfydXOZJRtI++UF6hqS8fJwq8+1j1C7Bf
         eu4E6F6ialSPRdyyTIsJXujNBRiiXePz8AN+4QGXrceqgIbXzkN91RWoJ6FWrmmNda
         chaU7CFQKGLOQ==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id y1so5252390pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:33:03 -0700 (PDT)
X-Gm-Message-State: AOAM533Wv6/RRrva4ig+c1VWdsjTa59P+fVVhkBE+7ULaSY4Hm9h3gRM
        nYZ8MODBwgAUNXQ39m4uHj268Ak9JTtLbKxqpvk=
X-Google-Smtp-Source: ABdhPJx5ISxGS/94EcoPNT45NxFJNoc9jngKBPveBfJ64Z+x8bwWXOFoeNvbPOXjLafIY0AbT99vAUWYGTY3OceCh80=
X-Received: by 2002:a17:902:9f86:: with SMTP id g6mr13782978plq.32.1600090382908;
 Mon, 14 Sep 2020 06:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200820063526.GA3278096@gmail.com> <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
 <20200914123708.GA603584@gmail.com>
In-Reply-To: <20200914123708.GA603584@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 14 Sep 2020 22:32:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4nRBkc1Cg5tJCCo=pmfLpXiAehv8tdh-KUK66JAPbxQ@mail.gmail.com>
Message-ID: <CAK7LNAT4nRBkc1Cg5tJCCo=pmfLpXiAehv8tdh-KUK66JAPbxQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Run syncconfig with -s
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 9:37 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > On Thu, Aug 20, 2020 at 3:35 PM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > On every kernel build that runs --syncconfig, there's an output of the following line:
> > >
> > >   scripts/kconfig/conf  --syncconfig Kconfig
> > >
> > > This is the only non-platform build message the kbuild system emits that isn't
> > > prefixed by at least a space, or is a build warning.
> > >
> > > Run it under -s - if there's any problem it will emit messages anyway.
> > >
> > > With this change the following simple grep filter will show all build warnings
> > > and errors of a kernel build:
> > >
> > >    make | grep -v '^ '
> >
> >
> >
> > I do want to see something when syncconfig is invoked.
> >
> > I will apply this instead:
> > https://patchwork.kernel.org/patch/11727445/
>
> BTW., there's another, rather spurious bug I recently triggered in kbuild.
>
> Occasionally when I Ctrl-C a kernel build on a system with a lot of CPUs,
> the .o.cmd file gets corrupted:
>
>   mm/.pgtable-generic.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.
>   make: *** [Makefile:1788: mm] Error 2
>   make: *** Waiting for unfinished jobs....
>
> The .o.cmd file is half-finished:
>
>     $(wildcard include/config/shmem.h) \
>     $(wildcard include/config/hugetlb/page.h) \
>     $(wildcard include/config/zone/device.h) \
>     $(wildcard include/config/dev/pagemap/ops.h) \
>     $(wildcard include/config/device/private.h) \
>     $(wildcard include/config/pci/p2pdma.h) \
>     $(wildcard include/config/sparsemem.h) \
>     $(wildcard include/config/sparsemem/vmemmap.h) \
>     $(wildcard include/config/numa/balancing.h) \
>     $(wildcard i
>     [premature EOF]


Hmm, previously fixdep was not robust against
errors or interruption.
So, I occasionally observed the same problem as you saw.


I fixed it in
6f9ac9f4427ec0470ccffbf852cfaf326677cc21


Since then, I have not seen
the broken .cmd file issue.


I repeated 'make -j256' and Ctrl-C,
but I could not reproduce it...



If GNU Make was interrupted during the build rule
of mm/pgtable-generic.o, GNU Make should automatically
have deleted mm/pgtable-generic.o because
partially updated (i.e. corrupted) files are
the source of all the troubles.

Isn't this the case for you?


If I interrupt Kbuild, I see several
Deleting file '.....'
messages, like follows:



  CC      fs/seq_file.o
  CC      drivers/acpi/dock.o
  CC      drivers/scsi/scsi_devinfo.o
  CC      fs/xattr.o
^Cmake[1]: *** [scripts/Makefile.build:283: fs/seq_file.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: net/ipv6/af_inet6.o] Interrupt
make[3]: *** [scripts/Makefile.build:283:
drivers/net/phy/mdio-boardinfo.o] Interrupt
make[4]: *** [scripts/Makefile.build:283:
drivers/tty/serial/8250/8250_pnp.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: security/selinux/status.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: arch/x86/kernel/dumpstack.o] Interrupt
make[2]: *** Deleting file 'drivers/acpi/resource.o'
make[2]: *** [scripts/Makefile.build:500: drivers/net/phy] Interrupt
make[2]: *** [scripts/Makefile.build:283: net/sched/act_api.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: drivers/scsi/scsi_devinfo.o] Interrupt
make[1]: *** Deleting file 'arch/x86/pci/mmconfig_64.o'
make[1]: *** [scripts/Makefile.build:500: net/ipv6] Interrupt
make[2]: *** [scripts/Makefile.build:283: net/ethtool/wol.o] Interrupt
make[1]: *** Deleting file 'arch/x86/pci/init.o'
make[1]: *** [scripts/Makefile.build:283: arch/x86/pci/mmconfig_64.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: net/sunrpc/socklib.o] Interrupt
make[1]: *** [scripts/Makefile.build:283: fs/xattr.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: sound/hda/hdac_sysfs.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: net/mac80211/main.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: drivers/input/input-mt.o] Interrupt
make[2]: *** [scripts/Makefile.build:283: net/rfkill/core.o] Interrupt
make[1]: *** [scripts/Makefile.build:283: lib/bug.o] Interrupt
make: *** [Makefile:1792: lib] Interrupt
make[2]: *** Deleting file 'drivers/rtc/systohc.o'




> Instead of the regular rules that end in:
>
>     $(wildcard include/config/memory/hotplug/sparse.h) \
>
>     mm/pgtable-generic.o: $(deps_mm/pgtable-generic.o)
>
>     $(deps_mm/pgtable-generic.o):
>     [regular EOF]
>
> Manually removing the corrupted .o.cmd dot file solves the bug.
>
> There's no reproducer other than Ctrl-C-ing large build jobs a couple of times.
>
> Thanks,
>
>         Ingo


--
Best Regards
Masahiro Yamada
