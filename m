Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4562B5433
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgKPWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgKPWUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:20:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC79C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=rmbEOUuFUDWT2r+1h2dWrIdCOj079NG2OKQi9QhFvjo=; b=uMUcuSmEOxdvWusgeKZNV0Z0f9
        SgXsrlfEMxCC2e6ojKy55SnEgSh+KeEe2wKJYWK/txvvRyur0+leAhE61oRPiAv8tMtf9RZNr4kCK
        DSSEZACpbdMCNOUb/oyxPPec/Ftlc/NDcJPkqhcjxeswUXTplEo7HbObtI9fJse3Gt8LnSQ/qj4uq
        dVxBmL6vfXDhYEAMSmR9Gk5mX9QkiKZorkd7vwX1TrKa9iqN3yGFBHD720f46rNKcpxjJSGH34B4n
        pH3t+rgYArYo8gHcuVGozyscG9Wdik22z1OyfIbOxvJA6vMYA2Fm5O2MgmryMR8Y9msnjcpl/XFse
        VIXva19Q==;
Received: from [2601:1c0:6280:3f0::f32]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kemqs-0002AK-0r; Mon, 16 Nov 2020 22:19:58 +0000
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
 <87sg999ot0.fsf@igel.home>
 <0dbaca2d-9ad0-8c1a-a280-97be01cac2bd@infradead.org>
 <87k0ul9msr.fsf@igel.home>
 <3fff1eb9-83c0-1c29-6f57-fa50f1ec6ee7@infradead.org>
Message-ID: <3c0a8d26-a95f-a7ca-60ee-203b67d07875@infradead.org>
Date:   Mon, 16 Nov 2020 14:19:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3fff1eb9-83c0-1c29-6f57-fa50f1ec6ee7@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 11:28 AM, Randy Dunlap wrote:
> On 11/16/20 10:30 AM, Andreas Schwab wrote:
>> On Nov 16 2020, Randy Dunlap wrote:
>>
>>> What kernel version are you building?
>>
>> 5.10-rc4
>>
>> Andreas.
> 
> OK, thanks.
> 
> My build machine is slow, but I have a patch that I am testing:
> 
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> riscv's <vdso/processor.h> uses barrier() so it should
> #include <asm/barrier.h> to prevent build errors.
> 
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/riscv/include/asm/vdso/processor.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
> +++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
> @@ -4,6 +4,8 @@
> 
>  #ifndef __ASSEMBLY__
> 
> +#include <asm/barrier.h>
> +
>  static inline void cpu_relax(void)
>  {
>  #ifdef __riscv_muldiv


This fixes the emulex/benet/ driver build.
I'm still building allmodconfig to see if there are any
other issues.

-- 
~Randy

