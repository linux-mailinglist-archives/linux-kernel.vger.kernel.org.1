Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22112F52B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbhAMSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbhAMSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:50:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0526CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:49:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hs11so2237351ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06tNAIM3rzI1mTaXUJwdQ3erZuFOAY1EV6qtxzuLx3M=;
        b=MqVx3KWSWLPeYNagBLQKAG689W1bZqBc851E1a90w0ABBdIKpy3ZEsBa3kEgIZ36cc
         U/D5oFVTIf2Baeb7+Nvdf6+6tw3TtAgaXbV2ZmbQJwPm6TLN84fn1vvPoaSgEO0Qu8jg
         tlDRgvm9dA0UzX3atZrLd2p5yRBRpT9F5Oz395wksw+k5UTsmabisYzFxH3wKZ02N0tl
         NRQ8K/TyljrXARdcI0cJ6hT9nv1SN7yKOBHNLWqe8PFx8ncNh78wu+KNJHNnLThWhvT+
         Dq8Wwlh7Kl4GvSI9cE09xLqP7xazG01+EqXL/ioTMtgo3NnnD+tkG6E8ugLSjHVOjU9+
         l6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06tNAIM3rzI1mTaXUJwdQ3erZuFOAY1EV6qtxzuLx3M=;
        b=T5XfnevVWDxbEuDgc0sNAMmfUyrflk2vdscfErDe48ohBrbY5b8MgxDGRBiFP8Uo76
         udsxDgboltw7i/k3ZAQoGojW3U3LWjRswYPU5h39ohG5fetfYlgemAhn543vIAN+hDI2
         /FKwDft+onDh4asj3brJfcNyscH5+gIaYM31OYn8KNedJ7MTf9Vc4bqcdkzHpRn5xN+h
         ThrMpJssnDbzEbB7Ji36Wi3qigC5Iq7FZFqMuTJJbqwSOEUNYw7SmMgrTX5wUhghjfmZ
         GXqv0daCEJDeARrmDkzsWVZdj1GSHO1DwmPwlWWYmJmFkvCSTEBWEZerFUaoix90l5NK
         hN2w==
X-Gm-Message-State: AOAM5320OfUUWs/D9CHLcjkZXcA7lJHdYbDtLWxAeAojtYP2aIHdPMeW
        LuXVKNB6X8jLODfC8NgT0JhnyS3TTAtZTgyNnRHXzQ==
X-Google-Smtp-Source: ABdhPJxfP5Sqw65PoQyIEQRQ5pcQeaXk3rpLAutzrJRMp+Z8rMqkQgqqYa1aMmGbloLCKJnuZG5DO+Yq61g+/d+2X2s=
X-Received: by 2002:a17:906:f0c9:: with SMTP id dk9mr2606811ejb.51.1610563769668;
 Wed, 13 Jan 2021 10:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
 <20190208131738.27668-2-andrejs.cainikovs@netmodule.com> <080346c5-eace-f0bc-ef3a-0354988b9fb4@pengutronix.de>
In-Reply-To: <080346c5-eace-f0bc-ef3a-0354988b9fb4@pengutronix.de>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 13 Jan 2021 15:49:18 -0300
Message-ID: <CAAEAJfAJs4fpTX=_caS3f7GA1V-bouVQ_G913MXb80Cn_DmFWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Zysset <Patrick.Zysset@netmodule.com>,
        "Federico Rossi (fede.a.rossi@gmail.com)" <fede.a.rossi@gmail.com>,
        Maximiliano Sonnaillon <msonnaillon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrejs, Marc,

On Wed, 24 Jul 2019 at 06:48, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 2/8/19 2:17 PM, Andrejs Cainikovs wrote:
> > D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
> > However, some CPUs with D_CAN controller have their own limits:
> > TI AM335x Sitara CPU, for example, supports max of 64 message objects.
> >
> > This patch extends max D_CAN message objects up to 64.
>
> Please don't make this a kconfig option.
>
> According to you description this is a HW feature, so please add the max
> number of messe objects to "struct c_can_driver_data" and adjust the
> drvdata accordingly.
>
> > static const struct of_device_id c_can_of_table[] = {
> >       { .compatible = "bosch,c_can", .data = &c_can_drvdata },
> >       { .compatible = "bosch,d_can", .data = &d_can_drvdata },
> >       { .compatible = "ti,dra7-d_can", .data = &dra7_dcan_drvdata },
> >       { .compatible = "ti,am3352-d_can", .data = &am3352_dcan_drvdata },
> >       { .compatible = "ti,am4372-d_can", .data = &am3352_dcan_drvdata },
> >       { /* sentinel */ },
> > };
>
> You probably have to pass it via "struct c_can_priv" so that it's
> available in the c_can.c
>

I came here to make the same suggestion :-)

Andrejs, do you think you could respin this patch? Or perhaps I can find
some time to do that myself, if that's OK with you.

Thanks,
Ezequiel
