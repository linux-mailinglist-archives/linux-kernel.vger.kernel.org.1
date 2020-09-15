Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D539269CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIODnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgIODnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:43:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12EC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:43:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so1882729ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANNjGwWRg+iDVVYtcoowotn4Zio+3Ac8neGudtjHOg4=;
        b=A//YnMekhyBWtv8P9+lJZaMqD1Ik1yGamHDdjb9HB/vyT8E/EPQzgR9SuGMl6EHg8y
         oJRiAuxYCgBEIpwnzQOLObRUWntjMRl4CdqjT0DFujBS61JggYW9Y2h5S7mKrpPEdnGA
         SwwOwWDzdHs/ashyHp4tYsl9M3q0hT/SdSS0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANNjGwWRg+iDVVYtcoowotn4Zio+3Ac8neGudtjHOg4=;
        b=Caif9p7L5rLQViaUgXLnI+RySLFBD8L6hiDmJtKbOMbc6U9ScWNk3G1UL6rZGFxv3j
         ald28Z2kvUnD1KL8QMmg7oY5gaUy+34vj62OLNgKsZpxnv6LEYpFLvow1q+6wQOz749H
         MGo6Q1olMGKXGvM8LqEOLDeiNOe4Am1RbZsQynDiuULPJ29bmmI6Qr4t2LwTXjI1YPLX
         g2my8ZEin6QjMqd/G2QxuBeDG8jPzYE0RocREn9/nim4GcDFovJXeKke/PJ6jTB9xDD7
         41ZV7fGpJAPlmeqIE3ncUVUUsc2bxO7PZq+U6dNv8UJsPGSOkpw1fKXOFgMu/061I8KM
         HxjA==
X-Gm-Message-State: AOAM531vkSMMHznyM4+hj9NgZP6ROQ6hQLhYX0Ld25wPRhLsIexZ0D/6
        s0lgQ1aOS7W/ZoaloeCtRUXUleSmkknTaozh
X-Google-Smtp-Source: ABdhPJzaQcWypRp6t74+q+eLX71BYbuA/RHeuiRAuCHSRmiRYkKmJ4OGWwcxe66e+EukkCJycxKquQ==
X-Received: by 2002:a9d:5a8c:: with SMTP id w12mr11419234oth.332.1600141420059;
        Mon, 14 Sep 2020 20:43:40 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id i5sm3656833otj.19.2020.09.14.20.43.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 20:43:39 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id a2so1872440otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:43:38 -0700 (PDT)
X-Received: by 2002:a9d:24c6:: with SMTP id z64mr10659220ota.97.1600141418092;
 Mon, 14 Sep 2020 20:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200915012911.489820-1-acourbot@chromium.org> <20200915032529.GA7762@uller>
In-Reply-To: <20200915032529.GA7762@uller>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 15 Sep 2020 12:43:26 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXGGn-QGZvCycfMNO-PW_pBhi+B0QWoa=iESBp1P-eZrw@mail.gmail.com>
Message-ID: <CAPBb6MXGGn-QGZvCycfMNO-PW_pBhi+B0QWoa=iESBp1P-eZrw@mail.gmail.com>
Subject: Re: [PATCH RESEND RESEND] remoteproc: scp: add COMPILE_TEST dependency
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:25 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 15 Sep 01:29 UTC 2020, Alexandre Courbot wrote:
>
> > This will improve this driver's build coverage.
> >
> > Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> > Hi remoteproc maintainers,
> >
> > Second resend as I got no reaction for almost 1 month on this one-liner.
>
> Sorry about that. I fell behind on my inbox and have missed your
> previous attempts.
>
> This has now been applied.

No worries, thanks for the quick response.

Mauro, the patch is applied on
https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git/commit/?id=5185e3a9dc2d68bb52e3e12400428aa060b87733,
will it work for you to merge this into the media tree and apply the
pull request on top?

>
> Regards,
> Bjorn
>
> > Pretty please?
> >
> > As explained in
> > https://www.spinics.net/lists/linux-media/msg175991.html, we need this
> > patch in order to merge a driver series in the media tree. If that
> > looks ok to you, can we pull it in the media tree along with the series
> > that depends on it?
> >
> >  drivers/remoteproc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index c6659dfea7c7..d1fcada71017 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -43,7 +43,7 @@ config INGENIC_VPU_RPROC
> >
> >  config MTK_SCP
> >       tristate "Mediatek SCP support"
> > -     depends on ARCH_MEDIATEK
> > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> >       select RPMSG_MTK_SCP
> >       help
> >         Say y here to support Mediatek's System Companion Processor (SCP) via
> > --
> > 2.28.0.526.ge36021eeef-goog
> >
