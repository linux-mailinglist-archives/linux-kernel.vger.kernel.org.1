Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC012E4154
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439598AbgL1OLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439164AbgL1OKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:10:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB3C061798
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:10:15 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 19so8817984qkm.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=660sEowX8NUl1TY2PSGi855PhDC79tS6p6oPbmXtfW8=;
        b=fBVUWIf8P3+k3u5W4NjqjSEmtkBfy31xsHGz2+wwYB3OWCmY1NJDqzYjnpwg9UcXn2
         1Gj5NdEfnTDuxNPVFSvl3Ky0U0XBMi5DYNgVfAi4ZmICQLoZ18soaqGPUhSz3VXzOPGR
         jrRAlisAAj+pPA8j4CjlWTqKV54VDj587pMPWQh1InG9qoYXvBgrGCHz1nTN69FWiX1N
         zMDzZbvABPFD14qXk/J6+Qe1g0cIrDf8knaxw5sfC1CWPoDiYWL31tFF+J653midM54S
         4HCEnVmBG1iQ4KthlhHyfHXT0CQFRMRinVb3UE54jqIzZnJlmHVtn+oSLiUp23Q8+JO7
         a86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=660sEowX8NUl1TY2PSGi855PhDC79tS6p6oPbmXtfW8=;
        b=Wqr0exUhNOjGtNdAzoP+N1AlpdM1oYo0l1Jr8RABp2ltyfaZRazucx/XbCYErHUBZt
         RLlTC/AZITib+z6gHoAsmzsHTetlJbXUMJYCMEsGgXKsLt/4XEKpL6iUX/4KTwZ28OkT
         8jXSa5E1VPOgi3j5Foa6J9uB4RZN3mBJdyPuyq5ej20G9NnsbNnV6/N93QDYmUQp0NGi
         9oettza5w7ovKaNXllsU/Zrv/XkpvMabQkvu3lOEKpEJbVdtNQjszJwYR7oCtXtrWp/O
         n8e0Eyv1YIRZNX6BNmZkBl/0ghlxU+LR1taG9i8KLSi91igWpdKloUO03mEbgCskDkGf
         gahg==
X-Gm-Message-State: AOAM532fF/511Bl7ASo4aZ+8EF87o/KMvCyIRtUBdMKat39fHDREfphC
        2edg6Snu5arhF4eFaeFp/453o8Y0emkm+IYFxtQ=
X-Google-Smtp-Source: ABdhPJwzPxtVoTPN0Nmz+v1/YjM5oX41b9gzZxow/JI60gsV+mqAwAVkzphIxglY5Y6AEsHufDxPJfImTGUN9Ju/rfw=
X-Received: by 2002:ae9:f312:: with SMTP id p18mr43728735qkg.311.1609164614671;
 Mon, 28 Dec 2020 06:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20201217170009.GA29186@192.168.3.9>
In-Reply-To: <20201217170009.GA29186@192.168.3.9>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Mon, 28 Dec 2020 22:10:03 +0800
Message-ID: <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid status
To:     davem@davemloft.net, bsingharora@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Could you help review this patch ?

thanks

On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
<zhangweiping@didiglobal.com> wrote:
>
> If a program needs monitor lots of process's status, it needs two
> syscalls for every process. The first one is telling kernel which
> pid/tgid should be monitored by send a command(write socket) to kernel.
> The second one is read the statistics by read socket. This patch add
> a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> The user just set the target pid/tgid to the struct taskstats.ac_pid,
> then kernel will collect statistics for that pid/tgid.
>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
> Changes since v1:
>  * use /proc/taskstats instead of /dev/taskstats
>
>  include/uapi/linux/taskstats.h |  5 +++
>  kernel/taskstats.c             | 73 +++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
> index ccbd08709321..077eab84c77e 100644
> --- a/include/uapi/linux/taskstats.h
> +++ b/include/uapi/linux/taskstats.h
> @@ -214,6 +214,11 @@ enum {
>
>  #define TASKSTATS_CMD_ATTR_MAX (__TASKSTATS_CMD_ATTR_MAX - 1)
>
> +/* ioctl command */
> +#define TASKSTATS_IOC_ATTR_PID _IO('T', TASKSTATS_CMD_ATTR_PID)
> +#define TASKSTATS_IOC_ATTR_TGID        _IO('T', TASKSTATS_CMD_ATTR_TGID)
> +
> +
>  /* NETLINK_GENERIC related info */
>
>  #define TASKSTATS_GENL_NAME    "TASKSTATS"
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index a2802b6ff4bb..c0f9e2f2308b 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -21,6 +21,8 @@
>  #include <net/genetlink.h>
>  #include <linux/atomic.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/proc_fs.h>
> +#include <linux/uio.h>
>
>  /*
>   * Maximum length of a cpumask that can be specified in
> @@ -28,6 +30,10 @@
>   */
>  #define TASKSTATS_CPUMASK_MAXLEN       (100+6*NR_CPUS)
>
> +#ifdef CONFIG_PROC_FS
> +#define PROC_TASKSTATS "taskstats"
> +#endif
> +
>  static DEFINE_PER_CPU(__u32, taskstats_seqnum);
>  static int family_registered;
>  struct kmem_cache *taskstats_cache;
> @@ -666,6 +672,60 @@ static struct genl_family family __ro_after_init = {
>         .n_ops          = ARRAY_SIZE(taskstats_ops),
>  };
>
> +#ifdef CONFIG_PROC_FS
> +static long taskstats_ioctl_pid_tgid(unsigned long arg, bool tgid)
> +{
> +       struct taskstats kstat;
> +       struct taskstats *ustat = (struct taskstats *)arg;
> +       u32 id;
> +       unsigned long offset = offsetof(struct taskstats, ac_pid);
> +       long ret;
> +
> +       /* userspace set monitored pid/tgid to the field "ac_pid" */
> +       if (unlikely(copy_from_user(&id, (void *)(arg + offset), sizeof(u32))))
> +               return -EFAULT;
> +
> +       if (tgid)
> +               ret = fill_stats_for_tgid(id, &kstat);
> +       else
> +               ret = fill_stats_for_pid(id, &kstat);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (unlikely(copy_to_user(ustat, &kstat, sizeof(struct taskstats))))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static long taskstats_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       long ret;
> +
> +       switch (cmd) {
> +       case TASKSTATS_IOC_ATTR_PID:
> +               ret = taskstats_ioctl_pid_tgid(arg, false);
> +               break;
> +       case TASKSTATS_IOC_ATTR_TGID:
> +               ret = taskstats_ioctl_pid_tgid(arg, true);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct proc_ops taskstats_proc_ops = {
> +       .proc_ioctl = taskstats_ioctl,
> +#ifdef CONFIG_COMPAT
> +       .proc_compat_ioctl = taskstats_ioctl,
> +#endif
> +};
> +#endif
> +
> +
>  /* Needed early in initialization */
>  void __init taskstats_init_early(void)
>  {
> @@ -682,9 +742,20 @@ static int __init taskstats_init(void)
>  {
>         int rc;
>
> +#ifdef CONFIG_PROC_FS
> +       if (!proc_create(PROC_TASKSTATS,  0, NULL, &taskstats_proc_ops)) {
> +               pr_err("failed to create /proc/%s\n", PROC_TASKSTATS);
> +               return -1;
> +       }
> +#endif
> +
>         rc = genl_register_family(&family);
> -       if (rc)
> +       if (rc) {
> +#ifdef CONFIG_PROC_FS
> +               remove_proc_entry(PROC_TASKSTATS, NULL);
> +#endif
>                 return rc;
> +       }
>
>         family_registered = 1;
>         pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
> --
> 2.17.2
>
