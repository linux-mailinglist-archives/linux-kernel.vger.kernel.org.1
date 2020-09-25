Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2114E2789D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgIYNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:41:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgIYNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:41:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E44DFB2FE;
        Fri, 25 Sep 2020 13:41:50 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:41:49 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sev-es: Use GHCB accessor for setting the MMIO
 scratch buffer
Message-ID: <20200925134149.GI31722@suse.de>
References: <ba84deabdf44a7a880454fb351d189c6ad79d4ba.1601041106.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba84deabdf44a7a880454fb351d189c6ad79d4ba.1601041106.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 08:38:26AM -0500, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Use ghcb_set_sw_scratch() to set the GHCB scratch field, which will also
> set the corresponding bit in the GHCB valid_bitmap field.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/sev-es.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 6fcfdd32769f..4a96726fbaf8 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -751,7 +751,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  	/* Can never be greater than 8 */
>  	exit_info_2 = bytes;
>  
> -	ghcb->save.sw_scratch = ghcb_pa + offsetof(struct ghcb, shared_buffer);
> +	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));

Reviewed-by: Joerg Roedel <jroedel@suse.de>

Thanks for catching this!

