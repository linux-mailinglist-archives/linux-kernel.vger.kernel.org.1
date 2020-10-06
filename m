Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AFE285036
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFQz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:55:25 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8B020796;
        Tue,  6 Oct 2020 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602003325;
        bh=pzBiZFeYHRuM1MF/EG+vEY3UU0+WKZ5gBUmlAf1fZk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p+wsizep1tpsNCv0UU0tD/SPcXCwTlcFK+FUqCnKk7fr+pu9UtVtfXz1IWM3qEzaa
         y0Fk5u/7eFsRCZRnpExTDNzfNK8cM4b4eLkJppmqJLItT1eNgpHRq+gXi4S9CcR3by
         LudgPKIwsY5MEcDwD+TKgpZhPREmC+Wp1lmlAk1o=
Received: by mail-lj1-f181.google.com with SMTP id v23so11646196ljd.1;
        Tue, 06 Oct 2020 09:55:24 -0700 (PDT)
X-Gm-Message-State: AOAM530P9JfkstNyCOwslGM2FkYZdaI3zIEN6WClbPJ8Pom2vuhfKvFs
        jfMBfY2za/h+Y6VFfCam1EHskMh4LFhbY1tmn5w=
X-Google-Smtp-Source: ABdhPJwhosMAr3iuJ1VKbEhFgz81Oros95KFySfs0kYUf49Z0cZexyRx4rKaRWsJf3NtGFrsN2s70CEiJegChyU1d9U=
X-Received: by 2002:a2e:86c2:: with SMTP id n2mr2048844ljj.346.1602003322919;
 Tue, 06 Oct 2020 09:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <87lfglt6z1.fsf@igel.home> <mhng-847e71cf-64bc-464b-8d09-3bcec40aa491@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-847e71cf-64bc-464b-8d09-3bcec40aa491@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Oct 2020 00:55:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRuQpwHvyZVjab+RMgx9BMR8gjcnGSgeP3a7L=dCcNqAg@mail.gmail.com>
Message-ID: <CAJF2gTRuQpwHvyZVjab+RMgx9BMR8gjcnGSgeP3a7L=dCcNqAg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 12:39 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
> > On Sep 14 2020, Aurelien Jarno wrote:
> >
> >> How should we proceed to get that fixed in time for 5.9? For the older
> >> branches where it has been backported (so far 5.7 and 5.8), should we
> >> just get that commit reverted instead?
> >
> > Why is this still broken?
>
> Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 with just
> CONFIG_HARDENED_USERCPOY=y in addition to defconfig (on QEMU, though I doubt
> that's relevant here).  It looks like the fix is to essentially revert this,
> which I'm fine with, but I'd prefer to have a failing test to make sure this
> doesn't break again.
>
> Guo: I don't see an actual patch (signed off and such) posted for this, do you
> mind posting one?  Otherwise I'll take a crack at constructing the revert
> myself.

Please have a look:
https://lore.kernel.org/linux-riscv/1602002973-92934-1-git-send-email-guoren@kernel.org/T/#u

The only revert couldn't solve the static_obj problem.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
