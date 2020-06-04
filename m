Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964F71EDDD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 09:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFDHOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 03:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgFDHOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:14:32 -0400
Received: from willie-the-truck (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9169206DC;
        Thu,  4 Jun 2020 07:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591254871;
        bh=pQiZ65/cUBUWSQ69Pq08Vdl1ay+BjdbFbkajb1aT1Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUcXCOKg4TAj9iHXF8yeI1elrDXEEOp/4uPhjL9xePaNoUijZ0Xw57hLkjCd6K0Ji
         MF/F1DTXZPJa4cak++xV07+8vXwvrMiMNiR89fi8bUUIn2Yr8MPrUKieaS2ja6M+Wj
         XtO6FKhx9/TE3nEhuVik1in0DW+6fQq0DVqKhuu8=
Date:   Thu, 4 Jun 2020 08:14:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     John Donnelly <john.p.donnelly@oracle.com>,
        chenzhou <chenzhou10@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Devicetree List <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        guohanjun@huawei.com,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>, nsaenzjulienne@suse.de,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        RuiRui Yang <dyoung@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20200604071410.GA30155@willie-the-truck>
References: <CAJ2QiJ+1Hj2OQzpR5CfvLGMfTTbXAST94hsbfm0VcDmJKV3WTw@mail.gmail.com>
 <303695cc-d3ea-9f51-1489-07d27d4253d4@oracle.com>
 <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
 <F64A309C-B9C0-45F2-A50D-D677005C33A6@oracle.com>
 <CAJ2QiJJE-jeRL1HPUZCwi1LtV9CBMmYrsOaS6vX1R1sJ6Z1t8g@mail.gmail.com>
 <6EA47B07-5119-49DF-9980-12A2066F22CA@oracle.com>
 <CAJ2QiJJhUCnobrMHui5=6zLzgy3KsoPxrqiH_oYT8Jhb5MkmbA@mail.gmail.com>
 <8463464e-5461-f328-621c-bacc6a3b88dd@huawei.com>
 <8E0D45DC-12BF-437D-A342-03E974D9C6D4@oracle.com>
 <CACi5LpN-+NRnaDoWWWidbzma8BNzmofA5FQBV=cPF1Mc84FpFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACi5LpN-+NRnaDoWWWidbzma8BNzmofA5FQBV=cPF1Mc84FpFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:17:06AM +0530, Bhupesh Sharma wrote:
> On Wed, Jun 3, 2020 at 9:03 PM John Donnelly <john.p.donnelly@oracle.com> wrote:
> > > On Jun 3, 2020, at 8:20 AM, chenzhou <chenzhou10@huawei.com> wrote:
> > > On 2020/6/3 19:47, Prabhakar Kushwaha wrote:
> > >>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > >>>> index 7f9e5a6dc48c..bd67b90d35bd 100644
> > >>>> --- a/kernel/crash_core.c
> > >>>> +++ b/kernel/crash_core.c
> > >>>> @@ -354,7 +354,7 @@ int __init reserve_crashkernel_low(void)
> > >>>>                       return 0;
> > >>>>       }
> > >>>>
> > >>>> -       low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> > >>>> +       low_base = memblock_find_in_range(0,0xc0000000, low_size, CRASH_ALIGN);
> > >>>>       if (!low_base) {
> > >>>>               pr_err("Cannot reserve %ldMB crashkernel low memory,
> > >>>> please try smaller size.\n",
> > >>>>                      (unsigned long)(low_size >> 20));
> > >>>>
> > >>>>
> > >>>    I suspect  0xc0000000  would need to be a CONFIG item  and not hard-coded.
> > >>>
> > >> if you consider this as valid change,  can you please incorporate as
> > >> part of your patch-set.
> > >
> > > After commit 1a8e1cef7 ("arm64: use both ZONE_DMA and
> > > ZONE_DMA32")，the 0-4G memory is splited to DMA [mem
> > > 0x0000000000000000-0x000000003fffffff] and DMA32 [mem
> > > 0x0000000040000000-0x00000000ffffffff] on arm64.
> > >
> > > From the above discussion, on your platform, the low crashkernel fall
> > > in DMA32 region, but your environment needs to access DMA region, so
> > > there is the call trace.
> > >
> > > I have a question, why do you choose 0xc0000000 here?
> > >
> > > Besides, this is common code, we also need to consider about x86.
> > >
> >
> >  + nsaenzjulienne@suse.de
> >
> >   Exactly .  This is why it needs to be a CONFIG option for  Raspberry
> >   ..,  or device tree option.
> >
> >
> >   We could revert 1a8e1cef7 since it broke  Arm kdump too.
> 
> Well, unfortunately the patch for commit 1a8e1cef7603 ("arm64: use
> both ZONE_DMA and ZONE_DMA32") was not Cc'ed to the kexec mailing
> list, thus we couldn't get many eyes on it for a thorough review from
> kexec/kdump p-o-v.
> 
> Also we historically never had distinction in common arch code on the
> basis of the intended end use-case: embedded, server or automotive, so
> I am not sure introducing a Raspberry specific CONFIG option would be
> a good idea.

Right, we need a fix that works for everybody, since we try hard for a
single Image that works for all platforms.

What I don't really understand is why, with Chen's patches applied, we can't
just keep the crashkernel out of the DMA zones altogether when no base is
specified. I guess I'll just look out for your patch!

Will
