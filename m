Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69F2C3003
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404260AbgKXSeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbgKXSeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:34:09 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C43206D8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606242848;
        bh=BcJ6arZeUbjKprnJCyHEKrqwEFHVrVObUUJBbxZ9olI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8x+UKwC5gGCCxcUYVQRJuXbl4f8+G2k1g7n2KWwqqnJti4au6SmGCcqxo4C1wtDr
         vnEXGfuBq0SobN7X+POTRCm/1+7B/akArha2EtpnvhlIfOsHntpkmTJ3lKN2oSdROa
         AMHn+XGObAqJWK79cq7hKmHhBrtQHZnqSX3+X1iY=
Received: by mail-wr1-f53.google.com with SMTP id 23so23329216wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:34:08 -0800 (PST)
X-Gm-Message-State: AOAM532p2g7FrJVMx1oy3A1Yf1ifAn2fHyp3Ajmu8yphT/LJoyB1tBAW
        Rof5K/E3+6WAoMFJ8QwUAjzR4/n8b4RhNfMwX/3HSA==
X-Google-Smtp-Source: ABdhPJwtUu9TE6fSIZqVEqC88wUhXvEOon7I+01JQPLxyRvMW7dhtlrhqtbFjGS/TBppLwEEvlY9LR2NADueDoM16k8=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr6625565wrs.75.1606242846792;
 Tue, 24 Nov 2020 10:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-16-chang.seok.bae@intel.com> <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
 <246DCF46-D7F4-4F68-ADF8-2F694FEFD2AC@intel.com>
In-Reply-To: <246DCF46-D7F4-4F68-ADF8-2F694FEFD2AC@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Nov 2020 10:33:53 -0800
X-Gmail-Original-Message-ID: <CALCETrXjgB_QXumQr+AgZx5O5SDv25yiVuDkFuCk9ZRDP6VoKQ@mail.gmail.com>
Message-ID: <CALCETrXjgB_QXumQr+AgZx5O5SDv25yiVuDkFuCk9ZRDP6VoKQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:22 AM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
>
> > On Nov 19, 2020, at 21:07, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>
> >>
> >> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
> >> index 8d863240b9c6..6b9d0c0a266d 100644
> >> --- a/arch/x86/kernel/fpu/regset.c
> >> +++ b/arch/x86/kernel/fpu/regset.c
> >> @@ -125,6 +125,35 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
> >>
> >>        xsave = __xsave(fpu);
> >>
> >> +       /*
> >> +        * When a ptracer attempts to write any state in task->fpu but not allocated,
> >> +        * it dynamically expands the xstate area of fpu->state_ptr.
> >> +        */
> >> +       if (count > get_xstate_size(fpu->state_mask)) {
> >> +               unsigned int offset, size;
> >> +               struct xstate_header hdr;
> >> +               u64 mask;
> >> +
> >> +               offset = offsetof(struct xregs_state, header);
> >> +               size = sizeof(hdr);
> >> +
> >> +               /* Retrieve XSTATE_BV */
> >> +               if (kbuf) {
> >> +                       memcpy(&hdr, kbuf + offset, size);
> >> +               } else {
> >> +                       ret = __copy_from_user(&hdr, ubuf + offset, size);
> >> +                       if (ret)
> >> +                               return ret;
> >> +               }
> >> +
> >> +               mask = hdr.xfeatures & xfeatures_mask_user_dynamic;
> >> +               if (!mask) {
> >> +                       ret = alloc_xstate_area(fpu, mask, NULL);
> >> +                       if (ret)
> >> +                               return ret;
> >> +               }
> >> +       }
> >> +
> >
> > This whole function is garbage.  The count parameter is entirely
> > ignored except that the beginning of the function compares it to the
> > constant known size.  Now that it's dynamic, you need to actually
> > validate the count.  Right now, you will happily overrun the buffer if
> > the mask in the buffer isn't consistent with count.
>
> In practice, copy_{kernel|user}_to_xstate() is the copy function. It actually
> relies on the mask [1], rather than the count. If the state bit not set in the
> mask, the state is not copied.
>
> This path may be better to be clean up for readability. We can try to cleanup
> in a separate series.
>
> Also, I think the series needs to enable XFD only with XSAVES -- the compacted
> format used in the kernel.

I disagree.  Before your patch, if you passed in a fixed-size buffer
with arbitrary data, the worst that could happen was corruption of the
target process.  With your patch, if you pass in a fixed-size buffer
with too many mask bits set, the syscall will overrun the buffer.  So
your patch really does break the syscall.  Please fix it.
