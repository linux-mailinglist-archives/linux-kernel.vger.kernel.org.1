Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43F203E21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgFVRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:37:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50654 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729857AbgFVRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:37:21 -0400
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFBCF1EC0283;
        Mon, 22 Jun 2020 19:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592847440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9f05Lxtpz3Otb1ah/vQVmeZ2BZZPOnMN3XK5Vp8OA4=;
        b=eoL7ELdRogcOXPrnd+8O49gqKzSk6Ue0CChxRf4MVBsTdH5Bs4d9eLw/QziQ3Q6dQZR2Bk
        GPOiBjzwVFKeOaLEVbIMnQCn+K/djNl9/leDoN3oQ1Amw7n1utV3F3B5GP1IaH5/LL6tpO
        SPv8FdobWVeKBcq4YvFDi8fEY7oBRQE=
Date:   Mon, 22 Jun 2020 19:37:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v33 01/21] x86/cpufeatures: x86/msr: Add Intel SGX
 hardware bits
Message-ID: <20200622173711.GJ32200@zn.tnic>
References: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
 <20200617220844.57423-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617220844.57423-2-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:08:23AM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add X86_FEATURE_SGX from CPUID.(EAX=7, ECX=1), which informs whether the
> CPU has SGX.
> 
> Add X86_FEATURE_SGX1 and X86_FEATURE_SGX2 from CPUID.(EAX=12H, ECX=0),
> which describe the level of SGX support available [1].
> 
> Add IA32_FEATURE_CONTROL_SGX_ENABLE. BIOS can use this bit to opt-in SGX

I'm guessing that wants to be

IA32_FEATURE_CONTROL.SGX_ENABLE

judging by the diff and the SDM chapter.

> before locking the feature control MSR [2].
> 
> [1] Intel SDM: 36.7.2 Intel® SGX Resource Enumeration Leaves
> [2] Intel SDM: 36.7.1 Intel® SGX Opt-In Configuration
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Jethro Beekman <jethro@fortanix.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeature.h        |  5 +++--
>  arch/x86/include/asm/cpufeatures.h       |  7 ++++++-
>  arch/x86/include/asm/disabled-features.h | 18 +++++++++++++++---
>  arch/x86/include/asm/msr-index.h         |  1 +
>  arch/x86/include/asm/required-features.h |  2 +-
>  arch/x86/kernel/cpu/common.c             |  4 ++++
>  tools/arch/x86/include/asm/cpufeatures.h |  7 ++++++-

Also, please drop this change to tools/, see

https://lkml.kernel.org/r/20200622141737.GA30611@kernel.org

from today.

With those addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
