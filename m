Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2322C2D83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbgKXQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390549AbgKXQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:56:06 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085ABC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:56:06 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id r14so11428137vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKhO+N54VgGJ49BJOFr6jokvHyMFWcmgDUq5BqHdsQA=;
        b=GXFhzRscqQ3tyn60aR6RDW5oQqWSU0oPbsapBBgHN1d4eubki9oMwxa5NeHeHk0gg3
         SQo2AtQBC9RKOx3D8ucQdrhAr2Pml0dNjcY7Eu/pIOV+id/1RCqgflYWAX4VAAMwklpB
         4pepvz7fYVL37894R881RDfg6GXr9DcWP2RtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKhO+N54VgGJ49BJOFr6jokvHyMFWcmgDUq5BqHdsQA=;
        b=VhhqMoAwEQjpubx4+NW2z7Ww4QJ1On5YyHfeGfe4wXWJOV+poYBIdwXJ0FYblwV11y
         hTfKnNK4Ly9N/G7aU+yP94R9eL3ZKQVhUOwPGbdnafc2O1ltteomsbyrOxoE637ZBTQo
         w4xufby2WAzbakYofnTaGP1/Pb8Zn+J/c/CS4dNaY49+Ce4gyocguPdw6htSt107YwZ7
         /ECGxe562ih0Ke8ytZ7V8I/PzZbX3zEGAQh21lBslWBaaVyIVukZAD6b5p9dffWJShJj
         vT79qUzynXG135ygNzcyQ4D1nxdCoxfD44PZiU0wGD7YzA6wuKqgNJHQGGeKnN5gkk9T
         qYWg==
X-Gm-Message-State: AOAM530smRcEOR3BduHUYKFu8l+6JhLAlXRhijljLJFkVrnhF27wRMly
        YQdKxh4iUEqy0/0WSTe/VtNotxhzRWRhYA==
X-Google-Smtp-Source: ABdhPJzwqEWXK+xQ0F7tq9Eqra5gR37Pjr0kKNGgTB4umO71/45o38/rASn2cV4JsmyHSvlTnjHZfQ==
X-Received: by 2002:a67:fb52:: with SMTP id e18mr4376538vsr.30.1606236964857;
        Tue, 24 Nov 2020 08:56:04 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id s6sm1798223vkk.20.2020.11.24.08.56.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 08:56:03 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id u7so11438767vsq.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:56:03 -0800 (PST)
X-Received: by 2002:a67:ef98:: with SMTP id r24mr4473856vsp.37.1606236963270;
 Tue, 24 Nov 2020 08:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20201123160139.1.I2702919afc253e2a451bebc3b701b462b2d22344@changeid>
 <CACRpkdamdXCqZa4=qb5MsJtQMw1v53z5HZVv5SHJv84dtVACqQ@mail.gmail.com>
In-Reply-To: <CACRpkdamdXCqZa4=qb5MsJtQMw1v53z5HZVv5SHJv84dtVACqQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Nov 2020 08:55:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W9+Wa=0d-Y+kxhqsRVM4TOofTC-C519cLkYOsLSBRZ4A@mail.gmail.com>
Message-ID: <CAD=FV=W9+Wa=0d-Y+kxhqsRVM4TOofTC-C519cLkYOsLSBRZ4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip: qcom-pdc: Fix phantom irq when changing
 between rising/falling
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maulik Shah <mkshah@codeaurora.org>,
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

On Tue, Nov 24, 2020 at 12:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Nov 24, 2020 at 1:02 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> > We have a problem if we use gpio-keys and configure wakeups such that
> > we only want one edge to wake us up.  AKA:
> >   wakeup-event-action = <EV_ACT_DEASSERTED>;
> >   wakeup-source;
>
> I would need Marc's ACK to apply this with the other patches
> to the pinctrl tree, but I can't really see if maybe it is OK to
> apply it separately?

I'll make an explicit note after the cut in the patch, but to also
respond here: we can apply this patch on its own.  The only reason I
sent as one series is because they address similar issues, this patch
stands on its own.  Patch #3 needs #2 but patch #2/#3 don't need patch
#1.

> Also are these patches supposed to all go in as fixes or
> for v5.11?

Wherever it makes sense.

-Doug
