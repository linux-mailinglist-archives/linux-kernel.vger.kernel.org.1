Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162352F62B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbhANOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbhANOHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:07:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B5BF23A69;
        Thu, 14 Jan 2021 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610633187;
        bh=bAYELvIG7I8zVi2HFRgsyj9ehliYdNEQMQDaCGmkLiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ravwqlsbBGOkiPgs97Qs4AfJ4uCrsNBH4b2Mv3aCSnztRkVS/ENISW05KXGjoUzDj
         WiUCG2ZTvo0yXCpXQTTgLtYwEHOzILCplypXnyScCaL63+4Azg/Xlkz6j9lAMin06J
         rGkSN9WZrXQOs6VsegSOs9hzizi8W11UHHBV7YXeHn/WjY095xNdeWCtqMfIsC9P0g
         JUhurmf04WmomnSgiZ8oZtbq2ZiCbKQRGi1MxNtOqahoyxpNc6bf4VGJMEk4yK4Zig
         T/Ob8BBhdFPkTICmVnigIYe6LBslBLADZcjBQbCHqWa6OIPcZuJ9W2WtFQ8bLQPS14
         u36KNqjfi6nRA==
Date:   Thu, 14 Jan 2021 15:06:22 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Fangrui Song <maskray@google.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Marco Elver <melver@google.com>
Subject: Re: [PATCH] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
Message-ID: <20210114140621.GA15904@linux-8ccs>
References: <20210114054831.343327-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210114054831.343327-1-maskray@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Fangrui Song [13/01/21 21:48 -0800]:
>clang-12 -fno-pic (since
>https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
>can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
>on x86.  The two forms should have identical behaviors on x86-64 but the
>former causes GNU as<2.37 to produce an unreferenced undefined symbol
>_GLOBAL_OFFSET_TABLE_.
>
>(On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
>linker behavior is identical as far as Linux kernel is concerned.)
>
>Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
>scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
>problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` for
>external function calls on x86.
>
>Note: ld -z defs and dynamic loaders do not error for unreferenced
>undefined symbols so the module loader is reading too much.  If we ever
>need to ignore more symbols, the code should be refactored to ignore
>unreferenced symbols.
>
>Reported-by: Marco Elver <melver@google.com>
>Link: https://github.com/ClangBuiltLinux/linux/issues/1250
>Signed-off-by: Fangrui Song <maskray@google.com>
>---
> kernel/module.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 4bf30e4b3eaa..2e2deea99289 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2395,8 +2395,14 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
> 				break;
> 			}
>
>-			/* Ok if weak.  */
>-			if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
>+			/* Ok if weak. Also allow _GLOBAL_OFFSET_TABLE_:
>+			 * GNU as before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_
>+			 * for call foo@PLT on x86-64.  If the code ever needs to ignore
>+			 * more symbols, refactor the code to only warn if referenced by
>+			 * a relocation.
>+			 */
>+			if (!ksym && (ELF_ST_BIND(sym[i].st_info) == STB_WEAK ||
>+				      !strcmp(name, "_GLOBAL_OFFSET_TABLE_")))
> 				break;

Hi Fangrui,

Thanks for the patch. I am puzzled why we don't already mirror modpost
here, that particular line of code in modpost to ignore _GLOBAL_OFFSET_TABLE_
has been there long before my time. Let's properly mirror modpost
then, and create a similar helper function ignore_undef_symbol() (and
stick the _GLOBAL_OFFSET_TABLE_ check in there) to account for future
cases like this.

Thanks,

Jessica
