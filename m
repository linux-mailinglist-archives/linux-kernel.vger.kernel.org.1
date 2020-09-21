Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78F271B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgIUGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIUGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:51:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24784C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 23:51:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so10135661ljm.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFEyjNKnXFjtORRH/I824Zbl6zwPTcp6NAg5ggkruUs=;
        b=tA7x+C+w3RMlgXrK07ww814JHwdUA3uCiTFSEvshTcr4CzKvZ38o1BJtJ6HvKBInad
         zkOMsHFs/tlt4xL1mWdaDO0W6j0LV/ht+MW5Yy+fkCFx4hyhV5zaTZW1EIF5iump/I9D
         +N7YdRk/mXj/VmZECKptC2EBLV2Do73wGIo3aYuES9G+2KnhgL56jbRjUPq21S6R8QoW
         4c2W/NBQWYCiY1cJx405QTXgfqRhmc/fTLOobz5/NWybBKwlKpOyG4Oriu8NHXCo+M5z
         EPTMea3LJiStioo9YpvLkzhznaNQRoY7DHm9s/8sqHZSIPkA5O4CodsfktXzNaQU95WG
         hoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFEyjNKnXFjtORRH/I824Zbl6zwPTcp6NAg5ggkruUs=;
        b=ZYqZbb+oq7I44T0RKTj8LJ+kl7KpNWJI/5nQz5wk/Aza9pQJt90gJKQuHhPQnaKtzo
         tI2HRD25G4/lEyJ6Aw9KWYzxz7aBrpsUtHawbXphIwMQOzIAnwxrgAXCQ0+u6kBLvDcy
         2Q1l+lw35nF2fzS/GwArtoUKI6TRicHQhYZj7uMNQL8wmWSpZm6fGO8YoeE2tthQsfBW
         0Y9KM3Hra0DSw88dBgPxbJAMWsEoOJGnILqYKrTn7Q2grj9KirZOCd0Jc7xqnP97Ij9C
         4+Nb3SAxclqtPyF+WgE5nLqrsawIDTp9GGYqZcPH9C8k6l7jwGvTbBTIyhvIRBMJC5YU
         hRDw==
X-Gm-Message-State: AOAM533Xpw96H3/J2M5auVOPyEeE5LLqxfzUspGTNK1SR5Dwx/wpIbbK
        IWMBr6VFszltuLH9fCKFzs+1zf5rJW6t+VZRU7eDrdkOUzU=
X-Google-Smtp-Source: ABdhPJwbs3EKaW33Rj83mDKnCEb5cu5zIkrzbrsjF5Ab72yIss7G9jCZlDYni6+AzTLH3yNkXvWNPP+nXT3FDxKVzoo=
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr15302618ljb.423.1600671073338;
 Sun, 20 Sep 2020 23:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200918165518.23246-1-grygorii.strashko@ti.com>
In-Reply-To: <20200918165518.23246-1-grygorii.strashko@ti.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Sep 2020 08:51:02 +0200
Message-ID: <CAKfTPtApNLAYq-=UcD6bM8nhT3pp3DSp2bCxFsTF3AZKs6Qz3g@mail.gmail.com>
Subject: Re: [PATCH] pm: runtime: fix timer_expires on 32bits arch
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 at 18:55, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> The commit 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> hrtimers") switched PM runtime autosuspend to use hrtimers and all related
> time accounting in ns, but missed update the struct
> dev_pm_info->timer_expires to u64. This causes timer_expires value to be
> truncated on 32bits architectures when assignment is done from u64 values:
>
> rpm_suspend()
> |- dev->power.timer_expires = expires;
>
> Hence, fix it by changing timer_expires type to u64.
>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  include/linux/pm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index a30a4b54df52..47aca6bac1d6 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -590,7 +590,7 @@ struct dev_pm_info {
>  #endif
>  #ifdef CONFIG_PM
>         struct hrtimer          suspend_timer;
> -       unsigned long           timer_expires;
> +       u64                     timer_expires;
>         struct work_struct      work;
>         wait_queue_head_t       wait_queue;
>         struct wake_irq         *wakeirq;
> --
> 2.17.1
>
