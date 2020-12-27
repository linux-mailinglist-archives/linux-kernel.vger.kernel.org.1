Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9062E3178
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgL0OJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 09:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgL0OJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 09:09:43 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0FC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 06:09:02 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m23so7368303ioy.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+gHZP7cPtjKkPqaKCZF4F4VOdZT0vsYRHLmdMGfyQw=;
        b=HAb9AHPyWi200m7OLsILHBgdyIYXB1rXlCmuW4Y0jRYZYCpvSu8+vux3Kp9/sCVZ0q
         gJVPpBzyiEruffT21pHmy8KqMwbD8SbOuDu/4dxd3AGEQRXP7qZ712EsvG0aGxc6vQv0
         795TOdcUKI80jYa18yaY4yHFsq76fnRjiOYZ25gjIM8RiYZyyGSuIfrx8KiA1WFGbG6S
         rMtTzp0QeBh2GgwFnW+dY0TUACQosRugevLII954X5tBwz5BMm3FuNVcT8nCFsW25oK0
         qyrs+SpW1CFiliClIo0BJm9+gUL/mpBT3m0AvSdqVJqZlNXeHfBgry8jNkgdFPA/9L/6
         RCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+gHZP7cPtjKkPqaKCZF4F4VOdZT0vsYRHLmdMGfyQw=;
        b=hVgQzy0lRzm4WPDysSESRAZ3pgRDsuRWPCk3g3VmiDBe2Loflswn44vS1OUe+K3DtU
         kgrKOCB80xngcqViD0zGnGb68HedI68Wb4zRecUexWS696R/R6kS2i+GyLDnJ0RjDyat
         s/tRqInS8dUkoBDu7iWF7wxH4243d95Oo9DwRqgdhzFW+poVRtTRDiM5+zDzwUMwcKD3
         wf1BwobF8GWr1xTfZr1dZMTig3KoaTADumjGDTw2x5+LIyYECONxVvCb8YRmjPVHXW//
         0+5jwvCiT3AgXDW2z9nBZFIl0jwnb5qj46pZR4tWR41mcNifvvSKAS6TSNiA+z6xd0cf
         dlcw==
X-Gm-Message-State: AOAM5301ocBP/8M3bhL5C59GGWf360GjLiT6DK0GydNx5du2x8M8V527
        zM3XKIGDntRjDQnskv/ymRLIjhlI4WSmIkSLXzc=
X-Google-Smtp-Source: ABdhPJzXYu2ADxzzsbtwyKbChDm3/ylJsYdAfu5qmLASgY7f4DS8MeIwnoBmh39nCAZYzFL1w7tbCFBH6DW0NFxC6Ck=
X-Received: by 2002:a6b:441a:: with SMTP id r26mr33065790ioa.105.1609078142261;
 Sun, 27 Dec 2020 06:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20201218170919.2950-1-jiangshanlai@gmail.com> <20201226103421.6616-1-hdanton@sina.com>
 <20201226145239.GJ2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201226145239.GJ2657@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 27 Dec 2020 22:08:51 +0800
Message-ID: <CAJhGHyBGb_fBqp7-XCD0bkZOt5E_aPKwkViY3PUN1MVZuBE3KA@mail.gmail.com>
Subject: Re: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 10:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> >
> > Can you please specify a bit what you encountered in rcutorture
> > before this patchset? You know we cant have a correct estimation
> > of the fix diameter without your help.

>
> It triggers the following in sched_cpu_dying() in kernel/sched/core.c,
> exactly the same as for Lai Jiangshan:
>
>         BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq))
>
> Which is in fact the "this" in my earlier "rcutorture hits this".  ;-)
>
>                                                         Thanx, Paul
>

Hi, Hillf

https://lkml.org/lkml/2020/12/22/141

From the email, I think rcutorture encountered the same problem.

Hi, Paul

I'm sorry to forget to add your Tested-by.

Thanks
Lai
