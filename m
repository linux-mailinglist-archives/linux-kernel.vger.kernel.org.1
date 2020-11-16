Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7062B4FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 19:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbgKPSe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 13:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387910AbgKPSe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:34:57 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3422231B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605551696;
        bh=Ae16e9zwZ+DMUvyqQKTLhkJCEL5vVvGc+zxNjI9QG6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tTeOeRj+1wV4lXQRIfuGFYomlCLP2E8WEJ08+mAtKOrsNTqJHqUVk6+j0Oja2iqKE
         vHAhvs4ALdqOyrxLDnR/jgb2QfZ7qDEixWK8SkhcWRmDKY9ow1TNwSheR2/3vz+PnS
         oBjkufh2HJ/bLpkH1YSTI2ilV9Kp3Vq0AZswKgCU=
Received: by mail-wm1-f50.google.com with SMTP id a65so247852wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 10:34:55 -0800 (PST)
X-Gm-Message-State: AOAM533h5MEoWpY2Gx1OC96lc6v6K5rlFvQCSZjcaFJ/X6TbxMpRE8SN
        Pdn901XQbAfeawW3/6TbdpiXcMo8kZgTdyp0jYhrLw==
X-Google-Smtp-Source: ABdhPJxX//M2liTzjJfdTzELKtgMmkXdLHdI5I1TbmhjDzQruW8WkdMIlAeyO3E87iNk5qE/6S60KfHjEgY/h4OGI5I=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr236051wmc.176.1605551694330;
 Mon, 16 Nov 2020 10:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com> <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
In-Reply-To: <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 10:34:40 -0800
X-Gmail-Original-Message-ID: <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
Message-ID: <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:10 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
> > On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
> > <alexandre.chartre@oracle.com> wrote:
> >>
> >> When entering the kernel from userland, use the per-task PTI stack
> >> instead of the per-cpu trampoline stack. Like the trampoline stack,
> >> the PTI stack is mapped both in the kernel and in the user page-table.
> >> Using a per-task stack which is mapped into the kernel and the user
> >> page-table instead of a per-cpu stack will allow executing more code
> >> before switching to the kernel stack and to the kernel page-table.
> >
> > Why?
>
> When executing more code in the kernel, we are likely to reach a point
> where we need to sleep while we are using the user page-table, so we need
> to be using a per-thread stack.
>
> > I can't immediately evaluate how nasty the page table setup is because
> > it's not in this patch.
>
> The page-table is the regular page-table as introduced by PTI. It is just
> augmented with a few additional mapping which are in patch 11 (x86/pti:
> Extend PTI user mappings).
>
> >  But AFAICS the only thing that this enables is sleeping with user pagetables.
>
> That's precisely the point, it allows to sleep with the user page-table.
>
> > Do we really need to do that?
>
> Actually, probably not with this particular patchset, because I do the page-table
> switch at the very beginning and end of the C handler. I had some code where I
> moved the page-table switch deeper in the kernel handler where you definitively
> can sleep (for example, if you switch back to the user page-table before
> exit_to_user_mode_prepare()).
>
> So a first step should probably be to not introduce the per-task PTI trampoline stack,
> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
> be introduced later when the page-table switch is moved deeper in the C handler and
> we can effectively sleep while using the user page-table.

Seems reasonable.

Where is the code that allocates and frees these stacks hiding?  I
think I should at least read it.
