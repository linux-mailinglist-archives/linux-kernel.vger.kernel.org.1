Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD01C435F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 19:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgEDRzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730215AbgEDRzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:55:09 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF33C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:55:08 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id u12so235653vsq.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/gQPiK17suTq6DuWJoy9CBpFSu8hTHVI3iRDs2LpJo=;
        b=Z9NzLadpYL6ZcaMH8/UG7+m0Is3JRgBpqDvu0N+weEfhTLO4xOv4bkPY7JC32O0chR
         uaZw/ZHjB92vj9dcV/KOk9raMH9IwyPJS6TtHalY0UWnBRRcxCJ92zgKH3v2OrH/kkOz
         Qudc2N/RPNQTufP/DoNvsRmw23xnTPWkfgoes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/gQPiK17suTq6DuWJoy9CBpFSu8hTHVI3iRDs2LpJo=;
        b=gdE+vXNpdBQbujAL3nnvmuRjidhhAeqy7E7d8esgttoZ10pxgolS/Of80y3mWx14K7
         X+VuPZTX8g1Pat6wxP6Q7xfozyyEnStJXJYFjsS17YyHGXtdmBd3JtGLYaIJG9jskBvZ
         L7iVLHznBFsrEK1RZpvCtuzkrQ42oy6+CRUfTD5MWimN+l5JJxAlhNp2kv2E4nq9VsJX
         2nGyDdkTnlcu5TwN1LjCCdD+rm2AvG0ekKQBBRjZx/SYyMfAxy0fyPo6BKXauMMl+ibt
         zlTethONxfabd8JlPpI7icm5R1SQmRNAejbwmu3H0j4cYhkt6Vq6Znk6N+IoVzL1TygB
         pcfw==
X-Gm-Message-State: AGi0PuZsL9VUoA6RmPYiQ51OdKJJuSLFPvskePp00UWTy2vRwpvdPTFN
        VQxUDP8GhC0u/T0hzQsWw0ozAByHmGU=
X-Google-Smtp-Source: APiQypIhw/aRIfEz5eDikfeNZPnwPN8gv0p9zmvEsz4l8NCoCGM9x5OiTXbcbTyFFdKwf0iR8qNMSg==
X-Received: by 2002:a05:6102:208f:: with SMTP id h15mr314525vsr.69.1588614906758;
        Mon, 04 May 2020 10:55:06 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id u85sm4945147vsu.22.2020.05.04.10.55.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:55:06 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id l25so206651vso.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:55:06 -0700 (PDT)
X-Received: by 2002:a67:fc46:: with SMTP id p6mr308066vsq.169.1588614905535;
 Mon, 04 May 2020 10:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200424094610.v5.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <e8310c51-d7b1-ac88-cd6b-0965804eb754@codeaurora.org>
In-Reply-To: <e8310c51-d7b1-ac88-cd6b-0965804eb754@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 May 2020 10:54:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WF4=4ZgeBE8WYysW1HevynMrPqv6oU4a=hZMQ_z9juiA@mail.gmail.com>
Message-ID: <CAD=FV=WF4=4ZgeBE8WYysW1HevynMrPqv6oU4a=hZMQ_z9juiA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] soc: qcom: rpmh-rsc: Correctly ignore
 CPU_CLUSTER_PM notifications
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 3, 2020 at 10:19 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 4/24/2020 10:16 PM, Douglas Anderson wrote:
> > Our switch statement doesn't have entries for CPU_CLUSTER_PM_ENTER,
> > CPU_CLUSTER_PM_ENTER_FAILED, and CPU_CLUSTER_PM_EXIT and doesn't have
> > a default.  This means that we'll try to do a flush in those cases but
> > we won't necessarily be the last CPU down.  That's not so ideal since
> > our (lack of) locking assumes we're on the last CPU.
> >
> > Luckily this isn't as big a problem as you'd think since (at least on
> > the SoC I tested) we don't get these notifications except on full
> > system suspend.  ...and on full system suspend we get them on the last
> > CPU down.  That means that the worst problem we hit is flushing twice.
> > Still, it's good to make it correct.
> >
> > Fixes: 985427f997b6 ("soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches")
> > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Corrently => Correctly
> >
> > Changes in v4:
> > - ("...Corrently ignore CPU_CLUSTER_PM notifications") split out for v4.
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> >   drivers/soc/qcom/rpmh-rsc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index a9e15699f55f..3571a99fc839 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -806,6 +806,8 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
> >       case CPU_PM_EXIT:
> >               cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_pm);
> >               goto exit;
> > +     default:
> > +             return NOTIFY_DONE;
>
> I noticed a bug here,
>
> Either need to unlock and return here.

Dang it!  Thank you very much for noticing.  v6 sent.  I removed both
yours and Stephen's "Reviewed-by" tags.  Please re-review to make sure
I didn't do anything else stuid.


> +       default:
> +               ret = NOTIFY_DONE;
> +               goto exit;
>
> Or
>
> If you move this patch at the end of series, it should will work fine as is.
> Since in patch 5 of this series,  pm_lock is removed, so return
> NOTIFY_DONE; do not any unlock.

Right.  It used to be part of the last patch but Stephen requested I
move the bugfixes first so they could land sooner even if we aren't
ready to land the "remove the pm_lock" patch.


> When i pulled in only first two changes in this series i got spinlock
> recursion during suspend-resume.
> Back when i pull in entire series for validation, the issue do not come
> because last patch removes pm_lock.

OK, v6 is sent out.

-Doug
