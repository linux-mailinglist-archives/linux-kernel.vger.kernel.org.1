Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99312F8707
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbhAOVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732824AbhAOVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610744369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=la5k3x6l5Nim7XIsc/rdW4MreIXzyWWyJp04sEMzpkU=;
        b=RvBdi2vAvNSUKNW/v5P28c2LyiZZq0fFotCUYiLNfTurKA6vEUw0YI4LJx5qHCwZQfojUN
        gLo/C3h3E5VOmiVShdolFsoRiyInh0AtL6uV9LVmNMAHBRepu+4Uvc22E8+fyT1+i5rM2W
        2yWBn6rj0N3WJ+vVonlqkacFj6xS5g0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-oLZI2KgHMyWoin35npKoqQ-1; Fri, 15 Jan 2021 15:59:26 -0500
X-MC-Unique: oLZI2KgHMyWoin35npKoqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D007E806661;
        Fri, 15 Jan 2021 20:59:24 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB8F10016F6;
        Fri, 15 Jan 2021 20:59:22 +0000 (UTC)
Date:   Fri, 15 Jan 2021 14:59:20 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
Message-ID: <20210115205920.oknluuroxlhkxd2c@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
 <20210115195226.uiclol5lji3tuxgx@treble>
 <CA+icZUXPiE_ES4V7SbKs6Et9nJua5j4HhxFcBjgzvyttaxszDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUXPiE_ES4V7SbKs6Et9nJua5j4HhxFcBjgzvyttaxszDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 09:19:16PM +0100, Sedat Dilek wrote:
> > > vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack
> > > state mismatch: cfa1=7+192 cfa2=7+176
> > > vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7:
> > > stack state mismatch: cfa1=7+160 cfa2=7+176
> > > vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to
> > > do_strncpy_from_user() with UACCESS enabled
> > > vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to
> > > do_strnlen_user() with UACCESS enabled
> > > vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call
> > > to __ubsan_handle_negate_overflow() with UACCESS enabled
> > > vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected
> > > end of section
> > >
> > > I haven't had a chance to take a closer look yet, but some of these
> > > are probably related to
> > > https://github.com/ClangBuiltLinux/linux/issues/1192. However, I can
> > > reproduce these also with ToT Clang, not just with Clang 11.
> >
> > Thanks, I'm able to reproduce these.  Will take a look.
> >
> 
> AFAICS, that misses the v2 diff (see attachment) you sent me when
> dealing with objtool-vmlinux and clang-cfi.
> It does not cleanly apply with the combination of your objtool-vmlinux
> Git and clang-cfi Git.

Patches 11 and 12 should in theory have the same functionality as that
diff.  I just refactored the code a bit before posting.

-- 
Josh

