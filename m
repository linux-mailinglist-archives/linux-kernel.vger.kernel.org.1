Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B722A6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 07:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgGWFgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 01:36:53 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50393 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgGWFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:36:53 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.14] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E2EA91BF206;
        Thu, 23 Jul 2020 05:36:45 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Palmer Dabbelt <palmer@dabbelt.com>, benh@kernel.crashing.org
Cc:     mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
References: <mhng-4b49d09a-0267-4879-849f-30c24f26e2c3@palmerdabbelt-glaptop1>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <970adad4-6eec-dffe-ad1c-bf74646229ad@ghiti.fr>
Date:   Thu, 23 Jul 2020 01:36:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-4b49d09a-0267-4879-849f-30c24f26e2c3@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 7/21/20 à 7:36 PM, Palmer Dabbelt a écrit :
> On Tue, 21 Jul 2020 16:11:02 PDT (-0700), benh@kernel.crashing.org wrote:
>> On Tue, 2020-07-21 at 14:36 -0400, Alex Ghiti wrote:
>>> > > I guess I don't understand why this is necessary at all.
>>> > > Specifically: why
>>> > > can't we just relocate the kernel within the linear map?  That would
>>> > > let the
>>> > > bootloader put the kernel wherever it wants, modulo the physical
>>> > > memory size we
>>> > > support.  We'd need to handle the regions that are coupled to the
>>> > > kernel's
>>> > > execution address, but we could just put them in an explicit memory
>>> > > region
>>> > > which is what we should probably be doing anyway.
>>> >
>>> > Virtual relocation in the linear mapping requires to move the kernel
>>> > physically too. Zong implemented this physical move in its KASLR RFC
>>> > patchset, which is cumbersome since finding an available physical spot
>>> > is harder than just selecting a virtual range in the vmalloc range.
>>> >
>>> > In addition, having the kernel mapping in the linear mapping prevents
>>> > the use of hugepage for the linear mapping resulting in performance 
>>> loss
>>> > (at least for the GB that encompasses the kernel).
>>> >
>>> > Why do you find this "ugly" ? The vmalloc region is just a bunch of
>>> > available virtual addresses to whatever purpose we want, and as 
>>> noted by
>>> > Zong, arm64 uses the same scheme.
>>
>> I don't get it :-)
>>
>> At least on powerpc we move the kernel in the linear mapping and it
>> works fine with huge pages, what is your problem there ? You rely on
>> punching small-page size holes in there ?
> 
> That was my original suggestion, and I'm not actually sure it's 
> invalid.  It
> would mean that both the kernel's physical and virtual addresses are set 
> by the
> bootloader, which may or may not be workable if we want to have an 
> sv48+sv39
> kernel.  My initial approach to sv48+sv39 kernels would be to just throw 
> away
> the sv39 memory on sv48 kernels, which would preserve the linear map but 
> mean
> that there is no single physical address that's accessible for both.  That
> would require some coordination between the bootloader and the kernel as to
> where it should be loaded, but maybe there's a better way to design the 
> linear
> map.  Right now we have a bunch of unwritten rules about where things 
> need to
> be loaded, which is a recipe for disaster.
> 
> We could copy the kernel around, but I'm not sure I really like that 
> idea.  We
> do zero the BSS right now, so it's not like we entirely rely on the 
> bootloader
> to set up the kernel image, but with the hart race boot scheme we have 
> right
> now we'd at least need to leave a stub sitting around.  Maybe we just throw
> away SBI v0.1, though, that's why we called it all legacy in the first 
> place.
> 
> My bigger worry is that anything that involves running the kernel at 
> arbitrary
> virtual addresses means we need a PIC kernel, which means every global 
> symbol
> needs an indirection.  That's probably not so bad for shared libraries, 
> but the
> kernel has a lot of global symbols.  PLT references probably aren't so 
> scary,
> as we have an incoherent instruction cache so the virtual function 
> predictor
> isn't that hard to build, but making all global data accesses GOT-relative
> seems like a disaster for performance.  This fixed-VA thing really just 
> exists
> so we don't have to be full-on PIC.
> 
> In theory I think we could just get away with pretending that medany is 
> PIC,
> which I believe works as long as the data and text offset stays 
> constant, you
> you don't have any symbols between 2GiB and -2GiB (as those may stay fixed,
> even in medany), and you deal with GP accordingly (which should work 
> itself out
> in the current startup code).  We rely on this for some of the early 
> boot code
> (and will soon for kexec), but that's a very controlled code base and we've
> already had some issues.  I'd be much more comfortable adding an explicit
> semi-PIC code model, as I tend to miss something when doing these sorts of
> things and then we could at least add it to the GCC test runs and 
> guarantee it
> actually works.  Not really sure I want to deal with that, though.  It 
> would,
> however, be the only way to get random virtual addresses during kernel
> execution.
> 
>> At least in the old days, there were a number of assumptions that
>> the kernel text/data/bss resides in the linear mapping.
> 
> Ya, it terrified me as well.  Alex says arm64 puts the kernel in the 
> vmalloc
> region, so assuming that's the case it must be possible.  I didn't get that
> from reading the arm64 port (I guess it's no secret that pretty much all 
> I do
> is copy their code)

See https://elixir.bootlin.com/linux/latest/source/arch/arm64/mm/mmu.c#L615.

> 
>> If you change that you need to ensure that it's still physically
>> contiguous and you'll have to tweak __va and __pa, which might induce
>> extra overhead.
> 
> I'm operating under the assumption that we don't want to add an 
> additional load
> to virt2phys conversions.  arm64 bends over backwards to avoid the load, 
> and
> I'm assuming they have a reason for doing so.  Of course, if we're PIC then
> maybe performance just doesn't matter, but I'm not sure I want to just 
> give up.
> Distros will probably build the sv48+sv39 kernels as soon as they show 
> up, even
> if there's no sv48 hardware for a while.
