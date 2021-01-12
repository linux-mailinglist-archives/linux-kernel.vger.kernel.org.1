Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E962F36C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbhALROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbhALROJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:14:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C9452311F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610471608;
        bh=twHLJ9CGnv0NIwQsAyiyk3+GTyCQ6W+V9TFfln36PjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vCkxH3OfI4Fl/Ss7xMwzgak+vnn4/yGqSRA6WKo0q004QMbEdEWZeS91BHhTtZzHR
         q/TVi/X8cjfDe6Rir2s1HyecUgYfWtPf7yQ6AHcwi165cn8SCTpzyimuktbUTofEvy
         Wl8nySJUuyinfWWq+/+aOXmmR4fpLaUBQqgWd+dU7r0pCCyvRVfc7ncJ3OO9Z5+QfS
         OHmkNhou8dJahzhBrnww1e1uK1igmlttHzo7QasDeLJbQu4mR9AFTW28L5GWrIb9NJ
         gyy7sp2FPn7P39np+FRwND5z3I0aGIzDQ5/1Cmv+5IpP6EOz18xcqClHrVDgfwoElu
         8pnviJAkVcsyA==
Received: by mail-ej1-f42.google.com with SMTP id d17so4559273ejy.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:13:28 -0800 (PST)
X-Gm-Message-State: AOAM532BDncMwviv3OTlYzZUwdzwUIFeA/vCKNgEGwfY7BVdNE3v7cwi
        41q/zeNDpgLldcbOFakUS/nztNbxMhkrB2mVa+EHwg==
X-Google-Smtp-Source: ABdhPJx0Wc81JQyR/ddJQAo3ssZlnOQ8XnOPMoC1lj7751wNZNjPW57SHsqSzTw+8FckedOiHbuqlfdDRDQfoByOqCU=
X-Received: by 2002:a17:906:ae55:: with SMTP id lf21mr3837689ejb.101.1610471606875;
 Tue, 12 Jan 2021 09:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20210111200027.GH25645@zn.tnic> <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com> <DM5PR11MB1690CB5004CADCE5E9D5A221DEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
 <CALCETrUzsx2gpJGwz4fwLTLTKG4i=izaGRYL-3dLrn389JV17w@mail.gmail.com> <DM5PR11MB16906085295875E670FC163CDEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB16906085295875E670FC163CDEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jan 2021 09:13:15 -0800
X-Gmail-Original-Message-ID: <CALCETrU5aHtJdJ29xSNCrXdycYMW=gsT7WzBT3-+GJqCEMM-dA@mail.gmail.com>
Message-ID: <CALCETrU5aHtJdJ29xSNCrXdycYMW=gsT7WzBT3-+GJqCEMM-dA@mail.gmail.com>
Subject: Re: gdbserver + fsgsbase kaputt
To:     "Metzger, Markus T" <markus.t.metzger@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "tdevries@suse.com" <tdevries@suse.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:02 AM Metzger, Markus T
<markus.t.metzger@intel.com> wrote:
>
> > [   26.990644] getreg: gs_base = 0xf7f8e000
> > [   26.991694] getreg: GS=0x63, GSBASE=0xf7f8e000
> > [   26.993117] PTRACE_SETREGS
> > [   26.993813] putreg: change gsbase from 0xf7f8e000 to 0x0
> > [   26.995134] putreg: write GS=0x63; old GSBASE=0x0
> > [   26.996235] PTRACE_SETREGS done
> >
> > That's gdbserver reading GS and GSBASE and then telling the kernel to
> > set GS to the same value and GSBASE to 0.
> >
> > I can come up with horrible kernel hacks to try to work around this,
> > but gdbserver is really giving the kernel bad instructions here.
>
> I agree that this looks like a GDB bug rather than a kernel bug.  GDB
> should preserve the GS_BASE value if it doesn't intend to change it.

Indeed.  But we have this pesky no-userspace-regressions policy in the kernel.

So the question I have is: is this enough of a regression that we need
to hack around it in the kernel?  The specific broken use case seems
quite niche: 64-bit gdbserver targeting 32-bit userspace.  It's taken
two-and-a-half kernel releases for anyone to notice, because sensible
people use plain gdb for local debugging and gdbserver for debugging
VMs, embedded targets, and such.

If we do decide we need to fix this in the kernel, I think we need to
simultaneously add ptrace GPR accessors that work better than the
current mess.  We should have explicit 32-bit GPR access and 64-bit
GPR access, and they should do precisely what is requested without
regard for caller's ABI or the target's CS.L.  And we should add some
API that can be used to look up a segment descriptor so that ptrace()
users can emulate segment writes.  At the same time, we can make
SETREGS so the descriptor lookup when writing GS and totally ignore
the GSBASE value if CS.L == 0, and we backport the entire mess back to
5.9 and ask all debugger maintainers to update their code to use the
new APIs that are kludge-free in future releases.  Everyone wins
except for anyone who wants to understand exactly what the legacy API
does and the suckers who have to write test cases for all of this.
