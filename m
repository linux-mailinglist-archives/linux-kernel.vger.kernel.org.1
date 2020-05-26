Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524CC1C7CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgEFVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 17:50:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:37627 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgEFVuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:50:50 -0400
IronPort-SDR: y3MzUdw3dkY54h0YwHTpUJomQUweU4DP0C14xEAFPSRk5SbEG0CHSHQDrzfRuN3ybDAr8XEokQ
 hnRQ2pqHS7bA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 14:50:49 -0700
IronPort-SDR: 5G8XdY4tOiPdm5joHaumsRQOl1rwSd60LdKvY92emy6QysvcKS/4UQOijPUKbKzaZgoKC1GklO
 WmCLCGbaYPQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="249902291"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2020 14:50:48 -0700
Date:   Wed, 6 May 2020 14:50:48 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v29 14/20] x86/sgx: ptrace() support for the SGX driver
Message-ID: <20200506215048.GJ3329@linux.intel.com>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
 <20200421215316.56503-15-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421215316.56503-15-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:53:10AM +0300, Jarkko Sakkinen wrote:
> Add VMA callbacks for ptrace() that can be used with debug enclaves.
> With debug enclaves data can be read and write the memory word at a time
> by using ENCLS(EDBGRD) and ENCLS(EDBGWR) leaf instructions.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 88 ++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index fe7dbca40bb4..0c5ea2968868 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -326,6 +326,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  	return 0;
>  }
>  
> +

Unnecessary whitespace change.

>  static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
>  			    unsigned long end, unsigned long prot)
>  {
