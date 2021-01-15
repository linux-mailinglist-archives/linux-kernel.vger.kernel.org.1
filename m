Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D202F7408
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbhAOIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbhAOIKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:10:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED103221E9;
        Fri, 15 Jan 2021 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610698165;
        bh=Mq/LTukrC0t3iHVpjub9KIF5jll7ihy+9U7R71ci734=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sciVsVPcKNtoAmAZUP47NaO7j3y4z02VjQlVZdZu5cGXUqlf+Xi1neW9JE++SfpWX
         wGhiuzgWWY98zuD8lYfyyXQI3MsXwVGoR48s8a7PBCVqG718XlpG/Qrxy9E30r6mKO
         Um/7+yBEwaSfRbQLnFqAWu3+nxZlAC73qaa1nuDPCVPr0d1gGGWXIYSYo7gHf9hWyv
         w/zqgMsgG2B6+OecEAVjo/LCIgU5dRak0ukKyaqunIZUjomYCqKem6DN5bofB5KAc5
         Yberl18nHnF5npmPzcL0VBdh0xLD7sRUfpRNl/lYhpvOhmmJxjYIAkBPk9pKaqQyJU
         lZsfGczkkwxlQ==
Date:   Fri, 15 Jan 2021 09:09:20 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sam Ravnborg <sam@ravnborg.org>, Marco Elver <elver@google.com>
Subject: Re: [PATCH v2] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
Message-ID: <20210115080920.GA9637@linux-8ccs>
References: <20210114211840.GA5617@linux-8ccs>
 <20210114215416.993167-1-maskray@google.com>
 <CAKwvOdnG8VP2n0E5UiM+txxN6SJp-MOMfNqawqtrCi04BettHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdnG8VP2n0E5UiM+txxN6SJp-MOMfNqawqtrCi04BettHg@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Nick Desaulniers [14/01/21 14:01 -0800]:
>On Thu, Jan 14, 2021 at 1:54 PM 'Fangrui Song' via Clang Built Linux
><clang-built-linux@googlegroups.com> wrote:
>>
>> clang-12 -fno-pic (since
>> https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
>> can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
>> on x86.  The two forms should have identical behaviors on x86-64 but the
>> former causes GNU as<2.37 to produce an unreferenced undefined symbol
>> _GLOBAL_OFFSET_TABLE_.
>>
>> (On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
>> linker behavior is identical as far as Linux kernel is concerned.)
>>
>> Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
>> scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
>> problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` for
>> external function calls on x86.
>>
>> Note: ld -z defs and dynamic loaders do not error for unreferenced
>> undefined symbols so the module loader is reading too much.  If we ever
>> need to ignore more symbols, the code should be refactored to ignore
>> unreferenced symbols.
>>
>> Reported-by: Marco Elver <elver@google.com>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1250
>> Signed-off-by: Fangrui Song <maskray@google.com>
>
>Thanks for the patch.
>
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Jessica, would you mind adding when applying:
>
>Cc: <stable@vger.kernel.org>
>
>as I suspect we might want this fixed in stable tree's branches, too.
>It might of interest to add:
>
>Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27178
>
>too.

Sure, will do!

Thanks,

Jessica

