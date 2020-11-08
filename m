Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8922AAD1F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgKHTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHTGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:06:50 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CBB20731
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604862409;
        bh=acB2l40KEY+ZGKUpvctsATAzoPa4/aQZDTtw8tSecV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p2hqSyHKFTBz7Jf4IJAQDJJYCA9+m1mtZi/fTfRBGraF4qIHFheCRV5JI/jdA/UR/
         Dm75O5hlEa7nL24vSwKXSzVc6cKehgcN30lgfAnPo65nyL2u+QuVxS3FhFrvRlYiRQ
         z6mhYZkvSObOpy5WFDXiTlupK3qT2EyZDcAn5zYI=
Received: by mail-wr1-f47.google.com with SMTP id b8so6521473wrn.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 11:06:48 -0800 (PST)
X-Gm-Message-State: AOAM531SrsjE7/QBpUEG8j8vaoQwhyvEEEOT3GWR8HAxhvOXNAYGkU71
        hiJTwZzcTVGj5IFhhzMY2VBwkZ0XcQtUHIhpQPfLxg==
X-Google-Smtp-Source: ABdhPJxskNJvIjRj0HmYTMBjJptdkE6oNwoLC6QNP3acBN3Y2GpG5cxNXUSogIqo3xqTCS/ZWa69ThFK/v40AR+HQxU=
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr13924677wrn.257.1604862407471;
 Sun, 08 Nov 2020 11:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20201108051730.2042693-1-dima@arista.com> <20201108051730.2042693-13-dima@arista.com>
In-Reply-To: <20201108051730.2042693-13-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 8 Nov 2020 11:06:36 -0800
X-Gmail-Original-Message-ID: <CALCETrW7zQMRZOJFVN5AsqMAy=F6jnVyj+QL_w3-xEghqT3XJw@mail.gmail.com>
Message-ID: <CALCETrW7zQMRZOJFVN5AsqMAy=F6jnVyj+QL_w3-xEghqT3XJw@mail.gmail.com>
Subject: Re: [PATCH 12/19] x86/signal: Land on &frame->retcode when vdso isn't mapped
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

On Sat, Nov 7, 2020 at 9:17 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Since commit 9fbbd4dd17d0 ("x86: Don't require the vDSO for handling
> a.out signals") after processing 32-bit signal if there is no vdso
> mapped frame->retcode is used as a landing.
> Do the same for rt ia32 signals.

Am I reading correctly that this makes the ia32 compat signals match
the native ia32 case?

--Andy
