Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C22B4A68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgKPQNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgKPQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:13:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A767C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:13:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so19293057wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fy9yJa8xaunaxNAmcC4fKqFwO3hgJ8i3UHbtvhB9OQ=;
        b=CCagE05Tte+vu4qHj9zLiAy1I7Elq1T7BM2FMQZRQchCZ21yGqXT2YIxuHB1rT6tQU
         0LcVZeEa/d5r7lBKYg885sd+EMDaHuuiUSjtiw6wyCzePiG9vcbpKpGxuuGAFKCHnKY9
         k4RMOEOann/4ubOcrv+/XYY0n4HBJcNr9nwT5hbOO0wssAjW86GoL5Inuob6H6fJzP5j
         Gxakvx1WwtCmj9A86RVfRKyhaKGY/apU5JxBjYFo4+a8UkfQoMuIDwX7LSC6kOpF3DGi
         ifwNLHwVW1ES9BGSAPmYeZsMVbpTpPOjXLR950OPJeXzIcejbCyDOvJvRc0OjFXCmDpU
         MqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fy9yJa8xaunaxNAmcC4fKqFwO3hgJ8i3UHbtvhB9OQ=;
        b=IIA2q4hJWkmQZeVFLN7El2cT+pWo2ckCqos/Hfzadq0MTZzQmK/YXCqWWo7Yam7Pdz
         AOsu+Q6Ra6UnQxWCZ3WzKGe07M/ijb1Vzy5c/lfqbsAXay2WE42PpxPXp83H4wT8Zb0r
         sNd5IRVce7Z+1v3v7Jl4ptJ649PE6o4pnVruXBK/lK3MtC2zv73MNEEqKj/uQ44Mr8vK
         PseJTH44TlJMdjMaZShVWDp2SRXyWjaZ8RvepFQE91TMuNrkfJ/ZClq96dNDB/9Jt8Lz
         73DTM/9tc4YSJmUrkmpbLcl5PD5/f2tIuXmy3xwfv3kCvB5G9xzDgYh/sfA8VL2w/OTv
         y67A==
X-Gm-Message-State: AOAM532rp92i9e5LlX9MmuE/Z/SrnvVqehFXoI37iIOgaWoo0AS+/hfo
        8Z84OCommItdSvrqiwCpI7lRco3RvRd6xNARv00aW3f9JwGRoQ==
X-Google-Smtp-Source: ABdhPJxC7jxqf4ZHD7BBqVXQL2hN8P5Oggx7Bc5cCg7hTHoa0ssVjlPSEQtioabPGctgV4nNkJs/uFpogKzZWU9akvo=
X-Received: by 2002:adf:f808:: with SMTP id s8mr20430438wrp.257.1605543179184;
 Mon, 16 Nov 2020 08:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20201116152301.24558-1-jgross@suse.com> <20201116152301.24558-3-jgross@suse.com>
In-Reply-To: <20201116152301.24558-3-jgross@suse.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 16 Nov 2020 08:12:46 -0800
Message-ID: <CALCETrWVSEB5zrUiZ81KaB5egx78TfDuSDv+qR3HFtJ=SKxwkQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86/xen: use specific Xen pv interrupt entry for DF
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> Xen PV guests don't use IST. For double fault interrupts switch to
> the same model as NMI.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/idtentry.h | 3 +++
>  arch/x86/xen/enlighten_pv.c     | 8 +++++++-
>  arch/x86/xen/xen-asm.S          | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 3505c0396fa5..b35825392547 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -611,6 +611,9 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_DB,   xenpv_exc_debug);
>
>  /* #DF */
>  DECLARE_IDTENTRY_DF(X86_TRAP_DF,       exc_double_fault);
> +#ifdef CONFIG_XEN_PV
> +DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,    xenpv_exc_double_fault);
> +#endif
>
>  /* #VC */
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 9f5e44c1f70a..803fbcb398c4 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -571,6 +571,12 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_nmi)
>         exc_nmi(regs);
>  }
>
> +DEFINE_IDTENTRY_RAW_ERRORCODE(xenpv_exc_double_fault)
> +{
> +       /* On Xen PV, DF doesn't use IST.  The C part is the sane as native. */

I would like to think that code is sane, but you probably meant "same".

> +       exc_double_fault(regs, error_code);
> +}
