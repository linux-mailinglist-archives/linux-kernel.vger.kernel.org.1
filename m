Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC72A2B5AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKQIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:30:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36065 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:30:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id n89so18630651otn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6z//zTI4jETXZ2/3aGkT7hNoZjFZ9VayNDxxzYNyiI=;
        b=p3Q9RkrcNteiO5s0Yrl0aEXimeXemC87OLHkGqLp2Z9Idwjh6gqJ2P6sMvZ91Fk2sG
         Q/1v9pDZZQQYEjsuHjDNlfLLCBE9LaMp6P30Kq89XqTpV2inkc7XYySpr+vKEGfaFEeX
         jyUqzTHjYug9N8LpU0vJ5Ut3DxCtcssnjPYOVNyn0as+fSKzIHn60Yit4HgXFW5biFsR
         8CazUgMwCcxsHVtRuJyOOklSfdCTzgH47gXCZ9oosIHh/GhFu0fLMuV25LDQ9FG8CvT+
         0vL2AwzXBo7DX3nFO1nLA8TP/5+ORQMbw1v2J4CB/N6U4QLP6HJ67VXilYxB8FJomFC7
         wiNA==
X-Gm-Message-State: AOAM533OQoVxlvsK0fIkjPdt2sISGHz+3wQpxtq826o6OR5sCJ4sVuW8
        3KpNl7PNcnObRA28M8TyKA+AXn1t4vO11neGefHBAaZERJnnIQ==
X-Google-Smtp-Source: ABdhPJwrgfuR/+NRgbIujdkTjxXwvhOp1Pe1dLqaAsjzU/qY01FL0aYqa13AuSaMFHNQJlh0hOANkipzP09JFoPVXbE=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr2126776otg.95.1605601837593;
 Tue, 17 Nov 2020 00:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20201115181457.GA376527@rlk>
In-Reply-To: <20201115181457.GA376527@rlk>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Tue, 17 Nov 2020 00:30:26 -0800
Message-ID: <CANaxB-zC9pCF-Vkda4dbPTdn+m8ObLunNFiOf5aAcECh6MFYQQ@mail.gmail.com>
Subject: Re: [PATCH] nsproxy: remove judge of timens_on_fork()'s return val
To:     Hui Su <sh_def@163.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 10:36 AM Hui Su <sh_def@163.com> wrote:
>
> timens_on_fork() always return 0, and maybe not
> need to judge the return value in copy_namespaces().

Thank you for cleaning this up. I think we can go even further and
change timens_on_fork to return nothing:

-int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
        struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
        struct time_namespace *ns = to_time_ns(nsc);

        /* create_new_namespaces() already incremented the ref counter */
        if (nsproxy->time_ns == nsproxy->time_ns_for_children)
-               return 0;
+               return;

        get_time_ns(ns);
        put_time_ns(nsproxy->time_ns);
        nsproxy->time_ns = ns;

        timens_commit(tsk, ns);
-
-       return 0;
 }


>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/nsproxy.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 12dd41b39a7f..e2e6c5dc433f 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -153,7 +153,6 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>         struct nsproxy *old_ns = tsk->nsproxy;
>         struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
>         struct nsproxy *new_ns;
> -       int ret;
>
>         if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
>                               CLONE_NEWPID | CLONE_NEWNET |
> @@ -180,11 +179,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>         if (IS_ERR(new_ns))
>                 return  PTR_ERR(new_ns);
>
> -       ret = timens_on_fork(new_ns, tsk);
> -       if (ret) {
> -               free_nsproxy(new_ns);
> -               return ret;
> -       }
> +       timens_on_fork(new_ns, tsk);
>
>         tsk->nsproxy = new_ns;
>         return 0;
> --
> 2.29.0
>
>
