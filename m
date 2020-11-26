Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC692C4EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbgKZG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgKZG2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:28:38 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF68C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:28:36 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d8so917025lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrCn0HK4581wnsppy1Np5qiOd8IF6a02wHXrju6sSj8=;
        b=MT3ReyDA7GcUE3UEiRtFN8XqF1c4x/Bat1aEy7UvE3NUZIGQ7+0vGliiI6mLh18xy6
         K+IMDFI98iJFuZ3KGhx+MiNbu0shWRW8oalOqLC7DHEvDfGX8c7QoiF+UOrxBcQ8Z8La
         0/xjg/qnlzTzaVYJGEKY4DRpGqhPmkF5VKKKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrCn0HK4581wnsppy1Np5qiOd8IF6a02wHXrju6sSj8=;
        b=pigvbFr29PmFlCUo7juhnsIrtWTV7ZB4ooHBy5RKMX2EAHrv+iY1m/SsJu0GISVotL
         6R2dbR4/SDU8xJVl3IdMv26DyclKgawUteL34HfEqYuY5B6Q/2fkIYI3kGnGUyIU23MR
         LOLRg0uiV86ASpdNPc5B9X3OgbEDE4jLvXtVZj/i0TF8tbuEtduTR2abq/5Lruy/UDjK
         TSCG3glzxTGdSvbIO652Rmc3vvlIS9OXUk7qUcOZqUnVFLUX8PKfLn5RfEm9TJv/z9h9
         uswLlDazj6y7KVik9CctyQy9E0GTsQP5g2j+1hrcj6JFC13WYG3ZC93OhDadoBCbPGC9
         cg5Q==
X-Gm-Message-State: AOAM5311wMR0ySCqv5Ri+ggEQuBLBTTpEdySQE63isNfgZN0LGJ0svkr
        0E9gwQTv34Yg10PKiEavm08+VIHB6dtcLQD2
X-Google-Smtp-Source: ABdhPJzR7++Zu88hP7tEzUA99kkkTIQJu2FnBK7BrLpxaNtOx/7r89XKLbD6uck6AJPbzzzrRl9ZXA==
X-Received: by 2002:ac2:5219:: with SMTP id a25mr721369lfl.264.1606372114490;
        Wed, 25 Nov 2020 22:28:34 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id d22sm484997ljh.44.2020.11.25.22.28.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 22:28:34 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id j10so1084022lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:28:33 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr698548ljj.312.1606372113030;
 Wed, 25 Nov 2020 22:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
 <20201120001037.10032-3-stanimir.varbanov@linaro.org> <CAPBb6MUnXmtSKy9NwikYXjafgB+WM9TKEFjkYK16T2V7KRx=JQ@mail.gmail.com>
 <8c6231b2-61c2-d432-aa47-ddc29de8da19@linaro.org>
In-Reply-To: <8c6231b2-61c2-d432-aa47-ddc29de8da19@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 26 Nov 2020 15:28:20 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXRat0g_+d04eoOL9Vpbv-2iJfqdOkzGB17=yjRMeVWXQ@mail.gmail.com>
Message-ID: <CAPBb6MXRat0g_+d04eoOL9Vpbv-2iJfqdOkzGB17=yjRMeVWXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] venus: Limit HFI sessions to the maximum supported
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:01 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
>
>
> On 11/25/20 5:46 AM, Alexandre Courbot wrote:
> > On Fri, Nov 20, 2020 at 9:12 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Currently we rely on firmware to return error when we reach the maximum
> >> supported number of sessions. But this errors are happened at reqbuf
> >> time which is a bit later. The more reasonable way looks like is to
> >> return the error on driver open.
> >>
> >> To achieve that modify hfi_session_create to return error when we reach
> >> maximum count of sessions and thus refuse open.
> >>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/core.h      |  1 +
> >>  drivers/media/platform/qcom/venus/hfi.c       | 19 +++++++++++++++----
> >>  .../media/platform/qcom/venus/hfi_parser.c    |  3 +++
> >>  3 files changed, 19 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> >> index db0e6738281e..3a477fcdd3a8 100644
> >> --- a/drivers/media/platform/qcom/venus/core.h
> >> +++ b/drivers/media/platform/qcom/venus/core.h
> >> @@ -96,6 +96,7 @@ struct venus_format {
> >>  #define MAX_CAP_ENTRIES                32
> >>  #define MAX_ALLOC_MODE_ENTRIES 16
> >>  #define MAX_CODEC_NUM          32
> >> +#define MAX_SESSIONS           16
> >>
> >>  struct raw_formats {
> >>         u32 buftype;
> >> diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
> >> index 638ed5cfe05e..8420be6d3991 100644
> >> --- a/drivers/media/platform/qcom/venus/hfi.c
> >> +++ b/drivers/media/platform/qcom/venus/hfi.c
> >> @@ -175,6 +175,7 @@ static int wait_session_msg(struct venus_inst *inst)
> >>  int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
> >>  {
> >>         struct venus_core *core = inst->core;
> >> +       int ret;
> >>
> >>         if (!ops)
> >>                 return -EINVAL;
> >> @@ -183,12 +184,22 @@ int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
> >>         init_completion(&inst->done);
> >>         inst->ops = ops;
> >>
> >> -       mutex_lock(&core->lock);
> >> -       list_add_tail(&inst->list, &core->instances);
> >> -       atomic_inc(&core->insts_count);
> >> +       ret = mutex_lock_interruptible(&core->lock);
> >> +       if (ret)
> >> +               return ret;
> >
> > Why do we change to mutex_lock_interruptible() here? This makes this
>
> Because mutex_lock_interruptible is preferable in kernel docs, but I
> agree that changing mutex_lock with mutex_lock_interruptible should be
> subject of another lock related patches. I will drop this in next patch
> version.
>
> > function return an error even though we could obtain the lock just by
> > trying a bit harder.
>
> I didn't get that. The behavior of mutex_lock_interruptible is that same
> as mutex_lock, i.e. the it will sleep to acquire the lock. The
> difference is that the sleep could be interrupted by a signal. You might
> think about mutex_trylock?

Unless that mutex can be held by someone else for a rather long time
(i.e. to the point where we may want to give priority to signals when
userspace opens the device, since that's where hfi_session_create() is
called), I am not convinced this change is necessary? It may confuse
userspace into thinking there was a serious error while there is none.
Granted, userspace should manage this case, and from what I can see
this code is correct, but I'm not sure we would gain anything by
adding this extra complexity.

>
> >
> >> +
> >> +       ret = atomic_read(&core->insts_count);
> >> +       if (ret + 1 > core->max_sessions_supported) {
> >> +               ret = -EAGAIN;
> >> +       } else {
> >> +               atomic_inc(&core->insts_count);
> >> +               list_add_tail(&inst->list, &core->instances);
> >> +               ret = 0;
> >> +       }
> >> +
> >>         mutex_unlock(&core->lock);
> >>
> >> -       return 0;
> >> +       return ret;
> >>  }
> >>  EXPORT_SYMBOL_GPL(hfi_session_create);
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> >> index 363ee2a65453..52898633a8e6 100644
> >> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> >> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> >> @@ -276,6 +276,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
> >>                 words_count--;
> >>         }
> >>
> >> +       if (!core->max_sessions_supported)
> >> +               core->max_sessions_supported = MAX_SESSIONS;
> >> +
> >>         parser_fini(inst, codecs, domain);
> >>
> >>         return HFI_ERR_NONE;
> >> --
> >> 2.17.1
> >>
>
> --
> regards,
> Stan
