Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385242CDB72
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgLCQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLCQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:41:42 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C6FC061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:41:02 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id q68so880078uaq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9nyCJC0nU38YlbMYoMuph+lAbm8n/7mX5kHqxu90WM=;
        b=O/1ecWU1krq4Zyfr7gXEOH6hvEU6wxv6MvpnyIMYB+qdtNqfRb9R+XXB/WkF6DvLkz
         Jd/LMUdnV85MKbmK/VPgE3LvueyKo4pMYW63veNYo6ClZno+xYKlNgEaXYGr7iYhNa7X
         ey16YAzQcxCBDI07FrSKpbNSSSJ4u4LktI0jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9nyCJC0nU38YlbMYoMuph+lAbm8n/7mX5kHqxu90WM=;
        b=bKBoxHEX9JvXbTvm1PW3QqcQdjtZI6Bb3rk9XHs8nBo9fVfNfPN1UVTn4ChKt4O+gt
         37jE623mChBU4b6MtDYeEdQkB2+DGffc7Z4tqwZ51GP+NC5ergxj7JsjbuwtDB7s1oD7
         iG1wpQk4h7fcqFaVUTvj3NIvwt+bArcQCT61xVCi7Z9Dz50YGSRpC27XjCPiDg7GWp42
         8XBtu1LJhsty3qYl8/47XNfPdutHMcSHs9yhPlGP7VVTuMvY+agBP7cHK4MFgfJOJj/f
         nsHQkU1DI9zzwm2phoTSttNEk0wnCjRtbd5X2DiVClQgbq7IBUTN83c3B2BTwUieOS8a
         qbrw==
X-Gm-Message-State: AOAM532Q9PmjlppQXMvIkToKw+w/4Z9yFFTFoNqlMU1qsl5AFxdDTl89
        7kPXER1u26LG92mcrIJm09AAzQzhWN1xlw==
X-Google-Smtp-Source: ABdhPJyda4j2FxmCHr+MUxuI79yaU1jsU6+D1fB0qOsMHo4n9q22TlMzR1JPpU0HK7vDBxz1a2rr0Q==
X-Received: by 2002:ab0:74d1:: with SMTP id f17mr2959153uaq.30.1607013660353;
        Thu, 03 Dec 2020 08:41:00 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id m14sm2033vkk.17.2020.12.03.08.40.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:41:00 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id n18so872688ual.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:40:58 -0800 (PST)
X-Received: by 2002:ab0:35fa:: with SMTP id w26mr2918514uau.90.1607013658306;
 Thu, 03 Dec 2020 08:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20201203074459.13078-1-rojay@codeaurora.org>
In-Reply-To: <20201203074459.13078-1-rojay@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Dec 2020 08:40:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
Message-ID: <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 2, 2020 at 11:45 PM Roja Rani Yarubandi
<rojay@codeaurora.org> wrote:
>
> Here, there is a chance of race condition occurrence which leads to
> NULL pointer dereference with struct spi_geni_master member 'cur_xfer'
> between setup_fifo_xfer() and handle_fifo_timeout() functions.
>
> Fix this race condition with guarding the 'cur_xfer' where it gets updated,
> with spin_lock_irq/spin_unlock_irq in setup_fifo_xfer() as we do in
> handle_fifo_timeout() function.
>
> Call trace:
>  geni_spi_isr+0x114/0x34c
>  __handle_irq_event_percpu+0xe0/0x23c
>  handle_irq_event_percpu+0x34/0x8c
>  handle_irq_event+0x48/0x94
>  handle_fasteoi_irq+0xd0/0x140
>  __handle_domain_irq+0x8c/0xcc
>  gic_handle_irq+0x114/0x1dc
>  el1_irq+0xcc/0x180
>  geni_spi a80000.spi: Failed to cancel/abort m_cmd
>  dev_watchdog+0x348/0x354
>  call_timer_fn+0xc4/0x220
>  __run_timers+0x228/0x2d4
>  spi_master spi6: failed to transfer one message from queue
>  run_timer_softirq+0x24/0x44
>  __do_softirq+0x16c/0x344
>  irq_exit+0xa8/0xac
>  __handle_domain_irq+0x94/0xcc
>  gic_handle_irq+0x114/0x1dc
>  el1_irq+0xcc/0x180
>  cpuidle_enter_state+0xf8/0x204
>  cpuidle_enter+0x38/0x4c
>  cros-ec-spi spi6.0: spi transfer failed: -110

Thanks for the patch!

I'm not convinced about your explanation, though.

The overall assumption in setup_fifo_xfer(), as indicated by the big
comment at the start of the function, is that once the spin_lock_irq()
/ spin_unlock_irq() dance happens at the start of that function that
no more interrupts will come in until the later lock.  If that
assumption is not true then we need to look at the whole function, not
just bandaid where we're setting "cur_xfer".  Specifically if
transfers are still happening all the other things that
setup_fifo_xfer() is doing are also all bad ideas.

I guess the first question is: why are you even getting a timeout?
SPI is clocked by the master and there's nothing the slave can do to
delay a transfer.  If you're getting a timeout in the first place it
means there's something pretty wrong.  Maybe that would be the first
thing to look at.  I guess the most likely case is that something else
in the system is somehow blocking our interrupt handler from running?

The second question is: what can we do about the "Failed to
cancel/abort m_cmd" message above.  I guess if our interrupt handler
is blocked that would explain why the cancel and abort didn't work.
It's pretty hard to figure out what to do to recover at this point.
When the function exits it assumes that the transfer has been canceled
/ aborted, but it hasn't.  This seems like it has the ability to throw
everything for a loop.  If an interrupt can come in for the previous
transfer after handle_fifo_timeout() exits it could cause all sorts of
problems, right?

It seems like one thing that might help would be to add this to the
start of handle_fifo_timeout():
  dev_warn(mas->dev, "Timeout; synchronizing IRQ\n");
  synchronize_irq(mas->irq);

Maybe also add a synchronize_irq() at the end of the function too?  If
my theory is correct and the whole problem here is that our interrupt
is blocked, I think that will make us block, which is probably the
best we can do and better than just returning and getting the
interrupt later.


That all being said, looking at all this makes me believe that the
NULL dereference is because of commit 7ba9bdcb91f6 ("spi:
spi-geni-qcom: Don't keep a local state variable").  There, I added
"mas->cur_xfer = NULL" into handle_fifo_timeout().  That should be the
right thing to do (without that we might have been reading bogus data
/ writing to memory we shouldn't), but I think geni_spi_handle_rx()
and geni_spi_handle_tx() don't handle it properly.  I think we'll
dereference it without checking.  :(  It would probably be good to fix
this too?  I would guess that if "mas->cur_xfer" is NULL then
geni_spi_handle_rx() should read all data in the FIFO and throw it
away and geni_spi_handle_tx() should set SE_GENI_TX_WATERMARK_REG to
0.  NOTE: I _think_ that with the synchronize_irq() I'm suggesting
above we'll avoid this case, but it never hurts to be defensive.


Does that all make sense?  So the summary is that instead of your patch:

1. Add synchronize_irq() at the start and end of
handle_fifo_timeout().  Not under lock.

2. In geni_spi_handle_rx(), check for NULL "mas->cur_xfer".  Read all
data in the FIFO (don't cap at rx_rem_bytes), but throw it away.

3. In geni_spi_handle_tx(), check for NULL "mas->cur_xfer".  Don't
write any data.  Just write 0 to SE_GENI_TX_WATERMARK_REG.

I think #1 is the real fix, but #2 and #3 will avoid crashes in case
there's another bug somewhere.


-Doug
