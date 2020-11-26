Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1848D2C5A75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404408AbgKZRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:23:48 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:52623 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404314AbgKZRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:23:47 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2020 12:23:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1606411427;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=30eEf+LXDGboAMJuVJgnrOE10nGpyifLpuzbpTyE6v0=;
  b=WNl/M0luAhGWvKcSbVrRe/K9Z9AkjyHQrUkSu3nt4+qQG0VsfmDkRHLK
   nIjZWwN1lNZRiS2Mr7s5z2JT5vEnT8T31r6uUu72WcKzLv+/VjUfFYJkj
   4FHQLPQeRQ1zi88CPznUaOkKLz4ofOQI/NH/JAesXcU4evauYqeIbb3xj
   w=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 1KWvzA3XKYqmExMrRgkDqSUSq8jWif4zd6yFt6Bw43YNYZPO7mwMd6sqbgcfgGDIlWolnz/bgH
 97J3MzPUyjNH39hGUqf+BPnmz1OvW/XS+Q+zoQfCDAQJznrsWedNLptB+vuFa7JLz7wjKSLgVl
 rK6LwSAcLnpt+qOoA7YD8YwYVq6O8cATiMiJaFMFlfuAYQUlEscXDZurWzA92M17EgW+ndQgNC
 Ng4/9/qz9HFWY7y86FVz81DhTpKAMJn6qo9rznnlxzkskKGsEhIstko1Y9etuOrno+ZdP+KlHw
 U3A=
X-SBRS: None
X-MesageID: 32232619
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.78,372,1599537600"; 
   d="scan'208";a="32232619"
Subject: Re: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
        Joerg Roedel <jroedel@suse.de>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201126115459.28980-1-lukas.bulwahn@gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <947b02eb-536f-16a0-fbb1-87b62ab8c13e@citrix.com>
Date:   Thu, 26 Nov 2020 17:16:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126115459.28980-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL04.citrite.net (10.13.108.177)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2020 11:54, Lukas Bulwahn wrote:
> Commit 1e5de18278e6 ("x86: Introduce GDT_ENTRY_INIT()") unintentionally
> transformed a few 0xffff values to 0xfffff (note: five times "f" instead of
> four) as part of the refactoring.

The transformation in that change is correct.

Segment bases are 20 bits wide in x86, but the top nibble is folded into
the middle of the attributes, which is why the transformation also has
xfxx => x0xx for the attributes field.

>
> A quick check with:
>
>   git show 1e5de18278e6 | grep "fffff"
>
> reveals all those 14 occurrences:
>
>     12 in ./arch/x86/kernel/cpu/common.c, and
>     2  in ./arch/x86/include/asm/lguest.h.
>
> The two occurrences in ./arch/x86/include/asm/lguest.h were deleted with
> commit ecda85e70277 ("x86/lguest: Remove lguest support").
> Correct the remaining twelve occurrences in ./arch/x86/kernel/cpu/common.c
> back to the original values in the source code before the refactoring.
>
> Commit 866b556efa12 ("x86/head/64: Install startup GDT") probably simply
> copied the required startup gdt information from
> ./arch/x86/kernel/cpu/common.c to ./arch/x86/kernel/head64.c.
> So, correct those three occurrences in ./arch/x86/kernel/head64.c as well.
>
> As this value is truncated anyway, the object code has not changed when
> introducing the mistake and is also not changed with this correction now.
>
> This was discovered with sparse, which warns with:
>
>   warning: cast truncates bits from constant value (fffff becomes ffff)

Does:

diff --git a/arch/x86/include/asm/desc_defs.h
b/arch/x86/include/asm/desc_defs.h
index f7e7099af595..9561f3c66e9e 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -22,7 +22,7 @@ struct desc_struct {
 
 #define GDT_ENTRY_INIT(flags, base, limit)                     \
        {                                                       \
-               .limit0         = (u16) (limit),                \
+               .limit0         = (u16) (limit) & 0xFFFF,       \
                .limit1         = ((limit) >> 16) & 0x0F,       \
                .base0          = (u16) (base),                 \
                .base1          = ((base) >> 16) & 0xFF,        \

fix the warning?

Changing the limit from 4G to 128M isn't going to be compatible with a
32bit kernel trying to boot :).

~Andrew
