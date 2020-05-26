Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA35C1B4CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDVSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:47:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BADC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:47:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so1569314pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5k+yPGx/qr44nGnCycXueReY9HedaR9suO/n1V+xq9k=;
        b=RFUf9SlO6v6pCUVmkWkRELNgk+1N3Zs9ucmPxL27YFrNXeKy55VzP5MIVle/v1F0y3
         VD0ElDOeI+B64ryKAl8IBmi6hGumY21RHSNiRJ+uXkPlg0v39ASsZhYhhdckAR5aIvIQ
         y6IzK01PbEzBGR8W4Uc1OHyusUmkCkOi8mYbyknc6ppZSuaCmxYlLYiNrgOsBfvtDlFG
         en+sqwFn7adRwle5S4ucCO4m2jqY8Vy1hHFYPPXg1FSpBPP9lg+LgLwN6sJ7nciNIbCp
         qgZm8hne2F5Mo3wOaeWsb38L0eFtVe1BHgm+KxDnMbHf+HKOEEPiDDl1nbKnRxlIUwlc
         wISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5k+yPGx/qr44nGnCycXueReY9HedaR9suO/n1V+xq9k=;
        b=gTEo0tkInrMCxzRWwFP2tekElzxyCMWSDm5QnDDdd8fAvueDsDrnfx06HNpbm23gXa
         cqC10ldQHBMTFXRvJYMazfakrh91SWpzTMAeIBTP3gJ2ykwKXVzc0iZ1iONR5vkrLLJR
         SSd6pcpvY3RArPXluum+VfISM5RMMOpAJw80Brfg3eW40H0ExAcKTxaBIgcNaRyl4k8g
         cd5fMl+45VVq62g0/qpIkJoez3adBUwa7l4pFpqRP/WlIZzKxrygscdlqbcTZKhuXSpI
         DGYkp9fHShwoMxxSooaHNnJb+LWYCI6TQ0j+CMuEriigEotUSYSlKrwhvgZ1AHhVK5Hn
         FAOA==
X-Gm-Message-State: AGi0PubhhNZkF8ztLHfFBLKaJbTCAt9AfaucixF+ao0R2IRl9Ol2ZjY5
        69l6kjNVLsA8ZySS1EJX1BJ14pc7MGYelEwxei71HQ==
X-Google-Smtp-Source: APiQypIfTDLwLZ5OTQEx/9phiirzNlm3DRUesmAFFcs1aeUn+ht7YWYve7BhbFgSRDBb8i2MeRRn5DoW46yqw0GPiu8=
X-Received: by 2002:a63:5009:: with SMTP id e9mr366799pgb.381.1587581260929;
 Wed, 22 Apr 2020 11:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak> <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de> <20200422102309.GA26846@zn.tnic>
 <20200422114007.GC20730@hirez.programming.kicks-ass.net> <20200422134924.GB26846@zn.tnic>
 <20200422135531.GM2424@tucnak> <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz> <20200422165339.GE26846@zn.tnic>
In-Reply-To: <20200422165339.GE26846@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Apr 2020 11:47:27 -0700
Message-ID: <CAKwvOd=1CDhfgkcXJ1Q8bZcy0UKWFFoP4QCeCzt4OE7LTGq6yA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Matz <matz@suse.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 9:53 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Apr 22, 2020 at 04:16:53PM +0200, Martin Li=C5=A1ka wrote:
> > And as I talked to Boris, I would recommend to come up with a "configur=
e" check
> > that a compiler does not optimize the key code sequence:
> >
> > $ cat asm-detect.c
> > int foo(int a);
> > int bar(int a)
> > {
> >   int r =3D foo(a);
> >   asm ("");
> >   return r;
> > }
> >
> > $ gcc -O2 -c asm-detect.c -S -o/dev/stdout | grep jmp
> > [no output]
>
> That is a good test to run at the beginning of the compilation I guess.
>
> Without the asm("") it produces:
>
> bar:
> .LFB0:
>         .cfi_startproc
>         jmp     foo@PLT
>         .cfi_endproc
>
> I'd like for LLVM folks to confirm that this is a good test for LLVM too
> Trying that here with clang gives:
>
> bar:                                    # @bar
>         .cfi_startproc
> # %bb.0:
>         jmp     foo                     # TAILCALL
> .Lfunc_end0:
>
> so this *looks* like it would work with LLVM too but I might be missing
> something...


LGTM https://godbolt.org/z/ExtHx7
--=20
Thanks,
~Nick Desaulniers
