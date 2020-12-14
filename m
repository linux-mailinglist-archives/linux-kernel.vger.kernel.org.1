Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093312D9847
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406851AbgLNMuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbgLNMuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:50:07 -0500
X-Gm-Message-State: AOAM533gKAwzCqrSKAZEpii2Bw6HX9gf/HQYIHnri6ZZEP3RGoaO+jaK
        TmEdoJ8Z57gCOUuo0tT7YyKf3iTcLKg6bFfDvnw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607950165;
        bh=XhgKhK7Njh5RT/CQ5PItmzp13WD7BGx9W7NVLDTxC4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bvAzRxAfXiafMmOZ78+AtTa0/MbGqQ3C6P7IfXuF1gUlyIg4+lESxfPDZTuML0OV1
         3FxdCmy5TjJTSmDt956suDBWigSGlRZS+UbhcjibGkIxJXwYfccPfcMR/s0uue66Iw
         RnblJJUKJVUnz3SzGV2hrw0nGKcJNci0OHoCXH9uGpvU3I628DfriS0XgxvP6fC0ug
         9l6mCRpGQKLZcudL+bZRRUjKQqZ4l6sd+Z6tZyAMeOg266WoCE9JpggQi3MQr7AN9H
         1n2q1osW2S60PWmS5wtOdD785ZxGy8YJPq1WPuBRLlVITpXE5+r51zOFH1Dcy9kpu8
         CZm4qgyBdDdlQ==
X-Google-Smtp-Source: ABdhPJwS5aNadcQWu2+nHwjFU7/V16x3ZsRYZdU/+f73suKpTJNLJneJtjo15kQfdhqTljmgqaPAIQXeqID53htvoNY=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr10726115ots.251.1607950165001;
 Mon, 14 Dec 2020 04:49:25 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
 <20201211093205.GU2414@hirez.programming.kicks-ass.net> <20201211163748.b37gashl6an6misu@treble>
 <20201211164915.GA2414@hirez.programming.kicks-ass.net> <20201211174610.2bfprpvrrlg66awd@treble>
 <CAKwvOdkWU3qQ_m3v1xn1Mm6+obC202NWEaF8g_gz3oqeeLkMQA@mail.gmail.com> <CAKwvOdmVq2StZbKZ0eaLEZmrPMgRUJMZFso+2G8tLJA_Nd-swA@mail.gmail.com>
In-Reply-To: <CAKwvOdmVq2StZbKZ0eaLEZmrPMgRUJMZFso+2G8tLJA_Nd-swA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 14 Dec 2020 13:49:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2NudGg_i7AMMF67mcFy-UD3RZbUwdWOm5Wv0AUQ0nLLQ@mail.gmail.com>
Message-ID: <CAK8P3a2NudGg_i7AMMF67mcFy-UD3RZbUwdWOm5Wv0AUQ0nLLQ@mail.gmail.com>
Subject: Re: objtool crashes with some clang produced .o files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/xfrm/xfrm_output.o: warning: objtool: xfrm_output_resume()+0xdb4:
unreachable instruction
On Sat, Dec 12, 2020 at 1:42 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, Dec 11, 2020 at 12:57 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Thanks for the patch!
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1207
>
> Arnd reported another objtool warning/error from another randconfig in
> https://github.com/ClangBuiltLinux/linux/issues/1209 and CrOS just hit
> this as well.
>
> I haven't been able to isolate the configs yet (Arnd has posted the
> full config: https://pastebin.com/wwwhUL8L
>
> $ ./tools/objtool/objtool orc generate  --no-fp --no-unreachable
> --retpoline arch/x86/entry/thunk_64.o
> arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn
> at offset 0x3e
>
> Is the offset 0x3e referring to the final `ret` instruction in
> preempt_schedule_notrace_thunk?  Observing insn_to_reloc_sym_addend()
> (with your patch applied), it looks like both calls to
> find_symbol_containing() with offset and offset-1 returns NULL.  I'm
> curious if there's another quirk going on here, or possibly a config
> from the randconfig that's messing up the special case? I don't follow
> the comment about:
> 119        * Hack alert.  This happens when we need to reference
> 120        * the NOP pad insn immediately after the function.
> 121        */
>
> Attached the object file FWIW.

For completeness, these are the ones I currently see using clang-11
and clang-12, I believe
I have reported each one in the past:

1. For each file in kernel/trace/
kernel/trace/trace_clock.o: warning: objtool:
__llvm_gcov_writeout()+0x7: call without frame pointer save/setup
kernel/trace/trace_clock.o: warning: objtool: __llvm_gcov_reset()+0x0:
call without frame pointer save/setup
kernel/trace/trace_clock.o: warning: objtool: __llvm_gcov_flush()+0x0:
call without frame pointer save/setup
kernel/trace/trace_clock.o: warning: objtool: __llvm_gcov_init()+0x0:
call without frame pointer save/setup

2) reiserfs_panic()
fs/reiserfs/do_balan.o: warning: objtool: replace_key()+0x3db: stack
state mismatch: cfa1=7+104 cfa2=7+128
fs/reiserfs/do_balan.o: warning: objtool: balance_leaf()+0xd80d: stack
state mismatch: cfa1=7+424 cfa2=7+440
fs/reiserfs/lbalance.o: warning: objtool:
leaf_copy_boundary_item()+0x2bc5: stack state mismatch: cfa1=7+248
cfa2=7+240
fs/reiserfs/lbalance.o: warning: objtool:
leaf_copy_items_entirely()+0xcda: stack state mismatch: cfa1=7+256
cfa2=7+248
fs/reiserfs/ibalance.o: warning: objtool: balance_internal()+0x3448:
stack state mismatch: cfa1=7+328 cfa2=7+336
fs/reiserfs/ibalance.o: warning: objtool:
internal_move_pointers_items()+0x7c1: stack state mismatch: cfa1=7+200
cfa2=7+192

3) unreachable instructions:
arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0xb95:
unreachable instruction
net/xfrm/xfrm_output.o: warning: objtool: xfrm_output_resume()+0xdb4:
unreachable instruction
drivers/hwmon/pmbus/adm1275.o: warning: objtool:
adm1275_probe()+0x622: unreachable instruction
drivers/xen/privcmd.o: warning: objtool: mmap_batch_fn()+0x14d:
unreachable instruction
drivers/xen/privcmd.o: warning: objtool:
privcmd_ioctl_mmap_batch()+0x954: unreachable instruction
lib/string.o: warning: objtool: fortify_panic()+0x3: unreachable instruction
drivers/scsi/smartpqi/smartpqi_init.o: warning: objtool:
pqi_shutdown()+0x244: unreachable instruction

4) jitterentropy built with -O0:
crypto/jitterentropy.o: warning: objtool: tsan.module_ctor()+0x0: call
without frame pointer save/setup

5) unsafe_put_user() misoptimization
arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x4c7:
call to memset() with UACCESS enabled
arch/x86/ia32/ia32_signal.o: warning: objtool:
ia32_setup_rt_frame()+0x15b: call to memset() with UACCESS enabled

6) user_access_save()/restore() problem in ftrace
kernel/trace/trace_branch.o: warning: objtool:
ftrace_likely_update()+0x1ed: call to __stack_chk_fail() with UACCESS
enabled

7) sibling calls:
mm/vmscan.o: warning: objtool: shrink_node()+0x540: sibling call from
callable instruction with modified stack frame
drivers/spi/spi-rockchip.o: warning: objtool:
rockchip_spi_transfer_one()+0x2e0: sibling call from callable
instruction with modified stack frame
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
check_relocations()+0x68: return with modified stack frame

8) i915 GEM_BUG_ON() stack state mismatch (same as reiserfs_panic()):
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
check_relocations()+0x145: stack state mismatch: cfa1=7+48 cfa2=-1+0
drivers/gpu/drm/i915/gem/i915_gem_mman.o: warning: objtool:
__igt_mmap_revoke()+0x180: stack state mismatch: cfa1=7+48 cfa2=-1+0

9) kasan build, for each file:
     arch/x86/entry/vdso/vma.o: warning: objtool:
asan.module_ctor()+0xc: call without frame pointer save/setup
     arch/x86/entry/vdso/vma.o: warning: objtool:
asan.module_dtor()+0xc: call without frame pointer save/setup
     arch/x86/entry/vsyscall/vsyscall_64.o: warning: objtool:
asan.module_ctor()+0xc: call without frame pointer save/setup
     arch/x86/entry/vsyscall/vsyscall_64.o: warning: objtool:
asan.module_dtor()+0xc: call without frame pointer save/setup
     arch/x86/events/amd/core.o: warning: objtool:
asan.module_ctor()+0xc: call without frame pointer save/setup
     arch/x86/events/amd/core.o: warning: objtool:
asan.module_dtor()+0xc: call without frame pointer save/setup
     arch/x86/events/amd/ibs.o: warning: objtool:
asan.module_ctor()+0xc: call without frame pointer save/setup
     arch/x86/events/amd/ibs.o: warning: objtool:
asan.module_dtor()+0xc: call without frame pointer save/setup

        Arnd
