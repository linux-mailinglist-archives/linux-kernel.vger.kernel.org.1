Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75F42FA784
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393727AbhARR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393606AbhARRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610990594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PonF/SDgCPcmmfKLGiNEs0Bfa6YqWm1uHjGPceEa6ds=;
        b=Vwh8nenRreMiUUcW8vmmS5ESYS7zFCQ1E/05NLcYat2VLIJsNZmGMgqflZ1D5V4v7PNA3p
        e5/fJWdDW8s792Bl3Cl24FM1tJ/ztSPAcWyRcl9RoqLQewo1UOX9i0CXlwHcrrxtCNMZCR
        AT2r5L7KwCxQklKepnZ9qVFrDBHmh94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-_tejTklNMMKa5ryqppb3eA-1; Mon, 18 Jan 2021 12:23:07 -0500
X-MC-Unique: _tejTklNMMKa5ryqppb3eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494DC1800D42;
        Mon, 18 Jan 2021 17:23:06 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D25EA60861;
        Mon, 18 Jan 2021 17:23:03 +0000 (UTC)
Date:   Mon, 18 Jan 2021 11:22:55 -0600
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
Message-ID: <20210118172255.hirr6qpquxgq2vr6@treble>
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
> I can confirm that all the warnings I previously saw are now fixed,
> but I'm seeing a few new ones:
> 
> vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack state mismatch: cfa1=7+192 cfa2=7+176
> vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7: stack state mismatch: cfa1=7+160 cfa2=7+176

These seem legit stack state mismatches (compiler bug).  Two code
blocks, with different stack sizes, transfer control to the same
noreturn block (violating DWARF/ORC expectation that each instruction
has a deterministic stack layout).  In both cases the noreturn block has
a call to __reiserfs_panic().

https://paste.centos.org/view/081cbfc1
https://paste.centos.org/view/265968a6

> vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to do_strncpy_from_user() with UACCESS enabled
> vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to do_strnlen_user() with UACCESS enabled

It's odd that Clang wouldn't inline these static single-called
functions.  I could '__always_inline' them, but is this expected
behavior?

> vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call to __ubsan_handle_negate_overflow() with UACCESS enabled

PeterZ, have you seen this one?

https://paste.centos.org/view/b4723113

> vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected end of section

Another weird compiler issue.  It generates obviously dead code which
jumps off the end of the function:

  f7:   b0 01                   mov    $0x1,%al
  f9:   84 c0                   test   %al,%al
  fb:   0f 84 79 05 00 00       je     67a <snd_trident_free_voice+0x67a>

https://paste.centos.org/view/a1887ae3

-- 
Josh

