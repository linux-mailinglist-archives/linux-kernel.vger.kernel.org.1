Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1293F27D455
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgI2RXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2RXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:23:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:23:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so4669965ljd.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0kihtq9EEmKHWM3zruPiltig8hiiIn0Yr9BtelBznU=;
        b=ovoDyTIDaCHovVhgarrlkJiW3uoanu2Dm2kg75HE5YjCPdwIF49n3vTuVzV7lj0tN4
         P0fAfoGzzuq6nQpEo59jiYrDN+C8f2ePhyRSRu6x0QvKxwB3hZCTVl+C71oSxU7WKbnR
         VlNny7sKYqJhMirwiCcj9kuLgr2x1f0JNNsb+n/NWPjom6CVeJrAUZX+QobKpD4siZxi
         1Rj4Wja+QwjjN3huS55S3Z34ArKzzQPEeCiFBb0KzAJU+HkCB/1zSTa+14L3l9NAOXRm
         nSFEMbZkBTHiXaK4hdOtOUWhmF1w9qE6AeAk5CR+1VCEjUfz/Uns8y4JhPKPrnTKY8F0
         354g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0kihtq9EEmKHWM3zruPiltig8hiiIn0Yr9BtelBznU=;
        b=tvlJBIt4vSwS7jONnoJ9rWoI3YC59dHZhYZj0XQyyb96N8fLKMS3WPnYqCwPHTWg1b
         Ff3gPf1pBA8O9evnfNYop0+6wzulRLGAGiBMmTNv4iUiPypjENjezMfUL6lH0ASGAAAR
         57YhicJ4hU+My1kZuNGt/pbMZzjJsFw5LuZrIxMQ+YtkRLabjiTgRnqT/EhcixrSSUxS
         1lQjEDMCvfPdKOVjMQHYU3BK88s0my6T59zW71OnKW/PPhheBTqtooEVKlQw77MiAUJB
         Ak/NSxdszu6iLKwQlc85SlFk8kB0sVqUC/4IL7na0xfQKmS72NJkCgIwke2vQ25bhKvf
         sUeQ==
X-Gm-Message-State: AOAM53011RBasmnjq9CnJLYRp59/70CwjNa8WNgQfUxN8BOzv6nX4KfO
        0YaQvJeAwzg5WZ9q2lBKvnin5UGghRALgdquFyme0P8HPxFFImM=
X-Google-Smtp-Source: ABdhPJyCLkOp+ZKTAD5f7vfO6SBmZ3p05q09GWu3cQlbyz81kCkKIIbPvFko8r5xiHvzyJoiAVSGBMIdYdM4cX7MTPo=
X-Received: by 2002:a2e:7e0f:: with SMTP id z15mr1374067ljc.117.1601400180362;
 Tue, 29 Sep 2020 10:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200921110020.GA2139@willie-the-truck> <20200922092153.978003-1-asteinhauser@google.com>
 <20200928130208.GA11356@willie-the-truck> <CAN_oZf36S=eX5qgyXg+dRi+thN5tRWxp7=SWYvjO0hZhxTAhrQ@mail.gmail.com>
 <20200929081035.GA13576@willie-the-truck>
In-Reply-To: <20200929081035.GA13576@willie-the-truck>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Tue, 29 Sep 2020 13:22:48 -0400
Message-ID: <CAN_oZf3HkO5+f5OJibGpsnnu1Khnx5mxdSimL9bDBbs+33ka0A@mail.gmail.com>
Subject: Re: [PATCH v2] PR_SPEC_DISABLE_NOEXEC support for arm64.
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, catalin.marinas@arm.com,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Will,

Everything looks good to me now.
On Tue, Sep 29, 2020 at 4:10 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Anthony,
>
...
>
> I'll fold in the diff below, which I think solves the problem above; it's
> closer to what you had originally, just refactored a bit and with the
> execve()/fork() issue fixed.
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index 59f2ceb7a0e5..68b710f1b43f 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -660,6 +660,20 @@ void spectre_v4_enable_task_mitigation(struct task_struct *tsk)
>   * prctl() may be necessary even when PSTATE.SSBS can be toggled directly
>   * from userspace.
>   */
> +static void ssbd_prctl_enable_mitigation(struct task_struct *task)
> +{
> +       task_clear_spec_ssb_noexec(task);
> +       task_set_spec_ssb_disable(task);
> +       set_tsk_thread_flag(task, TIF_SSBD);
> +}
> +
> +static void ssbd_prctl_disable_mitigation(struct task_struct *task)
> +{
> +       task_clear_spec_ssb_noexec(task);
> +       task_clear_spec_ssb_disable(task);
> +       clear_tsk_thread_flag(task, TIF_SSBD);
> +}
> +
>  static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
>  {
>         switch (ctrl) {
> @@ -679,8 +693,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
>                 if (spectre_v4_mitigations_on())
>                         return -EPERM;
>
> -               task_clear_spec_ssb_disable(task);
> -               clear_tsk_thread_flag(task, TIF_SSBD);
> +               ssbd_prctl_disable_mitigation(task);
>                 break;
>         case PR_SPEC_FORCE_DISABLE:
>                 /* Force disable speculation: force enable mitigation */
> @@ -693,28 +706,33 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
>
>                 task_set_spec_ssb_force_disable(task);
>                 fallthrough;
> -       case PR_SPEC_DISABLE_NOEXEC:
> -               /* Disable speculation until execve(): enable mitigation */
> -               fallthrough;
>         case PR_SPEC_DISABLE:
>                 /* Disable speculation: enable mitigation */
>                 /* Same as PR_SPEC_FORCE_DISABLE */
>                 if (spectre_v4_mitigations_off())
>                         return -EPERM;
>
> -               task_set_spec_ssb_disable(task);
> -               set_tsk_thread_flag(task, TIF_SSBD);
> +               ssbd_prctl_enable_mitigation(task);
> +               break;
> +       case PR_SPEC_DISABLE_NOEXEC:
> +               /* Disable speculation until execve(): enable mitigation */
> +               /*
> +                * If the mitigation state is forced one way or the other, then
> +                * we must fail now before we try to toggle it on execve().
> +                */
> +               if (task_spec_ssb_force_disable(task) ||
> +                   spectre_v4_mitigations_off() ||
> +                   spectre_v4_mitigations_on()) {
> +                       return -EPERM;
> +               }
> +
> +               ssbd_prctl_enable_mitigation(task);
> +               task_set_spec_ssb_noexec(task);
>                 break;
>         default:
>                 return -ERANGE;
>         }
>
> -       /* Handle the 'noexec' flag separately to save bloating up the switch */
> -       if (ctrl == PR_SPEC_DISABLE_NOEXEC)
> -               task_set_spec_ssb_noexec(task);
> -       else
> -               task_clear_spec_ssb_noexec(task);
> -
>         spectre_v4_enable_task_mitigation(task);
>         return 0;
>  }
