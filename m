Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3732F3755
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbhALRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390844AbhALRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:37:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E27C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:36:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w5so3356685wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfBdHlbPhe9JJVFJ53u2WB3aTeFtdCK9M9opKH7jl0E=;
        b=r+hFbctf7X7hHlEJB3cUCjzH8j2xrYepKGUGArG/haPmHg3VEsQqEoP+bjyfE+JUV4
         7fNlBjtiSaVAjnlZ8OaToJ9zft6m1wHPMAvTu/fKvVnerheKqOs0WRIVdNMN12Jw7COZ
         FVQMfPoZ0h5x0cFG0Z9WY0uT5Hp0zqIxpVoCNdwBTExy689NFmyPnNG3yNlT+FuggQJY
         PcUzwOPS1IslA3+lNcHct75qRyTW9ivKIgWwcPwxQoEltGGD4o6tV3kE9jPcvQfhuuXA
         O6Owucb4wqQ+RuictebWz50p1Hg4HXq7M3petBX90hlXHPZpAra0SIB2ZVih0uotmjgi
         REWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfBdHlbPhe9JJVFJ53u2WB3aTeFtdCK9M9opKH7jl0E=;
        b=olj8w+abni1hokyS6ZoZTzYZ5Vi0Oxv4KQ0DFVgLS7z5HzCA19J+csuhi8X65DbkqQ
         pg+AhSapLQET/gE6ogRj9MQOHz3Q+T+h0veZuPr5FKnkDUc3fDQIFpUz4oZLTkqxD6du
         Z5SmxTUwFT6b2UnBZoWxMPHmC+R+nHG5vfnTPAw2gVSdbX8cck+5Ty3CXM7yZyZtiVrp
         g+RQiL2SEAUhrylDyyQ01hRenBswbOaeqH9bnHTruZNI35ox9ib7obVooYw8PPh3bDcb
         ume6amq0VupnKGvmJe1wdv5FEBREYJG9p3r4eBjVgcfvaqEtqJUxDGW4/sJvlc0dIGhA
         Uv0Q==
X-Gm-Message-State: AOAM530rSD1ryJ2w1sqwRFEtS+MBCeFvVD3n3C/T3evWs5dL+7sDYQEb
        JqFKykC/uIDjPQakLaZBDbSM8U7K88D9DRnwLwd6yw==
X-Google-Smtp-Source: ABdhPJw1Jgdy43yhmaRwTd0pdcF+MsZsBqxx4SqJd+UJxoXstrUpJMKOObpVqUZhNvBXniG6D6ajQpMGbSb4nXVH30o=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr5603702wro.162.1610472990153;
 Tue, 12 Jan 2021 09:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
In-Reply-To: <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Jan 2021 09:36:18 -0800
Message-ID: <CAJuCfpFdSNTp+PhJ1ztyfbzdVWVHy=qJJPVizXPGizgBQqTKYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 5:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 11 Jan 2021 09:06:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > process_madvise currently requires ptrace attach capability.
> > PTRACE_MODE_ATTACH gives one process complete control over another
> > process. It effectively removes the security boundary between the
> > two processes (in one direction). Granting ptrace attach capability
> > even to a system process is considered dangerous since it creates an
> > attack surface. This severely limits the usage of this API.
> > The operations process_madvise can perform do not affect the correctness
> > of the operation of the target process; they only affect where the data
> > is physically located (and therefore, how fast it can be accessed).
> > What we want is the ability for one process to influence another process
> > in order to optimize performance across the entire system while leaving
> > the security boundary intact.
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
> It would be useful to see the proposed manpage update.
>
> process_madvise() was released in 5.10, so this is a
> non-backward-compatible change to a released kernel.
>
> I think it would be OK at this stage to feed this into 5.10.x with a
> cc:stable and suitable words in the changelog explaining why we're
> doing this.

Sure, I will post another patchset that will include manpage update
and will CC:stable. That's of course after Michal's concerns are
addressed.
Thanks!

>
> Alternatively we could retain PTRACE_MODE_ATTACH's behaviour and add
> PTRACE_MODE_READ&CAP_SYS_NICE alongside that.
