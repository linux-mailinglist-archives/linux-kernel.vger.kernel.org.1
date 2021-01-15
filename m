Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42CE2F7CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbhAONkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:40:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:56042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbhAONkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:40:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EAFEAC63;
        Fri, 15 Jan 2021 13:39:29 +0000 (UTC)
Date:   Fri, 15 Jan 2021 14:39:24 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/21] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Message-ID: <20210115133924.GE11337@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-6-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223155717.19556-6-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:57:01AM -0800, Chang S. Bae wrote:
> The perf has a buffer that is allocated on demand. The states saved in the

What's "the perf"? I hope to find out when I countinue reading...

> buffer were named as 'dynamic' (supervisor) states but the buffer is not
> updated in every context switch.
> 
> The context switch buffer is in preparation to be dynamic for user states.
> Make the wording to differentiate between those 'dynamic' states.
> 
> Add a new variable -- xfeatures_mask_user_dynamic to indicate the dynamic
> user states, and rename some define and helper as related to the dynamic
> supervisor states:
> 	xfeatures_mask_supervisor_dynamic()
> 	XFEATURE_MASK_SUPERVISOR_DYNAMIC
> 
> No functional change.

Text needs cleaning up.

> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v2:
> * Updated the changelog for clarification.
> ---
>  arch/x86/include/asm/fpu/xstate.h | 12 +++++++-----
>  arch/x86/kernel/fpu/xstate.c      | 29 +++++++++++++++++++----------
>  2 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 24bf8d3f559a..6ce8350672c2 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -56,7 +56,7 @@
>   * - Don't set the bit corresponding to the dynamic supervisor feature in
>   *   IA32_XSS at run time, since it has been set at boot time.
>   */
> -#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
> +#define XFEATURE_MASK_SUPERVISOR_DYNAMIC (XFEATURE_MASK_LBR)

Is XFEATURE_MASK_USER_DYNAMIC coming too?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
