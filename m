Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2618C2A63A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgKDLsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:48:35 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31047C0613D3;
        Wed,  4 Nov 2020 03:48:35 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b12so10186701plr.4;
        Wed, 04 Nov 2020 03:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IzbM9m4aaHXdrXJm05MLSazuYENXBo0KE7aGRSwMEM=;
        b=ZdFcNNsEPd+MrYWXHoLvBaTyKHUZhwFwZu3J/PQqzp5Y/s91VRqgtwgRqnPdnsJFzV
         u8ndi/4ac74yeUDpbQr7HXPlEJnbasb7cO8o7gJ5QfnXfnqvT0IrHsEaICKEwxEa70A2
         YXFhqPLDhnbJkNUfiRkcSqJ8rcr7T7iBd7vGmo4WjMykCP58kLBQOzps+/fitCtmG7lx
         rqQXdb82DTVqzyozftIz+18xHfX9wm2lvzWUKmKLYyJ3imRpyuFKCfkdabT8dbUsAWYG
         nv0yauU0g8FHPsO317oAA4Yrr0jRGmrdqn85extqA7+6MeHG+mc31wlEfpFhQQxxW9Z6
         hBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IzbM9m4aaHXdrXJm05MLSazuYENXBo0KE7aGRSwMEM=;
        b=hg+Ri/MEBJrLVyt6nwfiPJxjwP5O4yU43nlDmotGDwZG0RNu/Fl7bH1fC4btlWn8GJ
         F2C7zQC2/K5LP7czbHlu7dJMcytb/YiSGxyVI7XwJcBVs6P5s8OZQnMTWyGYD1V058yi
         c8sxNuLdKO8IALrugfv1vPSwJVUGDNam8g/Rnd1ndAejpTPXIM2SZ/DfRYr9m8gm6Uox
         JkOMw/WfEhmhYOfUiqh9CmHULoUxkU4YBQ8S+RzLVupWt/asmgMPmbtXIvzPZ04rCfQ9
         GcciqVfL9Yqj8EKoRcHHxzT/t8HFi8GiR3JGKzAXMct1s5pEAjA5zBSpoIq71v27SN7d
         LGEA==
X-Gm-Message-State: AOAM532R3iW2Z3OOrPTUMe49g7oTa3qVLQ5V86qGG8M3TloOUEsajTIO
        dGDUFUTt3ad70ONP+fRyAnNuw6diopW70iJdUEk=
X-Google-Smtp-Source: ABdhPJwhKGHgOtsgYmsX8K8geLNyRT+0OoRlLf1+UEBmK6aJHTGU8p2K0A8JMelevcl7yJOdhQWuD2QnmsGaSXA3des=
X-Received: by 2002:a17:902:d30c:b029:d6:8208:bb1 with SMTP id
 b12-20020a170902d30cb02900d682080bb1mr29348288plc.44.1604490514732; Wed, 04
 Nov 2020 03:48:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604410035.git.yifeifz2@illinois.edu> <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu>
 <87wnz1to9n.fsf@mpe.ellerman.id.au>
In-Reply-To: <87wnz1to9n.fsf@mpe.ellerman.id.au>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Wed, 4 Nov 2020 05:48:21 -0600
Message-ID: <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
Subject: Re: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        linux-riscv@lists.infradead.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>,
        linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        David Laight <David.Laight@aculab.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 4:22 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > +#ifdef __LITTLE_ENDIAN__
>
> As Kees mentioned this should (must?!) match the configured endian.
>
> But I think it would still be better to use the CONFIG symbol, which is
> CONFIG_CPU_LITTLE_ENDIAN.

My attempt here is to be consistent with asm/syscall.h
syscall_get_arch [1]. Would it make sense to change that to
CONFIG_CPU_LITTLE_ENDIAN then?

[1] https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/syscall.h#L116

> > +# define SECCOMP_ARCH_NATIVE         (AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
>
> You use __SECCOMP_ARCH_LE there, but previously you only defined
> __SECCOMP_ARCH_LE_BIT.
>
> Is there some magic somewhere that defines __SECCOMP_ARCH_LE based on
> __SECCOMP_ARCH_LE_BIT ?

Oops, my bad here.

> > +# define SECCOMP_ARCH_NATIVE_NR              NR_syscalls
> > +# define SECCOMP_ARCH_NATIVE_NAME    "ppc64"
>
> What's the name used for?

This is used in the last patch in this series to report in procfs the
name of each architecture tracked by the bitmap cache.

> Usually we use "ppc64" for 64-bit big endian and "ppc64le" for 64-bit
> little endian.
>
> And usually we use "ppc" for 32-bit.

Ok.

YiFei Zhu
