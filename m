Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3867276389
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIWWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:07:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgIWWHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:07:21 -0400
Received: from zn.tnic (p200300ec2f0d13008640eb80b0e83752.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:8640:eb80:b0e8:3752])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 091F41EC046C;
        Thu, 24 Sep 2020 00:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600898840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E8svIU7KxoHoNsxMynX+D6tK+ukLxgLJ7PA+tbcM/pA=;
        b=XTa5xvpjcZqfro9vhdKzIrO/99egWdlfL8iZu34ovpVv8XE/8L5dRXuYZS6bgJSIGdlOHj
        CiplYR26U7zc9s3EnvUyIgcKyBjmJM6LSj2qlYp+YDLmV6n122YooGvh/bZeuLIGt82zQi
        O/emwBzB2PIm3HqK8AqxKRff3VjZ0u0=
Date:   Thu, 24 Sep 2020 00:07:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 18/24] x86/vdso: Add support for exception fixup in
 vDSO functions
Message-ID: <20200923220712.GU28545@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-19-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915112842.897265-19-jarkko.sakkinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:28:36PM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> The basic concept and implementation is very similar to the kernel's
> exception fixup mechanism.  The key differences are that the kernel
> handler is hardcoded and the fixup entry addresses are relative to
> the overall table as opposed to individual entries.

...

This gist of this commit message should be also in
Documentation/x86/sgx.rst

And I already said the same thing during v33 review:

"That is a very good explanation and I would prefer if it would be in a
sgx-specific README or so instead of it getting lost in git..."

...

> diff --git a/arch/x86/entry/vdso/extable.h b/arch/x86/entry/vdso/extable.h
> new file mode 100644
> index 000000000000..aafdac396948
> --- /dev/null
> +++ b/arch/x86/entry/vdso/extable.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_EXTABLE_H
> +#define __VDSO_EXTABLE_H
> +
> +/*
> + * Inject exception fixup for vDSO code.  Unlike normal exception fixup,
> + * vDSO uses a dedicated handler the addresses are relative to the overall
> + * exception table, not each individual entry.
> + */
> +#ifdef __ASSEMBLY__
> +#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
> +	ASM_VDSO_EXTABLE_HANDLE from to
> +
> +.macro ASM_VDSO_EXTABLE_HANDLE from:req to:req
> +	.pushsection __ex_table, "a"
> +	.long (\from) - __ex_table
> +	.long (\to) - __ex_table
> +	.popsection
> +.endm
> +#else
> +#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
> +	".pushsection __ex_table, \"a\"\n"      \
> +	".long (" #from ") - __ex_table\n"      \
> +	".long (" #to ") - __ex_table\n"        \
> +	".popsection\n"
> +#endif
> +
> +#endif /* __VDSO_EXTABLE_H */
> +

Also from last time:

.git/rebase-apply/patch:122: new blank line at EOF.
+


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
