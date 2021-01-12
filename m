Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625D72F3639
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405687AbhALQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbhALQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:54:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 501F52311F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610470447;
        bh=cIWoPzrWZKqwpLcgp2Lr54R7c9LfFLyCAMdonQt2vgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tgEWjeXs6AyAnI4Ro6p62pMt7NbBaRs+TJaIbP2M3hvhgd7JapbJDW1TGnrDksu9+
         YDTXs8x8VheC3DxH3NeMGmED5KeO/EiKE8FT0wiHDNGgS0AmbjWsj7JqLv97KJ9LPY
         dqN5IBDcJ1fO5WLf2bTBR2hnaFQiKqLgzIThV8v1mFd+JlljYH8luUMgk4ra4KTn7g
         0t2usReo20GOenehbL2XdPWBe4NOwRRrERy2FR8h8n3YeCbUX2w1VY3uV8Lvvfv24w
         xaKefDxfACkOf8xXm4YIVpnDSJ3PKDEvGeDvxpx5BGVUO2v5EgWZcAFuRd55ujCFCT
         Szt27SOiLnnQA==
Received: by mail-ed1-f50.google.com with SMTP id v26so3044707eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:54:07 -0800 (PST)
X-Gm-Message-State: AOAM5308myxh69MWTbblYiLIaZU6azjsldOpeofkQsjHsatjTmD0OIk2
        y3xIHIht0XEOZpCZcjQp/9ykApuecop2V1XF+0F5VQ==
X-Google-Smtp-Source: ABdhPJxq37O3y4EfXgFM1mhi298ZQhVcoSs/RBIgHLO8RRbq93NlZ+KfnWfibO/uMVsn7hxjGYXuHozK/yTY6RRGNPw=
X-Received: by 2002:aa7:ca55:: with SMTP id j21mr67361edt.172.1610470445858;
 Tue, 12 Jan 2021 08:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20210111200027.GH25645@zn.tnic> <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com> <DM5PR11MB1690CB5004CADCE5E9D5A221DEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB1690CB5004CADCE5E9D5A221DEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jan 2021 08:53:53 -0800
X-Gmail-Original-Message-ID: <CALCETrUzsx2gpJGwz4fwLTLTKG4i=izaGRYL-3dLrn389JV17w@mail.gmail.com>
Message-ID: <CALCETrUzsx2gpJGwz4fwLTLTKG4i=izaGRYL-3dLrn389JV17w@mail.gmail.com>
Subject: Re: gdbserver + fsgsbase kaputt
To:     "Metzger, Markus T" <markus.t.metzger@intel.com>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "tdevries@suse.com" <tdevries@suse.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 3:39 AM Metzger, Markus T
<markus.t.metzger@intel.com> wrote:
>
> > The GDB behavior looks to be different between the two cases -- with vs
> > without gdb server, when I checked the GS/GSBASE values on the ptrace front.
>
> 64-bit GDB doesn't support FSGSBASE for 32-bit inferiors and it looks like gdbserver
> might not support FSGSBASE, at all.
>
> I had added support for the former as part of the tests I wrote about a year ago [1]
> but never submitted the patch.  Was the discussion ever concluded?
>
> The general behavior should be that GDB reads a regset, overwrites the registers it
> knows about, and writes it back again to preserve the original values of registers it
> doesn't know about.
>
> When I log the values that are read and written for FSGSBASE, however, it looks like
> ptrace is returning a non-zero GS_BASE on a read and gdbserver is writing zero on
> the next write.

I instrumented the kernel, and I see:

[   26.990644] getreg: gs_base = 0xf7f8e000
[   26.991694] getreg: GS=0x63, GSBASE=0xf7f8e000
[   26.993117] PTRACE_SETREGS
[   26.993813] putreg: change gsbase from 0xf7f8e000 to 0x0
[   26.995134] putreg: write GS=0x63; old GSBASE=0x0
[   26.996235] PTRACE_SETREGS done

That's gdbserver reading GS and GSBASE and then telling the kernel to
set GS to the same value and GSBASE to 0.

I can come up with horrible kernel hacks to try to work around this,
but gdbserver is really giving the kernel bad instructions here.

--Andy
