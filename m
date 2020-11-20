Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC022BB23F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKTSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgKTSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:16:43 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:16:43 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id a10so3409295uan.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7i3IDjQZXUbrZIsC0hxmEc0DVFntA7n45yVpEf8muDM=;
        b=LnupxrZtYoidppN3e502cNrtySa1sP+YUJ2Qq//NRyV2IEpCKnqt4DKnow8Jiovym9
         dUzhoesDtc9JQZCbtRB0nCO5ORWy47eFOsfxfIZyysvds7zQ0VXNWcnRzYg0bKSXimPb
         wqMsyE3pWtZraS9yPvuM4X24YZtc+JFF9PpDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7i3IDjQZXUbrZIsC0hxmEc0DVFntA7n45yVpEf8muDM=;
        b=hpebjEkRCOHQiAozX+Pkjw3n4UQBwPZiqFkzEnE8W0b3VdyybK4C8luBHLHVj6s1vi
         kFQbFNTTjvbZFCKa546JDt2xvTb6lTC2a7X+U9vo7npSalx+Z05sjYqyRkx+r+7OLQOe
         dDnJ04GWQMKnMpNeLeoicb9a28u94lyxOJC6la4FF5RWNNGGINmMM1NGxOyPprtJ0Iil
         yzCVyNuXZ8/Eyqa57gCKZcFlUCCYytikXgQv44onoH/BLXs0JMcKdrbHEGRIpI189OUr
         4TdSGsQIcPA2y+64Kn5EA1wmaCQnuSpZ+pqGVn2gVCvWmt2u7CZ+dzzyJ9/1GVSNGbKf
         N+zw==
X-Gm-Message-State: AOAM5328CBGl8IriqVSwp/DD78PLTo3fKsT/A9Su9d/+pLskAMxFF28p
        ol/Ks7s1oXbeL4ukFeZ4WhzbxOTp5V9ymg==
X-Google-Smtp-Source: ABdhPJzItUly0dL4AJcMj+GAIB8lusInsYSXf7HpWc02iIjWCcTBkEI+cMzjl9F/3D6G9EEXh1joQA==
X-Received: by 2002:ab0:224b:: with SMTP id z11mr16767866uan.103.1605896201964;
        Fri, 20 Nov 2020 10:16:41 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id b23sm392629vsa.11.2020.11.20.10.16.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:16:41 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id g3so3403326uae.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:16:40 -0800 (PST)
X-Received: by 2002:a9f:24eb:: with SMTP id 98mr12605782uar.90.1605896200430;
 Fri, 20 Nov 2020 10:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20201120073842.3232458-1-swboyd@chromium.org>
In-Reply-To: <20201120073842.3232458-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 10:16:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ue_fjEPv_S=21=Mq8cCzo2FOVJB+Y0vzT1jyehsQzDZA@mail.gmail.com>
Message-ID: <CAD=FV=Ue_fjEPv_S=21=Mq8cCzo2FOVJB+Y0vzT1jyehsQzDZA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 19, 2020 at 11:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 16.
>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> This fixes commit 5b19ca2c78a0 ("iio: sx9310: Set various settings from
> DT") in the togreg branch.
>
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index a2f820997afc..5d8387ed9301 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1305,7 +1305,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>                 if (ret)
>                         break;
>
> -               pos = min(max(ilog2(pos), 3), 10) - 3;
> +               pos = min(max(ilog2(pos), 3), 11) - (pos > 16 ? 4 : 3);

Checking the math for the documented possible values of pos.  What we want:

0 => 0
16 => 1
64 => 2
128 => 3
256 => 4
512 => 5
1024 => 6
4294967295 => 7

So looks OK.  Do we care about anything other than the documented
numbers?  If my understanding of ilog2 is correct, then you'll get the
wrong answer for 17.  I think you could fix it with:

pos = min(max(ilog2(pos), 3), 11) - (pos >= 32 ? 4 : 3);

-Doug
