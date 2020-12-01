Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A22CAA1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392022AbgLARsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389404AbgLARsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:48:31 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B108F2168B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606844871;
        bh=O4Uu/iq4Kh9cujffQ6ihpyeaHs2StYUL8Blh+qZ4cEY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KNPKzuAyx7EYFCOIfbHg9OkxoC67Qv2iJxAMkAe5isYWiG+XL6za7epLjqzgnW8go
         GOB+IAua2Ysb6ELj22ZhzIWGTL78y8Uemi4NLe0ZLdMtGRXCP5AkqMQc+c+4m2N1Nm
         7gRPENWJ6bNr0+I5LC3Q60pq/ZKw/EEFl7D/L3hQ=
Received: by mail-wm1-f52.google.com with SMTP id c198so5095295wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:47:50 -0800 (PST)
X-Gm-Message-State: AOAM532dfu9W17P5E1RHuMq+nbjMi3kuP5rJtk0xC3Si1gkCWwZodEvE
        cOc0fGoFSCNM5fS+G3Bxo0YNwSyBl8RgrCWr7IJxFQ==
X-Google-Smtp-Source: ABdhPJy30xOLgN5VXGtHnvOo0aAaevagzcWZuQ7BSNLmq7Et41HWqId6iFQs2v824B0sP5r+M44N8po6KuYAYP4WBj0=
X-Received: by 2002:a7b:c303:: with SMTP id k3mr3844295wmj.21.1606844869175;
 Tue, 01 Dec 2020 09:47:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606758530.git.luto@kernel.org> <9b8ecd9a017960c9e56ef3f3e733f32aa1194366.1606758530.git.luto@kernel.org>
 <1261102549.69322.1606833558510.JavaMail.zimbra@efficios.com>
In-Reply-To: <1261102549.69322.1606833558510.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 09:47:35 -0800
X-Gmail-Original-Message-ID: <CALCETrWYkOp1QkCtzR2APW2KUJV5CGbfae-pTODt76OOB+Mg-A@mail.gmail.com>
Message-ID: <CALCETrWYkOp1QkCtzR2APW2KUJV5CGbfae-pTODt76OOB+Mg-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/membarrier: Get rid of a dubious optimization
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:39 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Nov 30, 2020, at 12:50 PM, Andy Lutomirski luto@kernel.org wrote:
> [...]
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index 11666ba19b62..dabe683ab076 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -474,8 +474,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> > mm_struct *next,
> >       /*
> >        * The membarrier system call requires a full memory barrier and
> >        * core serialization before returning to user-space, after
> > -      * storing to rq->curr. Writing to CR3 provides that full
> > -      * memory barrier and core serializing instruction.
> > +      * storing to rq->curr, when changing mm.  This is because membarrier()
> > +      * sends IPIs to all CPUs that are in the target mm, but another
> > +      * CPU switch to the target mm in the mean time.
>
> The sentence "This is because membarrier() sends IPIs to all CPUs that are in
> the target mm, but another CPU switch to the target mm in the mean time." seems
> rather unclear. Could be clarified with e.g.:
>
> "This is because membarrier() sends IPIs to all CPUs that are in the target mm
> to make them issue memory barriers. However, if another CPU switches to/from the
> target mm concurrently with membarrier(), it can cause that CPU not to receive the
> IPI when it really should issue a memory barrier."
>
> For the rest of this patch:
>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Thanks!

Done, thanks!

>
> Mathieu
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
