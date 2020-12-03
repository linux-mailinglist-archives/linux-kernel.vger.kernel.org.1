Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378072CCE2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLCFBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 00:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgLCFBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:01:00 -0500
X-Gm-Message-State: AOAM530PEtvhPJt7ozLJPRHHcqjDKxG4b6NTAZoMCnxnKvIrBE7HFESZ
        3vbIP1xmNxmdLZKBN5iUbQsYgHZBRkG+FaReIXHNEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606971619;
        bh=vcBiDUGvGRXCASKRjn6tLzrthqGOKsBcgn/v89k1bLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bYAM04CnbRbTJVQeZmTpPY6ZPrU9s0SvoLb7xwqiPhOh6FSutZUWyVJr+p1mJMtuX
         NjTcF9IvQYm8BITE3IrQgls1irSTe6zl+zRbfa9x/kkaMEPWyAcZOpgX3hoLHMqlgB
         fR4pQy0JiroEaJy0xycXhjtYcH80I0JwQ+HmaPEpxMKMjD61EwUiDsnlW7Ja/crx/J
         xVCPe8XoAZTnMxJ7KamdZIaLG5M8066+yDSqNxS8z1rkuFoJWnuvH4u5yTnNBZsHaB
         /DexEmMDU6dNk4YGojC6nyZhzEq8gW3k5clT8p++JdiSIRphsekEfqjXGp1hoPezrT
         0YY+H6ZI2b5jw==
X-Google-Smtp-Source: ABdhPJycHGaQAdO/rXGQas+F4KIUJRv+xTEEj1IpIm9CShoRcb69XboiOSASktWPGd/O0RC+v/3qP5bbqxpdq2J6wSI=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr1588125wru.70.1606971617555;
 Wed, 02 Dec 2020 21:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-16-chang.seok.bae@intel.com> <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
 <246DCF46-D7F4-4F68-ADF8-2F694FEFD2AC@intel.com> <CALCETrXjgB_QXumQr+AgZx5O5SDv25yiVuDkFuCk9ZRDP6VoKQ@mail.gmail.com>
 <A7AD8A0D-0346-4B25-A2C8-283E59D422EF@intel.com>
In-Reply-To: <A7AD8A0D-0346-4B25-A2C8-283E59D422EF@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 2 Dec 2020 21:00:05 -0800
X-Gmail-Original-Message-ID: <CALCETrX6=1AOS_G=dUdMyCiCSVRA3ns937nhRS5O1DwvfWtSQA@mail.gmail.com>
Message-ID: <CALCETrX6=1AOS_G=dUdMyCiCSVRA3ns937nhRS5O1DwvfWtSQA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 8:00 PM Bae, Chang Seok <chang.seok.bae@intel.com> w=
rote:
>
>
> > On Nov 25, 2020, at 03:33, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, Nov 24, 2020 at 10:22 AM Bae, Chang Seok
> > <chang.seok.bae@intel.com> wrote:
> >>
> >>
> >>> On Nov 19, 2020, at 21:07, Andy Lutomirski <luto@kernel.org> wrote:
> >>>
> >>> On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.co=
m> wrote:
> >>>>
> >>>>
> >>>> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regs=
et.c
> >>>> index 8d863240b9c6..6b9d0c0a266d 100644
> >>>> --- a/arch/x86/kernel/fpu/regset.c
> >>>> +++ b/arch/x86/kernel/fpu/regset.c
> >>>> @@ -125,6 +125,35 @@ int xstateregs_set(struct task_struct *target, =
const struct user_regset *regset,
> >>>>
> >>>>       xsave =3D __xsave(fpu);
> >>>>
> >>>> +       /*
> >>>> +        * When a ptracer attempts to write any state in task->fpu b=
ut not allocated,
> >>>> +        * it dynamically expands the xstate area of fpu->state_ptr.
> >>>> +        */
> >>>> +       if (count > get_xstate_size(fpu->state_mask)) {
> >>>> +               unsigned int offset, size;
> >>>> +               struct xstate_header hdr;
> >>>> +               u64 mask;
> >>>> +
> >>>> +               offset =3D offsetof(struct xregs_state, header);
> >>>> +               size =3D sizeof(hdr);
> >>>> +
> >>>> +               /* Retrieve XSTATE_BV */
> >>>> +               if (kbuf) {
> >>>> +                       memcpy(&hdr, kbuf + offset, size);
> >>>> +               } else {
> >>>> +                       ret =3D __copy_from_user(&hdr, ubuf + offset=
, size);
> >>>> +                       if (ret)
> >>>> +                               return ret;
> >>>> +               }
> >>>> +
> >>>> +               mask =3D hdr.xfeatures & xfeatures_mask_user_dynamic=
;
> >>>> +               if (!mask) {
> >>>> +                       ret =3D alloc_xstate_area(fpu, mask, NULL);
> >>>> +                       if (ret)
> >>>> +                               return ret;
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>
> >>> This whole function is garbage.  The count parameter is entirely
> >>> ignored except that the beginning of the function compares it to the
> >>> constant known size.  Now that it's dynamic, you need to actually
> >>> validate the count.  Right now, you will happily overrun the buffer i=
f
> >>> the mask in the buffer isn't consistent with count.
> >>
> >> In practice, copy_{kernel|user}_to_xstate() is the copy function. It a=
ctually
> >> relies on the mask [1], rather than the count. If the state bit not se=
t in the
> >> mask, the state is not copied.
> >>
> >> This path may be better to be clean up for readability. We can try to =
cleanup
> >> in a separate series.
> >>
> >> Also, I think the series needs to enable XFD only with XSAVES -- the c=
ompacted
> >> format used in the kernel.
> >
> > I disagree.  Before your patch, if you passed in a fixed-size buffer
> > with arbitrary data, the worst that could happen was corruption of the
> > target process.  With your patch, if you pass in a fixed-size buffer
> > with too many mask bits set, the syscall will overrun the buffer.
>
> True, user space provides a fixed-size buffer in an uncompacted format
> -- the size should be enough to cover states set in XCR0 [1].
>
> Here, the code only cares states set in XCR0; the mask bits not set in XC=
R0 do
> not trigger the expansion. I don=E2=80=99t get the buffer overrun.

Oh, I get it.  The user is expected to pass in data in the uncompacted form=
at.

Have you confirmed that real ptrace users (gdb?  does anything
actually use this code?) can handle the huge buffers that will be
needed?

--Andy
