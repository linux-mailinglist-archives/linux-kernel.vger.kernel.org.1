Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90178283F64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgJETOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJETON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:14:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B62BC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:14:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v8so10385100iom.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwAxPetPQqjNloRqroHgPvWNU+a4/LgMNfeziHOHJfY=;
        b=F2TRLVcMaGt3VPEEmegwbHPJ4ou8ND6anmLed18QlQIrqj8v2nxubg6lM79u1s4oi9
         pUIrVv2FRRGNSC8ASvas42okTQ3qCh7q3fWtd6bfHviFqAceEtSblKsomzFqK+lMqnir
         MxxNaca8KW2t8a/hAAHLN2eXGppKSuGDWm1aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwAxPetPQqjNloRqroHgPvWNU+a4/LgMNfeziHOHJfY=;
        b=ptEpLgQeE7wVByma9L1+PdrS+8tUGFNFeAnu1OebNQdKMNfB0BibxnMgAAsTNdU4nL
         Ia5b8GmXhbnZ84R8Qk20GF5zn/7H5aR1mXlZjSSaHX43LZktP2qW7bqE84eehOVWmsrP
         fBovPOFhpiOjJ8fLOfmcdelrekHte/xQy4ZBRJoQQ3WaQKJV9Op2z4oFTXK54dx9i/Hi
         KpnsimuDmAv7Q/DbxtBd3JqblzvniH96aQgnlsSQb49kpBx15UDqt5hGlScGUI5ngsFs
         tJHuOJTfxuSiG8pFEoz4nIbt3mdt+0hPGcu09Gkz91CuPGvzjCLdikaN43QYaQjjsBJe
         WSRg==
X-Gm-Message-State: AOAM532+AzMQxxN/IuGr5MSWGZLST6SrmIv/lr+iILOH/JrXtwhFSBTW
        FIRM95/8dzcWjaJROGtUgXS6f3OKHTZ/m40aHezp
X-Google-Smtp-Source: ABdhPJzZTWc5aDIps9qCUH4gIcx01yrGYSRg4jL6Z7cAHeANHCNGR8ghILZwdUivcGDVDXopZEUHL3dxxcJiPt4KNJA=
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr1345504jaj.115.1601925252825;
 Mon, 05 Oct 2020 12:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net> <87lfgzeidk.fsf@igel.home> <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 5 Oct 2020 12:14:01 -0700
Message-ID: <CAOnJCUJhb2K89pRETbfTJ=5jHQhWfyfrOUu8zOE77j+id6OpSA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 9:19 AM Guo Ren <guoren@kernel.org> wrote:
>
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

I think you need to move EXIT_DATA as well. Currently, we have init
data & text in one section.
In general it is better idea to separate those similar to ARM64.
Additionally, ARM64 applies different mapping for init data & text
as the init data section is marked as non-executable[1]

However, we don't modify any permission for any init sections. Should
we do that as well ?

[1] https://patchwork.kernel.org/patch/9572869/

>         /* Start of data section */
>         _sdata = .;
>         RO_DATA(SECTION_ALIGN)
>
> On Thu, Sep 24, 2020 at 3:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >
> > On Sep 14 2020, Aurelien Jarno wrote:
> >
> > > How should we proceed to get that fixed in time for 5.9? For the older
> > > branches where it has been backported (so far 5.7 and 5.8), should we
> > > just get that commit reverted instead?
> >
> > Can this please be resolved ASAP?
> >
> > Andreas.
> >
> > --
> > Andreas Schwab, schwab@linux-m68k.org
> > GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> > "And now for something completely different."
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
