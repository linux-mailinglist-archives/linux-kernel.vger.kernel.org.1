Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDA2F7AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbhAOMxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:53:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbhAOMvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:51:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6059CAC95;
        Fri, 15 Jan 2021 12:50:53 +0000 (UTC)
Date:   Fri, 15 Jan 2021 13:50:48 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/21] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
Message-ID: <20210115125048.GB11337@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223155717.19556-3-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:56:58AM -0800, Chang S. Bae wrote:
> In preparation for dynamic xstate buffer expansion, update the xstate
> copy function parameters to equally handle static in-line buffer, as well
> as dynamically allocated xstate buffer.

This is repeated from the previous patch. I'm sure you can think of text
which fits here.

> 
> No functional change.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v2:
> * Updated the changelog with task->fpu removed. (Boris Petkov)
> ---
>  arch/x86/include/asm/fpu/xstate.h |  8 ++++----
>  arch/x86/kernel/fpu/regset.c      |  6 +++---
>  arch/x86/kernel/fpu/signal.c      | 16 +++++++---------
>  arch/x86/kernel/fpu/xstate.c      | 19 +++++++++++++++----
>  4 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 47a92232d595..e0f1b22f53ce 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -105,10 +105,10 @@ const void *get_xsave_field_ptr(int xfeature_nr);
>  int using_compacted_format(void);
>  int xfeature_size(int xfeature_nr);
>  struct membuf;
> -void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
> -int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
> -int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
> -void copy_supervisor_to_kernel(struct xregs_state *xsave);
> +void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu);
> +int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
> +int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
> +void copy_supervisor_to_kernel(struct fpu *fpu);

Hmm, so those functions have "xstate" in the name because they took and
@xstate parameter. I guess not such a big deal you changing them, just
pointing out what the naming logic was.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
