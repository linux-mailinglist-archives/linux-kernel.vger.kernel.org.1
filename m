Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6E2C2030
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgKXIjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbgKXIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:39:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE65C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:39:07 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so27679857lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8+bYCeKuOJvnepjKUXd1bAXp/xtxeuCkyy0njL/NAA=;
        b=pM2yYux2OW5DIOxHgUVmKI58b7pM94gtzpow1fv7nhugyA1ylNk6yTjvTfL6Isdxa0
         RL/fpFvBHQmjRmSqhc9JPxpgv4Hh8ZdWdWI/E3jRb8mDsuIlEa8niLuk/MPJrYGDbpC1
         ADKmWNH3/BnBsyr72JUrUNzFnzVK/KfPZEgi72Q5YZ4KCmMlzZ47dgHY6QO2za5gPKB5
         VTGRXum+qhzFRudFxIXNExPBbDtNE8JkFI04gjlMrBOsyvWtsD4l6S422YBS7glv9aTv
         GVrFYKXL+T7T05X0vlLfSlmzxYxqNnh7dO0mGfiJzBO5zM6/1XhzLSL3OAJaHlc2kx3c
         9TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8+bYCeKuOJvnepjKUXd1bAXp/xtxeuCkyy0njL/NAA=;
        b=QKizo+hc5wbq6jo5F1CD6wRhU9Tz+dFz0EQJmjWRufpguNXGPm4ccjWTkAmDTnjwYr
         /nJtU/QtqtXXk+Aiq4r1eh+sGmTkBAjb+BlLj8Y/SClkiWVLnYOAZiwr8sgzOwB9PiV3
         WG4cp/FTwXKgPtoZT1gn/ytRbBg0OsRH3mDKky8wT0iyHAkfBvnl4taE7WEiAmMB/p3r
         +EbGoEbdcojqv8RKhiwaOxWjX8wHr2rL3N4K+S6r+kvZryzvqjYdYQfXLGp3tyF1XAP8
         taNiNFPQ9BN54C9pd7RnCXT8UnPd/ofnpJ5g40e3cyPtkuJuqgNR59B1NAGAyfEFm7qh
         4FtA==
X-Gm-Message-State: AOAM532R0GBaQoOmucRnLF1mKpcf8yxCR8HtU5XdGUdy4ByPNfI6d9rG
        zkl1LhPTFD8JLu3yLfIm5j9Rk9n1Hql/j+v6V8OXD0qhYd/kAA==
X-Google-Smtp-Source: ABdhPJzQT4fDtfKY20ncG9HETAsp8RdTF79Jyc6mRKyoBEhhdyG1qtyOY5kKpTCHvD7v0L+Hn6wSYsEYEGC2qtveh2Q=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr1212354lfb.572.1606207146303;
 Tue, 24 Nov 2020 00:39:06 -0800 (PST)
MIME-Version: 1.0
References: <1604570192-15057-1-git-send-email-rnayak@codeaurora.org> <1604570192-15057-2-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1604570192-15057-2-git-send-email-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:38:55 +0100
Message-ID: <CACRpkdbrOKct5v2YY6L8G5fweP=eOFpcS9=Z6nUyA2E4Of+h7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add sc7280 pinctrl driver
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:56 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for SC7280 SoC
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> v2: Consolidated functions under phase_flag and qdss
>     Moved ufs reset pin to pin175 so its exposed as a gpio
>     npios updated from 175 to 176

Patch applied.

> +config PINCTRL_SC7280
> +       tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
> +       depends on GPIOLIB && OF
> +       select PINCTRL_MSM

I changed this to depends on PINCTRL_MSM in the process to stay
consistent with John's changes to modularize the pin controllers.

Yours,
Linus Walleij
