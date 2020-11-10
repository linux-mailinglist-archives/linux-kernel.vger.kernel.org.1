Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8492AE432
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgKJXkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKJXj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:39:58 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771E7216C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605051597;
        bh=vP9Wu8elj1EjHmdlev8FX3SwEeYPqgcrwW7YJdbph/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X1mKbI858L3Ju6cKsCrDVUrisca1p76TX0NeubgFVdJaVdL1bG8munaGwvbkb7P8m
         eUCyIB0xowCjZcBVAJEOncV3IwRXqglxX6u/GEo6CDjW+ak+S4H/Q0ESp2vBbb9vQ8
         zFR1prT3OcqCFIEhd5pvP02Q1cH/XwjHuaBW83ok=
Received: by mail-wm1-f42.google.com with SMTP id a3so107653wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:39:57 -0800 (PST)
X-Gm-Message-State: AOAM531speReVyKu6/e8FUWiQMqXOTQ3uYZMVhy9CDQgpUof7T2RyHQh
        zArha68IwgOhzKr1m1Oo1IufBTN8c4yoWB0pKZShvw==
X-Google-Smtp-Source: ABdhPJzMJpBqXvd1Aj5j+2KijkHX6sy0yoQ0Ob4MWCtBPKp//N72JCAjlig7pXZKfR8/lyjkczLnnS4hDe290OUkXn0=
X-Received: by 2002:a1c:9c56:: with SMTP id f83mr576089wme.49.1605051595859;
 Tue, 10 Nov 2020 15:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
 <20201109144425.270789-14-alexandre.chartre@oracle.com> <bb5b370b-5091-f3ca-9967-5a5d91287788@oracle.com>
In-Reply-To: <bb5b370b-5091-f3ca-9967-5a5d91287788@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 10 Nov 2020 15:39:43 -0800
X-Gmail-Original-Message-ID: <CALCETrUcyHtoZOjkoivDfMZHo0Z-gum_eHP8ca4gPLcTLWu5Xg@mail.gmail.com>
Message-ID: <CALCETrUcyHtoZOjkoivDfMZHo0Z-gum_eHP8ca4gPLcTLWu5Xg@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
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

On Mon, Nov 9, 2020 at 11:54 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
> [Copying the reply to Andy in the thread with the right email addresses]
>
> On 11/9/20 6:28 PM, Andy Lutomirski wrote:
> > On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
> > <alexandre.chartre@oracle.com> wrote:
> >>
> >> Extend PTI user mappings so that more kernel entry code can be executed
> >> with the user page-table. To do so, we need to map syscall and interrupt
> >> entry code,
> >
> > Probably fine.
> >
> >> per cpu offsets (__per_cpu_offset, which is used some in
> >> entry code),
> >
> > This likely already leaks due to vulnerable CPUs leaking address space
> > layout info.
>
> I forgot to update the comment, I am not mapping __per_cpu_offset anymore.
>
> However, if we do map __per_cpu_offset then we don't need to enforce the
> ordering in paranoid_entry to switch CR3 before GS.

I'm okay with mapping __per_cpu_offset.

>
> >
> >> the stack canary,
> >
> > That's going to be a very tough sell.
> >
>
> I can get rid of this, but this will require to disable stack-protector for
> any function that we can call while using the user page-table, like already
> done in patch 21 (x86/entry: Disable stack-protector for IST entry C handlers).
>

You could probably get away with using a different stack protector
canary before and after the CR3 switch as long as you are careful to
have the canary restored when you return from whatever function is
involved.
