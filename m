Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8D2B5498
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgKPWs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKPWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:48:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:48:55 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so22046017ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oqw9epQWjuqQxumm1qz/wnmcqCFBLpywk+xBolP4O8c=;
        b=a90FLjLDw/opYyMk6t7cdGXGKSI2b8IgRXgsEkBadTQC29AJ9CCSviJX9AD7WM6PVL
         E0JkHgnaJ5tEEAHvGwGV+kSKMaS9V2q57MKbIxjxkp91f4ZV6ytzTZyMZoOG28QGnVxm
         +TIE2ZrOQP9ZxrvCS17/+R7gt2w1RSldJ462M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oqw9epQWjuqQxumm1qz/wnmcqCFBLpywk+xBolP4O8c=;
        b=tsUwl0yEYFhpnIZIAYup7snJZiUQNus910V0Q5BUzJ9q02qxvPUmoLIvz8CsLPw+DV
         R/LUDB6ctTh/SnLHy1BMnCwFZYEL2psQlPGKWyF2Oafjbvye0mFVUEUIhjvvfVgaWcdX
         CwxkBgQqGLZQpifRz6NQJ2lN6ZtvvaRBmFdwnKKd5eM+u5SVoyTAF3+6F7IbyS/BP1Iz
         HaOA8O275dl05H73PVxEJ3Xgjnt4pIXJMi+8AbqD3ndLsRfRdIJY5l7nwO8vxJnX8TV+
         VK7oyXqqeoV23Z0SaPQ6+vLYMubRUZ72ulqy3g6GhPOmFG65iWawe/KmyONEsJx8jDC1
         59Bg==
X-Gm-Message-State: AOAM533NT29hSHXx8ya2sGwBM4TTZkuuMdhB7IoPlf0Zmi165zGKiUAO
        zw040lEZa1u5wic6GnhmQscVhw7R6XgaG3N3+s2x7Q==
X-Google-Smtp-Source: ABdhPJwb06unpnL5QaqHHPp0HNHwcwCk4x8fHDA1SSjvR/3dSoXcB0kN5E5tswNOgKPGnqa1G2l6aAEVQySeZ3clnj4=
X-Received: by 2002:a2e:b16f:: with SMTP id a15mr643461ljm.430.1605566933909;
 Mon, 16 Nov 2020 14:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20201116140110.1412642-1-kpsingh@chromium.org> <793acf23-b263-6ae5-2206-18fcdfa991eb@iogearbox.net>
In-Reply-To: <793acf23-b263-6ae5-2206-18fcdfa991eb@iogearbox.net>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 16 Nov 2020 23:48:43 +0100
Message-ID: <CACYkzJ6U3PNZ0w5ryeWbyTi0NfSLg241iHMHz-b8mrDdsgfkfw@mail.gmail.com>
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

[...]

> >
> > +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> > +{
>
> This should also reject invalid flags. I'd rather change this helper from RET_VOID
> to RET_INTEGER and throw -EINVAL for everything other than BPF_LSM_F_BPRM_SECUREEXEC
> passed in here including zero so it can be extended in future.

Sounds good, I added:

 enum {
        BPF_LSM_F_BPRM_SECUREEXEC       = (1ULL << 0),
+       /* Mask for all the currently supported BPRM options */
+       BPF_LSM_F_BRPM_OPTS_MASK        = 0x1ULL,
 };

changed the return type to RET_INTEGER as suggested checking for
invalid flags as:

 BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
 {
+
+       if (flags & !BPF_LSM_F_BRPM_OPTS_MASK)
+               return -EINVAL;

Do let me know if this is okay and I can spin up a v2 with these changes.

- KP

>
> > +     bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
> > +     return 0;
> > +}
> > +
> > +BTF_ID_LIST_SINGLE(bpf_lsm_set_bprm_opts_btf_ids, struct, linux_binprm)
> > +
> > +const static struct bpf_func_proto bpf_lsm_set_bprm_opts_proto = {
> > +     .func           = bpf_lsm_set_bprm_opts,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_VOID,
> > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > +     .arg1_btf_id    = &bpf_lsm_set_bprm_opts_btf_ids[0],
> > +     .arg2_type      = ARG_ANYTHING,
> > +};
> > +
