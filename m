Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D3268F86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgINPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:19:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbgINPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600096718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMJxm1Jc4Nh4jqXOW2pJdv2KoBRQRvljHLhhxY9jovQ=;
        b=Vlp2Sh0y+QO39wIUYvF/WwYTBgyvBfcnjhFgzBCC/gGcH97XPgza2KhcDsBBLzee5UY08l
        i98xjYOMS0F2xy/r7Q4UKWmLe+AFLcGmCq2SVDSUkKXC/BXlz29CcZU+hEObxPymTvkQTO
        1MfF9UtH44SrN2qnsvc6s9xO1WBgHCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-kWZZv6VSMEWPsPqBURmLLQ-1; Mon, 14 Sep 2020 11:18:34 -0400
X-MC-Unique: kWZZv6VSMEWPsPqBURmLLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8B41009466;
        Mon, 14 Sep 2020 15:18:30 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BE9D75139;
        Mon, 14 Sep 2020 15:18:17 +0000 (UTC)
Date:   Mon, 14 Sep 2020 10:18:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v37 02/24] x86/cpufeatures: x86/msr: Add Intel SGX Launch
 Control hardware bits
Message-ID: <20200914151816.u6camicid4bd5lgo@treble>
References: <20200911124019.42178-1-jarkko.sakkinen@linux.intel.com>
 <20200911124019.42178-3-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911124019.42178-3-jarkko.sakkinen@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarko,

It looks like some of the patches weren't delivered to the lists.
Patches 0, 1, 8, 9, and 17 seem to be missing.

Lore agrees with me:

  https://lore.kernel.org/linux-sgx/20200911124019.42178-1-jarkko.sakkinen@linux.intel.com/

On Fri, Sep 11, 2020 at 03:39:57PM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add X86_FEATURE_SGX_LC, which informs whether or not the CPU supports SGX
> Launch Control.
> 
> Add MSR_IA32_SGXLEPUBKEYHASH{0, 1, 2, 3}, which when combined contain a
> SHA256 hash of a 3072-bit RSA public key. SGX backed software packages, so
> called enclaves, are always signed. All enclaves signed with the public key
> are unconditionally allowed to initialize. [1]
> 
> Add FEAT_CTL_SGX_LC_ENABLED, which informs whether the aformentioned MSRs
> are writable or not. If the bit is off, the public key MSRs are read-only
> for the OS.
> 
> If the MSRs are read-only, the platform must provide a launch enclave (LE).
> LE can create cryptographic tokens for other enclaves that they can pass
> together with their signature to the ENCLS(EINIT) opcode, which is used
> to initialize enclaves.
> 
> Linux is unlikely to support the locked configuration because it takes away
> the control of the launch decisions from the kernel.
> 
> [1] Intel SDM: 38.1.4 Intel SGX Launch Control Configuration
> 
> Reviewed-by: Borislav Petkov <bp@alien8.de>
> Acked-by: Jethro Beekman <jethro@fortanix.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/msr-index.h   | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 159b635159c0..398e4f19c3d7 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -354,6 +354,7 @@
>  #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
>  #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
>  #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
> +#define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Launch Control */
>  
>  /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
>  #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index c0b04f020162..e574b4bb5aad 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -602,6 +602,7 @@
>  #define FEAT_CTL_LOCKED				BIT(0)
>  #define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
>  #define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
> +#define FEAT_CTL_SGX_LC_ENABLED			BIT(17)
>  #define FEAT_CTL_SGX_ENABLED			BIT(18)
>  #define FEAT_CTL_LMCE_ENABLED			BIT(20)
>  
> @@ -622,6 +623,12 @@
>  #define MSR_IA32_UCODE_WRITE		0x00000079
>  #define MSR_IA32_UCODE_REV		0x0000008b
>  
> +/* Intel SGX Launch Enclave Public Key Hash MSRs */
> +#define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
> +#define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
> +#define MSR_IA32_SGXLEPUBKEYHASH2	0x0000008E
> +#define MSR_IA32_SGXLEPUBKEYHASH3	0x0000008F
> +
>  #define MSR_IA32_SMM_MONITOR_CTL	0x0000009b
>  #define MSR_IA32_SMBASE			0x0000009e
>  
> -- 
> 2.25.1
> 

-- 
Josh

