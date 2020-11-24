Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25512C3459
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbgKXXJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:09:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgKXXJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:09:06 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8B12158C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606259345;
        bh=ahy2k/Gc609ovaeFWrlHHl8K9n5k9vUfX+NgSmPek4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lf+Kk0OJTqhB/8d2YP7KZu2CybzbV8At1UMbfYN43hc65zEFTMZZuMhTfd6ZYhZz3
         +v3iFvG1r1b6LondqS7yuhDi8FJspxCp8C2A8RxjPeng2/FDfNE9nejAkBWn5s6l8E
         4ez3Lo/5/V9hw6A/yygMOoQWXDm3PDfGXilqBx98=
Received: by mail-wr1-f49.google.com with SMTP id r17so101155wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 15:09:04 -0800 (PST)
X-Gm-Message-State: AOAM532h5dlXMI7HqE5cwomqeBOWe5dh0Qlia6uZokv9e0pKMNpMd5Xq
        Zq1DFUBH3o7tfeBTVmoGjSdVUTAViMpsqWomCJi7yg==
X-Google-Smtp-Source: ABdhPJwDvv+6joZFPg45hAtndpkPQdXY3QBXRKhhnFzmrPdk/pct6xdGmjMNR7iJvJAU3h3KwmuRYk1Dk9uP3tdqfaU=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr818826wrs.75.1606259343449;
 Tue, 24 Nov 2020 15:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20201124002932.1220517-1-dima@arista.com> <20201124002932.1220517-13-dima@arista.com>
In-Reply-To: <20201124002932.1220517-13-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Nov 2020 15:08:49 -0800
X-Gmail-Original-Message-ID: <CALCETrWMFDqJrOrq3Z1LpryvysMsE=9b_Zm_aDMuqe4uRL8Wyw@mail.gmail.com>
Message-ID: <CALCETrWMFDqJrOrq3Z1LpryvysMsE=9b_Zm_aDMuqe4uRL8Wyw@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] x86/signal: Land on &frame->retcode when vdso
 isn't mapped
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 4:30 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Since commit 9fbbd4dd17d0 ("x86: Don't require the vDSO for handling
> a.out signals") after processing 32-bit signal if there is no vdso
> mapped frame->retcode is used as a landing.
> Do the same for rt ia32 signals.
> It also makes the ia32 compat signals match the native ia32 case.
>
> This shouldn't be mistaken for encouragement for running binaries with
> executable stack, rather something to do in hopefully very rare
> situation with disabled or unmapped vdso and absent SA_RESTORER.
> For non-executable stack it'll segfault on attempt to land, rather than
> land on a random address where vdso was previously mapped.
> For programs with executable stack it'll just do the same for rt signals
> as for non-rt.
>
> Discouraging users to run with executable stack is done separately in
> commit 47a2ebb7f505 ("execve: warn if process starts with executable
> stack").
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

The new code is more readable than the old code, too.

Acked-by: Andy Lutomirski <luto@kernel.org>
