Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D83293285
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 02:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbgJTA7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 20:59:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:28385 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389721AbgJTA7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 20:59:33 -0400
IronPort-SDR: nsE4OjVmrlwQ9Noj/TZzTVCrUnHGX3Xqj2BV8ufzSOqh8O7I0w7onv8R+t2qlGDYZDN7gL8jo0
 802YmxSedspw==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="184750426"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="184750426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 17:59:29 -0700
IronPort-SDR: y2bhiDTElEd/tbWCJaH2tOhg6qMOVMLXC/AcIjf/9KhQjX1lmeAj6jRsHlRCkDgi867okATlMa
 bMDJRwajUL6Q==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="359004321"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 17:59:29 -0700
Date:   Mon, 19 Oct 2020 17:59:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201020005925.GA24596@linux.intel.com>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019151121.826-2-joro@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 05:11:17PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce sev_status and initialize it together with sme_me_mask to have
> an indicator which SEV features are enabled.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/mem_encrypt.S | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index dd07e7b41b11..0effd58f0095 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -71,6 +71,8 @@ SYM_FUNC_END(get_sev_encryption_bit)
>  SYM_FUNC_START(set_sev_encryption_mask)
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	push	%rbp
> +	push	%rax
> +	push	%rcx

There's no need to save/restore RAX and RCX, they are callee save.  This
function is only called from C, so I doubt it's using a custom ABI.

>  	push	%rdx
>  
>  	movq	%rsp, %rbp		/* Save current stack pointer */
> @@ -81,10 +83,19 @@ SYM_FUNC_START(set_sev_encryption_mask)
>  
>  	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
>  
> +	/* Read sev_status */
> +	movl	$MSR_AMD64_SEV, %ecx
> +	rdmsr
> +	shlq	$32, %rdx
> +	orq	%rdx, %rax
> +	movq	%rax, sev_status(%rip)
> +
>  .Lno_sev_mask:
>  	movq	%rbp, %rsp		/* Restore original stack pointer */
>  
>  	pop	%rdx
> +	pop	%rcx
> +	pop	%rax
>  	pop	%rbp
>  #endif
>  
> @@ -96,5 +107,6 @@ SYM_FUNC_END(set_sev_encryption_mask)
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	.balign	8
> -SYM_DATA(sme_me_mask, .quad 0)
> +SYM_DATA(sme_me_mask,		.quad 0)
> +SYM_DATA(sev_status,		.quad 0)
>  #endif
> -- 
> 2.28.0
> 
