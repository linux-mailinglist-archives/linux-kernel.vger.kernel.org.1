Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB832B9CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKSVUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:20:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgKSVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:20:41 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605820839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKbqn9VXgNpOqO/gQTqxdK8gHKgwjQY8spBTlAGs3Cs=;
        b=feovV58IxK3uNezc6Y23E/UCPLw8nJAlrH1EYvludowU5GBgDX+NLJiUu7RN4bPFz3Fj2M
        Id6IJ50GvGKk88fgHtEC+sTiMVm1fjOeoqe+39x6MteCa0AK1w7AJskDjlL4XZgenXHhKj
        1uw/Fnjva45pp1rgRa9/FUIrHt/EiSr+jK2kKu69Zz/8pW4Kox0xToZ13t9o0FCAfcUqMf
        fqnIaRfoVlyHp5R98KXYmTw1Wp8KcRt7+vrIfMfVn/3yYcEjrejmH3D5uF9i9tx1LDHGnX
        3VTmHZUkGaRjbw8p4PngYU5IluwKQYFc51EXN4TZhjNDG08KLGM2xuKwvgFtDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605820839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKbqn9VXgNpOqO/gQTqxdK8gHKgwjQY8spBTlAGs3Cs=;
        b=g+p6OGY5Zofr5cyA/kujV78vO8bjYw7zMK8UpT3wG/0ZrRAmFZ7rYQw/0cBRpH1ja0n1kT
        hbcvX++9WTU2XjAw==
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of trampoline stack
In-Reply-To: <a9aa4887-02ee-0e9a-a37e-63e9cb0ff27f@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116144757.1920077-13-alexandre.chartre@oracle.com> <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com> <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com> <87ft55p3gp.fsf@nanos.tec.linutronix.de> <a9aa4887-02ee-0e9a-a37e-63e9cb0ff27f@oracle.com>
Date:   Thu, 19 Nov 2020 22:20:38 +0100
Message-ID: <87zh3dnivt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 20:55, Alexandre Chartre wrote:
> On 11/19/20 8:10 PM, Thomas Gleixner wrote:
> Sorry I mixed up a few thing; I got confused with my own code which is not a
> good sign...
>
> It's not sleeping with the user page-table which, as you mentioned, doesn't
> make sense, it's sleeping with the kernel page-table but with the PTI stack.
>
> Basically, it is:
>    - entering C code with (user page-table, PTI stack);
>    - then it switches to the kernel page-table so we have (kernel page-table, PTI stack);
>    - and then it switches to the kernel stack so we have (kernel page-table, kernel stack).
>
> As this is all C code, some of which is executed with the PTI stack, we need the PTI stack
> to be per-task so that the stack is preserved, in case that C code does a sleep/schedule
> (no matter if this happens when using the PTI stack or the kernel stack).

That makes some more sense, but I'm not convinced that this dual stack
is really a good thing.

Thanks,

        tglx

