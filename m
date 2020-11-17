Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4602B68DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKQPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:38:12 -0500
Received: from m12-12.163.com ([220.181.12.12]:50074 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgKQPiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=u58mj
        Jkzv3jdDruoOquOasmAn5u3VBPVz/2w85IZ+Xk=; b=EG/B2QM9kjV3Ehvvl31eI
        KdPJc+OIAHLwXZC6lz42rGMlhTIIj+37mjoES3Va1Hei5hbD/Jk5fv0SWSiRDjNw
        w+4QqDutOjIQtYt1OFTSLMvWmfJpcK5KLzgVDAyp0iq+S5cTuCG91BSOo9n3NcGG
        5MLmz/QLyqsyGRI5HgtqH8=
Received: from localhost (unknown [101.86.213.176])
        by smtp8 (Coremail) with SMTP id DMCowAAnf_vM7bNfaN__CA--.19301S2;
        Tue, 17 Nov 2020 23:35:41 +0800 (CST)
Date:   Tue, 17 Nov 2020 23:35:40 +0800
From:   Hui Su <sh_def@163.com>
To:     Andrey Vagin <avagin@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nsproxy: remove judge of timens_on_fork()'s return val
Message-ID: <20201117153540.GA4268@rlk>
References: <20201115181457.GA376527@rlk>
 <CANaxB-zC9pCF-Vkda4dbPTdn+m8ObLunNFiOf5aAcECh6MFYQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-zC9pCF-Vkda4dbPTdn+m8ObLunNFiOf5aAcECh6MFYQQ@mail.gmail.com>
X-CM-TRANSID: DMCowAAnf_vM7bNfaN__CA--.19301S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFykJryUArykXw15ArykAFb_yoW8Zw17pF
        4ktr9Fyw4jq34qgF15Xa1DuryakwnYq3W8Gw1kCa4Sk3ZFgry3GF1vyw1Y9r4Fyrs2grWx
        XFW8Jwn8trn0q37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UM89_UUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByw3fX1PAPtOwjAAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:30:26AM -0800, Andrey Vagin wrote:
> On Sun, Nov 15, 2020 at 10:36 AM Hui Su <sh_def@163.com> wrote:
> >
> > timens_on_fork() always return 0, and maybe not
> > need to judge the return value in copy_namespaces().
> 
> Thank you for cleaning this up. I think we can go even further and
> change timens_on_fork to return nothing:
> 
> -int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
> +void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
>  {
>         struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
>         struct time_namespace *ns = to_time_ns(nsc);
> 
>         /* create_new_namespaces() already incremented the ref counter */
>         if (nsproxy->time_ns == nsproxy->time_ns_for_children)
> -               return 0;
> +               return;
> 
>         get_time_ns(ns);
>         put_time_ns(nsproxy->time_ns);
>         nsproxy->time_ns = ns;
> 
>         timens_commit(tsk, ns);
> -
> -       return 0;
>  }
> 
> 
> >
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> >  kernel/nsproxy.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index 12dd41b39a7f..e2e6c5dc433f 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -153,7 +153,6 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
> >         struct nsproxy *old_ns = tsk->nsproxy;
> >         struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
> >         struct nsproxy *new_ns;
> > -       int ret;
> >
> >         if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
> >                               CLONE_NEWPID | CLONE_NEWNET |
> > @@ -180,11 +179,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
> >         if (IS_ERR(new_ns))
> >                 return  PTR_ERR(new_ns);
> >
> > -       ret = timens_on_fork(new_ns, tsk);
> > -       if (ret) {
> > -               free_nsproxy(new_ns);
> > -               return ret;
> > -       }
> > +       timens_on_fork(new_ns, tsk);
> >
> >         tsk->nsproxy = new_ns;
> >         return 0;
> > --
> > 2.29.0
> >
> >

Yeah, thank for your reply, Andrey.

I will resend PATCH V2 with makeing timens_on_fork() return nothing.

Thanks.

