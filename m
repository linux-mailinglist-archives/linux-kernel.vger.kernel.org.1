Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FC2F335F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbhALO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhALO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:56:46 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE8C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:56:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r9so4607727ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDvvMWx616tK9iO3ucvHylGVi9etvk47ivicHsgpugs=;
        b=HwpmcAFhmQFCHZJ6csLxF4mY8cL2dq0owVZR1ohjtymwUP8rMvihFXlKVXQ9rp/n3k
         jW6UQuECsvPBvn9NKphG6k1eh0NL89x5rvrSrlUVN6Kt2HQZDkPOn+VRQtYuo3LmK/yU
         fbo7SCQFOoVPrE0Po0Ck2A25MKhRmrI4/9jXicTn4GGqeuuRxEAY4cxYojA4FxV7kx54
         JRf/clYk9Wv92D43EgK6HjU6KhoeMYRRv7IjAexId7q5SM9Z21qrpg9eCGm8Nn1lauu2
         THJx8PkGdHFbuWFjOj/eYzs2iCZM/f9tyEV2z7TYz/Oh/ZCjQXjd5dNmQEI/xrQjBHxS
         dbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDvvMWx616tK9iO3ucvHylGVi9etvk47ivicHsgpugs=;
        b=XSRVSYuYP2lTmFyXrxL+5+OfYlDa7XBKHYCQ7EYnZduh3JPh6Qf9Yj3wKYwacaqFH+
         l5glRuU5nK7HnHb1Ofqm8ynRRx2hfZz9ouTOJWZ3f+jxGrThf9jI+nYd7Q1VEmJSgUEC
         /0uPi/mZHDSVf2HjR9Yzn2OklC1X695L/0yS/1yqXiJ1mFDr85G2LwHdTkWKtjhcqbKI
         rekXguy+ICfRrrvuRODjTlmykJed9o/gKhYmqUcJqC77Y2KGJavO9C8EbmBJZ+qLoDBg
         ODsh3pGWAQFjJ9uHx0394m9VIpkEe8Bx0IGsPqZzBgRli2UWUB4X51iJBRgFqwIhakvy
         yrng==
X-Gm-Message-State: AOAM5317iGKe7Y10dTBxM4kS+FsjecCAXy2P8Zpj3Xc+J3kvrJXXPpOB
        mq0RsD+h+nwkyWY8Ka3bNiUm64c/XS99WeFestfLtg==
X-Google-Smtp-Source: ABdhPJwIsvY+xcPHvEy8rCFNdrrlPcdaEkeysMNo28dO4UQVV52YDXYd2WZZizMrcT+bFn9AW7NPNfFmyRVzBw9s41I=
X-Received: by 2002:a6b:e805:: with SMTP id f5mr3582199ioh.199.1610463364992;
 Tue, 12 Jan 2021 06:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20210112123913.2016804-1-jackmanb@google.com> <CACYkzJ5v6ANJnB0qk7hdEFf+44RH02G22+JFi0OUoJiFLe-RMA@mail.gmail.com>
In-Reply-To: <CACYkzJ5v6ANJnB0qk7hdEFf+44RH02G22+JFi0OUoJiFLe-RMA@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 12 Jan 2021 15:55:54 +0100
Message-ID: <CA+i-1C0ps2ToxnCv58hP3-ZNnJ1ydkQJ_7s4mXnZG89j6UTQhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a verifier message for alloc size
 helper arg
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, duplicate - seems I had my mail client in HTML mode the first
time around.

On Tue, 12 Jan 2021 at 14:14, KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jan 12, 2021 at 1:39 PM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > The error message here is misleading, the argument will be rejected
> > unless it is a known constant.
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 17270b8404f1..5534e667bdb1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4319,7 +4319,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         err = mark_chain_precision(env, regno);
> >         } else if (arg_type_is_alloc_size(arg_type)) {
> >                 if (!tnum_is_const(reg->var_off)) {
> > -                       verbose(env, "R%d unbounded size, use 'var &= const' or 'if (var < const)'\n",
>
> Can you check if:
>
> int var = 1000;
> var += 1;
>
> if (var < 2000)
>    // call helper
>
> and then using var in the argument works? If so, the existing error
> message would be correct.

I think that would work because var is already a known constant before
the conditional.. but the error message is still wrong, the `if (var <
2000)` is irrelevant. If var was not already a known constant (e.g.
came from the return value of a bpf_probe_read_kernel_str) it would
fail verification.
