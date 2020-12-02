Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8242CC486
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbgLBSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:07:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51972 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgLBSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:07:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C4CC88AD7;
        Wed,  2 Dec 2020 13:06:38 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=xchxvcgdOOFFZWHClwls/YGIHlk=; b=hPL3yG
        mT5VZAEnudO6JZyKt3t+xZ2aqPt11dJ3uDa9wnwGk6Eyoc5LTYULCOtFcBBnsfIk
        MIhX4dvuH1R7omufW39Hj8nQx0gnKMsUxRJXHm/Jj6Z6QUU6EEHiHrm2t+g1gyXm
        SCODG9S82KZdiKcYSW6t14feJofPvlBoYR2zk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73B5088AD6;
        Wed,  2 Dec 2020 13:06:38 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=qJIqO5Uf6GpAQisSeceYMe5ahfpyrEbeOGVBOz1OEAo=; b=MBmjzAvEvtodaoDHpn6T30wgG1MCoc2aFqqKBQPQMlqrbML0FMcmcC/rJTHhQxXShLGPiCAD67N7XzQab2pu7Mhu+6AO+u4eqs/L+udIzfcPRwyzxhGyr+gxprZZF/LGBRvkt9NJKdl9hosq0BEw+E/pXRLoGK4DhbI5HzjST9A=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E66E788AD5;
        Wed,  2 Dec 2020 13:06:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id DFBC82DA0208;
        Wed,  2 Dec 2020 13:06:36 -0500 (EST)
Date:   Wed, 2 Dec 2020 13:06:36 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] arch/riscv: enable XIP
In-Reply-To: <20201202150130.16936-1-vitaly.wool@konsulko.com>
Message-ID: <5916q277-o720-n6q-9o2-oo9nsqr6q63q@syhkavp.arg>
References: <20201202150130.16936-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 1F178C70-34C9-11EB-9060-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020, Vitaly Wool wrote:

> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> It allows code to be executed directly from non-volatile storage
> directly addressable by the CPU, such as QSPI NOR flash which can
> be found on many RISC-V platforms. This makes way for significant
> optimization of RAM footprint. The XIP kernel is not compressed
> since it has to run directly from flash, so it will occupy more
> space on the non-volatile storage to The physical flash address
> used to link the kernel object files and for storing it has to
> be known at compile time and is represented by a Kconfig option.
> 
> XIP on RISC-V will currently only work on MMU-enabled kernels.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>

That's nice!

Suggestion for a future enhancement:
To save on ROM storage, and given that the .data segment has to be 
copied to RAM anyway, you could store .data compressed and decompress it 
to RAM instead. See commit ca8b5d97d6bf for inspiration. In fact, many 
parts there could be shared.

More comments below.

> +#define __XIP_FIXUP(addr) \
> +	(((long)(addr) >= CONFIG_XIP_PHYS_ADDR && \
> +	  (long)(addr) <= CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
> +	(long)(addr) - CONFIG_XIP_PHYS_ADDR + CONFIG_XIP_PHYS_RAM_BASE - XIP_OFFSET : \
> +	(long)(addr))

Here you should cast to unsigned long instead.

> +#ifdef CONFIG_XIP_KERNEL
> +	la a0, _trampoline_pg_dir
> +	lw t0, _xip_fixup
> +	add a0, a0, t0
[...]
> +_xip_fixup:
> +	.dword CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> +#endif

Here _xip_fixup is a dword but you're loading it as a word.
This won't work for both rv32 and rv64.

> +SECTIONS
> +{
> +	/* Beginning of code and text segment */
> +	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> +	_xiprom = .;
> +	_start = .;
> +	HEAD_TEXT_SECTION
> +	INIT_TEXT_SECTION(PAGE_SIZE)
> +	/* we have to discard exit text and such at runtime, not link time */
> +	.exit.text :
> +	{
> +		EXIT_TEXT
> +	}
> +
> +	.text : {
> +		_text = .;
> +		_stext = .;
> +		TEXT_TEXT
> +		SCHED_TEXT
> +		CPUIDLE_TEXT
> +		LOCK_TEXT
> +		KPROBES_TEXT
> +		ENTRY_TEXT
> +		IRQENTRY_TEXT
> +		SOFTIRQENTRY_TEXT
> +		*(.fixup)
> +		_etext = .;
> +	}
> +	RO_DATA(L1_CACHE_BYTES)
> +	.srodata : {
> +		*(.srodata*)
> +	}
> +	.init.rodata : {
> +		INIT_SETUP(16)
> +		INIT_CALLS
> +		CON_INITCALL
> +		INIT_RAM_FS
> +	}
> +	_exiprom = ALIGN(PAGE_SIZE);		/* End of XIP ROM area */

Why do you align this to a page size?

> +
> +
> +/*
> + * From this point, stuff is considered writable and will be copied to RAM
> + */
> +	__data_loc = ALIGN(PAGE_SIZE);	/* location in file */

Same question here?

> +	. = PAGE_OFFSET;		/* location in memory */
> +
> +	_sdata = .;			/* Start of data section */
> +	_data = .;
> +	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +	_edata = .;
> +	__start_ro_after_init = .;
> +	.data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> +		*(.data..ro_after_init)
> +	}
> +	__end_ro_after_init = .;
> +
> +	. = ALIGN(PAGE_SIZE);

And again here?

> +#ifdef CONFIG_XIP_KERNEL
> +/* called from head.S with MMU off */
> +asmlinkage void __init __copy_data(void)
> +{
> +	void *from = (void *)(&_sdata);
> +	void *end = (void *)(&_end);
> +	void *to = (void *)CONFIG_XIP_PHYS_RAM_BASE;
> +	size_t sz = (size_t)(end - from);
> +
> +	memcpy(to, from, sz);
> +}
> +#endif

Where is the stack located when this executes? The stack for the init 
task is typically found within the .data area. At least on ARM it is. 
You don't want to overwrite your stack here.


Nicolas
