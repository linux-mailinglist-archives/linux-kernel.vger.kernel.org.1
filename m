Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91841CE259
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgEKSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:12:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6436C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:12:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o14so9526159ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wr1ycv+siaolsKCvcq8pIOR365B5ZJOgX6Pl3lWLVLc=;
        b=bDQ3m7zIuQxezVOH9ZwaR/IFoNv1Ph7lBUT4KC1tOQ29Sv7/FfbpX1jR5I6MiVD1H3
         a6h6kbSLdtdqMnCnTY9J9fT1T3Y12NmwK/y/yA9X355RI68xbl+N5jZAFV9W8R7IIbJ0
         mV7WNsTiUF4PgcffhE6LD2y3c416dUv6ks6E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wr1ycv+siaolsKCvcq8pIOR365B5ZJOgX6Pl3lWLVLc=;
        b=cLnvenB3ALSI6l/iTuA4Uj8mdw0UdFLimDCGas++aD7Wkd4WUl1Ge7qfS3KpEKQiba
         F6G1zA/IAHAyluX7IX2eKqLyYDPfhQ4o4SOnYTAO3OV9EHiFWVeF6Z/Ub1SnSDR3KQH7
         tSNICibEgGmqo89RmYS/AsMh2NpinCL98AL7fy4siGqJYF1bfk8C/GCU9vK2wq34WI4c
         v9J/6NVXmR90WoC4WbspZGHSzmH1XyxSxYkvwJVybljDRX2Wx9vQzj4mvGH433UbQg+Y
         c4dud7pPMok1/sbhMUiFhki7wCxAp25tN5IrjphTlZnfUHoOnVQLO9J8beQzNnRW9WqL
         cocQ==
X-Gm-Message-State: AOAM5313iLJRMSIF03ffR6gXTZr6ZCSnp/hJL/bQUqj20i//FZQwh/1a
        Xz0jKssEeVTPsgmTNF9GprZ1iUb8ZJw=
X-Google-Smtp-Source: ABdhPJzMZU/urFCv2BxIulERXeHLyISR5VF8zmcq/vAZnlC+nwrz9QKFxWkqXKGOl0dcImbm4wVxWw==
X-Received: by 2002:a2e:b605:: with SMTP id r5mr10963005ljn.40.1589220770894;
        Mon, 11 May 2020 11:12:50 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s27sm10532965ljo.80.2020.05.11.11.12.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 11:12:49 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z22so8351522lfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:12:49 -0700 (PDT)
X-Received: by 2002:ac2:47fb:: with SMTP id b27mr12159503lfp.10.1589220768686;
 Mon, 11 May 2020 11:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com> <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
In-Reply-To: <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 11:12:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com>
Message-ID: <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:24 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Bumping for comment+review.
>
> On Mon, May 4, 2020 at 4:03 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > -                   : "qi" ((pto_T__)(val)));           \
> > +                   : "qi" ((unsigned char)(unsigned long)(val))); \

I find the extra casts really annoying and illogical.

I kind of see why they happen: just casting to 'unsigned char' can
cause warnings, when this case isn't even taken, and the sizeof(var)
is something else (and you cast a pointer to a char without going
through the 'unsigned long' first.

But that doesn't make this change any more sensible or readable.

Would using "__builtin_choose_expr()" be able to avoid this whole issue?

Because I'd rather re-write the whole thing with a different model
that doesn't have this issue, than make the code look insane.

And it does look insane, because that whole thing makes for a very
natural question: "why do we cast to unsigned long and then to char,
when we just checked that the size of the type is 1"?

                 Linus
