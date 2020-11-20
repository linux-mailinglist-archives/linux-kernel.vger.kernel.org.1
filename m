Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964E72BA1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgKTFH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgKTFH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:07:27 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBF7223AC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605848845;
        bh=oP5AYOfagMnkr9djVz/iMR0Y2onv2GxbCMuMeOZkgwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvzfm9nLWACWhiTKQB4D7kfyIAFaxMD8v21vAH3AOzGqd4S8NT1Cyb2mCk2NLy863
         BXJKIca5v2Lg0myeoy8fbYv4uiwzK4YhwEMe4oW4Ea9G/d5qcjmC8YEKKq9YxzaA3C
         QtQshmLyzVLCjioIchnqcaH4WP5AyWLB8kSCGTRg=
Received: by mail-wr1-f48.google.com with SMTP id r17so8771796wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 21:07:25 -0800 (PST)
X-Gm-Message-State: AOAM530z53f6D3nM6NnM6Z5E/T+hbXFIg/h13VWYvQqlg+YVGH8nvp6T
        9cgVMjTr413zU44LRoneJGdmkr99sUcVbpgfDP+ckQ==
X-Google-Smtp-Source: ABdhPJxECQJKsSuFLYYmsN6+V1qbyVQ7uD3cepFWNm9KyAEl5kMXh6vOu/gNnyCf6sdfPfgdrSNjSzM8YA+MTeUmk10=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr13484978wrs.75.1605848844000;
 Thu, 19 Nov 2020 21:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com> <20201119233257.2939-16-chang.seok.bae@intel.com>
In-Reply-To: <20201119233257.2939-16-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Nov 2020 21:07:09 -0800
X-Gmail-Original-Message-ID: <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
Message-ID: <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> ptrace() may request an update to task->fpu that has not yet been
> allocated. Detect this case and allocate task->fpu to support the request.
> Also, disable the (now unnecessary) associated first-use fault.
>
> No functional change until the kernel supports dynamic user states.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/fpu/regset.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
> index 8d863240b9c6..6b9d0c0a266d 100644
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -125,6 +125,35 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
>
>         xsave = __xsave(fpu);
>
> +       /*
> +        * When a ptracer attempts to write any state in task->fpu but not allocated,
> +        * it dynamically expands the xstate area of fpu->state_ptr.
> +        */
> +       if (count > get_xstate_size(fpu->state_mask)) {
> +               unsigned int offset, size;
> +               struct xstate_header hdr;
> +               u64 mask;
> +
> +               offset = offsetof(struct xregs_state, header);
> +               size = sizeof(hdr);
> +
> +               /* Retrieve XSTATE_BV */
> +               if (kbuf) {
> +                       memcpy(&hdr, kbuf + offset, size);
> +               } else {
> +                       ret = __copy_from_user(&hdr, ubuf + offset, size);
> +                       if (ret)
> +                               return ret;
> +               }
> +
> +               mask = hdr.xfeatures & xfeatures_mask_user_dynamic;
> +               if (!mask) {
> +                       ret = alloc_xstate_area(fpu, mask, NULL);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +

This whole function is garbage.  The count parameter is entirely
ignored except that the beginning of the function compares it to the
constant known size.  Now that it's dynamic, you need to actually
validate the count.  Right now, you will happily overrun the buffer if
the mask in the buffer isn't consistent with count.

Please add some real bounds checking here.
