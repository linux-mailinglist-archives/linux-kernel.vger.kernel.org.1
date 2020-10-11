Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA928AA07
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgJKUAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:00:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgJKUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:00:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602446436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpI+/VDI/eLtFN7Wtd3XRlKtugOdm7U5hjPzfzci+ZU=;
        b=bFyvD3HapyI/PYaFffg7m1LUySB7jFx8hxq/q+nz6LeIWotWY5CuD7K+BhrwmLVRg2J1cn
        Q8JRGDZGIt9NdNnIy6NjuovsqO0RTrvhTTwYPPaFgkvnGbVYlY1qrChOj5TmolYW6iRr63
        /1HCej5DTjGDpo1ti4iuloYqZDkgc2aReuCGwNiv8/AlW+OLa4JPx6IhhN+VEM7+/wKZsD
        o/fUhLTLxmOBF4ngQb99Nk9p1S9aYRcwAnWrTcPB7tsIbdTDEA3TcXhql0IVpM7gqOul3D
        TeId3FEHeMkZA8KSRn8Yt3GC2WNjxjEHNZlqjZQHosuFC14hQ5KcpJS2NbObGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602446436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpI+/VDI/eLtFN7Wtd3XRlKtugOdm7U5hjPzfzci+ZU=;
        b=yFK29wb9vfiPJ5uUm+9GPidZQQazef8nMpEKmmbO1KeuBfSZUDbGXPG/5pnOoDWwes+xXx
        3ZwdfiUsQMY+R0CQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86 fixes
In-Reply-To: <CAHk-=wi_Uc6uFAXRa+3PAi0eRpu0Uw5v40VjKTj3B21VbOd1rg@mail.gmail.com>
References: <20201011080859.GA3598074@gmail.com> <CAHk-=wi_Uc6uFAXRa+3PAi0eRpu0Uw5v40VjKTj3B21VbOd1rg@mail.gmail.com>
Date:   Sun, 11 Oct 2020 22:00:35 +0200
Message-ID: <87k0vwr0rg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Sun, Oct 11 2020 at 11:00, Linus Torvalds wrote:
> On Sun, Oct 11, 2020 at 1:09 AM Ingo Molnar <mingo@kernel.org> wrote:
>>
>>  - Fix a (hopefully final) IRQ state tracking bug vs. MCE handling
>
> Why is the nmi_enter/nmi_exit thing not a problem on non-x86 architectures?
>
> Put another way: x86 does extra work to track IRQ state across NMI.
> What makes x86 special? It _feels_ to me like everybody should do
> that? No?
>
> Please tell me what I've missed..

Not a lot. The nmi related tracking plus the entry/exit inconsistencies
which we identified and fixed over the past couple of releases in x86
apply pretty much to all of arch/* in one way or the other and of course
in different flavours.

This is worked on by architecture people and will hopefully be solved at
some point by moving all architectures to the generic entry code.

Thanks,

        tglx
