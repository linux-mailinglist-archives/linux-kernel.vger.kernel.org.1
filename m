Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE12AE87D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKFyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:54:34 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EC5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:54:34 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so1159239ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bh7PHvB+uW1WTzgT8N8pAmTH1u+aQK1HrAa01M9SPg=;
        b=dTaRHX61ohf7cUW03/j55VZt8YPiY/2JGly90k+NbhLJoqQtP2Sqc56Hxpo6eJiD2E
         MPfAU/wc8TC5hsrx9827YCONKEd9aSSKIPvb+AqTefsv2y5k6nubpdMO8qaadU5k60cG
         AQdHuBskmnrSzSC/HWPpcsNxcZWvLZgRO3ZJ8fXScvf3ZwaTYulVJq6ELjg4qzuDWwnF
         MI7dc2IVHHkfvbLtbhDVelSlJTrhjE+KE1isvtXurHDj3EewG/uWc/1oJ1oo+S9z33yr
         S2U/Rp3XdWmdcICjMY8Z2Qciyapet4uRGBopFotOn2l9o0on9DAyYwl8wqXSk7nuBsJW
         d/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bh7PHvB+uW1WTzgT8N8pAmTH1u+aQK1HrAa01M9SPg=;
        b=Oivu00e3rmABUtEmJFcR8TfQmX7HixcpTNPfdVfIyLqAQ03vnxwhPsgUu3vOETq/Pl
         b9u2ctU09ukut3lfOlZOFrFDd6jqYvhdRgjgl/DBp4AlPEU3Kw2K+gHq6m6+9IRPWmSv
         W3BJ67Zxolr+oaO/LcaZWIh+jyXkkVBjQ82DNg+BSV3frhnIjszwOXUuAVntezhEikE6
         oCQh1CKjLKlWoFL6614aS58piSQ8SsL3JVu8HjT/mq1paGu6dJTf+OlVbGRCKwXUQr5p
         06a0Oq1t/HUPMOR+EcG2zj/+cLTwVYKtKYWdDLflwTYH/umsQU1OsolaLRZCe1hhQ4G/
         3b3A==
X-Gm-Message-State: AOAM5302wMS51PuC9SHRMWL2vT2IhTaCxcu96E1ga2pG1cQfBRpuhCgj
        Rxi83CX6cwXeFPDmb4wR1pAH9260+On3s498JLg=
X-Google-Smtp-Source: ABdhPJyXa+D3J1gsOWxkepyWWaPtRxQa0Wo0O/WqXbQs+Lp6Uq5qXAmNMGxDJaxp6/N6z3AaJKYGjPEq/dtmMEAj8Gc=
X-Received: by 2002:a17:906:5a97:: with SMTP id l23mr23159209ejq.232.1605074072963;
 Tue, 10 Nov 2020 21:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20201109121214.19012-1-frank@allwinnertech.com> <fba49549-9a78-32ee-a55c-97499f24fe62@sholland.org>
In-Reply-To: <fba49549-9a78-32ee-a55c-97499f24fe62@sholland.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 11 Nov 2020 13:54:21 +0800
Message-ID: <CAEExFWvJvVZzC=YzZLUApf34mP1+oXQL=XsQd-+zYcFV-iC5ZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for
 debounce and poll
To:     Samuel Holland <samuel@sholland.org>
Cc:     Frank Lee <frank@allwinnertech.com>, vkoul@kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
On Wed, Nov 11, 2020 at 11:44 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/9/20 6:12 AM, Frank Lee wrote:
> > From: Yangtao Li <frank@allwinnertech.com>
> >
> > The debounce and poll time is generally quite long and the work not
> > performance critical so allow the scheduler to run the work anywhere
> > rather than in the normal per-CPU workqueue.
> >
> > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > ---
> >  drivers/phy/allwinner/phy-sun4i-usb.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> > index 651d5e2a25ce..4787ad13b255 100644
> > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > @@ -326,7 +326,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
> >               /* Force ISCR and cable state updates */
> >               data->id_det = -1;
> >               data->vbus_det = -1;
> > -             queue_delayed_work(system_wq, &data->detect, 0);
> > +             queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
> >       }
> >
> >       return 0;
> > @@ -444,7 +444,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
> >
> >       /* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
>
> This doesn't sound like "not performance critical" to me. My understanding is
> the debouncing has a deadline from the USB spec. Maybe this is more flexible
> than the comment makes it sound?

According to my understanding, the more meaning of performance here
comes from cache locality.
