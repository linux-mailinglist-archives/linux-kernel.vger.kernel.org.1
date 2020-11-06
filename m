Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95AC2A9AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKFRd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKFRd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:33:27 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3746C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:33:26 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id a20so1717345ilk.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZI7U3izYBLuKgwxS1LJeRXMFqpXLyUguXUomcL5pdk=;
        b=Gum7idwrRZT5cLtv5uC2Sol2ja8VuOwCY2LT1Rmh5IGcI+Zaj1U8ZZl7uHAfTB/K+4
         zwc01wlq6zZLsaM2E95LmhahaauO+pYSvPz9R40ehLEkrBdCtsMEF2Ryf0vyQWUH3gwF
         OLrrVouaLiZ0iDFQ1wOGn5DnXRwRIKsUmSkPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZI7U3izYBLuKgwxS1LJeRXMFqpXLyUguXUomcL5pdk=;
        b=CXuyKupDIuMKNZH2wFjY2ufNi3kimlHseAlqE3o+QVBbHtBKeHr6DChW3iMba0AHi1
         MZM/M7xSAiarLk6Jx0K3c5tpA6w+Rme8qge32/TPaLplpcJEj2ZUKJ7tQnKDQ627FXh2
         aIt7VrBodicHQ4N5Q+72jG3eiqp7k5QoLURqJP7StOB5du/MGUurWnL1m/vQ38LK/6Ct
         hCu+ykirIBDjXbeIdn6bCXxKIhHq8f4uuz4f0uajPw6qVPfrojv0oEA61ZswKpgL6c+v
         Pe2x7Q3tjBVY065WmSkzH19FRat1mD1Iytmj0pgHuCCDavo/Irzvl0Vyw/GwCMwXBQc/
         Krow==
X-Gm-Message-State: AOAM530suata0K/3X6zHiqX2PwRBBkyMhNMYmexc8KOw6ougLJJiLM/d
        WChchlI86laIYULGKOvlzuQG3Zph1UqFZXIanCaN
X-Google-Smtp-Source: ABdhPJxQKkLDaYAAvOSbnwEMmdO14qmO69Gu2BtyVBOiLFGnveflirWOvnXE8aUK7P43i2+nv0iQkJp/BpemBT5JVeU=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr2266305ilm.79.1604684006022;
 Fri, 06 Nov 2020 09:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20201006001752.248564-1-atish.patra@wdc.com> <20201006001752.248564-3-atish.patra@wdc.com>
 <20201106171403.GK29329@gaia>
In-Reply-To: <20201106171403.GK29329@gaia>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 6 Nov 2020 09:33:14 -0800
Message-ID: <CAOnJCUJo795yX_7am0hdB_JFio3_ZBRHioHNcydhqEouCUynUg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64, numa: Change the numa init functions name
 to be generic
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 9:14 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Oct 05, 2020 at 05:17:49PM -0700, Atish Patra wrote:
> > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > index 7ff800045434..96502ff92af5 100644
> > --- a/arch/arm64/kernel/acpi_numa.c
> > +++ b/arch/arm64/kernel/acpi_numa.c
> > @@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> >
> >       node_set(node, numa_nodes_parsed);
> >  }
> > -
> > -int __init arm64_acpi_numa_init(void)
> > -{
> > -     int ret;
> > -
> > -     ret = acpi_numa_init();
> > -     if (ret) {
> > -             pr_info("Failed to initialise from firmware\n");
> > -             return ret;
> > -     }
> > -
> > -     return srat_disabled() ? -EINVAL : 0;
> > -}
>
> I think it's better if arm64_acpi_numa_init() and arm64_numa_init()
> remained in the arm64 code. It's not really much code to be shared.
>

RISC-V will probably support ACPI one day. The idea is to not to do
exercise again in future.
Moreover, there will be arch_numa_init which will be used by RISC-V
and there will be arm64_numa_init
used by arm64. However, if you feel strongly about it, I am happy to
move back those two functions to arm64.

In case, we decide to go that route, can we define arm64_numa_init in
mm/init.c ?
Defining numa.c just for arm64_numa_init in arm64 may be an overkill.

> > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > index 73f8b49d485c..74b4f2ddad70 100644
> > --- a/drivers/base/arch_numa.c
> > +++ b/drivers/base/arch_numa.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >
> > -#include <asm/acpi.h>
> >  #include <asm/sections.h>
> >
> >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > @@ -444,16 +443,37 @@ static int __init dummy_numa_init(void)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_ACPI_NUMA
> > +static int __init arch_acpi_numa_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = acpi_numa_init();
> > +     if (ret) {
> > +             pr_info("Failed to initialise from firmware\n");
> > +             return ret;
> > +     }
> > +
> > +     return srat_disabled() ? -EINVAL : 0;
> > +}
> > +#else
> > +static int __init arch_acpi_numa_init(void)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +#endif
> > +
> >  /**
> > - * arm64_numa_init() - Initialize NUMA
> > + * arch_numa_init() - Initialize NUMA
> >   *
> >   * Try each configured NUMA initialization method until one succeeds. The
> > - * last fallback is dummy single node config encomapssing whole memory.
> > + * last fallback is dummy single node config encompassing whole memory.
> >   */
> > -void __init arm64_numa_init(void)
> > +void __init arch_numa_init(void)
> >  {
> >       if (!numa_off) {
> > -             if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
> > +             if (!acpi_disabled && !numa_init(arch_acpi_numa_init))
> >                       return;
> >               if (acpi_disabled && !numa_init(of_numa_init))
> >                       return;
>
> Does riscv even have an acpi_disabled variable?
>
It is defined in "include/linux/acpi.h" which is included in arch_numa.c

> --
> Catalin
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
