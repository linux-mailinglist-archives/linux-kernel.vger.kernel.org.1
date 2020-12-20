Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17172DF659
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 18:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgLTR5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 12:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgLTR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 12:57:43 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5683C061248
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 09:57:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h205so18286078lfd.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SS+6SdyI+rcbjDhdXHsBBuRjftGGhmQIeaQJPFsBWOw=;
        b=VF2768VKMUoOTOyLhEcc33S2gDZQzecQ5yLZXCdms/VkHQSKK14LS9xpCUAtklLtCW
         dT714LE4G3wPtziW7FuhqvUUmJv27X65NJZXWaLYYH93AenP/cvvghl9hZn23nB2ffvk
         r80B0mg+d4mLEsMokSlOmvyuIbdpdyrqt9M5JLnCvNGz27Mv2MvNqYUirGoXNouaZqs9
         KBSa4BVvt7IGyxgTnxjy44CBTRXxZUyzHjof7lnD54j/td7G02bC71LbHhq6cmExr4BH
         AAD0DaWcpZ7wL3JE+pT3R7kLY6KLu90Mg864z91I6H5eKcHtXo1Yzc9rvAaS7PsRtZZX
         YR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS+6SdyI+rcbjDhdXHsBBuRjftGGhmQIeaQJPFsBWOw=;
        b=Afa+a2HA+Kl+qNY1T92PmVvP2Ol02+Fr7V1o3kboT/G1f7IcgPCeL6AM7k5GkULb/1
         bCESRDdAsXsxL3+QLNBtcJ+Cr7YdQJcNDsTfi9Z8D/0SBdgDtUyMpoKlvDkMwCioIz4S
         0XxrqrwcbT+n37c/RGFPOHR+G40ty40aNPhSkvjUTyDsdu4dX5bKabrAmV8CvLFUlOE+
         82T+p4Mi/NrbEUsQCxz7OT3txmnMWyp1JUNahp+8CNB8zH61aovjEAkWusgcHcYfWvmV
         hQmTr0U1RcPDP7le8ThEHanit8yPBJzmnN5NBeZwpCGdRa1D4tYnsyxB+Hkma16zoIyP
         APFw==
X-Gm-Message-State: AOAM532pt8lI5WTIAWuIR8C9fz4cyfnYF7a7rYZpoKz1gwK74B4polB9
        zwA2tsqjw18TsneN8Jt8/Dm9ReCxnovGzOldsbjOVg==
X-Google-Smtp-Source: ABdhPJwqIA3fLTEbYJXYWeMIbFuRSlHYQCbyICUZdE7FIuD8fsHpJtYEmKF7ASr8FE2SN7X+jcqL90KZKzf6EGBt6Yg=
X-Received: by 2002:a2e:b0d3:: with SMTP id g19mr5712254ljl.279.1608487018981;
 Sun, 20 Dec 2020 09:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com> <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
 <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com>
 <CAOQ4uxh3vEBMs8afudFU3zxKLpcKG7KuWEGkLiH0hioncum1UA@mail.gmail.com>
 <CALvZod6fua_SQ=1+MX_R52w8PVbFafSHgjcmhXdaRWkZtfe+cg@mail.gmail.com> <CAOQ4uxhNw12XSb7dVbUAGh+LdDzpVaF=LozoPTuXOjL8DGXn4Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhNw12XSb7dVbUAGh+LdDzpVaF=LozoPTuXOjL8DGXn4Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 20 Dec 2020 09:56:48 -0800
Message-ID: <CALvZod4jMF96Un_wM019pQxjJZemokrwed2PgPpXW9-EhhQnUw@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 3:31 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Dec 20, 2020 at 6:24 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Sat, Dec 19, 2020 at 8:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Sat, Dec 19, 2020 at 4:31 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Sat, Dec 19, 2020 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > > >
> > > > > > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > > > > > number of inotify instances on the system. For systems running multiple
> > > > > > workloads, the per-user namespace sysctl max_inotify_instances can be
> > > > > > used to further partition inotify instances. However there is no easy
> > > > > > way to set a sensible system level max limit on inotify instances and
> > > > > > further partition it between the workloads. It is much easier to charge
> > > > > > the underlying resource (i.e. memory) behind the inotify instances to
> > > > > > the memcg of the workload and let their memory limits limit the number
> > > > > > of inotify instances they can create.
> > > > >
> > > > > Not that I have a problem with this patch, but what problem does it try to
> > > > > solve?
> > > >
> > > > I am aiming for the simplicity to not set another limit which can
> > > > indirectly be limited by memcg limits. I just want to set the memcg
> > > > limit on our production environment which runs multiple workloads on a
> > > > system and not think about setting a sensible value to
> > > > max_user_instances in production. I would prefer to set
> > > > max_user_instances to max int and let the memcg limits of the
> > > > workloads limit their inotify usage.
> > > >
> > >
> > > understood.
> > > and I guess the multiple workloads cannot run each in their own userns?
> > > because then you wouldn't need to change max_user_instances limit.
> > >
> >
> > No workloads can run in their own user namespace but please note that
> > max_user_instances is shared between all the user namespaces.
>
> /proc/sys/fs/inotify/max_user_instances is shared between all the user
> namespaces, but it only controls the init_user_ns limits.
> /proc/sys/user/max_inotify_instances is per user ns and it is the one that
> actually controls the inotify limits in non init_user_ns.
>
> That said, I see that it is always initialized to MAX_INT on non init user ns,
> which is exactly the setup that you are aiming at:
>
> $ unshare -U
> $ cat /proc/sys/user/max_inotify_instances
> 2147483647
> $ cat /proc/sys/fs/inotify/max_user_instances
> 128

From what I understand, namespace-based limits are enforced
hierarchically. More specifically in the example above, the
application running in a user namespace with
/proc/sys/user/max_inotify_instances = 2147483647 and
/proc/sys/fs/inotify/max_user_instances = 128 will not be able to
create more than 128 inotify instances. I actually tested this with a
simple program which calls inotify_init() in a loop and it starts
failing before the 128th iteration.
