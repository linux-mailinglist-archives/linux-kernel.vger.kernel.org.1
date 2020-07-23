Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA4E22A6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 07:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGWFWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 01:22:01 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46983 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGWFWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:22:00 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.14] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 722BD60002;
        Thu, 23 Jul 2020 05:21:51 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
References: <mhng-831c4073-aefa-4aa0-a583-6a17f9aff9b7@palmerdabbelt-glaptop1>
 <d7e3cbb7-c12a-bce2-f1db-c336d15f74bd@ghiti.fr>
 <7cb2285e-68ba-6827-5e61-e33a4b65ac03@ghiti.fr>
 <54af168083aee9dbda1b531227521a26b77ba2c8.camel@kernel.crashing.org>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <cade70e2-0179-2650-41c5-036679aaf30c@ghiti.fr>
Date:   Thu, 23 Jul 2020 01:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <54af168083aee9dbda1b531227521a26b77ba2c8.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Le 7/21/20 à 7:11 PM, Benjamin Herrenschmidt a écrit :
> On Tue, 2020-07-21 at 14:36 -0400, Alex Ghiti wrote:
>>>> I guess I don't understand why this is necessary at all.
>>>> Specifically: why
>>>> can't we just relocate the kernel within the linear map?  That would
>>>> let the
>>>> bootloader put the kernel wherever it wants, modulo the physical
>>>> memory size we
>>>> support.  We'd need to handle the regions that are coupled to the
>>>> kernel's
>>>> execution address, but we could just put them in an explicit memory
>>>> region
>>>> which is what we should probably be doing anyway.
>>>
>>> Virtual relocation in the linear mapping requires to move the kernel
>>> physically too. Zong implemented this physical move in its KASLR RFC
>>> patchset, which is cumbersome since finding an available physical spot
>>> is harder than just selecting a virtual range in the vmalloc range.
>>>
>>> In addition, having the kernel mapping in the linear mapping prevents
>>> the use of hugepage for the linear mapping resulting in performance loss
>>> (at least for the GB that encompasses the kernel).
>>>
>>> Why do you find this "ugly" ? The vmalloc region is just a bunch of
>>> available virtual addresses to whatever purpose we want, and as noted by
>>> Zong, arm64 uses the same scheme.
> 
> I don't get it :-)
> 
> At least on powerpc we move the kernel in the linear mapping and it
> works fine with huge pages, what is your problem there ? You rely on
> punching small-page size holes in there ?
> 

ARCH_HAS_STRICT_KERNEL_RWX prevents the use of a hugepage for the kernel 
mapping in the direct mapping as it sets different permissions to 
different part of the kernel (data, text..etc).


> At least in the old days, there were a number of assumptions that
> the kernel text/data/bss resides in the linear mapping.
> 
> If you change that you need to ensure that it's still physically
> contiguous and you'll have to tweak __va and __pa, which might induce
> extra overhead.
> 

Yes that's done in this patch and indeed there is an overhead to those 
functions.

> Cheers,
> Ben.
>   
> 

Thanks,

Alex
