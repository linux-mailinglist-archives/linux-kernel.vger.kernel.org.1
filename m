Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0155D29AA71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420872AbgJ0LUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:20:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899103AbgJ0LUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:20:10 -0400
Received: from zn.tnic (p200300ec2f0dae00bd0b3d5f265e51fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:bd0b:3d5f:265e:51fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 586BB1EC025D;
        Tue, 27 Oct 2020 12:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603797609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YLEMlU2F8JKFCfKj2+E02GhRKUEkIfqvoLDcNUn3MA=;
        b=lqVSS+BkCGJtG3m0XVNSdto5pBZSNXrIBPqXa+4nxntBxWg7Ibl9eYR6k4BM0m7bGedhrG
        /T4hmH88NTIZG5Uttg0owoRAKpvlkddHGY3L/RwxdUjeGlZarfnb0CCkw1K2z1CWdumHyQ
        DlgyTSmA9pfsZ+TcdXqFAfwCRPw3HaM=
Date:   Tue, 27 Oct 2020 12:20:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] x86/head/64: Check SEV encryption before
 switching to kernel page-table
Message-ID: <20201027112001.GE15580@zn.tnic>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-5-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201021123938.3696-5-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:39:37PM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index ebb7edc8bc0a..bd9b62af2e3d 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -39,6 +39,7 @@
>   */
>  u64 sme_me_mask __section(.data) = 0;
>  u64 sev_status __section(.data) = 0;
> +u64 sev_check_data __section(.data) = 0;

Apparently section names are supposed to be given as strings now:

In file included from ././include/linux/compiler_types.h:65,
                 from <command-line>:
arch/x86/mm/mem_encrypt.c:42:30: error: expected expression before ‘.’ token
   42 | u64 sev_check_data __section(.data) = 0;
      |                              ^
./include/linux/compiler_attributes.h:257:68: note: in definition of macro ‘__section’
  257 | #define __section(section)              __attribute__((__section__(section)))
      |                                                                    ^~~~~~~
arch/x86/mm/mem_encrypt.c:42:30: error: section attribute argument not a string constant
   42 | u64 sev_check_data __section(.data) = 0;
      |                              ^
./include/linux/compiler_attributes.h:257:68: note: in definition of macro ‘__section’
  257 | #define __section(section)              __attribute__((__section__(section)))
      |                                                                    ^~~~~~~
make[2]: *** [scripts/Makefile.build:283: arch/x86/mm/mem_encrypt.o] Error 1
make[1]: *** [scripts/Makefile.build:500: arch/x86/mm] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1799: arch/x86] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
