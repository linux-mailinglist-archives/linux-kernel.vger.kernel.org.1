Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B22A70D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgKDWyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgKDWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:54:24 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B20C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 14:54:23 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id x6so213574ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JfSC8vfkextKI0CTxdreiJW8D06AVfpIQrednxXpok=;
        b=OY98b6mIcEkijtWQ3mppvCqE+6cW+WWP+NPcK56NFRgXflP8MdM9tH/VMR8CSHnlw7
         ZfUbR/6L6toEG0xoduVm4SnsF55sExHnpQp9r40JSzsP/AwR3oJrxMxjwytOADuq1qM9
         hqccqfLtSS895CkgKBr5+iHFM1Vx8gPUdMN1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JfSC8vfkextKI0CTxdreiJW8D06AVfpIQrednxXpok=;
        b=U8ELRfV7ZkzwoKHYsZScihFXPPM8Zg5NvlU8zKcqtK4n0Qk31UrhDYD9nZ1P0NgQbl
         8Da8eZHDC2lvXYdeB3EkTSrvW/oezDNIXfjFsnVOxT6l6+RcbiUZOp7Fl9EC/+E9L4+l
         75P4hUY0dI73DYWTRrEKvIMd7mXYNskq2b5sIvYzd3lRnskBNh6CycgQCRskex4+Y/z7
         1uYeuq4zS95TdOIrPJo/IXqKuBHF8ii/VP/pG3OynMYKAUPqSeBu3esWIIyC/8zA0+n4
         fzxjxqKNeHfKLoShLMsAFJxKq0ZLMeJfj5KmMVj3f9m18bhMdRH8sf7nVIeB61EXxgqm
         Qp+w==
X-Gm-Message-State: AOAM5324qf/8cL6FRNVFmq8pAz/WMT58yfIexCdVBiSy8yXIwro0Mu+X
        bRRTZfWYdOeFbm8xpjwLF8sRgEMXD9KaMcUfwOFTtg==
X-Google-Smtp-Source: ABdhPJzM25O+m3zcGcPdBWCey9N4TZDrHf083uNAky6PYnYnVMOWY1awerwvELTCyOIRPfZfZyZMHbTO3u0JEPish9o=
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr75379ljj.49.1604530460480;
 Wed, 04 Nov 2020 14:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20201104164453.74390-1-kpsingh@chromium.org> <20201104164453.74390-2-kpsingh@chromium.org>
 <20201104221526.dv6qfpfp5lk2t7zw@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201104221526.dv6qfpfp5lk2t7zw@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 23:54:09 +0100
Message-ID: <CACYkzJ6t12AORyTzAP_P3bZG-_K_01h7DVaUmYTWCd-8U-8-bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Implement task local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     WARN_ON_ONCE(!rcu_read_lock_held());
> > +     task = pid_task(pid, PIDTYPE_PID);
> > +     if (!task) {
> > +             err = -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     sdata = bpf_local_storage_update(
> > +             task, (struct bpf_local_storage_map *)map, value, map_flags);
> It seems the task is protected by rcu here and the task may be going away.
> Is it ok?
>
> or the following comment in the later "BPF_CALL_4(bpf_task_storage_get, ...)"
> is no longer valid?
>         /* This helper must only called from where the task is guaranteed
>          * to have a refcount and cannot be freed.
>          */

I reworded this (and the other similar comment) as:

/* This helper must only be called from places where the lifetime of the task
* is guaranteed. Either by being refcounted or by being protected
* by an RCU read-side critical section.
*/
