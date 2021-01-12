Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED72F26B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbhALDch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbhALDch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:32:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 882BB22DFB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610422316;
        bh=LbikLWN0Wr/yfcAvca6bpWFUFuvrFZe518dAXl2GcfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJOTfjnFIOZQbQKPvrqZR8mKcj035uWjHHe4OCjVgCIEZwg9kTvUfwrDh417Nk3jg
         CskG85XcsNu7QFPGMNR7Fi/hS27ZvLeV02vpEXdldS97RdtnghiFSDC2+92FyeZbT4
         f1yq2Hwqaukeyk5wsKyrbg4acxw1QvsmUY4D2f0qFhZ0JwG82bfcCLwIRcHIj78j/M
         jmcWhbYtLckPgmMdG7yNNwfdU+zS6lp1kFT5oDlGHxzW+XPVJPJ7h/ne6pUyqIAKjf
         Eay/bohnlFrhrjjvlTs1TQRIKxMXRsuawHnyLbNamH0+V5G7w3A59S3EKzGpNT3leV
         pX8NiRhn80rhA==
Received: by mail-ed1-f51.google.com with SMTP id v26so696570eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:31:56 -0800 (PST)
X-Gm-Message-State: AOAM532xHpAbLjtKeOYGYhzYJp5YIyi69xRQCheyeZ1BxQpXDgIrH/Xx
        wT1QSTTGaBsTUXQYSf076iOwU8vo02zZATS6kLWFDA==
X-Google-Smtp-Source: ABdhPJxiSpIjrZ53OjTj99e1q25kepOCc1vfEkEJQqQohjfhK66ZYJsARVpSpEvughILlwDZeClamnlLVplk5u0LjWA=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr1730459edr.97.1610422315014;
 Mon, 11 Jan 2021 19:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20210111200027.GH25645@zn.tnic> <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <CALCETrV=BpFwR-RU5ORioBCZj3RwK7nmD2Yz3VNd4gfFjukRAw@mail.gmail.com> <0ad68c87-ac2e-478e-ed97-95256464a3ba@suse.de>
In-Reply-To: <0ad68c87-ac2e-478e-ed97-95256464a3ba@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Jan 2021 19:31:43 -0800
X-Gmail-Original-Message-ID: <CALCETrXkePULoyH85bmUGfCbvn4M9xxQOK9v_UL_+BkwUDrt1Q@mail.gmail.com>
Message-ID: <CALCETrXkePULoyH85bmUGfCbvn4M9xxQOK9v_UL_+BkwUDrt1Q@mail.gmail.com>
Subject: Re: gdbserver + fsgsbase kaputt
To:     Tom de Vries <tdevries@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 3:52 PM Tom de Vries <tdevries@suse.de> wrote:
>
> On 1/12/21 12:40 AM, Andy Lutomirski wrote:
> > On Mon, Jan 11, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >>
> >>> On Jan 11, 2021, at 12:00 PM, Borislav Petkov <bp@alien8.de> wrote:
> >>>
> >>
> >>
> >>> Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
> >>> with fsgsbase enabled in all test kernels?
> >>
> >> Yes. But I can also look myself in a bit.
> >>
> >
> > Tom, if I reproduce it in an interactive gdb and play a bit, I get:
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0xf7df2cb6 in init_cacheinfo () from target:/lib/libc.so.6
> > (gdb) p $gs = $gs
> > $1 = 99
> > (gdb) si
> >
> > Program terminated with signal SIGSEGV, Segmentation fault.
> > The program no longer exists.
> >
> > That's gdb itself crashing.  Any idea what's wrong?
> >
>
> The first "Program received signal SIGSEGV, Segmentation fault" means
> that gdb intercepts the sigsegv, and allows you to inspect it f.i. by
> printing $_siginfo.  The inferior is still live at this point.
>
> Then when trying to continue using si,  the signal is passed on to the
> inferior, which means it'll be terminated.
>
> AFAIU, gdb has not crashed, and behaves as expected.  See below for a
> similar scenario.
>
> Thanks,
> - Tom
>
> ...
> $ cat test2.c
> int
> main (void)
> {
>   *((int *)0) = 0;
>   return 0;
> }
> $ gcc test2.c
> $ ./a.out
> Segmentation fault (core dumped)
> $ gdb -q ./a.out
> Reading symbols from ./a.out...
> (gdb) r
> Starting program: /home/vries/a.out
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000004004a0 in main ()
> (gdb) si
>
> Program terminated with signal SIGSEGV, Segmentation fault.
> The program no longer exists.
> (gdb)
> ...
>

Hah, you're right.  Is there an easy way to tell gdb to suppress the
first signal and try again?
