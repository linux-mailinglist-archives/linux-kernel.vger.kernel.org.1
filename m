Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4CB2B54BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgKPXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPXER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:04:17 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE78C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:04:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so20810421wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PP6FX2f2oqxrVvYPJAU1kY9ytsKB35iPzARqt8mNWbA=;
        b=VsgnJCtcHNaLAZW4qhQS4kYs27Dbh2epwN+6KIl2yFDSVuNKflTUZ0xcfEF+EIQ+OJ
         6Tg8vDV4HORMLm8tHo/J8Yf9qhMrPpIKaW2p3r4bOW9T+xwiOG00DHwEtJJTdHsoy5pw
         CpMye71FoNHxRq+YXFX8GQw6X/kzKrDEu5RLasOJthqXOt7OnthYroZUIx4kKx2q/tI9
         l8S5KWkQgxnz8mX8pRPMwYRJc8f+2EQ8tyanAabCN9H+t7/Ie+qMarpaUG+zQErlzF2m
         QzKOwvT2yaRfFsBj8DljUStD0IsriJUeKYRL7pxea/5kblscys0Ssm45D1JGjgpTd+Pv
         wiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PP6FX2f2oqxrVvYPJAU1kY9ytsKB35iPzARqt8mNWbA=;
        b=MU49FGk1PWOnSmFBd7dAWoOlF86OKAfJObLBFhERzfCAUMMRzg5tU8ke3SNXsnmemq
         6OPL1cxpp94doWAUa9deXv1rQnEfHoiAXm013KN9kTrNjZeiicbTWL160cvXsZ/Djf0k
         50sTcyPitwtnjeUqvikTdZxCBnNENdkfq/yLAGtY5YG5KdRgMX1De0xfxV3h6lc81+n/
         nxiGpJpprgIlz8FQRqkRJc4R3yXJLtd5mVYmRKekbAMYENv9W+hzpGX3YNeGJ7cEWDsG
         zB4+sFFjVeyeHGjN8ueB9KewdeSxGU+VQXnd/jfhp/m2WiVBglWnsW9nahOcLe7+/mDI
         ZNDw==
X-Gm-Message-State: AOAM530NYmzW66L90A+2tB6iJrx96N2/c5dvQH2H48glXanf5U8BaUcS
        hSi+3+rp1ZMA2E0nIX2DZMg4SFj2TxzkoIKq6PXIow==
X-Google-Smtp-Source: ABdhPJwENCdjM+k4PETduXFWBM58hHcx0EZxIC5UOTjI81q2YI4Ck1x1x3QOkK4dH5S6ijiN7TkFifiwgkUytrCAeVc=
X-Received: by 2002:a5d:5482:: with SMTP id h2mr10951710wrv.18.1605567855975;
 Mon, 16 Nov 2020 15:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com> <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com> <20201103175237.GD4111@zn.tnic>
 <20201103181114.GC23992@redhat.com> <20201103182018.GE4111@zn.tnic> <87blfxx8ps.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blfxx8ps.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 16 Nov 2020 15:04:02 -0800
Message-ID: <CALCETrW+Jek_t51RyqxO=HUA_PJ4APwS9hJQWsXyc426cgf0wA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        kyin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 2:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>  arch/x86/kernel/dumpstack.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *reg
>         if (!user_mode(regs))
>                 return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
>
> +       /* The user space code from other tasks cannot be accessed. */
> +       if (regs != task_pt_regs(current))
> +               return -EPERM;

Depending on exactly where this gets called, this may not be
sufficient.  You should also check nmi_uaccess_okay().

--Andy
