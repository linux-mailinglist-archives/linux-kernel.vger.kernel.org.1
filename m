Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC32F343B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391733AbhALPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391715AbhALPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:35:04 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8295CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:34:13 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id j59so943584uad.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxCZhN0HPYWVbJAFHzviClBBvfiktQzKxiUuI/WHb64=;
        b=JwBBAAjWC19z8UsuWqxUc5kVg0wMb6EWFRHoz7kkGUngbEhRU+C6/MCHia57wDr8X9
         Jd86Mt63DQEmW6eSaffdLzO7z7LiNnNGMHUe46zYzJcyQA6RGLKr4Kmg011Z0Emovi4/
         at0IHPfJVaNEMbSJ/B0M5S6vGzvw1vRl459Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxCZhN0HPYWVbJAFHzviClBBvfiktQzKxiUuI/WHb64=;
        b=shFvkIugjCiFoYJkMneVSTVpV0TtJArWkq0kuEUZbwv/F7T/7Xs6nIOugIWJYgteGx
         AATApRV/7J3xoI3HCJ5Er+Sa1pY7usEhDh18li+t6/5Kc8rhAupR7G47wbAcRjWT1hpo
         W4oBd7r7vC+Stex7fobareaNw6HHucWKgPZqa3O2n9uqlUvVoPUwqgZpapeoQKKoeseK
         aGClwlR0kg38Zhpc4Wu7BepHtfaSyBQ6TVt5fjOue/+z26BCZHPRxTNkkENAXVRHQkvx
         Ufhjr0QFqgNb0JPcWy8SIT5+7h+cY+oJCiUgoIdMh3QRr5NXwxr5h0cGaiChZ66xmozT
         IT6Q==
X-Gm-Message-State: AOAM533G9gBCYLZO1RghrNbS1mge+g65xGXPe4bBO2P5S4y+WL/MfdvF
        7H5MHJ2UJ7z7wCldPW2rl0MBrmbyqU4bpA==
X-Google-Smtp-Source: ABdhPJwwIqzmFYvRuKbNJpn4uky1eDZLvO3f8aNt7/sh2WClA/lFfpKwI6kTS9tX0yU5pKL4szupdw==
X-Received: by 2002:a9f:2213:: with SMTP id 19mr4065405uad.15.1610465652553;
        Tue, 12 Jan 2021 07:34:12 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id z18sm480087vkd.13.2021.01.12.07.34.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:34:11 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id a6so692427vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:34:11 -0800 (PST)
X-Received: by 2002:ac5:cde4:: with SMTP id v4mr4651199vkn.21.1610465651285;
 Tue, 12 Jan 2021 07:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20210112001301.687628-1-swboyd@chromium.org>
In-Reply-To: <20210112001301.687628-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jan 2021 07:33:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WRx2+jh7P5rM5S+C2shwbJiZSJxpf_fe57D+KpB4bijw@mail.gmail.com>
Message-ID: <CAD=FV=WRx2+jh7P5rM5S+C2shwbJiZSJxpf_fe57D+KpB4bijw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-qcom-qspi: Use irq trigger flags from firmware
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 4:13 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force this to be trigger high here, as the firmware
> properly configures the irq flags already. Drop it to save a line.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Rebased onto v5.11-rc1
>
>  drivers/spi/spi-qcom-qspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
