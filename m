Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4627D628
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgI2Svm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2Svm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:51:42 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9870C061755;
        Tue, 29 Sep 2020 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=4oPHUpydHQHVg7N/DiTg/2k5w4HoApzrMoMKz556bOk=; b=LYrI13lQzAkLkQtkFjsnhoaIto
        +1o1p738YrPZINi8UpfLvfRYPfu9YXt/TWANnemzsu/WSbVsODTgNC/ARyLKp/gLoIW2mMZcjbv3h
        xuq8plU4wHnSGvLKW7Na6oePETtve74DhVmSH1azo2sOAD20v1lKUPSjlfwiZTCV4h428O7imIpgq
        Snj2dEUyADwX3v8TK2TE3RW9aKAlgwp0u6u7LrqL0g3WUhu28JHW/wN0OwOFJb3Vw1LrEIoySZeWm
        pL3Vh556nV4bXwDnWg55LQ2iKoMUCR+NdXDfzufhACNgLNiyB5lv78YOlT6Ir/QgO5WLarIidRO86
        Tg+BbfCw==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1kNKio-0004jI-HC; Tue, 29 Sep 2020 20:51:30 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1kNKil-000oKY-UZ; Tue, 29 Sep 2020 20:51:27 +0200
Date:   Tue, 29 Sep 2020 20:51:27 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
Message-ID: <20200929185127.GC2705@aurel32.net>
Mail-Followup-To: Guo Ren <guoren@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Tycho Andersen <tycho@tycho.ws>, Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org>
 <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net>
 <87lfgzeidk.fsf@igel.home>
 <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-09-25 00:19, Guo Ren wrote:
> How about this, revert the commit and don't free INIT_DATA_SECTION. I
> think the solution is safe enough, but wast a little memory.
> 
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index f3586e3..34d00d9 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -22,13 +22,11 @@ SECTIONS
>         /* Beginning of code and text segment */
>         . = LOAD_OFFSET;
>         _start = .;
> -       _stext = .;
>         HEAD_TEXT_SECTION
>         . = ALIGN(PAGE_SIZE);
> 
>         __init_begin = .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -       INIT_DATA_SECTION(16)
>         . = ALIGN(8);
>         __soc_early_init_table : {
>                 __soc_early_init_table_start = .;
> @@ -55,6 +53,7 @@ SECTIONS
>         . = ALIGN(SECTION_ALIGN);
>         .text : {
>                 _text = .;
> +               _stext = .;
>                 TEXT_TEXT
>                 SCHED_TEXT
>                 CPUIDLE_TEXT
> @@ -67,6 +66,8 @@ SECTIONS
>                 _etext = .;
>         }
> 
> +       INIT_DATA_SECTION(16)
> +
>         /* Start of data section */
>         _sdata = .;
>         RO_DATA(SECTION_ALIGN)
> 

This patch doesn't apply, as tabs have been converted to space
somewhere. After fixing that, the patch applies and I confirm that it
fixes the problem.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
