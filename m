Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7C25216D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHYUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:00:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3EEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:00:17 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a13so41974vso.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vx1r2CNa1rBAm3wMcMuYtNO0QstZgyCPzPi8kkUlIz4=;
        b=KZ3pczexEVfIWGV0IPWdQYQBqYBChCLEGtApRH3QfnlBWqlOq7DlgnonpQmEeHUr9Q
         CcDjp+GBQCLuy08q0QefeFt/oMhUiuz7IYGYn7y53OmbbjhagUOyhSljtDmaGrh+QCYk
         IBApJr1K/C8AUJcz5Qn0It9c7W46C0PZP4bo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vx1r2CNa1rBAm3wMcMuYtNO0QstZgyCPzPi8kkUlIz4=;
        b=Jwa5J5azqUUEOGX3TRdrIXS+w/GVz0gtA0m1OD5cTIlX6E5tvxJtDu9Q+GH1PLto3O
         lThVsA+97vpoBgZaLlyqaioBzHExMXB2AOozP9p/sLkIyQ8Quq5/eBzO9O7MXH0RL1Qp
         PJ1++os+zYOBrj1eoZgeBna05XxIa+/d9stxOTlQKbvxjxs9F/QtYw/Fn4IYWi8IB2UD
         O/YsjFdsRW5lTJwbW3qEZc7rR09xPAoQLi5ZDAz2yf8lhHEEilqYMw6TIEwc1+IOxP2/
         d0AE7UQA/7g77FYgxM10/eoSipOuh8ChS+ZdL1Jmgldsg7j3RTSjTofFGzxnID0MTV4B
         rB6Q==
X-Gm-Message-State: AOAM533f1ECoMSlPDoiSrzBn5VdTqvmZ8hGBOJ2CygfKsECLF0LJ41w4
        yDzciwBiCbQiAFFVNThM4Qybj5kD6zKghw==
X-Google-Smtp-Source: ABdhPJze9HQ0rvLac4/tXefzVmrKhgi0WM8GpKnGmLLO5G7rRDkI/8L1s/lzmaUZ9p891sYjklmbiw==
X-Received: by 2002:a67:e3c3:: with SMTP id k3mr6851574vsm.189.1598385616877;
        Tue, 25 Aug 2020 13:00:16 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id t136sm14896vkb.38.2020.08.25.13.00.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 13:00:16 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id s81so29790vkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:00:16 -0700 (PDT)
X-Received: by 2002:a1f:9b8f:: with SMTP id d137mr7014781vke.97.1598385615556;
 Tue, 25 Aug 2020 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org> <1598113021-4149-7-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1598113021-4149-7-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Aug 2020 13:00:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBidZvVit+P-HmQpxdi0XwD7uwkawJMCjPAp715Cg=4g@mail.gmail.com>
Message-ID: <CAD=FV=XBidZvVit+P-HmQpxdi0XwD7uwkawJMCjPAp715Cg=4g@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] irqchip: qcom-pdc: Reset PDC interrupts during init
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 22, 2020 at 9:18 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Kexec can directly boot into a new kernel without going to complete
> reboot. This can leave the previous kernel's configuration for PDC
> interrupts as is.
>
> Clear previous kernel's configuration during init by setting interrupts
> in enable bank to zero. The IRQs specified in qcom,pdc-ranges property
> are the only ones that can be used by the new kernel so clear only those
> IRQs. The remaining ones may be in use by a different kernel and should
> not be set by new kernel.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/irqchip/qcom-pdc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
