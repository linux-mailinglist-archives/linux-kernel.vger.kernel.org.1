Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22D4231927
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgG2FhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 01:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgG2FhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:37:03 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B825C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:37:02 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so6789408vsl.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhJGf0UOhBnAaBM4uo+RC5KnIOLIwVjqf9Yxhm4B4Us=;
        b=Ki7SYqvPryyMJ98JQEvZxaCYHLlVDrak2Lq67YCyNV/y0dYOx+svgog4yoDdTaoIIZ
         9jecpy4jsbqv9HdOGPlYVyWNBU+BRkVbRxLt8m5QJZ9jc0KqewG6rDpKFuy71txYkg61
         rikZ4RkT3QJ+4J5A1p0QN+zIqwkzoviZlkzGtEiRMnHjdfKbTuaXjuASsgl92Pvtb9dO
         14SnZHFAjp+CdYxcIW5BqQJS3wSKw1snvEfZxM+9t9unij+pzXPTUt6I0RMvtEuT77aC
         2T/UbZ9KS0n4mMp/HyXYl/Z8cWD+CWJeIF39bKzJSHJkrAGjJd8hG8L0UV1xcrtrjOVs
         fcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhJGf0UOhBnAaBM4uo+RC5KnIOLIwVjqf9Yxhm4B4Us=;
        b=ToZWubxxkSQ98ZkzAJbGPIS5eG3iOTU+Y3b+EdsL3pgRelbHXzy12PY21bW8Dct0W0
         Ap22OigRyQ9Qa52p4KxT885Vyr/rtSAtbU96e1lwDl+zGFpwk8Oixj4Jqhyy0LKAAAvH
         Kt/l3kktSyc7pKKH6AUfD445B0zfEuyRqLSFjIgxNYz7mZ1QXFWfNsYeXHRwclV1reks
         BxUxhwSxvfioUEotByXYbM9VlhVW6aYBPSk8SFugOuyoqPQhC18eIyt4iFIMZKb3VtRb
         emyzkuuXk/uhydh3K4QefXgRARXmPDHU01CMCxwfIKj8pEqCaRSTR85u645tCT9EYc7l
         Temw==
X-Gm-Message-State: AOAM533omf+SrNG/5NyVR56KZtDuHjJeVaRyzSUrPomACB6UqgqLsoex
        x/Cs0q/BSlv1D4vsw/yOR6rspU/ShUWnSuI5MMjrRLpEj/E=
X-Google-Smtp-Source: ABdhPJx5wTVPEqRv93P4gv7a7CPfrjA9CKuqGTm844eGicIZHFMXAnDx/9+9p28axSdgxz4xHiMexC0Syfhu6AvCYdI=
X-Received: by 2002:a67:6b05:: with SMTP id g5mr22267118vsc.9.1596001021135;
 Tue, 28 Jul 2020 22:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200727231033.26512-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200727231033.26512-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 29 Jul 2020 11:06:50 +0530
Message-ID: <CAHLCerO=KPUR-2qEuFpNV9UUV_O7GoXY-EPhyefOFfL_jZ_0gA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Add thermal zone enable/disable notification
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:40 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Now the calls to enable/disable a thermal zone are centralized in a
> call to a function, we can add in these the corresponding netlink
> notifications.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9748fbb9a3a1..72bf159bcecc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -509,6 +509,11 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>
>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> +       if (mode == THERMAL_DEVICE_ENABLED)
> +               thermal_notify_tz_enable(tz->id);
> +       else
> +               thermal_notify_tz_disable(tz->id);
> +
>         return ret;
>  }
>
> --
> 2.17.1
>
