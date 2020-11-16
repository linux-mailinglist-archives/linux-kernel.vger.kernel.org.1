Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F92B54A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgKPWxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPWw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:52:59 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD860C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:52:57 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so22020353ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/oQ9zEkDplrUPR9F+3eVed6iy62HqH4efkAMrPRTSU=;
        b=UJ2Jbe9jevW0jo4w4lrpWhHri2nEJX2nY2oTLC9c1uRyTqOjkoa1QvivwK4rMs7kkb
         /MvBBQuTIKk4zjXkXYSNh6OtqwNQb0ev730sMlyrfNSo4BM3Ls2/f8oyoD6wK21tGlE+
         dDZlNm6VwRaZN5fNAD/Xx/lDvAfhrsRaMMiBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/oQ9zEkDplrUPR9F+3eVed6iy62HqH4efkAMrPRTSU=;
        b=T6C2r7MdeUqg1XEexQ4Hn+ykrj/xP4CRqcb/1nFVGJfqxvNepWZyqcBs3l6ZJkrq6H
         NsaxJ1iRLWepwy9GD2bdKsJsOS4IbVSe72rVrOMD+Dj7RzPmzwB4bbv80OKbCcoHKa3+
         XxR7ANbkc7UjOEowyWE4P4DKzQCxSJF2BxHMGVwtovisWZHjddSTC/re9dzU1zcAYeb5
         9nQkZfFuLLMt9BMbbzBz1f5muEKPw9r140loU6x2DVh8gdUA0uRqcQ+JYQGVf9dMj2QX
         p7CmiKtak0BKjJlVoE+DJmaqHZhaOmL3BecJJ0eyhE8ofI7UVCt/QrdTHARzxQMtPuSP
         NRaw==
X-Gm-Message-State: AOAM531EXeJJvnEGObiA6rF1i7ytPIySMdXB9cLw/Vb2fMslzjUlAQa+
        7jnpPhMfQMpw3oAM65J+JLIS0MP6MwSn07byYh4ygg==
X-Google-Smtp-Source: ABdhPJxk37TC4D39hPh+cUJqlBTJu6wkpuHYNR2FPEWz8NaHWEvRSroH9qcM2wVU1F2lKt2Wn2ciTktyMpPmxUtNpqY=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr610529ljk.466.1605567176373;
 Mon, 16 Nov 2020 14:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116140110.1412642-1-kpsingh@chromium.org>
 <793acf23-b263-6ae5-2206-18fcdfa991eb@iogearbox.net> <CACYkzJ6U3PNZ0w5ryeWbyTi0NfSLg241iHMHz-b8mrDdsgfkfw@mail.gmail.com>
In-Reply-To: <CACYkzJ6U3PNZ0w5ryeWbyTi0NfSLg241iHMHz-b8mrDdsgfkfw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 16 Nov 2020 23:52:45 +0100
Message-ID: <CACYkzJ5LcS6s+a=yzVggx-6e2MpLMZ2CtJa2M6ZEjBOpyDYMtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:48 PM KP Singh <kpsingh@chromium.org> wrote:
>
> [...]
>
> > >
> > > +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> > > +{
> >
> > This should also reject invalid flags. I'd rather change this helper from RET_VOID
> > to RET_INTEGER and throw -EINVAL for everything other than BPF_LSM_F_BPRM_SECUREEXEC
> > passed in here including zero so it can be extended in future.
>
> Sounds good, I added:
>
>  enum {
>         BPF_LSM_F_BPRM_SECUREEXEC       = (1ULL << 0),
> +       /* Mask for all the currently supported BPRM options */
> +       BPF_LSM_F_BRPM_OPTS_MASK        = 0x1ULL,
>  };
>
> changed the return type to RET_INTEGER as suggested checking for
> invalid flags as:
>
>  BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
>  {
> +
> +       if (flags & !BPF_LSM_F_BRPM_OPTS_MASK)
> +               return -EINVAL;
>
> Do let me know if this is okay and I can spin up a v2 with these changes.

Oops this should have been:

      if (flags & ~BPF_LSM_F_BRPM_OPTS_MASK)
               return -EINVAL;

>
> - KP
>
> >
> > > +     bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
> > > +     return 0;
> > > +}
> > > +
> > > +BTF_ID_LIST_SINGLE(bpf_lsm_set_bprm_opts_btf_ids, struct, linux_binprm)
> > > +
> > > +const static struct bpf_func_proto bpf_lsm_set_bprm_opts_proto = {
> > > +     .func           = bpf_lsm_set_bprm_opts,
> > > +     .gpl_only       = false,
> > > +     .ret_type       = RET_VOID,
> > > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > > +     .arg1_btf_id    = &bpf_lsm_set_bprm_opts_btf_ids[0],
> > > +     .arg2_type      = ARG_ANYTHING,
> > > +};
> > > +
