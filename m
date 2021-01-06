Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BE2EC2E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAFSAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbhAFSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:00:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5043C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SbDlb62azLLErNtoLAgpM7mPyNJeiRp45EdLK5CGGD4=; b=jlJgy9quUkfhD0uBMbDHTgASdi
        BV02teSaG5hMnkMTonXbdvn+5MVuN98QQxNEidqrSS+nNuDtpEgvoVOOl9a+mt6UjmCwNRcfWs2gH
        +WFPmA6p5tz4vc2syFGcE1gC8nBXh738OYKvDOqGc9zyCXxwEwdLXYvz6G9uR077Vm9nXz6Goq0Of
        H/muwRx1mvpBwXb8FncWFiPhqTa2els/ULRFJRFEjYsFN/UEU2fIwhq0AvXRjxdcEdhdnfN5t/vY2
        YSTLtF7a94xp0DQ1wOrYlZv37GZkyw7anbxmGGoI7waHn11OTQ60sd5qD75Wk8FAon9AeFKnPCnoA
        re6+KmAg==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxD5f-0008TV-5O; Wed, 06 Jan 2021 17:59:23 +0000
Subject: Re: [PATCH 2/6] x86/sev: Fix nonistr violation
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        sfr@canb.auug.org.au, tony.luck@intel.com
References: <20210106143619.479313782@infradead.org>
 <20210106144017.532902065@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dc6e7e19-881a-c778-22df-15176db4aeb9@infradead.org>
Date:   Wed, 6 Jan 2021 09:59:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210106144017.532902065@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 6:36 AM, Peter Zijlstra wrote:
> When the compiler fails to inline; we violate nonisntr:
> 
>   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xc7: call to sev_es_wr_ghcb_msr() leaves .noinstr.text section

I am still seeing (a variant of) this one:

vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section

> gcc --version
gcc (SUSE Linux) 7.5.0


The other 2 that I reported are gone with all 6 patches applied.

> Fixes: 4ca68e023b11 ("x86/sev-es: Handle NMI State")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/sev-es.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -225,7 +225,7 @@ static inline u64 sev_es_rd_ghcb_msr(voi
>  	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
>  }
>  
> -static inline void sev_es_wr_ghcb_msr(u64 val)
> +static __always_inline void sev_es_wr_ghcb_msr(u64 val)
>  {
>  	u32 low, high;
>  
> 
> 


-- 
~Randy

