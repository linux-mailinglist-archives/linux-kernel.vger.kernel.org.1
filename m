Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A802AD797
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgKJNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgKJNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:33:48 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:33:46 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so14132976lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+6VXi/5fY0aP8aAL5vEFMrlAfYUy6hH2SKWPsznW1Q=;
        b=FmlAGRfSk4J3zgXbJDv8yHH20lrNZWFBkHg/DnPlYXHe2VccCLgYFTG8bjdBptozIj
         C2SnnYxyrVFoEIY8U1UhC6ub3gwPf//MyHB4gfw2rbPTQhPCPbO5KO4f2s9/x01x5c2q
         d6E8PMeQIsrG5wuAilg4l2FHg93/R/9JGkgflAWK9Hl3OzEvAijLIUAx7ofhK+AaESb+
         1GmPNkrH2tMp7ciAAlxzkR08SQ+fhcGiiToI55gcDiBOR7/lsm7BVrnvEM5ycDQakWp1
         s0DF7ekcsMLZBvO0AbIver97jjPizf/gVWAnl+PQFCdABi/mw1+gmjWTI039J+xVWXTO
         gE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+6VXi/5fY0aP8aAL5vEFMrlAfYUy6hH2SKWPsznW1Q=;
        b=hEuTxPa1GrfJ+uLjEf2XMwuE9w4c+m+gV/d8ax9AygQBSu75HXpr60M/HMRvd15g/v
         la/5BZZb5k2+qiV+k2m+JGlt5SOY6M7k9lGGw0IQ9b+uvW48TNVtauai6zKPSs/sShdX
         1PuKTvCGOoHUO+IfJEc3yrORjW/gAys0XLr2D4bFTNyKQ2uETg9QJ4r+u7eLoc97r04O
         g4FCrC1ghlOejft6ikNYTr5Bp/DvrfQsxOUFZ6BjH+yWdTdARbGDRaxMU9ah60nm/hGV
         0xqkTjNNz1BZtH+wNPlpo5EBOgEfvlnz4MZk6RA4CnPOt2KdeUHnUQwto8RwrHO+Yg8B
         VUlQ==
X-Gm-Message-State: AOAM533EXr8yl7zG0R9KHprCf2vKYrKWep56lLk4vgIAMrIJUx3JDe1L
        u5hmJ3jEgAoH0x+fRPKtByLFy73e+cQZ2vrGW4/Rvw==
X-Google-Smtp-Source: ABdhPJwuAaqcMMw0q1QKD4oDxOC2Zd/QBV3ne5UQWRpT2XN+r51MyMsPZhWlpVqWlaIpmZiQGEvtoy7cfNG7jCXEoB0=
X-Received: by 2002:a19:f00b:: with SMTP id p11mr7200799lfc.585.1605015225371;
 Tue, 10 Nov 2020 05:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
In-Reply-To: <20201106042710.55979-1-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 14:33:34 +0100
Message-ID: <CACRpkdY2oH47Om1Xa=ku4csU-YHBB8XFrsemgfOvh0XCTog-aQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] pinctrl: qcom: Kconfig: Rework PINCTRL_MSM to be a
 depenency rather then a selected config
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 5:27 AM John Stultz <john.stultz@linaro.org> wrote:

> This patch reworks PINCTRL_MSM to be a visible option, and
> instead of having the various SoC specific drivers select
> PINCTRL_MSM, this switches those configs to depend on
> PINCTRL_MSM.
>
> This is useful, as it will be needed in order to cleanly support
> having the qcom-scm driver, which pinctrl-msm calls into,
> configured as a module. Without this change, we would eventually
> have to add dependency lines to every config that selects
> PINCTRL_MSM, and that would becomes a maintenance headache.
>
> We also add PINCTRL_MSM to the arm64 defconfig to avoid
> surprises as otherwise PINCTRL_MSM/IPQ* options previously
> enabled, will be off.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Patch applied!

Yours,
Linus Walleij
