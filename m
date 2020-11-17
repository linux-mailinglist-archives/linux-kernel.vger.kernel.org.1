Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9F2B727F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgKQXfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQXfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:35:46 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:35:45 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so300073lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeKKFBADpWN954+IsjWIr6cgEypB+tWqmR313eWsUZQ=;
        b=WZyZegk3XS6jrNOhpP9XVbKY/k4lwQwrmxgAQthohq39GWVWjYSa37pMS8M9R+nA6q
         jN5lLGlDohciyA5mc2sqEmyPaVEcYzWvJhJnDfHaJtClBXNaqssKMNoQQM1to3AKnxHU
         o8G/h1a9oa7M3n8NtiEluAKT1GWyygLT0jhao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeKKFBADpWN954+IsjWIr6cgEypB+tWqmR313eWsUZQ=;
        b=KNX69kOpfj88ALa94FkPd78FFIG9V65g1aUUftw92NMpzYaJuyPdr5zIIkRQtlIKXY
         /ZP3M/+xPLbqVJfKzW6GGJBmJ6wAFNFqHHLFUffxBfaTS05mncY0+P1ilg3x9RNOpGKn
         l82PMyjNc6lcNJ9FzyRqZUcckYDycxbTdxOhA428a9jhLF01uoFUJ/AeNAx1P6kLQF7G
         KOa4yqLsjavX6l7fQOpT3dgIrMA/5WLExCAEAxMGoHdtTlxNwnbFudeR8OtFSAlrDO4t
         gFMwqHOD5M3kDfK6+nPfYjhoYIn+fiyYi1CItdRDgvMZWfVXGqpNDUkCitBuNdFPZT4B
         vr7Q==
X-Gm-Message-State: AOAM531ylXmVrIlGhpBn10dKzPwHD8lZQki5o821WAARMsJYWYc/WzMv
        eOaXOqerxk+qVNAWSHlxpCcteEzsHMjG1iYUJBybbw==
X-Google-Smtp-Source: ABdhPJxYqW4KKC6wvgXSRVBXVMDStNeme+c99uG/OaKioLneRwupeJj+sC+B0/kqf9e+qh939D7483AjgJEoxO/41Jk=
X-Received: by 2002:a19:418d:: with SMTP id o135mr2789233lfa.329.1605656144289;
 Tue, 17 Nov 2020 15:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20201117021307.1846300-1-kpsingh@chromium.org> <cc03ab7e-dee8-f717-7a4f-413a3a5f58b7@iogearbox.net>
In-Reply-To: <cc03ab7e-dee8-f717-7a4f-413a3a5f58b7@iogearbox.net>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 18 Nov 2020 00:35:33 +0100
Message-ID: <CACYkzJ54zxE2uefF3actr90OVdKeWTgREffw9TKc54yWeyjAPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:41 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/17/20 3:13 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > The helper allows modification of certain bits on the linux_binprm
> > struct starting with the secureexec bit which can be updated using the
> > BPF_LSM_F_BPRM_SECUREEXEC flag.
> >
> > secureexec can be set by the LSM for privilege gaining executions to set
> > the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> > use of certain environment variables (like LD_PRELOAD).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >   include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
> >   kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
> >   scripts/bpf_helpers_doc.py     |  2 ++
> >   tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
> >   4 files changed, 65 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 162999b12790..bfa79054d106 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3787,6 +3787,18 @@ union bpf_attr {
> >    *          *ARG_PTR_TO_BTF_ID* of type *task_struct*.
> >    *  Return
> >    *          Pointer to the current task.
> > + *
> > + * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
> > + *
>
> small nit: should have no extra newline (same for the tools/ copy)
>
> > + *   Description
> > + *           Set or clear certain options on *bprm*:
> > + *
> > + *           **BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
> > + *           which sets the **AT_SECURE** auxv for glibc. The bit
> > + *           is cleared if the flag is not specified.
> > + *   Return
> > + *           **-EINVAL** if invalid *flags* are passed.
> > + *
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)               \
> >       FN(unspec),                     \
> > @@ -3948,6 +3960,7 @@ union bpf_attr {
> >       FN(task_storage_get),           \
> >       FN(task_storage_delete),        \
> >       FN(get_current_task_btf),       \
> > +     FN(lsm_set_bprm_opts),          \
> >       /* */
> >
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > @@ -4119,6 +4132,11 @@ enum bpf_lwt_encap_mode {
> >       BPF_LWT_ENCAP_IP,
> >   };
> >
> > +/* Flags for LSM helpers */
> > +enum {
> > +     BPF_LSM_F_BPRM_SECUREEXEC       = (1ULL << 0),
> > +};
> > +
> >   #define __bpf_md_ptr(type, name)    \
> >   union {                                     \
> >       type name;                      \
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 553107f4706a..cd85482228a0 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -7,6 +7,7 @@
> >   #include <linux/filter.h>
> >   #include <linux/bpf.h>
> >   #include <linux/btf.h>
> > +#include <linux/binfmts.h>
> >   #include <linux/lsm_hooks.h>
> >   #include <linux/bpf_lsm.h>
> >   #include <linux/kallsyms.h>
> > @@ -51,6 +52,30 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >       return 0;
> >   }
> >
> > +/* Mask for all the currently supported BPRM option flags */
> > +#define BPF_LSM_F_BRPM_OPTS_MASK     BPF_LSM_F_BPRM_SECUREEXEC
> > +
> > +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> > +{
> > +
>
> ditto
>
> Would have fixed up these things on the fly while applying, but one small item
> I wanted to bring up here given uapi which will then freeze: it would be cleaner
> to call the helper just bpf_bprm_opts_set() or so given it's implied that we
> attach to lsm here and we don't use _lsm in the naming for the others either.
> Similarly, I'd drop the _LSM from the flag/mask.
>

Thanks Daniel, this makes sense and is more future proof, I respun this and
sent out another version with some minor fixes and the rename. Also added
Martin's acks.

- KP
