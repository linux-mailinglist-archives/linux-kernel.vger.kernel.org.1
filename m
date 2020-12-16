Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681372DC92A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgLPWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbgLPWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:43:50 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615BC0611CE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:42:38 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id b23so13864320vsp.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XaKi3pkn/qWGGL1OHbeKodqShSNHBJUEuwGVlhnD1I=;
        b=IW0m6+gNe0u498pdoXwDRl5AhteMmcMqIqpySkBIHT/CsrxDkBj6MqBZqBQBC07ZpG
         p/OWvZ7MC5yxIQry+BRZ8lb9BtCx7Y4Oaxdgxt3eqRvnzoRaS2YzD5Vq3/giZq6ufL3X
         14Ty9izbJxcbI8ks4fR512B5w6HLoD01GYIG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XaKi3pkn/qWGGL1OHbeKodqShSNHBJUEuwGVlhnD1I=;
        b=GxtKFOG1/pTiJP8UvficFXxyMAcJOXcTEtGKo4LrN+5mliIdrYehme+WymWPOljRsk
         qeK2XfSUSuCYL7C8ECvJKVyaLehdT0GMZ3Llzjm+oQTpvx5ibYf3IlFrMcNasC8uMvdl
         PFK5zJv/6H8gMnsW0uEYjyK8Yaee3hnIIKdNfU9+l9re8iuSsi8YGnUEuh6Qb/lpsVoG
         unZ84yCmaw1nclBbvVUvbxnciyPs1d/ZYZm+Gb97yX8bzb/dj4fR8FkO674liI8k8KHX
         tBUyUAV0KQfgQVugHiBjWM8tKygUx+2mYj2HASu7r4c0wEHzhfKpgnRvPKc6hpA4Ve6W
         M33w==
X-Gm-Message-State: AOAM533ljrcyiq0Z3oiAgtVBRo149oS48t6xq+7NhQxNKUdgbcqr4ocv
        8TF7QKszyYSq/ODu5J9WQqETS5kCJQz4HQ==
X-Google-Smtp-Source: ABdhPJwxyDS7DFl3jUoYOtTS5TsMWDGLuTlScE2AknbQQgAb5rJxoJt8BQZmTFy8Z8rmhCITLDuReA==
X-Received: by 2002:a67:bc06:: with SMTP id t6mr36168151vsn.47.1608158557429;
        Wed, 16 Dec 2020 14:42:37 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id m186sm182846vkm.15.2020.12.16.14.42.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:42:36 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id s85so13888520vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:42:36 -0800 (PST)
X-Received: by 2002:a67:bd01:: with SMTP id y1mr27690548vsq.49.1608158556188;
 Wed, 16 Dec 2020 14:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <160799937019.1580929.2975094455755766017@swboyd.mtv.corp.google.com>
In-Reply-To: <160799937019.1580929.2975094455755766017@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Dec 2020 14:42:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wy_zmFrtG37pAPf5TBJc9ykffs4E-KLtytrOzv0nrXnw@mail.gmail.com>
Message-ID: <CAD=FV=Wy_zmFrtG37pAPf5TBJc9ykffs4E-KLtytrOzv0nrXnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-geni-qcom: Fix geni_spi_isr() NULL
 dereference in timeout case
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 14, 2020 at 6:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Here's a shortened version:
>
>   CPU0                           CPU1
>   ----                           ----
>                                  setup_fifo_xfer()
>                                   geni_se_setup_m_cmd()
>                                  <hardware starts transfer>
>                                  <transfer completes in hardware>
>                                  <hardware sets M_RX_FIFO_WATERMARK_EN in m_irq>
>                                  ...
>                                  handle_fifo_timeout()
>                                   spin_lock_irq(mas->lock)
>                                   mas->cur_xfer = NULL
>                                   geni_se_cancel_m_cmd()
>                                   spin_unlock_irq(mas->lock)
>
>   geni_spi_isr()
>    spin_lock(mas->lock)
>    if (m_irq & M_RX_FIFO_WATERMARK_EN)
>     geni_spi_handle_rx()
>      mas->cur_xfer NULL dereference!
>
> Two CPUs also don't really matter but I guess that's fine.

OK, replaced it with your version.


> > Specifically it should be noted that the RX/TX interrupts are still
> > shown asserted even when a CANCEL/ABORT interrupt has asserted.
>
> Can we have 'TL;DR: Seriously delayed interrupts for RX/TX can lead to
> timeout handling setting mas->cur_xfer to NULL.'?

Sure, added this.  ...but made the super important change that "tl;dr"
is more conventionally lower case.  :-P


> > Let's check for the NULL transfer in the TX and RX cases.
>
> and reset the watermark or clear out the fifo respectively to put the
> hardware back into a sane state.

Sure.


> > @@ -396,6 +402,17 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
> >                 if (rx_last_byte_valid && rx_last_byte_valid < 4)
> >                         rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
> >         }
> > +
> > +       /* Clear out the FIFO and bail if nowhere to put it */
> > +       if (mas->cur_xfer == NULL) {
>
> I think if (!mas->cur_xfer) is more kernel idiomatic, but sure.

I've been yelled at both ways, but changed it to your way here.


> > +               for (i = 0; i < words; i++)
>
>                 while (i++ < DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word))
>                         readl(se->base + SE_GENI_RX_FIFOn);

Sure, that's fine.  I was marginally worried that the compiler
wouldn't know it could optimize the test and would do the divide every
time, but I guess that's pretty dang unlikely and also not a place we
really care about optimizing a lot.  I'm also not a huge fan of
relying on loop counters being initted at the start of the function,
but I guess it's OK.  Changed to your syntax.



-Doug
