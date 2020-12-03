Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0922CE075
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgLCVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:17:54 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F52BC061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 13:17:14 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id f16so1152492uav.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGoE8xubVEgNLoB/pENK1O+pppyzMnVzHXcTRFU/KCc=;
        b=chE+k1Qcf+xrh+adSDGV7aBESLQtsxS8VaxO+3F3wy6/fQERIPW1WnfMaIVPhx66TK
         Tp2ORtvkN5wXVBhwFIpcN/vmUaA8MkgdnQsRJDX/aoIO6UIEUkEuMo8fA3PCVy7sWc9h
         dcMP3U1bhclTx00l5t8IG6Zloa0qvLiXU1mw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGoE8xubVEgNLoB/pENK1O+pppyzMnVzHXcTRFU/KCc=;
        b=RNgt4c9PWveHeyzSnQP+NeGEb1G4C5aw9iCGkCJS2bJ9A1caivRbuHW75xYEr/EyiK
         rUQGz9oAsiOSu+/qsWjLr+BFplLekRTmXD8+KKQqC/zAtJtvhMeKYKoCUct1FQRl0inO
         M7FQDrRURcFi/jrBOGJdt4UOcq1kBp5Pcdog2ppsamFqcUvkK9xWMrht4J2Nvyrh/J1+
         wnWwwnk45cAnXPv1Kluqdu24qgHzUolWG8XuVBfXdDNDmKAyjSd7RKmf3jKWsso2+Ee6
         Tr74nUEY4q3IGPdGVU6cfOOooynRYYkWCltvIpLNVqdOhQDXnn3U+T6aKIgSMUoeUL5M
         mGHA==
X-Gm-Message-State: AOAM533cbWa7e/YhzYQL2QtLMu9qAYdY3dwN2DLiHaZ9lYaTWZRDkr0K
        IcIiofNvJld7hOSX+E+F19zg9IcsJym4SQ==
X-Google-Smtp-Source: ABdhPJzatTZqCJKW7lx0tMnT+OhOw12CvASbMl8riQbJjNPPAmtCm8CtfYOdcrmRJMDkb2r3i4F2Bg==
X-Received: by 2002:a9f:2210:: with SMTP id 16mr914624uad.59.1607030233138;
        Thu, 03 Dec 2020 13:17:13 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id g93sm77330uag.9.2020.12.03.13.17.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 13:17:12 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id q10so2069964vsr.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:17:12 -0800 (PST)
X-Received: by 2002:a67:70c6:: with SMTP id l189mr1318354vsc.34.1607030231837;
 Thu, 03 Dec 2020 13:17:11 -0800 (PST)
MIME-Version: 1.0
References: <1606211610-15168-1-git-send-email-mkshah@codeaurora.org> <CAD=FV=Xk_1=eCvqLPPnYLrQWf1zVy+iEHs=DWEubb6n5ub3Wxw@mail.gmail.com>
In-Reply-To: <CAD=FV=Xk_1=eCvqLPPnYLrQWf1zVy+iEHs=DWEubb6n5ub3Wxw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Dec 2020 13:17:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XafiNR+vZc2nM6JzhU7xPm9v3eeeR5SMhBM3k3mmsZDQ@mail.gmail.com>
Message-ID: <CAD=FV=XafiNR+vZc2nM6JzhU7xPm9v3eeeR5SMhBM3k3mmsZDQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Do not read back the register
 write on trigger
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 3, 2020 at 1:15 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Nov 24, 2020 at 1:53 AM Maulik Shah <mkshah@codeaurora.org> wrote:
> >
> > From: Lina Iyer <ilina@codeaurora.org>
> >
> > When triggering a TCS to send its contents, reading back the trigger
> > value may return an incorrect value. That is because, writing the
> > trigger may raise an interrupt which could be handled immediately and
> > the trigger value could be reset in the interrupt handler.
> >
> > A write_tcs_reg_sync() would read back the value that is written and try
> > to match it to the value written to ensure that the value is written,
> > but if that value is different, we may see false error for same.
> >
> > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > ---
> >  drivers/soc/qcom/rpmh-rsc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for
> QCOM SoCs")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Ugh, brain-fart.  Not Signed-off-by, but:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
