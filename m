Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231072CA985
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391249AbgLARYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391070AbgLARYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:24:19 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF03F20757
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606843419;
        bh=cMWpNNo6B+ZlVFzu224cjifSj9yFS3k9AicU80f4SEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IV0IyKCwzeBRr1qMgS2FpRiP8GRUZsCHicnOsP6Cw2q1TwwIgurtFqWTEmBxwPhhx
         4+SIk4cPu7d2SGBZ7YP0MdDGk4u3i5+t5I+od6eWAeHEf3DH4URwoHRBb2Z56Z9hf6
         Uyf055CCunkhNlwg6vSVLNKzGcS8jqHhUmv4QTAM=
Received: by mail-wm1-f52.google.com with SMTP id v14so4859569wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:23:38 -0800 (PST)
X-Gm-Message-State: AOAM533xByHgS1iAWzQWoQ57xYYpAFGj5/bU2RitxWzLHrf22Hu/KOT6
        c9Ct2JtS/1MM3OgbTDJxOFfd5pS5LcdMXXeM5pNrBw==
X-Google-Smtp-Source: ABdhPJxwIoxnPYmHPBshKhNMIQNApM9L39NbYy3h1Mq+2lSZYau6V+a7ILPJZGh2DAs7Jz8iM7L0uGwILrgNYlfn6ZQ=
X-Received: by 2002:a7b:cb41:: with SMTP id v1mr3876786wmj.36.1606843417218;
 Tue, 01 Dec 2020 09:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20201130223059.101286-1-brgerst@gmail.com>
In-Reply-To: <20201130223059.101286-1-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 09:23:24 -0800
X-Gmail-Original-Message-ID: <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
Message-ID: <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Pawe=C5=82_Jasiak?= <pawel@jasiak.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 2:31 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments t=
o
> use the compat handlers to allow conversion to passing args via pt_regs.
> sys_fanotify_mark() was however missed, as it has a general compat handle=
r.
> Add a config option that will use the syscall wrapper that takes the spli=
t
> args for native 32-bit.
>
> Reported-by: Pawe=C5=82 Jasiak <pawel@jasiak.xyz>
> Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscal=
ls taking 64-bit arguments")
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/Kconfig                       |  6 ++++++
>  arch/x86/Kconfig                   |  1 +
>  fs/notify/fanotify/fanotify_user.c | 17 +++++++----------
>  include/linux/syscalls.h           | 24 ++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 090ef3566c56..452cc127c285 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1045,6 +1045,12 @@ config HAVE_STATIC_CALL_INLINE
>         bool
>         depends on HAVE_STATIC_CALL
>
> +config ARCH_SPLIT_ARG64
> +       bool
> +       help
> +          If a 32-bit architecture requires 64-bit arguments to be split=
 into
> +          pairs of 32-bit arguemtns, select this option.

You misspelled arguments.  You might also want to clarify that, for
64-bit arches, this means that compat syscalls split their arguments.

Aside from that:

Acked-by: Andy Lutomirski <luto@kernel.org>
