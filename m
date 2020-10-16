Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA8290B41
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391665AbgJPSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391559AbgJPSZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:25:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC9C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:25:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so5085668ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H94CcgSvoIFt4eb8xx+jgPXylVUqc01bZ1bzkG3yk18=;
        b=pkd24YtztESI+PfUnD1xCEGpwDBledIKaA7zmnGVNDsCkXZFfBnhxGEe5IBDuKpR8x
         TO9hO3LiOSl9qS5Y1mWNb2c7fxnr6TAOprB944NpsMlVre+AxvF460WPgPziM58YvsF/
         mpALdX2yqj4rTSqrgWD/Ixg/1w9rHhHfE/DGsY+h+u1MiIuwR6I299roQEqAI4kDKcVd
         aUxt51Yc/LLbd6cL7AnlMs2gfvX89WyU/hgci4tnl5bJbWrfL2LhMbyNz4TdLqviVUl7
         +xeXxomOiOXwdKhEmJNb70KTvO7PwJhQgoqna4Bu0JDFPSDjs7ONFCNVy1ZOPwyQ0rNi
         q6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H94CcgSvoIFt4eb8xx+jgPXylVUqc01bZ1bzkG3yk18=;
        b=NZW7KjMMGewDUc4xJ0zAEJMGBgwzg6+UynLzJaGQv8hcKiMa8J545ikDgOkd+J9jXw
         TnPhYGSg/gF9zMHyPZcyIix2O/bqzFGCYRwRxyEis1AsCVrzrX3HrgS3X6//E6JPn+4a
         t4QyvCJVdClE85ap6UmvT76k7LrpD2QWYWDTgki0aIQbbv4GFkIKp8nXqt4ZmjSPeYwv
         pmL62wTUi6SHiJIt2NRmZhSIrxmjy9qKS9qBskbGUODiB2WznsGWjdS6W/ql+TG7PlfI
         qssWr2MwuBT1EgBB5nNSljLwmPpEaJvqnVOPMw3PCqJo6ZQSFT/z3JyKAx5vvlQ3MtGi
         fSLA==
X-Gm-Message-State: AOAM532OK31L5LIRJjtaMI/zkhJET6bGVa3t6lHZtNwev2m5unabbck7
        UyDPySfsAIJs/3TYGmEWEmgBrZMgXxJRp7K9cRw=
X-Google-Smtp-Source: ABdhPJw5Y0eNTk6lBLN1SHs6VLBL/9EObUmdAu1lA/4RCMYltkLlgictyvVxBPeBodUqwt7bo+Q5eyTguzAXdz24nlY=
X-Received: by 2002:a05:6638:14c5:: with SMTP id l5mr3562028jak.68.1602872706946;
 Fri, 16 Oct 2020 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201016173020.12686-1-jassisinghbrar@gmail.com> <20201016175039.7xs4cafoe2uq7zus@bogus>
In-Reply-To: <20201016175039.7xs4cafoe2uq7zus@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Oct 2020 13:24:56 -0500
Message-ID: <CABb+yY0Mf_Nj=FoWkiVOQPFa9jay60u7+gpj-Q7bmm5EQqZWpA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: avoid timer start from callback
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da@libre.computer>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:50 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 16, 2020 at 12:30:20PM -0500, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > If the txdone is done by polling, it is possible for msg_submit() to start
> > the timer while txdone_hrtimer() callback is running. If the timer needs
> > recheduling, it could already be enqueued by the time hrtimer_forward_now()
> > is called, leading hrtimer to loudly complain.
> >
> > WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> > CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> > Hardware name: Libre Computer AML-S805X-AC (DT)
> > Workqueue: events_freezable_power_ thermal_zone_device_check
> > pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> > pc : hrtimer_forward+0xc4/0x110
> > lr : txdone_hrtimer+0xf8/0x118
> > [...]
> >
> > This can be fixed by not starting the timer from the callback path. Which
> > requires the timer reloading as long as any message is queued on the
> > channel, and not just when current tx is not done yet.
> >
>
> I came to similar conclusion and was testing something similar. You bet
> me. Since we have single timer and multiple channels, each time a message
> is enqueued on any channel, timer gets added which is wrong.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I tested this patch too by reverting offending commit in -next, so
>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> You seem to have dropped the Fixes tags. Is that intentional ? If so,
> any particular reasons. I think it is stable material and better to have
> fixes tag so that it gets added to stable trees.
>
Thanks for testing. I will decorate it appropriately once I have
Jerome's tested-by too.

-jassi
