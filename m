Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9F2F7423
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbhAOIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbhAOIP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:15:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 513C52072D;
        Fri, 15 Jan 2021 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610698487;
        bh=VDBSNkhjih0ytWUhVsQuY2EtZRagprXKw9fTDS9CCDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3lziUWJc66mIc65O04sk7hiw5QKBQL2GnpTYf7OeJhH83aiZdrSjYpLSQChdhI/D
         N/2QP9z8AnLTX2s+diTRuSWpiSahvJJes6J7PDPmp+SuctM1tpkr+IZkjvdPkGDDKF
         tGF60IlD3kaGZMWWzIqB3xN0ZRj8SduaI5Wywp4qdbLtYirNlth9b12GmSR/Gxm2kA
         z4Uzsfm6h94mYE9ioqzRbbtvkIsT0lVfKJGdSICvuRKCt0c2WpA9HVwHZWWWM/elI9
         upDpmBtLAyLmLDRuoP7QKdVGe+Muej35iQ2jTrApVOxtxUhieE5YjKH/vc1hR9PZll
         kPhuUrP33HRTw==
Date:   Fri, 15 Jan 2021 09:14:42 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
Message-ID: <20210115081442.GB9637@linux-8ccs>
References: <20210114211840.GA5617@linux-8ccs>
 <20210114215416.993167-1-maskray@google.com>
 <CANpmjNOrD76O2_Zpwo5RJ2d12gczuQpG9bJkXYLY_sOVeEVZGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANpmjNOrD76O2_Zpwo5RJ2d12gczuQpG9bJkXYLY_sOVeEVZGQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Marco Elver [15/01/21 08:03 +0100]:
>On Thu, 14 Jan 2021 at 22:54, Fangrui Song <maskray@google.com> wrote:
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
>Tested-by: Marco Elver <elver@google.com>
>
>Thank you for the patch!
>
>> ---
>>  kernel/module.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>> ---
>> Changes in v2:
>> * Fix Marco's email address
>> * Add a function ignore_undef_symbol similar to scripts/mod/modpost.c:ignore_undef_symbol
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 4bf30e4b3eaa..278f5129bde2 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2348,6 +2348,20 @@ static int verify_exported_symbols(struct module *mod)
>>         return 0;
>>  }
>>
>> +static int ignore_undef_symbol(Elf_Half emachine, const char *name)
>
>Why not 'bool' return-type?
>
>> +{
>> +       /* On x86, PIC code and Clang non-PIC code may have call foo@PLT. GNU as
>
>Not sure if checkpatch.pl warns about this, but this multi-line
>comment does not follow the normal kernel-style (see elsewhere in
>file):
>
>/*
> * ...
> */

+1 to Marco's comments. Otherwise, patch looks good to me.

Thanks Fangrui!

Jessica

