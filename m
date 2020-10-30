Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE712A03B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3LHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3LHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:07:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD3C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:07:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l28so7311318lfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t19jBLJy8LyrL1w4Rgl5+7QGWOjDVZBVKjSp5AohpkU=;
        b=KwD16XGcCGelvdk31q/ME/V6nhyu08SDG+H3PJOXuzKVHCZ+2dFy/+QUD2ZzXeqccu
         hf5KusIjaFa5eEr7rhIiU9nMcbX3fMYyrktBgAuhGpqtPlSKHYF0rzWeGtq3Y3m5oSkn
         2MoL5X4WUloxRTeuw6+H4sNe1U33QuiZWVicI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t19jBLJy8LyrL1w4Rgl5+7QGWOjDVZBVKjSp5AohpkU=;
        b=ETPENL22yTUSAUYnE/qTxS536TTczKqDJHyuM1k9IarC+q2CgtdV4hEjRAkvvWd/dA
         qRkz6UcFZqiW+9Px/jmo9MHRCa6TU1i1Bxdyiu13BV+KF9e/YtGZQmM/XuHXCG0Du2f5
         VdIMOFATCHSEtyrjHuc9Arv36iqovLKppSnoStyqWbRxevGhnsRAmsDn0S/wL7j+GCXG
         NLNgjOhevihZLBGSwi6ycJM048/Z17oxITmb97Lz2IqI7xzcUwtlldWKv4Io9BKZ5VZd
         nlphFTxHxpdxjhCiSy0cp1Ld/S0OkKn59eiwlcwaWihPShVXaY9prGCznAvy670aG293
         wNlw==
X-Gm-Message-State: AOAM532+NERDAmR/Rh4sH2AKwZdTpF0WrtOZgK4BvWsUlhx9LuOjYQro
        BNiiPsM2bM7XoJ/YtzkJaXMuRAd6bBnW6iGYwGexFw==
X-Google-Smtp-Source: ABdhPJxVQTJKl961Cy0dCCCnHaPVtkvgBeMDN42MBovSsFHmEYN7LHhxL8KHUH75lODFfnld3jZ6oOAoT7kkBaaacxE=
X-Received: by 2002:a05:6512:3102:: with SMTP id n2mr666158lfb.153.1604056062234;
 Fri, 30 Oct 2020 04:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org> <CAPhsuW6yFbWLGZwpCE4whUm_ncJG4Fr7kf75XeqYLRWG8PvnWQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6yFbWLGZwpCE4whUm_ncJG4Fr7kf75XeqYLRWG8PvnWQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 30 Oct 2020 12:07:31 +0100
Message-ID: <CACYkzJ7kbq0Nq71fJCkHSwEmJfKFKOsvRZos_tT64N1f-aT4-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     Song Liu <song@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"

On Fri, Oct 30, 2020 at 12:28 AM Song Liu <song@kernel.org> wrote:
>
> On Wed, Oct 28, 2020 at 9:17 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Similar to bpf_local_storage for sockets and inodes add local storage
> > for task_struct.
> >
> > The life-cycle of storage is managed with the life-cycle of the
> > task_struct.  i.e. the storage is destroyed along with the owning task
> > with a callback to the bpf_task_storage_free from the task_free LSM
> > hook.
>
> It looks like task local storage is tightly coupled to LSM. As we discussed,
> it will be great to use task local storage in tracing programs. Would you
> like to enable it from the beginning? Alternatively, I guess we can also do
> follow-up patches.
>

I would prefer if we do it in follow-up patches.

> >
> > The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> > the security blob which are now stackable and can co-exist with other
> > LSMs.
> >
> > The userspace map operations can be done by using a pid fd as a key
> > passed to the lookup, update and delete operations.
>
> While testing task local storage, I noticed a limitation of pid fd:
>
> /* Currently, the process identified by
>  * @pid must be a thread-group leader. This restriction currently exists
>  * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
>  * be used with CLONE_THREAD) and pidfd polling (only supports thread group
>  * leaders).
>  */
>
> This could be a problem for some use cases. How about we try to remove
> this restriction (maybe with a new flag to pidfd_open) as part of this set?

I would appreciate it if we could also do this in a follow-up patch.

I do see that there is a comment in fork.c:

    "CLONE_THREAD is blocked until someone really needs it."

But I don't understand the requirements well enough and would thus prefer
to do this in a follow-up series.

- KP

>
> Thanks,
> Song
>
> [...]
