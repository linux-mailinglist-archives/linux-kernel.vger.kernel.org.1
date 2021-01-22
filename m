Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA20530050E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbhAVOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbhAVOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:08:47 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9813C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:08:06 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l23so1642222qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TERIPq8AnRP0+heC8JP6C1Hqcc4LMIy29lTpckheB7I=;
        b=g8GUkZ7waXCLdvp9NP/6HED27xxvBUYuul5TF2IOCO3fvEztrPYrkLqiQiLAY4KJ2u
         0EfIuhIMqfkFkVsTTpkaNh4yl6rY/OYNJz7ggobBFo4x2D8RKDAvs3qkpQjekX1xU+lN
         f7q3pJfwJMPYu+x41OqiHrZB2gv+oZahg8GYw3eDQBcmpiydQKKrznQdWWFo5IMT6O8T
         vN2s6zh5zu+EWg+C8ka02G7jVaX7MAu5g9VfoBKNkRMvZpFodzJR3NPYL3prcyhLv3AJ
         IfdSE3/6KDxxtNd7osLUqcrmA5LbY4YBlotYJwFVZHXkPRqhyIe9TLbIgH1FvtBtbgzg
         8c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TERIPq8AnRP0+heC8JP6C1Hqcc4LMIy29lTpckheB7I=;
        b=qNULxTTVj31taex8np1eIdn2m5X9etecqCV2T/EwxUhYYroSqP/yfM9DjxBBfwp0LE
         jtB4BZNvosPUxpgGwB5m2aYZ0KsE2j4cuktEZcD1/vaOxMZ3z1GjkEEU0CXwynODlqdV
         ZEq+IrpREQ1r8epYLOOzBzYhBRwFK5rN4Wheje8TC1H9zo3X9jbQQ7GkqsbGmaZiqVxM
         0L8ZAJ/7C7sVOJknE9R4ve9C152dXGdyfI0slRahCQvFlK9LAP1ADGMRKwkTEZDCIDCH
         kGQAavVuCha9M8pWiPyrtEBBXHpPX/41JNLt/yZfAtBJMMiJNekm2Idg1crGd8IHLy6c
         804A==
X-Gm-Message-State: AOAM53318RTo2vIG46Gledn7BHS3uBAgASx3WBrABwT5sx376MmZxfji
        fFXwt7+yP6xWIkHNOF2PhWPVfJRs5j+HR0uao64qP8PGyDYfE4CJ
X-Google-Smtp-Source: ABdhPJzfvNjSEdtB3qItEhSxC0TUC7ROqxEUGjpCv/54F1yC2Oyrq0eA6BZz2oWGvWwfGQ/EMnQcXvem42bP95QxqkI=
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr4562036qti.246.1611324486158;
 Fri, 22 Jan 2021 06:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20201217170009.GA29186@192.168.3.9> <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
In-Reply-To: <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 22 Jan 2021 22:07:50 +0800
Message-ID: <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid status
To:     sblbir@amazon.com, davem@davemloft.net, bsingharora@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Balbir Singh,

Could you help review this patch, thanks

On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> Hi David,
>
> Could you help review this patch ?
>
> thanks
>
> On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> <zhangweiping@didiglobal.com> wrote:
> >
> > If a program needs monitor lots of process's status, it needs two
> > syscalls for every process. The first one is telling kernel which
> > pid/tgid should be monitored by send a command(write socket) to kernel.
> > The second one is read the statistics by read socket. This patch add
> > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > then kernel will collect statistics for that pid/tgid.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> > Changes since v1:
> >  * use /proc/taskstats instead of /dev/taskstats
> >
> >  include/uapi/linux/taskstats.h |  5 +++
> >  kernel/taskstats.c             | 73 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
> > index ccbd08709321..077eab84c77e 100644
> > --- a/include/uapi/linux/taskstats.h
> > +++ b/include/uapi/linux/taskstats.h
> > @@ -214,6 +214,11 @@ enum {
> >
> >  #define TASKSTATS_CMD_ATTR_MAX (__TASKSTATS_CMD_ATTR_MAX - 1)
> >
> > +/* ioctl command */
> > +#define TASKSTATS_IOC_ATTR_PID _IO('T', TASKSTATS_CMD_ATTR_PID)
> > +#define TASKSTATS_IOC_ATTR_TGID        _IO('T', TASKSTATS_CMD_ATTR_TGID)
> > +
> > +
> >  /* NETLINK_GENERIC related info */
> >
> >  #define TASKSTATS_GENL_NAME    "TASKSTATS"
> > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > index a2802b6ff4bb..c0f9e2f2308b 100644
> > --- a/kernel/taskstats.c
> > +++ b/kernel/taskstats.c
> > @@ -21,6 +21,8 @@
> >  #include <net/genetlink.h>
> >  #include <linux/atomic.h>
> >  #include <linux/sched/cputime.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/uio.h>
> >
> >  /*
> >   * Maximum length of a cpumask that can be specified in
> > @@ -28,6 +30,10 @@
> >   */
> >  #define TASKSTATS_CPUMASK_MAXLEN       (100+6*NR_CPUS)
> >
> > +#ifdef CONFIG_PROC_FS
> > +#define PROC_TASKSTATS "taskstats"
> > +#endif
> > +
> >  static DEFINE_PER_CPU(__u32, taskstats_seqnum);
> >  static int family_registered;
> >  struct kmem_cache *taskstats_cache;
> > @@ -666,6 +672,60 @@ static struct genl_family family __ro_after_init = {
> >         .n_ops          = ARRAY_SIZE(taskstats_ops),
> >  };
> >
> > +#ifdef CONFIG_PROC_FS
> > +static long taskstats_ioctl_pid_tgid(unsigned long arg, bool tgid)
> > +{
> > +       struct taskstats kstat;
> > +       struct taskstats *ustat = (struct taskstats *)arg;
> > +       u32 id;
> > +       unsigned long offset = offsetof(struct taskstats, ac_pid);
> > +       long ret;
> > +
> > +       /* userspace set monitored pid/tgid to the field "ac_pid" */
> > +       if (unlikely(copy_from_user(&id, (void *)(arg + offset), sizeof(u32))))
> > +               return -EFAULT;
> > +
> > +       if (tgid)
> > +               ret = fill_stats_for_tgid(id, &kstat);
> > +       else
> > +               ret = fill_stats_for_pid(id, &kstat);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (unlikely(copy_to_user(ustat, &kstat, sizeof(struct taskstats))))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +
> > +static long taskstats_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +       long ret;
> > +
> > +       switch (cmd) {
> > +       case TASKSTATS_IOC_ATTR_PID:
> > +               ret = taskstats_ioctl_pid_tgid(arg, false);
> > +               break;
> > +       case TASKSTATS_IOC_ATTR_TGID:
> > +               ret = taskstats_ioctl_pid_tgid(arg, true);
> > +               break;
> > +       default:
> > +               ret = -EINVAL;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct proc_ops taskstats_proc_ops = {
> > +       .proc_ioctl = taskstats_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +       .proc_compat_ioctl = taskstats_ioctl,
> > +#endif
> > +};
> > +#endif
> > +
> > +
> >  /* Needed early in initialization */
> >  void __init taskstats_init_early(void)
> >  {
> > @@ -682,9 +742,20 @@ static int __init taskstats_init(void)
> >  {
> >         int rc;
> >
> > +#ifdef CONFIG_PROC_FS
> > +       if (!proc_create(PROC_TASKSTATS,  0, NULL, &taskstats_proc_ops)) {
> > +               pr_err("failed to create /proc/%s\n", PROC_TASKSTATS);
> > +               return -1;
> > +       }
> > +#endif
> > +
> >         rc = genl_register_family(&family);
> > -       if (rc)
> > +       if (rc) {
> > +#ifdef CONFIG_PROC_FS
> > +               remove_proc_entry(PROC_TASKSTATS, NULL);
> > +#endif
> >                 return rc;
> > +       }
> >
> >         family_registered = 1;
> >         pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
> > --
> > 2.17.2
> >
