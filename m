Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256EA2A83B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKEQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:42:18 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:42:17 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gn41so3545603ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6NI8PLn6qYNBnYjgB4FzOkwm+CyN8AnQY7eSxHSLiUs=;
        b=v5LK4B07XpF53LTXlvJ4vQ0jRMnYoY0zyNRgtixsX8gNAu6h5BDYphx4hUcfV5/Xc4
         asIgNvV6k0GYj3f268dXkvZ7gIP5/oWKYOJJ+joUA92Q6eeJXmmaTp2FcfXkZSTw68au
         efowyULVQErGKWecCrqO4QwjpMPHCAXLetwzO2vjmlELE21x/GxToT+febKAkv1CXObr
         TK6WSl2O6/g1rmBk+lzo9IrBpjaHjIqgESq8LZF8hk5dIuu4oeQGHFkr/8OLDmxTfWkf
         OmmmcVAHuQH/VGsOvfbZjrKcyQv1GKFtfZyf4zsXjMmoTutFj8/Y0hRvqRbX9tXZrBx3
         zofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6NI8PLn6qYNBnYjgB4FzOkwm+CyN8AnQY7eSxHSLiUs=;
        b=mmPSwgH/2Cc4Oocro5MIr/ZBGxcZEaDq4+agMMOkh1/aDBvRGBZ2BPbxe6pdnzTGkF
         9ihviFIDKvQeaQRJqQ0gJRvlabL39OSi5UV9G6HJMF6pI1zL9Dh8PQ7hHpHhEG2SM1eV
         EQc0RnMD33NYptH7wBCy3ZDaoZoa7aEoNqtyJtsSIVYo4v84+KG5vrmYvQ2bGfGG1FWN
         iRI658XuZ9keIyfp34HKxqk5bZda7mQ8fIVQQELspxY+S9Z12DCwGRs3vfNDVYRqm3/K
         NcvdnRfRrd19Pti88G1qt1GCW/79noJpJiH2zWt6I6Fk7/L/0OkYo7gDCslhHL3DWI1Q
         jNRg==
X-Gm-Message-State: AOAM530sbmu7mdo0OBjveYQVXLpx78aohVRqaCOPKpOK/BNvzhbBH/2a
        ulNrYLnnuk2fpw823AgpquQQNy8brlAAqGdg2BKX+cRRaQgF0w==
X-Google-Smtp-Source: ABdhPJzHZ8cTd60580bhBaaAB5Pjkd8pHwdrSshuGLPU99WQJ3zuS/OsF0LXMM6VnQv5qWxcaJfs0esrp+/DEdqgvGA=
X-Received: by 2002:a17:906:6702:: with SMTP id a2mr3048755ejp.309.1604594536549;
 Thu, 05 Nov 2020 08:42:16 -0800 (PST)
MIME-Version: 1.0
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk> <d32523a5-a9c4-28a9-0286-9cd4a01b122d@kernel.dk>
In-Reply-To: <d32523a5-a9c4-28a9-0286-9cd4a01b122d@kernel.dk>
From:   Michal Simek <monstr@monstr.eu>
Date:   Thu, 5 Nov 2020 17:42:05 +0100
Message-ID: <CAHTX3dK_VbvKEho5vxOkY6BAnUWj8+HJZ6ESsLOmW5TMM3=bCg@mail.gmail.com>
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=C4=8Dt 5. 11. 2020 v 17:18 odes=C3=ADlatel Jens Axboe <axboe@kernel.dk> na=
psal:
>
> Gentle nudge on this one.
>
> On 10/29/20 10:16 AM, Jens Axboe wrote:
> > Wire up TIF_NOTIFY_SIGNAL handling for microblaze.
> >
> > Cc: Michal Simek <monstr@monstr.eu>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > ---
> >
> > 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> > for details:
> >
> > https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.d=
k/
> >
> > As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs=
,
> > as that will enable a set of cleanups once all of them support it. I'm
> > happy carrying this patch if need be, or it can be funelled through the
> > arch tree. Let me know.
> >
> >  arch/microblaze/include/asm/thread_info.h | 2 ++
> >  arch/microblaze/kernel/signal.c           | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaz=
e/include/asm/thread_info.h
> > index ad8e8fcb90d3..44f5ca331862 100644
> > --- a/arch/microblaze/include/asm/thread_info.h
> > +++ b/arch/microblaze/include/asm/thread_info.h
> > @@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_in=
fo(void)
> >  #define TIF_NEED_RESCHED     3 /* rescheduling necessary */
> >  /* restore singlestep on return to user mode */
> >  #define TIF_SINGLESTEP               4
> > +#define TIF_NOTIFY_SIGNAL    5       /* signal notifications exist */
> >  #define TIF_MEMDIE           6       /* is terminating due to OOM kill=
er */
> >  #define TIF_SYSCALL_AUDIT    9       /* syscall auditing active */
> >  #define TIF_SECCOMP          10      /* secure computing */
> > @@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_in=
fo(void)
> >  #define _TIF_SIGPENDING              (1 << TIF_SIGPENDING)
> >  #define _TIF_NEED_RESCHED    (1 << TIF_NEED_RESCHED)
> >  #define _TIF_SINGLESTEP              (1 << TIF_SINGLESTEP)
> > +#define _TIF_NOTIFY_SIGNAL   (1 << TIF_NOTIFY_SIGNAL)
> >  #define _TIF_POLLING_NRFLAG  (1 << TIF_POLLING_NRFLAG)
> >  #define _TIF_SYSCALL_AUDIT   (1 << TIF_SYSCALL_AUDIT)
> >  #define _TIF_SECCOMP         (1 << TIF_SECCOMP)
> > diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/s=
ignal.c
> > index f11a0ccccabc..5a8d173d7b75 100644
> > --- a/arch/microblaze/kernel/signal.c
> > +++ b/arch/microblaze/kernel/signal.c
> > @@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_=
syscall)
> >
> >  asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
> >  {
> > -     if (test_thread_flag(TIF_SIGPENDING))
> > +     if (test_thread_flag(TIF_SIGPENDING) ||
> > +         test_thread_flag(TIF_NOTIFY_SIGNAL))
> >               do_signal(regs, in_syscall);
> >
> >       if (test_thread_flag(TIF_NOTIFY_RESUME))
> >
>
>
> --
> Jens Axboe
>

Give me some time. I have it on my todo list.

M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
