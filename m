Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971CB28EAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbgJOCAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 22:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbgJOB7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:37 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3740C0613AA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:14:04 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id s2so101880vks.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RC25HY5NnJ5FNFugLVlYGqgrjVBJgiwdGnqPIb+Pkec=;
        b=Eudd9Igdl/h4VlLzh+aptHOEYif6JqCGyjeEgznhJwQJ1ttBoPa1uqULYPz9oPlCXy
         c7SM6xDD18LjK/c5U+87y0gfMTersHROiToiRFTAD/yQO1OsuN7uOr2MLccaOEP05GV5
         mbjFG5TewOySMnmNVW5yP7KHxfDdQZEsCE11w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RC25HY5NnJ5FNFugLVlYGqgrjVBJgiwdGnqPIb+Pkec=;
        b=Z0vqw2pOMtv4uIh7z7dQRQqaSdPlo6NhAp7MdskHgeSlRUhAaPWvUsJVmdixSUG7Ki
         GIUAM4ZXAxZj49Mfu4KewWiAf/pvxYW1HG7dZ0ZgP6mAnS4iecePLlwweNe56YTmWRHv
         YUdMmL3XKHX12d5xCdO5MR4PQffvqzmZkddisMqcMgeaaUyPXulrYH5MJGdFA/39JrZR
         mc9yyya8rSXQmv6NYaK3K4KV5A53tNnW6LdZwYQFwXk5HS0yRdNC8TJgliAX5gT03GC4
         ncpjwuftGMcZKrQ1yG7OzGNG4gbSH0s1x0/Sv4YKSm2V+rNtsq1SNpvhuXeo8W4ewBTB
         3KjQ==
X-Gm-Message-State: AOAM532sfAigIH8pHga4yVVWqIqUmuXA2iILalokV7PntLtFoTcVCHc8
        /Ov+jxM/ueK5viThqlYJxbttocLj2/0ERQ==
X-Google-Smtp-Source: ABdhPJx8tYLgoFNKbgW6O0SAVgXm9odXeaK52eBsYIej44dXRlWX2wpdBeeQUK7PEG8jwtWJ/twNRw==
X-Received: by 2002:a1f:988e:: with SMTP id a136mr989700vke.4.1602710043456;
        Wed, 14 Oct 2020 14:14:03 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id i3sm124507vkp.6.2020.10.14.14.14.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 14:14:02 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id d4so238222vsk.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:14:02 -0700 (PDT)
X-Received: by 2002:a67:b405:: with SMTP id x5mr993311vsl.4.1602710041706;
 Wed, 14 Oct 2020 14:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201014085758.v2.1.Id0cc5d859e2422082a29a7909658932c857f5a81@changeid>
 <160269519265.884498.6320532206038624483@swboyd.mtv.corp.google.com>
In-Reply-To: <160269519265.884498.6320532206038624483@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Oct 2020 14:13:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcH0DKhiKp4X8j0mxUUCm-yZmJp1boXqVOhCWeySydiQ@mail.gmail.com>
Message-ID: <CAD=FV=WcH0DKhiKp4X8j0mxUUCm-yZmJp1boXqVOhCWeySydiQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: qcom: lpasscc: Re-configure the PLL in case lost
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 14, 2020 at 10:06 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Douglas Anderson (2020-10-14 08:58:24)
> > diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> > index 228d08f5d26f..ee23eb5b9bf2 100644
> > --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> > +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> > @@ -356,6 +356,25 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
> >         .num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
> >  };
> >
> > +static int lpass_core_cc_pm_clk_resume(struct device *dev)
> > +{
> > +       struct regmap *regmap = dev_get_drvdata(dev);
>
> Can we use dev_get_remap(dev, NULL) instead?

Good idea.  ...but as far as I can tell there are two regmaps.  I'll use

dev_get_regmap(dev, "lpass_core_cc");


> > +       unsigned int l_val;
> > +       int ret;
> > +
> > +       ret = pm_clk_resume(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Read PLL_L_VAL */
>
> Please drop this useless comment. Replace it with something like this
> (if at all):
>
>         /* Reconfigure PLL if PLL was reset across suspend */

We reconfigure more than just the PLL.  I believe that the PLL being
zero is just a clue that we use to know we should re-init the whole
thing.  I've tried to convey this in a comment in the next version.
