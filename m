Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264AB2AAD23
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgKHTH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHTH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:07:58 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6902B221FF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604862477;
        bh=xHtls6lXIezqo3MY4JofvqKy4eD3Tg/zP3T1SVhh14M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OwQBk7ZmeUfBRnMBYMDC3sno96dtH68oH0mcOGWybDGRJ2FiCm75Pd11HFk47H/yj
         yStAq4g40HDRq1G96eWCFFZ+2GuX/1qkEjgF6w6934s8SVBAZbU7sE5DSRakMA+cil
         1XGBFU401g4nzMjMZlv+BJaFsuvKrl6V5PEeHVSI=
Received: by mail-wr1-f53.google.com with SMTP id c17so6502133wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 11:07:57 -0800 (PST)
X-Gm-Message-State: AOAM531u4mmVrMqgxsx/NhS2F8e76c9NMCy/VFDPchWgJI8ZXgQC7wxe
        u+rb6/fuvAwPu/58bq88nlFtvwE2qnP6UlwN7aj5Rw==
X-Google-Smtp-Source: ABdhPJzhIeYsh6ImqBo3MO13jFnDXj/3CxHcgilHtBOIs01JZKqESrAhAXBK5n9FiqSo+pApvOkp93Dmq6I76qqKv1w=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr7511599wro.184.1604862475870;
 Sun, 08 Nov 2020 11:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20201108051730.2042693-1-dima@arista.com>
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 8 Nov 2020 11:07:44 -0800
X-Gmail-Original-Message-ID: <CALCETrW-hHyh3nF3ATmy61PCy1iFqVhVYX+-ptBCMP5Bf7aJ0w@mail.gmail.com>
Message-ID: <CALCETrW-hHyh3nF3ATmy61PCy1iFqVhVYX+-ptBCMP5Bf7aJ0w@mail.gmail.com>
Subject: Re: [PATCH 00/19] Add generic user_landing tracking
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
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 9:17 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Started from discussion [1], where was noted that currently a couple of
> architectures support mremap() for vdso/sigpage, but not munmap().
> If an application maps something on the ex-place of vdso/sigpage,
> later after processing signal it will land there (good luck!)
>
> Patches set is based on linux-next (next-20201106) and it depends on
> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
> on my changes in akpm (fixing several mremap() issues).
>
> Logically, the patches set divides on:
> - patch       1: cleanup for patches in x86/cleanups
> - patches  2-11: cleanups for arch_setup_additional_pages()

I like these cleanups, although I think you should stop using terms
like "new-born".  A task being exec'd is not newborn at all -- it's in
the middle of a transformation.

--Andy
