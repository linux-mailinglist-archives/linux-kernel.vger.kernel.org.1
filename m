Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41AC2F6D09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbhANVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbhANVT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:19:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A72A623A50;
        Thu, 14 Jan 2021 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610659127;
        bh=BrJPgq6l56uubqM18BQiREgQCz/KBbMOrPmN8iJX6Jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Em6O1kBsyqHWuIfLFA/N5t4mC7hDuNwrTPyDt3ifXB+FPVmutrVNE32U3itCz4VP/
         pEMu7BmU0EiZAN0wzTlUgiTcoyQMzCx7TlxoT7KRQslUJ8o182EypBwVq4CmuA6flQ
         TIPn6r05r3nKrNNuxInorRtcaFGFMG4m281CrLaT2bkFrDSfWl5LoBZZCigLEoYM+a
         mRdZ++uRJkrNHxPthzZiHRiJ3PuW89V0otuVKzAApQTNYm4B1q/UoHwaVB76Cs0RRE
         QjfSgdJVHPqxkPZHYKqP2pRGrJkA3bVEu3U2U0xOQOk54i1AAubEiXC3rw4eXDeFqW
         ARXEzV28JMQng==
Date:   Thu, 14 Jan 2021 22:18:42 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <melver@google.com>
Subject: Re: [PATCH] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
Message-ID: <20210114211840.GA5617@linux-8ccs>
References: <20210114054831.343327-1-maskray@google.com>
 <20210114140621.GA15904@linux-8ccs>
 <CAFP8O3Liydjn=6PwaDdYAhtMS1zC3=aKW6oq6UBOXGr9HKoQ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3Liydjn=6PwaDdYAhtMS1zC3=aKW6oq6UBOXGr9HKoQ1g@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Fāng-ruì Sòng [14/01/21 08:57 -0800]:
>On Thu, Jan 14, 2021 at 6:06 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> +++ Fangrui Song [13/01/21 21:48 -0800]:
>> >clang-12 -fno-pic (since
>> >https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
>> >can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
>> >on x86.  The two forms should have identical behaviors on x86-64 but the
>> >former causes GNU as<2.37 to produce an unreferenced undefined symbol
>> >_GLOBAL_OFFSET_TABLE_.
>> >
>> >(On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
>> >linker behavior is identical as far as Linux kernel is concerned.)
>> >
>> >Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
>> >scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
>> >problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` for
>> >external function calls on x86.
>> >
>> >Note: ld -z defs and dynamic loaders do not error for unreferenced
>> >undefined symbols so the module loader is reading too much.  If we ever
>> >need to ignore more symbols, the code should be refactored to ignore
>> >unreferenced symbols.
>> >
>> >Reported-by: Marco Elver <melver@google.com>
>> >Link: https://github.com/ClangBuiltLinux/linux/issues/1250
>> >Signed-off-by: Fangrui Song <maskray@google.com>
>> >---
>> > kernel/module.c | 10 ++++++++--
>> > 1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/kernel/module.c b/kernel/module.c
>> >index 4bf30e4b3eaa..2e2deea99289 100644
>> >--- a/kernel/module.c
>> >+++ b/kernel/module.c
>> >@@ -2395,8 +2395,14 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>> >                               break;
>> >                       }
>> >
>> >-                      /* Ok if weak.  */
>> >-                      if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
>> >+                      /* Ok if weak. Also allow _GLOBAL_OFFSET_TABLE_:
>> >+                       * GNU as before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_
>> >+                       * for call foo@PLT on x86-64.  If the code ever needs to ignore
>> >+                       * more symbols, refactor the code to only warn if referenced by
>> >+                       * a relocation.
>> >+                       */
>> >+                      if (!ksym && (ELF_ST_BIND(sym[i].st_info) == STB_WEAK ||
>> >+                                    !strcmp(name, "_GLOBAL_OFFSET_TABLE_")))
>> >                               break;
>>
>> Hi Fangrui,
>>
>> Thanks for the patch. I am puzzled why we don't already mirror modpost
>> here, that particular line of code in modpost to ignore _GLOBAL_OFFSET_TABLE_
>> has been there long before my time. Let's properly mirror modpost
>> then, and create a similar helper function ignore_undef_symbol() (and
>> stick the _GLOBAL_OFFSET_TABLE_ check in there) to account for future
>> cases like this.
>>
>> Thanks,
>>
>> Jessica
>
>Hi Jessica,
>
>I guess __this_module in scripts/mod/modpost.c:ignore_undef_symbol is
>not a problem.
>For PPC64 _restgpr0_* and _savegpr0_*, I am not sure ignoring the
>undefined functions in kernel/module.c is right.
>(I know they can be produced by gcc -Os in some cases
>(https://reviews.llvm.org/D79977), but I want to learn whether that is
>a real issue before adding them.)
>
>If we ever need to ignore more symbols, the code should be refactored
>to not warn for unreferenced undefined symbols as my description says.

Hi Fangrui,

Sorry for the confusion, I did not mean to exactly mirror
ignore_undef_symbol() in modpost. The conditions are different there
and not all of them would not apply to kernel/module.c. Like
__this_module, as you say, is not a problem as this will be resolved
once all the module *.o are linked in the final .ko. So when it
reaches the module loader it would no longer be UNDEF. I assume that
it is a similar situation for the PPC64 symbols.

What I meant that we could probably make this patch look nicer by
moving the hardcoded check for "_GLOBAL_OFFSET_TABLE_" to a helper
function ignore_undef_symbol(), similar to how modpost does it,
without adding any additional conditions for now. And yes, if we ever
need to extend this and refactor to not warn for unreferenced
undefined symbols, we should refactor to generalize this case, but for
the scope of this patch I think the suggested change is sufficient for
now.

Thank you,

Jessica
