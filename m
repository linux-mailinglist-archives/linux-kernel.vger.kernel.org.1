Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE32A5C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKDBzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgKDBzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:55:38 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E5C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:55:37 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 23so21185030ljv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 17:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC/xIvZGSkaTO8y7f9/vrA3KVSHb2F+OelGKcm/sKKc=;
        b=UDe8jLpCB+WxzAVoojotqbUn2by+ziGqSXAXwsQWexbdbBJetCaBPG36ChGckON9RE
         KQtHYZY4kYd5C0E62QRN+usRS3jFG1LFnLkEcDRwGWkX1Gb3xl3qXLBCsg5LZnXwLUGb
         ojxIEpmA1L/5chEGV75wTojVJP7yV6j4lsc+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC/xIvZGSkaTO8y7f9/vrA3KVSHb2F+OelGKcm/sKKc=;
        b=QZQpmIAXQlJKKYLNgJuDW5F7eiERSMvNpnT4jc95TRsW1WZJl5w7zFOVt4N5LtCFta
         nwXW2qKzGO3MWdzIDTno2X7oLACsVScHtWDyBCF+AZQsCEzATiu96LjHMju0Ca4/MpVO
         EBIDl5e3objU5Rtmy4wgIMvkbwyzvyXgzocfW7UzOgJJV6vhCkJH9rCrpxos5aW/Punu
         5s+VgzBDl2twLRVu939g8TRO5ph98UKk1w93LF59Pxf/X/kZRbMsVbGZmovnIF7MTRAs
         eLMNgzsojhsH9tB61Ptt0KWAr5D1MHcIRvp2wEkfPcZNOGXqTduphL0P9HMI4Wim8MNF
         S3DQ==
X-Gm-Message-State: AOAM533FxmrTVOl4jfhGO/Xg+/AgD8Ni7ghTHPCbax9Qg7/rxm+l8x/1
        swGcrgE+VSWTB55lapG5R0Ow8mjnVat0ncXuU20eSw==
X-Google-Smtp-Source: ABdhPJzU+Or/goPNlldoC7kYLe0Bvvhak+CU2G3StLfnDMcezHnCOYsZ1yIpqbHvoysop9kA13opOgnIx4yCLHPQR1E=
X-Received: by 2002:a05:651c:10b:: with SMTP id a11mr9636190ljb.49.1604454936480;
 Tue, 03 Nov 2020 17:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
 <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com> <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com>
In-Reply-To: <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 02:55:25 +0100
Message-ID: <CACYkzJ6uc4fbRMNmj3kFeSu=V2JqWruJLFjMnPet_HXW-EdRng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> > I saw the docs mention that these are not exposed to tracing programs due to
> > insufficient preemption checks. Do you think it would be okay to allow them
> > for LSM programs?
>
> hmm. Isn't it allowed already?
> The verifier does:
>         if ((is_tracing_prog_type(prog_type) ||
>              prog_type == BPF_PROG_TYPE_SOCKET_FILTER) &&
>             map_value_has_spin_lock(map)) {
>                 verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>                 return -EINVAL;
>         }
>
> BPF_PROG_TYPE_LSM is not in this list.

The verifier does not have any problem, it's just that the helpers are not
exposed to LSM programs via bpf_lsm_func_proto.

So all we need is:

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 61f8cc52fd5b..93383df2140b 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const
struct bpf_prog *prog)
                return &bpf_task_storage_get_proto;
        case BPF_FUNC_task_storage_delete:
                return &bpf_task_storage_delete_proto;
+       case BPF_FUNC_spin_lock:
+               return &bpf_spin_lock_proto;
+       case BPF_FUNC_spin_unlock:
+               return &bpf_spin_unlock_proto;
        default:
                return tracing_prog_func_proto(func_id, prog);
        }
