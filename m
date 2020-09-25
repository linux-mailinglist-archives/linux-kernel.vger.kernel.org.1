Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08445277CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 02:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgIYAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 20:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 20:25:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D60C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:25:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n13so694138edo.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mb/Gyht1d42k5WLRRBLSKrU8LIj1ziyutaDcZAUiiDE=;
        b=f9l5Zd3/T/siD3esxvK9V7YnPdrOPwx1tq742hlnDqkxlWrK/d7wadfgenOzWaholI
         EGlI6+dTP7IK4eZMyXFvN1jy4A1imuSMp+jrckKEPcgsAaYu5gsSQMyHqqwQWJF0sDU1
         5xzCMwIddufxjAl9RoRLXKtXbm0VEXIvz+CyefndRGPpKrVrNRrKyvmhCstvSG054h75
         /w7FRLohxgg+mkAxbgF06fH0/b5lpv0lS7KnVnWwZp6JamH8ekmXkyRaA0ONHW7gNWSj
         /xKm2wzh4qshXB/KxxZX2DfEOV9720E9nsisCdV28VmRKFCNLHI2UDRDSoq28tGoscpp
         75SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mb/Gyht1d42k5WLRRBLSKrU8LIj1ziyutaDcZAUiiDE=;
        b=SG1z0prCSUup8BenKoLP7J+ubqPrc42VK2tUuP3db5IXeFDU+mm3Zx/pvrx0svytkP
         hCKmYDMoN3P8k0yAf74xl6XeHb2tsbqODZS7/HjibSh74GOM7nDXVsEAaGQj0BxYf6bU
         Sw715pELtEsqH7b71ZrDDR+RFREJlurfSnA+lpgYDaAqBuB+b9o9ikMyS16oe+E5d6PS
         487cNmIIt63+Ql4aacVporkPjx96E7r5MHKb6v6P+llBhtXPzTm56ezHPW2DDlp75OEe
         jL54hq7HTHxN9Rq2BW5BQVEubYSuAPfE0UFsanOHvAIXncXiRoUYlxzYfCpyP5Puytle
         3Dow==
X-Gm-Message-State: AOAM533JG5jwdhuXaWBHIrb+IpgIcVpqZr9DnqAn9M3fSy7ggNwrGwrS
        0tcjstSOSPUe/aSzAslrS0gLmdOWAMo4bBhjgVL9vA==
X-Google-Smtp-Source: ABdhPJyXMnD+DwkHGMzEgLFLrUX3vRxmEK0cIvo8M77oLrJDknVzbQ95k1e4VVTE9KNNBZHJjBqthcj+pzQZ1DxtQHI=
X-Received: by 2002:a50:ccd2:: with SMTP id b18mr1328552edj.51.1600993510229;
 Thu, 24 Sep 2020 17:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook> <CAG48ez2R1fF2kAUc7vOOFgaE482jA94Lx+0oWiy6M5JeM2HtvA@mail.gmail.com>
 <20200925001803.GV3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200925001803.GV3421308@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 25 Sep 2020 02:24:43 +0200
Message-ID: <CAG48ez1VxTewE5AjStBjy_-YA9yV4P4svtm2ZzwG2dWugMU21A@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 2:18 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Sep 25, 2020 at 02:15:50AM +0200, Jann Horn wrote:
> > On Fri, Sep 25, 2020 at 2:01 AM Kees Cook <keescook@chromium.org> wrote:
> > > 2) seccomp needs to handle "multiplexed" tables like x86_x32 (distros
> > >    haven't removed CONFIG_X86_X32 widely yet, so it is a reality that
> > >    it must be dealt with), which means seccomp's idea of the arch
> > >    "number" can't be the same as the AUDIT_ARCH.
> >
> > Sure, distros ship it; but basically nobody uses it, it doesn't have
> > to be fast. As long as we don't *break* it, everything's fine. And if
> > we ignore the existence of X32 in the fastpath, that'll just mean that
> > syscalls with the X32 marker bit always hit the seccomp slowpath
> > (because it'll look like the syscall number is out-of-bounds ) - no
> > problem.
>
> You do realize that X32 is amd64 counterpart of mips n32, right?  And that's
> not "basically nobody uses it"...

What makes X32 weird for seccomp is that it has the syscall tables for
X86-64 and X32 mushed together, using the single architecture
identifier AUDIT_ARCH_X86_64. I believe that's what Kees referred to
by "multiplexed tables".

As far as I can tell, MIPS is more well-behaved there and uses the
separate architecture identifiers
AUDIT_ARCH_MIPS|__AUDIT_ARCH_64BIT
and
AUDIT_ARCH_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_CONVENTION_MIPS64_N32.

(But no, I did not actually realize that that's what N32 is. Thanks
for the explanation, I was wondering why MIPS was the only
architecture with three architecture identifiers...)
