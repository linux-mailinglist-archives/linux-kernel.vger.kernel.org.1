Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66C127B6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgI1VNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 17:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1VNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 17:13:02 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E1C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:13:02 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 5so1669926vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Atw6tlilgo9PIrWGO9ZwsIYlXI3Umohxy7sKhaDAMxM=;
        b=TV9amf1jSDj/q0zk2+YZ06YRaT4r/ztQksbRXH4VE2Ei0ZNblIhDRJdW5oI66xgqbK
         HZ9HR42RKge6Jr2OIBuQIzgx3dLw6RJuVKBUvHDBNW4o4Cxr69cZ9yjDLFPcuMqKKw3H
         cO3UUNlSeBTrZCMRZ+GhIb0oXVHPKu3IlK5gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Atw6tlilgo9PIrWGO9ZwsIYlXI3Umohxy7sKhaDAMxM=;
        b=l/bbmpV6ujEo0PAtXOPS9d/baabqHyigWkarWQp3dVQIUKOSoJIhWl4hVAI5KM87TG
         66NELyXTXv2ondf2CVcE0sj29fJccHwVATV9ob0Rl159CJLfXaDqzyBPE25Bdu5AXSdL
         06hYs4Z2G0soyymUXu1xVB+NUCKQT6zRE4mz5XOvfjxNBmwCW18G4n0o8CiSoVudLyQp
         YswaY5H6XGvQMh1Ptpx4XdepCZPlJX9+izM0XSOKHJbD7LbPwnpRoh9pQ7CNUvbEeHDU
         uUYRZeWvV6aw4n1ULTFk3DT8I3a4R1Hzu41m7HW9R4yv7FBsx/jr7Hg90qnkeX8U10gi
         Tlnw==
X-Gm-Message-State: AOAM5311J0agBDE+PrlxMg+iAIlDh/wDknW6ztt7fIQKMsa51pcbpNap
        L+PYgLRjpBGZ9sNu8g1IWnlt0n42PiJRiA==
X-Google-Smtp-Source: ABdhPJy0stzeKOzYbG6N307Q8Ag2VZYwM4sLz/PQzZjZKqLyggjmM4ypZFgjpXJHr/XlDi8OxZklhA==
X-Received: by 2002:a67:6bc6:: with SMTP id g189mr1137378vsc.30.1601327580068;
        Mon, 28 Sep 2020 14:13:00 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id c16sm297216vsh.5.2020.09.28.14.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:12:58 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id e23so1674168vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:12:57 -0700 (PDT)
X-Received: by 2002:a67:8bc2:: with SMTP id n185mr1119720vsd.49.1601327577585;
 Mon, 28 Sep 2020 14:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <1601267524-20199-1-git-send-email-mkshah@codeaurora.org> <1601267524-20199-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1601267524-20199-4-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Sep 2020 14:12:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VqkgWTrGLrUMdBWGD8_wd4yMr+e6U-xCxFg4B2LfhTRw@mail.gmail.com>
Message-ID: <CAD=FV=VqkgWTrGLrUMdBWGD8_wd4yMr+e6U-xCxFg4B2LfhTRw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND
 flag
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 27, 2020 at 9:32 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> An interrupt that is disabled/masked but set for wakeup still needs to
> be able to wake up the system from sleep states like "suspend to RAM".
>
> This change introduces IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag. If irqchip
> have this flag set then irq PM will enable/unmask irqs that are marked
> for wakeup but are in disabled state.
>
> On resume such irqs will be restored back to disabled state.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  include/linux/irq.h  | 49 ++++++++++++++++++++++++++++++-------------------
>  kernel/irq/debugfs.c |  3 +++
>  kernel/irq/pm.c      | 34 ++++++++++++++++++++++++++++++----
>  3 files changed, 63 insertions(+), 23 deletions(-)

I will freely admit not being an expert on this code / knowing all the
subtle edge conditions, but this seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
