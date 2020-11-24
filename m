Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB42C2F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403986AbgKXRqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403979AbgKXRqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:46:17 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE09AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:46:15 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id m16so11542121vsl.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mep5g3jd3Wcro6wz5b9PghU5nLpdZLWg1PGCxkgwp3w=;
        b=X2o/ZcxEs4KlhZZWqNX+HZCTnBf5x/L6fV9FDjTOY/GFMTeC+8Ky9wvb/Nf8OfWUWI
         hqlAD2iIwvxuYcsVOVzC23Hu6ysGeREOWXyQma6bRhUTAt9XN6W82Jrk4tDsydvNjL+p
         VHKttUI7lJMGgp4LeK0pDdNbUPOqLnMWglorA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mep5g3jd3Wcro6wz5b9PghU5nLpdZLWg1PGCxkgwp3w=;
        b=Rt5Bpo4u3IhCezH1lz2ilTyvtr1dHeq0eNEs8NM/TcPAWGVUJqqseVtg2yyJdUF0+y
         oLuHm+FMo+Q2b8Ut8n7O9WErPM+GouIgzv380JfdrynmWEB6R7Fy/MRmeVFShUZvGUb2
         YS1NbsIQMEJAGwPPaX9JyhZA6QXg0wmYKHKw05cg707BvgsoPTatOxqVPkn5R3OMry+6
         g1IkHV1MmIFS1+8XAqGIU2Eba1t6Y+Lv2r7ynf9ciHPFS2xccEuEpVpezAMayapObnaV
         NcrEvbQcJGJYwygkK+SnWJJGEzZdJJSSwLn4c82HukvLzYFcjMsc9P+IpHpU+1nQm3ZG
         hDzQ==
X-Gm-Message-State: AOAM533la/G47sA75tuO1fl41iGYdYdUsu7e0JwY93fXub34lhQH+Jl1
        z/go1kunLkpTX2YLyiuFnCAhRl/CwRbsCw==
X-Google-Smtp-Source: ABdhPJwwgQJG7beV1L+c296kzS9jBI0iflO6GBEv5IdTXkqoFu9oUcaPp/YZCa3rJnfeFXpzlBxFhA==
X-Received: by 2002:a67:e9d0:: with SMTP id q16mr5202068vso.2.1606239974803;
        Tue, 24 Nov 2020 09:46:14 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id n16sm1422121vsj.9.2020.11.24.09.46.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:46:13 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id r14so11521727vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:46:12 -0800 (PST)
X-Received: by 2002:a05:6102:309a:: with SMTP id l26mr4989655vsb.4.1606239971784;
 Tue, 24 Nov 2020 09:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20201123160139.1.I2702919afc253e2a451bebc3b701b462b2d22344@changeid>
 <CACRpkdamdXCqZa4=qb5MsJtQMw1v53z5HZVv5SHJv84dtVACqQ@mail.gmail.com>
 <CAD=FV=W9+Wa=0d-Y+kxhqsRVM4TOofTC-C519cLkYOsLSBRZ4A@mail.gmail.com> <603c691f-3614-d87b-075a-0889e9ffc453@codeaurora.org>
In-Reply-To: <603c691f-3614-d87b-075a-0889e9ffc453@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Nov 2020 09:46:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UdExXYaf3K6jbyr8tR3_NEib+BaYtxk1xQzS7-DuLC-g@mail.gmail.com>
Message-ID: <CAD=FV=UdExXYaf3K6jbyr8tR3_NEib+BaYtxk1xQzS7-DuLC-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip: qcom-pdc: Fix phantom irq when changing
 between rising/falling
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 24, 2020 at 9:42 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi Linus,
>
> +        * When we change types the PDC can give a phantom interrupt.
> +        * Clear it.  Specifically the phantom shows up if a line is already
> +        * high and we change to rising or if a line is already low and we
> +        * change to falling but let's be consistent and clear it always.
> +        *
>
> Can you please hold this change. I am checking with HW folks if above
> commented behaviour is expected/is valid case to set the irq type rising
> edge when the line is already high.
>
> Will keep posting update here.
>
> Thanks,
> Maulik

Thanks for the update.  I'm still going to post a v2 because I think
patch #1 in the series should land and it seems nice to keep them
together.  I'll add a note to the patch indicating your request to
wait for an ack before landing.

-Doug
