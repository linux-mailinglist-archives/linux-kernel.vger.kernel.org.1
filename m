Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7A2F85C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbhAOTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729079AbhAOTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610740355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYUX2O2Url/4uImMaTVPMyONJrBt2Lv/2+C4E8uQ6Pw=;
        b=CAlbNLEe38GjFAnbCaf9YvbkyOK8T1Mko+EpJjQXX2mR/tZOEgkZqf7A7Ux1C35v7x9kwq
        eHohXULQ04vIm8OqO+U0wwUH2Sg8YqgMwwMFTPhoLhSXP3z/yiMjJ1Nme+dq0F6gUSl+BP
        YIQkAidySSrjfNC1A0EQIXNY9OIcGDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-gXpwSsl0Mh2Do2FIQbWDKQ-1; Fri, 15 Jan 2021 14:52:31 -0500
X-MC-Unique: gXpwSsl0Mh2Do2FIQbWDKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80050107ACF7;
        Fri, 15 Jan 2021 19:52:29 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9745D5C675;
        Fri, 15 Jan 2021 19:52:28 +0000 (UTC)
Date:   Fri, 15 Jan 2021 13:52:26 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
Message-ID: <20210115195226.uiclol5lji3tuxgx@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:41:28PM -0800, Sami Tolvanen wrote:
> Hi Josh,
> 
> On Thu, Jan 14, 2021 at 11:40 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > Add support for proper vmlinux.o validation, which will be needed for
> > Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> > objtool anyway, for other reasons.)
> >
> > This isn't 100% done -- most notably, crypto still needs to be supported
> > -- but I think this gets us most of the way there.
> >
> > This can also be found at
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> >
> > And for more testing it can be combined with Sami's x86 LTO patches:
> >
> >   https://github.com/samitolvanen/linux clang-lto
> 
> Thank you for sending these! I applied this series on top of the
> clang-lto tree and built allyesconfig with LTO_CLANG enabled and the
> following crypto options disabled:
> 
> CRYPTO_AES_NI_INTEL
> CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
> CRYPTO_SHA1_SSSE3
> CRYPTO_SHA256_SSSE3
> CRYPTO_SHA512_SSSE3
> CRYPTO_CRC32C_INTEL
> 
> I can confirm that all the warnings I previously saw are now fixed,
> but I'm seeing a few new ones:
> 
> vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack
> state mismatch: cfa1=7+192 cfa2=7+176
> vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7:
> stack state mismatch: cfa1=7+160 cfa2=7+176
> vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to
> do_strncpy_from_user() with UACCESS enabled
> vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to
> do_strnlen_user() with UACCESS enabled
> vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call
> to __ubsan_handle_negate_overflow() with UACCESS enabled
> vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected
> end of section
> 
> I haven't had a chance to take a closer look yet, but some of these
> are probably related to
> https://github.com/ClangBuiltLinux/linux/issues/1192. However, I can
> reproduce these also with ToT Clang, not just with Clang 11.

Thanks, I'm able to reproduce these.  Will take a look.

-- 
Josh

