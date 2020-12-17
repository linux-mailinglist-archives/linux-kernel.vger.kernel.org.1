Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F02DDAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgLQVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgLQVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:36:03 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB43C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:35:22 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id f16so122045uav.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Yy0ldVuuJaGFM+MNqEysR2gur5o+i8usb8h9eXll+c=;
        b=Xei5+0LqNNVPaWZyitvbbu6d+/kK5f1HcGXver02BWJSPGI39mi4xcQeLJFO21Zqgx
         UltUc8We5V1TOFXfrEwvrSBnodJVlpOIyeXD3tLhaHl+waXIJyr0SnOR29e1L02oJA7W
         Gg3eJTtUwZzM9UiRzTHoT04HLzYThuDk6+OH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Yy0ldVuuJaGFM+MNqEysR2gur5o+i8usb8h9eXll+c=;
        b=KAgYUsEpSgaT2C0Crrx1Fr69dK66liYRX01PZYGEOw4x20JUyCitt50DU2LtmF927p
         MNwKsrZLJ2w/yR1Lem5u1X7PH9G/W+8iU7vK1yKs1TojmU7rLrt67cJ782B7SrVhWEG3
         NJg582wOwyd66KlBqpekdu103yQBpGJGLlmHOF+fMJrEbA5QbVpkjLq5+RgnFdxL2rBa
         Pr9S9LRvFJA41jDzr1iavzgxD1irStv54FGu4d2woAT5BHvF9I8GdnZbt3LYDugLYMtc
         v0a0DrSqOMuCvssRZTfAUXCQEd28vto2B+vbxFyMH00SqsMJG95elHoJxgGMEHpHunqa
         HWjA==
X-Gm-Message-State: AOAM533aMZVN547Ldy6fgzj8gtol6IvJQTZkdQ4ZNT2q6TYZtht4c5ER
        DIbsf++goEet2Y8BdMVg62qJ2IV4zmWyew==
X-Google-Smtp-Source: ABdhPJwdpk+lXxze9Ht8pUv99hskUKYaKyD4UN/04ejm5BCOKYNFFbQCe5o7JB0LzJ04RrEtSe/iCg==
X-Received: by 2002:a9f:242a:: with SMTP id 39mr1148192uaq.49.1608240921643;
        Thu, 17 Dec 2020 13:35:21 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id x18sm3662256uan.17.2020.12.17.13.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 13:35:20 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id 73so131932uac.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:35:20 -0800 (PST)
X-Received: by 2002:ab0:5a70:: with SMTP id m45mr1120094uad.121.1608240920144;
 Thu, 17 Dec 2020 13:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <20201216144114.v2.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid> <160817939232.1580929.12113046418592056259@swboyd.mtv.corp.google.com>
In-Reply-To: <160817939232.1580929.12113046418592056259@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Dec 2020 13:35:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XBMYpxLMqEDEwnpVGjtL+iUvCCmXWDrdwngMa-BWGM+w@mail.gmail.com>
Message-ID: <CAD=FV=XBMYpxLMqEDEwnpVGjtL+iUvCCmXWDrdwngMa-BWGM+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer
 is pending
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 16, 2020 at 8:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > The SPI core in general assumes that setting chip select is a simple
> > operation that doesn't fail.  Yet another reason to just reconfigure
> > the chip select line as GPIOs.
>
> BTW, we could peek at the irq bit for the CS change and ignore the irq
> handler entirely. That would be one way to make sure the cs change went
> through, and would avoid an irq delay/scheduling problem for this simple
> operation. Maybe using the irq path is worse in general here?

Yes, when I was in my SPI optimization phase I actually coded this up
and thought about it.  It can be made to work and is probably
marginally faster at the expense of more cpu cycles to poll the
interrupt line.  I also don't think it fixes this issue nor does it
simplify things...  :(

1. If there are already commands pending we still have to do something
about them.  Said another way: there's not a separate channel just for
setting the chip select, so if the single command channel is gummed up
then using polling mode to handle the chip select won't really un-gum
it up.

2. In order to use polling mode to set the chip select we have to do
_something_ to temporarily disable our interrupt handler.  If we don't
do that then the interrupt handler will fire for the "DONE" when we
send the chip select command.


If we wanted to truly make this driver super robust against ridiculous
interrupt latencies then, presumably, we could handle the SPI timeout
ourselves but before timing out we could check to see if the
interrupts were pending.  Then we could disable our interrupts,
synchronize our interrupt handler, handle the interrupt directly, and
then re-enable interrupts.  If we did this then transfers could
continue to eek their way through even if interrupts were completely
blocked.  IMO, it's not worth it.  I'm satisfied with not crashing and
not getting the state machine too out-of-whack.

-Doug
