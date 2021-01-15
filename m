Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B8C2F8715
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbhAOVCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbhAOVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:02:06 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14AAC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:01:39 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y19so20807353iov.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Rw2hDfTe+mOrdjn0mjFiTbDIDipciz+JNoQG0iXK/9Y=;
        b=RRcneQSDd2Q+bcR1C2G1J6p7XC92+UD2YEqjzug20jBTr8HB8ioRL/ZWKho//53NCC
         AUoDTZqoI4KeovpA0ox6zL5jSgu9ybbcUfnOql1HHFxK3VDu4f9A5tSJKr0qZLlbwpIS
         7vStDDy3AeWatRsLjyvHD9jk/jB85xKAo08899EKxy/yxXlgtcvt19w28Y2WkNSNHrHT
         OqTp4Tjoi/MzDtmS2V0YM/UhQ+uvUXqVNzPmoYoKmUyguQDwefMgEcasNv2sNPA6OYIj
         DxyvKIS7dURDlqz0mB0MgEirKmjrX6PDp7o+hsRQ7gYJdARaG1ZMkGdUbeKS8sxYiCEo
         T6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Rw2hDfTe+mOrdjn0mjFiTbDIDipciz+JNoQG0iXK/9Y=;
        b=elGaXx5ccBVqkI9UdFWiXU+nbdMSW0chSx48qEejc+9XpyS0ib3kzUcf/dsiODnoUJ
         DlKmFMir79JcgYBDkpBkJ6gnKQ+jctVcnWxAXsb86pORFbQDLRMGcvMGvnusi4TC9own
         FNIiFYPd22Km0fp+VLPefRclfzHaTKDUSNy69TOl9wyaI9zMTEAdBFOAGP+paSDRvIrF
         poa5hIes44E8ekowzNJviOHzhYYxmDXjM9jKIT5bpD49e9qSGrRgPqPsbvBAOyzLhBvV
         luVhKeulWlPjDvaZoGiJnn/MJtK1XDWG3WNDX4nRaChtiRu6h2mviGboNQin4s88/Nm/
         U06A==
X-Gm-Message-State: AOAM531E6kdxP1+LArnrE4ezwzcNi4QnN6x4ajiE+eU7GrTh+NXTykWP
        tCuSripM1cGGsRCHGZU3Qjojg5rEiVf+UlTgxa8=
X-Google-Smtp-Source: ABdhPJyY9UFhOyzCBDzayUJvAnxrpWOh22P1aGEh485o5DkL08NdyXQDKkstZ6Epc2hL84YFPUCKNr8wF71kBU7aaOk=
X-Received: by 2002:a92:c692:: with SMTP id o18mr12608774ilg.215.1610744498720;
 Fri, 15 Jan 2021 13:01:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
 <20210115195226.uiclol5lji3tuxgx@treble> <CA+icZUXPiE_ES4V7SbKs6Et9nJua5j4HhxFcBjgzvyttaxszDQ@mail.gmail.com>
 <20210115205920.oknluuroxlhkxd2c@treble>
In-Reply-To: <20210115205920.oknluuroxlhkxd2c@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 22:01:27 +0100
Message-ID: <CA+icZUWOSNAff5ZmxjQ752Lw02dvYo-mFwvOG87bYtF2EzfFnA@mail.gmail.com>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 9:59 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jan 15, 2021 at 09:19:16PM +0100, Sedat Dilek wrote:
> > > > vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack
> > > > state mismatch: cfa1=7+192 cfa2=7+176
> > > > vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7:
> > > > stack state mismatch: cfa1=7+160 cfa2=7+176
> > > > vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to
> > > > do_strncpy_from_user() with UACCESS enabled
> > > > vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to
> > > > do_strnlen_user() with UACCESS enabled
> > > > vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call
> > > > to __ubsan_handle_negate_overflow() with UACCESS enabled
> > > > vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected
> > > > end of section
> > > >
> > > > I haven't had a chance to take a closer look yet, but some of these
> > > > are probably related to
> > > > https://github.com/ClangBuiltLinux/linux/issues/1192. However, I can
> > > > reproduce these also with ToT Clang, not just with Clang 11.
> > >
> > > Thanks, I'm able to reproduce these.  Will take a look.
> > >
> >
> > AFAICS, that misses the v2 diff (see attachment) you sent me when
> > dealing with objtool-vmlinux and clang-cfi.
> > It does not cleanly apply with the combination of your objtool-vmlinux
> > Git and clang-cfi Git.
>
> Patches 11 and 12 should in theory have the same functionality as that
> diff.  I just refactored the code a bit before posting.
>

Just realized that when looking at "objtool: Add CONFIG_CFI_CLANG
support" in your tree.

- Sedat -
