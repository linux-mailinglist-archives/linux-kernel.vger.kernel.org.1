Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562FB2981FB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 14:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416443AbgJYNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414920AbgJYNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:52:11 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE6C0613CE;
        Sun, 25 Oct 2020 06:52:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p10so5782817ile.3;
        Sun, 25 Oct 2020 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/t3/fDWbrPxN2Fbi74TsOZV6Um8+Rh4eDT5vDwSkaRQ=;
        b=GN8SENdQGhJrW/rxuQ0P77Dl/EUOl6C8NANF4waJC5cITKnK89oUxgu2pBoWDlWqwm
         WbE5TybthyXSvgUGTDdJvJkK1s3cGnUlJj6lP0c3QPHS2I0oivs2PEXmPGR//YuPJc2U
         FGJgX9Ir315NfkXXbZfhMfyf4rhjfeOwaBBm7jzMyEe2hYgI6dTp0pzW+ucDYPB7MZWt
         s/aVNXRxU/NX5wiRfapJMJP1SHRFL7Yqhnz4tx0NgizliR0JSjOaZit1nR455pYFVH1P
         MMt9EIgtC/DOr5gpTOYfd8+YfWc+LJoKT/q79LQk5n2lO17tramElU73ykpcCRvPm1Ke
         emdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/t3/fDWbrPxN2Fbi74TsOZV6Um8+Rh4eDT5vDwSkaRQ=;
        b=nIyxefD4c0Uf9meOaQQCBY7WcKd/AeEo8V9w2h1GvNJpw2McRedB1Xk5ZKfKNDQNbC
         7CR07OpnIESw2rVZexEyGy/Id4H8oMZ0oSjrTmQhkars+3omaDvXxO7DQqtARGIQVAvU
         //82Tk9n2GDK8g1e965fBnjapPXvisgsu1EpMh84AEBqJfWtq4P7U56tZBZXNd8DvoMt
         mndyliWs8ElLqGlt8yOme3lhCWK+jvEo3mJjYCHq6YCpat5AyofU6bSCABCxCAdxnB+t
         qAoX4RZVbULzWZP6JDOUCOWyHsZbK/+u2NbZ+4wdWegTuINfpLFRhRG0ZFZ2DUkByOdr
         Y4fw==
X-Gm-Message-State: AOAM530lo2zNR693ohEMiKXA4vLzD4CT5LlXu1Tf2EPtr3DxOBCs4CPQ
        siDcS5uiVhSnNEiDxJU1UgJl5e1czx9kYigbqaU=
X-Google-Smtp-Source: ABdhPJwkcxh5oBkZ7eykeseQWPspvr5+nqoFJoUVm9U44/qOuwEmO+lnpnA4f8o/NNfLH73pcbvINl+neiaFP0aoVTY=
X-Received: by 2002:a92:9a8c:: with SMTP id c12mr7787569ill.186.1603633930162;
 Sun, 25 Oct 2020 06:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAOSf1CG=Pvr8Yw_+6J3c4VOD0QJwv58iRtSAqBFpeZM6S=7Viw@mail.gmail.com> <CAFgQCTveoz0fOELrwUY5ZSG_iNKkjGJ32QW1POo-OfjvXM=YLQ@mail.gmail.com>
In-Reply-To: <CAFgQCTveoz0fOELrwUY5ZSG_iNKkjGJ32QW1POo-OfjvXM=YLQ@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 26 Oct 2020 00:51:58 +1100
Message-ID: <CAOSf1CGHPUZUBQV0Zm3onMxCZ-zBpOxE9tmMeBODeKUyuO3Rpg@mail.gmail.com>
Subject: Re: [Skiboot] [PATCH 0/3] warn and suppress irqflood
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <mkshah@codeaurora.org>,
        Petr Mladek <pmladek@suse.com>,
        Oliver Neukum <oneukum@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:11 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Sun, Oct 25, 2020 at 8:21 PM Oliver O'Halloran <oohall@gmail.com> wrote:
> >
> > On Sun, Oct 25, 2020 at 10:22 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > > > > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > > > > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > > > > may be nothing or just soft lockup warning showed in console. It is better
> > > > > to warn users with irq flood info.
> > > > >
> > > > > In the kdump case, the kernel can move on by suppressing the irq flood.
> > > >
> > > > You're curing the symptom not the cause and the cure is just magic and
> > > > can't work reliably.
> > > Yeah, it is magic. But at least, it is better to printk something and
> > > alarm users about what happens. With current code, it may show nothing
> > > when system hangs.
> > > >
> > > > Where is that irq flood originated from and why is none of the
> > > > mechanisms we have in place to shut it up working?
> > > The bug originates from a driver tpm_i2c_nuvoton, which calls i2c-bus
> > > driver (i2c-opal.c). After i2c_opal_send_request(), the bug is
> > > triggered.
> > >
> > > But things are complicated by introducing a firmware layer: Skiboot.
> > > This software layer hides the detail of manipulating the hardware from
> > > Linux.
> > >
> > > I guess the software logic can not enter a sane state when kernel crashes.
> > >
> > > Cc Skiboot and ppc64 community to see whether anyone has idea about it.
> >
> > What system are you using?
>
> Here is the info, if not enough, I will get more.
>  Product Name          : OpenPOWER Firmware
>  Product Version       : open-power-SUPERMICRO-P9DSU-V1.16-20180531-imp
>  Product Extra         : op-build-e4b3eb5
>  Product Extra         : skiboot-v6.0-p1da203b
>  Product Extra         : hostboot-f911e5c-pda8239f
>  Product Extra         : occ-77bb5e6-p623d1cd
>  Product Extra         : linux-4.16.7-openpower2-pbc45895
>  Product Extra         : petitboot-v1.7.1-pf773c0d
>  Product Extra         : machine-xml-218a77a

Unfortunately I don't have a schematic for that one.

> > There's an external interrupt pin which is supposed to be wired to the
> > TPM. I think we bounce that interrupt to FW by default since the
> > external interrupt is sometimes used for other system-specific
> > purposes. Odds are FW doesn't know what to do with it so you
> > effectively have an always-on LSI. I fixed a similar bug a while ago
> > by having skiboot mask any interrupts it doesn't have a handler for,
>
> This sounds like the root cause. But here Skiboot should have handler,
> otherwise the first kernel can not run smoothly.

I don't know why the TPM interrupt is asserted. If the TPM driver is
polling for a response it might clear the underlying condition as a
side effect of it's normal operation.

> Do you have any idea about an unexpected re-initialization introducing
> an unsane stage?

No idea, but those TPMs have a history of bricking themselves if you
do anything slightly odd to them. It wouldn't surprise me if the
re-probe can cause issues.

> Thanks,
> Pingfan
