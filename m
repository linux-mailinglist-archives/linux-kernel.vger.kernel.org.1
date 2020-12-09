Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348202D3937
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 04:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgLIDW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 22:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLIDW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 22:22:59 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B881DC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 19:22:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c1so147518wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 19:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEWLaiABhfSkvT1cOB+vXvjqCQDKr8VP2HOqqGxlXaU=;
        b=pcvicRPw5fYEgoz+vgcA1n+jR1qIiuAy8vpfCm59ZqryG+PILmlYM1YTrFKF/wyXpZ
         v1pywrJXjxoRPB8GkzlTagFXSd7kNkJGHzhriOnPCNwCDMK9i28G3mSf5EmV5tFFWE4Z
         6VGGhT0BHDl63+AbvGzdMKqnakYnPxEZqOnlVrW8DEu4/xzih1VVvbKwacsHZeI7IW/b
         XrzN4RVG4uKI220wjgDbdVZmGVqg1S/v9pzn8EPUQiis1Dv7fNabFblXHL9iULtncz1V
         DdUZ7ySgDlhUQI5aYOh+BUKMieD+QCltb5ahUFhEoxsmGo1HCWbkmLUnwyv8b5KtDrFM
         YCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEWLaiABhfSkvT1cOB+vXvjqCQDKr8VP2HOqqGxlXaU=;
        b=GaANNQB/IT/j5L+18ZUfb19ix995+XfpsGYrYryvrXcsNuKrfGSzw5/t3+kCGCFZNJ
         6Y64zwDfCoj+VG6Y7flLlEOXb2cowuePVXUmWEO8KO13yTVtlnN0nFEaLmu0HNUjX9Kd
         2ZZoQdrzvms5FngCHyzwdnSJxKrelJeX4INuSl0vPe9Eciohy8OWfled6jJQi5IoWDxY
         t9SOyarj0Lg6nnJJmUxwCVqcdnTQsqoxJDfT2m5mMXwiu2V9f6W10fU46by7CkSc+KPM
         Qnhg+dwVEYYmWrOLEHEQLg67sm4ObsGPikSWl4j+xHx2/+PTLZKCvCY8CXPLqjEIYGoL
         SvVQ==
X-Gm-Message-State: AOAM5300TvhrEJy+mviP+fCn/A09qfaghvzz6WtwTfu1X2MpEL05KRD4
        eHE5X6gauYkMZwg1kiSyEoVqRmPFmLF/R3JQFLnZJw==
X-Google-Smtp-Source: ABdhPJys8XjTYlYD4Is3VJpGoB4xidKKlzXKFYfxomIpBCqGHtRRE3dodQQQJaEyQSL7UKQnrDuTMgyBoQjbgGeEUGk=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr242674wru.334.1607484137328;
 Tue, 08 Dec 2020 19:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20201208083510.14344-1-odin@uged.al>
In-Reply-To: <20201208083510.14344-1-odin@uged.al>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 8 Dec 2020 19:22:06 -0800
Message-ID: <CAJuCfpFjdE3k+eWoJLZMp9miffmueZ0hgLLF1b_V6Kb4=i+D3g@mail.gmail.com>
Subject: Re: [PATCH] psi: fix monitor for root cgroup
To:     Odin Ugedal <odin@uged.al>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, dschatzberg@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 12:35 AM Odin Ugedal <odin@uged.al> wrote:
>
> Fix NULL pointer dereference when adding new psi monitor to the root
> cgroup. PSI files for root cgroup was introduced in df5ba5be742 by using
> system wide psi struct when reading, but file write/monitor was not
> properly fixed. Since the PSI config for the root cgroup isn't
> initialized, the current implementation tries to lock a NULL ptr,
> resulting in a crash.
>
> Can be triggered by running this as root:
> $ tee /sys/fs/cgroup/cpu.pressure <<< "some 10000 1000000"
>
>
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>  kernel/cgroup/cgroup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e41c21819ba0..5d1fdf7c3ec6 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3567,6 +3567,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
>  {
>         struct psi_trigger *new;
>         struct cgroup *cgrp;
> +       struct psi_group *psi;
>
>         cgrp = cgroup_kn_lock_live(of->kn, false);
>         if (!cgrp)
> @@ -3575,7 +3576,8 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
>         cgroup_get(cgrp);
>         cgroup_kn_unlock(of->kn);
>
> -       new = psi_trigger_create(&cgrp->psi, buf, nbytes, res);
> +       psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
> +       new = psi_trigger_create(psi, buf, nbytes, res);
>         if (IS_ERR(new)) {
>                 cgroup_put(cgrp);
>                 return PTR_ERR(new);
> --
> 2.29.2
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
