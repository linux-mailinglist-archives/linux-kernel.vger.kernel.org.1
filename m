Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A545F2AD874
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgKJOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgKJOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:14:55 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A15C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:14:54 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id g19so12580873otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9nUfLb+QLQPTkg3AquA/X12iHNZUp2yVfXlTA+PPU4=;
        b=vVcPZHkh0l4LL8I1pxa4yWvbHqy0mxTYP7ow7Nd6sfgTbsPHE4QIPYfF5aX4gO/Kwn
         lyGi1ttrljEtz+LFyCW7Lr4LOxhVe96i3gnivyvY/jYFHZo+URHT0v59xw49rGzuc077
         gGpHbRZowa26qQGaNC/8gy8xt4VPgO78aMR1P8kuvAANNZvG2U7URnTawO5tSRgPB1BF
         mtTfA2tblTe70CeHUrUCo5n7Ri0KpxzHbRbxaoKNPk11cYBJqkGvShIXLanUDtIJnaLK
         F5izPBWWifNNGIZ4zuFa6f/SrchFTt6u3JbyCEQRXmGi9mQVAfp525BfDPpdulEMnIpq
         u0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9nUfLb+QLQPTkg3AquA/X12iHNZUp2yVfXlTA+PPU4=;
        b=DckJkW5qT2TcFsqizMw2s9yw77mGd1lPfoaeh5jhiQx5SotHdv3VC+8GjzgUPPKxDc
         n5KiSeEgAmMv3wBWW5fDC53/EPedlE1rUCxBrCK4R3+jJyMYyhISEAhEZg92AapP/jXT
         CITMWVTaYxruGXSoIQnToEbYp8wsl3b0s6+V1tgqXyKyDpbImrl7Ab+IIeEpqqY22PVj
         9ipn4t6hxqq5ngGmU6xaPhurCoWoLg2MlC7HREXFzv5uENiPa/VDYBaaPYpOwAFp7/yy
         8Xo3d4it7z3V3fZ35iIlNwASLq0lrdGFw+gEJI0+zx0NgKvQILcEhnn7+lVTIyI7Cn9B
         jzsg==
X-Gm-Message-State: AOAM533RST0blkrBYxKM2FnPUhFKBszmwzjnjMPD4UvaBbdvXMcuxjGJ
        23utkmhvdm61KPzEb3MCqbgRuEDSmQOaLVcTt+TbiQ==
X-Google-Smtp-Source: ABdhPJwRO86c13kzB8/54MFkxpkQIpnbN9BnIHo9LbAkm+KL014xKHRNvFUF9ulevilNweqU/AXjZCRomtU7NoajQh8=
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr13495736otc.368.1605017694179;
 Tue, 10 Nov 2020 06:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20201028043642.1141723-1-bjorn.andersson@linaro.org>
 <CACRpkdaBbdC5_6y=w5eL-jJ_Mk+toKWy8kj9t-UWx02wNfjo+g@mail.gmail.com>
 <d1c2a25e-3cb1-5d67-d038-be80094c64be@linaro.org> <CACRpkdb=qt7rNORLs3VJCa=Wg1yzgL5-1wujOr4r+GhRUx3_yA@mail.gmail.com>
In-Reply-To: <CACRpkdb=qt7rNORLs3VJCa=Wg1yzgL5-1wujOr4r+GhRUx3_yA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 10 Nov 2020 17:14:43 +0300
Message-ID: <CAA8EJprJzambszvQfbR_t34POWqNN=RMVJmqdbTVoiwCf=Ys0w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8250: Specify PDC map
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 16:58, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Nov 5, 2020 at 4:01 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> > On 05/11/2020 16:59, Linus Walleij wrote:
> > > On Wed, Oct 28, 2020 at 5:36 AM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > >
> > >> Specify the PDC mapping for SM8250, so that gpio interrupts are
> > >> propertly mapped to the wakeup IRQs of the PDC.
> > >>
> > >> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > >
> > > Patch applied for next (v5.11).
> > >
> > > If this is urgent and needs to go into fixes, just provide me
> > > a Fixes: tag and I will move it to the fixes branch.
> >
> > Yes, please:
> >
> > Fixes: 4e3ec9e407ad ("pinctrl: qcom: Add sm8250 pinctrl driver.")
>
> OK moved this over to fixes and added the tag.

Thank you!


-- 
With best wishes
Dmitry
