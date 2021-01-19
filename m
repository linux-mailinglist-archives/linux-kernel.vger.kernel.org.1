Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5468B2FC25F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbhASVao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbhASVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:30:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58039C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:29:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m5so753632pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCrNzaL4w56hc9lFQdEeIjWEg1C4jutehfs9o1t6SSE=;
        b=EP4GZbG7iSTRo2M03aXhTsYPTbL1hhmDd/P1IxUY28HnAxihA+CZm/HKAQfH/ZWnEM
         5Ud7FhWRP8uExoMSTRq4m0UGe7k9CY1B0P2q7XOSlfwiWVzUZaHtL+0svF1sg60g1pcT
         ikIXCx2LgfjSlKQYBQEZh0MnGyvfuQsO9a1KQ39IK4LIsCpVDCvIHU3IVIy6RSrIxwyb
         lVXZ8oKmipzj0mKlMrW5L8C+i15mWgSAVGKyPo+cDgppVxR3Ji7s7Ufcng+YrR8QInIp
         tCtK28jZycw4M9e4i0ZX1fXbnJgrrwg2UsQdhzh+aJJY4VP36Xj8vKo+TQKGC8ZwYiJM
         JbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCrNzaL4w56hc9lFQdEeIjWEg1C4jutehfs9o1t6SSE=;
        b=DABA5/02lT5/7PI3tuygwl7/C2f4XOguGr0H1euHlKP95SUVrpTOBdFXwAS3co1qqe
         lZgpf2G7Fx7wa/YsdRwX8thnihmKN7fCs/HuKPUUabJJMiO4JTc/bNvO3xGGMCV5w+Mr
         +JxCsTyoWWm0EMD2UCms7+i2IpB55VmznEMdd3IqXOq+1G1NasWhrTQ+wXd5I6g/9VlD
         VkDEVXVy5e9KdrthbmEknBza3mfahm/yKxBsgZRvUyVElbXyvVqB+bi1jPp8KypZ4PFM
         J6MRVxa9wIVlBbhfkxrhLOnWjUPD4VltH9qPbO4D+bOCCdSi2yx6vK2EJ4vewKlTAVpc
         QWDA==
X-Gm-Message-State: AOAM530t8uKhG0RDXmTdoo+8YvR0C/4R9jHzOmOEduV5YDOyC5ozVxQD
        Btwwsn3YKe2IhYQ7L8lwoOL8//VZJn7BzxKYuKx2fA==
X-Google-Smtp-Source: ABdhPJwzbmHZWiFDAoi5GNhX3mvHJePmQfQgYOB+IhwMfzGj/G4alx72Gy0EdCsbvc85u7d2JLUgwFYZvz/g2BFKlNk=
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr1752235pjp.101.1611091767735;
 Tue, 19 Jan 2021 13:29:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
 <20210118172255.hirr6qpquxgq2vr6@treble>
In-Reply-To: <20210118172255.hirr6qpquxgq2vr6@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 13:29:16 -0800
Message-ID: <CAKwvOd=tRwOvLdQXDRYo00P3vLAnwnb1SXtaHPVkXTnfjMst+g@mail.gmail.com>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 9:23 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jan 14, 2021 at 04:41:28PM -0800, Sami Tolvanen wrote:
> > I can confirm that all the warnings I previously saw are now fixed,
> > but I'm seeing a few new ones:
> >
> > vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack state mismatch: cfa1=7+192 cfa2=7+176
> > vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7: stack state mismatch: cfa1=7+160 cfa2=7+176
>
> These seem legit stack state mismatches (compiler bug).  Two code
> blocks, with different stack sizes, transfer control to the same
> noreturn block (violating DWARF/ORC expectation that each instruction
> has a deterministic stack layout).  In both cases the noreturn block has
> a call to __reiserfs_panic().
>
> https://paste.centos.org/view/081cbfc1
> https://paste.centos.org/view/265968a6
>

Sorry, I think all of the pastes linked here expired before I had a
chance to grab them.

> > vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to do_strncpy_from_user() with UACCESS enabled
> > vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to do_strnlen_user() with UACCESS enabled
>
> It's odd that Clang wouldn't inline these static single-called
> functions.  I could '__always_inline' them, but is this expected
> behavior?
>
> > vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call to __ubsan_handle_negate_overflow() with UACCESS enabled
>
> PeterZ, have you seen this one?
>
> https://paste.centos.org/view/b4723113
>
> > vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected end of section
>
> Another weird compiler issue.  It generates obviously dead code which
> jumps off the end of the function:
>
>   f7:   b0 01                   mov    $0x1,%al
>   f9:   84 c0                   test   %al,%al
>   fb:   0f 84 79 05 00 00       je     67a <snd_trident_free_voice+0x67a>
>
> https://paste.centos.org/view/a1887ae3
>
> --
> Josh
>


-- 
Thanks,
~Nick Desaulniers
