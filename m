Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3F2FBBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbhASQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391226AbhASQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:00:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70012C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:59:49 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w18so40555761iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnSHKTtadAAW6f/V6v1P54dpn5XhZcWC2sCdL18R9nM=;
        b=BCz/IO67zgT9CdPUsNFpVQqiCBjOVaMK/Pax9eNFPRuTiMeljI8vVrfwgwPLLQjAS4
         Tikti9KuYz6SSyNawS4HSnT31Tysbz2DTAYV+HiWMN2c5lswqB2gOQ1HOjDuXgOl0D4E
         4z5lBRztA4DJSLN/+W/OVX/rw5LoMqUxnWuA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnSHKTtadAAW6f/V6v1P54dpn5XhZcWC2sCdL18R9nM=;
        b=J40VGDMUpoz4O6Nm5tO0NmjgyNyGtIE87xCm6LVEeEIrwMriCQkpLPuxazG6StDYSo
         lCSvpXZLZ1pcsdGRGvPkmPJbXP5GKUPMA2DctNO/Ewz/vB35pvgpGUvolyZlFjVXKrHh
         z6P3KrxJs6pDDs3ctlHn4Scs2l3/Htv79b8h8RzXStUVIjgXXybvJ5u9rU90NvTkfG6H
         DGc5Q7NOE2JuXlnVSqL6OUqT5zlYqOzPB0u06mWo0hFvkQtS+8GM05WjZMMh127etFdC
         GmQqCCBf3a4lfWHz/T3cGMZ0vL4Ek60+RKzAJTnwWWG55PVPH7Jj6zV6oEMYhh1HhUzQ
         vBkA==
X-Gm-Message-State: AOAM530Fx74OO14TlDZ9Er6GvrfhH6htRj3MsXVkb9/3HSZLW1ae1h8S
        oVP4cRaYxIh1BQ6T44ekmRAIEpeqAQzAzE8WdSEJJA==
X-Google-Smtp-Source: ABdhPJw1q2AuXeeiU4fIPEMq65Kyi56qqi9inbUrV//84fq15yKyeQTBsx0IAV4FlbnjU3y7bjNocnTIPYiTyCiBzoE=
X-Received: by 2002:a5e:8d03:: with SMTP id m3mr3547547ioj.130.1611071988858;
 Tue, 19 Jan 2021 07:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20201209132636.1545761-1-revest@chromium.org> <20201209132636.1545761-2-revest@chromium.org>
 <c3f1619d-41c1-89d3-a2a2-c2de0041fa51@iogearbox.net>
In-Reply-To: <c3f1619d-41c1-89d3-a2a2-c2de0041fa51@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 19 Jan 2021 16:59:38 +0100
Message-ID: <CABRcYmKpDvy=_pXcL=XDiWkjxqumMBgRoApWrAru1Dc-=21eUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 5:35 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/9/20 2:26 PM, Florent Revest wrote:
> > This needs two new helpers, one that works in a sleepable context (using
> > sock_gen_cookie which disables/enables preemption) and one that does not
> > (for performance reasons). Both take a struct sock pointer and need to
> > check it for NULLness.
> >
> > This helper could also be useful to other BPF program types such as LSM.
>
> Looks like this commit description is now stale and needs to be updated
> since we only really add one helper?
>
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >   include/linux/bpf.h            |  1 +
> >   include/uapi/linux/bpf.h       |  7 +++++++
> >   kernel/trace/bpf_trace.c       |  2 ++
> >   net/core/filter.c              | 12 ++++++++++++
> >   tools/include/uapi/linux/bpf.h |  7 +++++++
> >   5 files changed, 29 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 07cb5d15e743..5a858e8c3f1a 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1860,6 +1860,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
> >   extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
> >   extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> >   extern const struct bpf_func_proto bpf_sock_from_file_proto;
> > +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
> >
> >   const struct bpf_func_proto *bpf_tracing_func_proto(
> >       enum bpf_func_id func_id, const struct bpf_prog *prog);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index ba59309f4d18..9ac66cf25959 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1667,6 +1667,13 @@ union bpf_attr {
> >    *  Return
> >    *          A 8-byte long unique number.
> >    *
> > + * u64 bpf_get_socket_cookie(void *sk)
> > + *   Description
> > + *           Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> > + *           *sk*, but gets socket from a BTF **struct sock**.
>
> Maybe add a small comment that this one also works for sleepable [tracing] progs?
>
> > + *   Return
> > + *           A 8-byte long unique number.
>
> ... or 0 if *sk* is NULL.

Argh, I somehow missed this email during my holidays, I'm sending a
v5. Thank you Daniel!
