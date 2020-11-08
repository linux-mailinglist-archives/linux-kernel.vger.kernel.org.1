Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C02AACAB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgKHRzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:55:52 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 09:55:52 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id i186so6068489ybc.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 09:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmWUWppYtFwVGnbqnjHVdjfmtFQq6Ssv8szPUV4ghMI=;
        b=rU7t+xTIfuIcDY5hoRM9w/gETDTs+vfyhqAY2Dd3M/jS2gra/qqOozX8yQfcHFJwdD
         2LxEb7CL4b8rYoPiLxlbS5Klef0HggKBxYOx6wq9Ya+Qpkj94BZ/U3po/RBTRvxeU+XE
         uMyaODFQAEOVU8jYFOUIgz38Fu2QCKHRGHUcoLJyyFLgx1ZHNsHGwV1RYqT5ZfgXOK4h
         iy1FxTyOiotU/nMHvUYKLcC0BZunxINmlrbX36YIF0Lsq+29bGJCPKqV5s2hm/zOxmUA
         mIeRV+nMSEne4/667rkY/F7RKizgBk/9euaYXQz4g2SzjGaY3zj0kmzEEn/UBD8rkdzx
         M0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmWUWppYtFwVGnbqnjHVdjfmtFQq6Ssv8szPUV4ghMI=;
        b=clJwKTEna4hxAm01ptgiBJSJZcTjXWgdTmxEki3v1qkfzwXNqoBssFLLvMg3JFMMBo
         JsTpr3NFgPJiD4bLXHTPWY0w9VVHZYV0yxJgVWyBCFSV1GwthoXURp+LjKCo7SJElMtj
         SMZlmDxV4Ium+oAapENxcygl4+DtlR5J4myxTd+PMXqC10UpV9d9wv3LafkCU262bJlL
         IRl9V3Joh6xwLL0AMqOXNGxW7Tu2mdsGvVNAKwN+GSTOB3l5XGZ3I2+tD+2/JLCScQYS
         xTt0KLDrGfKp43RwCGTj7O8hIRJOAZoHFEGyU+T+1WaXwfq6Q7wKYTIHlPH2Pltkl2qy
         ERlQ==
X-Gm-Message-State: AOAM530ZfRgw9uoCd4+wddqmbB2mrOBulLQorxJcXl+3H6w8h7CNf987
        n7SjeKChYbwvJ6h3yC+yl9iQxew/AZy0IT0VN5Ptcg==
X-Google-Smtp-Source: ABdhPJyDSh//P8YGCca/h595WPbNkP9vxMSpO45fIp2fFwEVMxoWVkZ+T5UcRE0J2J1xCgzdUPtWfd4b52s0RoOYFzM=
X-Received: by 2002:a25:4c1:: with SMTP id 184mr14830144ybe.318.1604858151648;
 Sun, 08 Nov 2020 09:55:51 -0800 (PST)
MIME-Version: 1.0
References: <1594899334-19772-1-git-send-email-kalyan_t@codeaurora.org>
 <1594899334-19772-3-git-send-email-kalyan_t@codeaurora.org> <CAF6AEGsYmxwmG2OWdX3Q-5tio+kU-AwhiL_0EyLTVb0=gWgwgw@mail.gmail.com>
In-Reply-To: <CAF6AEGsYmxwmG2OWdX3Q-5tio+kU-AwhiL_0EyLTVb0=gWgwgw@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Sun, 8 Nov 2020 23:25:15 +0530
Message-ID: <CAMi1Hd1+0Gz18Lzm43-gyAEF+gAqd1+9EcYCsJcsgKNbE3WZSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/dpu: add support for clk and bw scaling for display
To:     Rob Clark <robdclark@gmail.com>
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        nganji@codeaurora.org, Georgi Djakov <georgi.djakov@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 at 21:09, Rob Clark <robdclark@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 4:36 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
> >
> > This change adds support to scale src clk and bandwidth as
> > per composition requirements.
> >
> > Interconnect registration for bw has been moved to mdp
> > device node from mdss to facilitate the scaling.
> >
> > Changes in v1:
> >  - Address armv7 compilation issues with the patch (Rob)
> >
> > Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
>
> Reviewed-by: Rob Clark <robdclark@chromium.org>
>

Hi Kalyan, Rob,

This patch broke the display on the PocoF1 phone
(sdm845-xiaomi-beryllium.dts) running AOSP.
I can boot to UI but the display is frozen soon after that and
dmesg is full of following errors:

[drm:dpu_core_perf_crtc_update:397] [dpu error]crtc-65: failed to
update bus bw vote
[drm:dpu_core_perf_crtc_check:203] [dpu error]exceeds bandwidth:
7649746kb > 6800000kb
[drm:dpu_crtc_atomic_check:969] [dpu error]crtc65 failed performance check -7
[drm:dpu_core_perf_crtc_check:203] [dpu error]exceeds bandwidth:
7649746kb > 6800000kb
[drm:dpu_crtc_atomic_check:969] [dpu error]crtc65 failed performance check -7
[drm:dpu_core_perf_crtc_check:203] [dpu error]exceeds bandwidth:
7649746kb > 6800000kb
[drm:dpu_crtc_atomic_check:969] [dpu error]crtc65 failed performance check -7

Here is the full dmesg https://pastebin.ubuntu.com/p/PcSdNgMnYw/.
Georgi pointed out following patch but it didn't help,
https://lore.kernel.org/dri-devel/20201027102304.945424-1-dmitry.baryshkov@linaro.org/
Am I missing any other followup fix?

Regards,
Amit Pundir
