Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3362AD79B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgKJNeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbgKJNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:34:15 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5BC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:34:14 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id b17so2041025ljf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGLM9fPNY7+GT4p8nJCSTip3uZZh4KalRevc6NBKqSw=;
        b=h3fs2yDbhXzIKAaNrM+h8p/XSPvr3EH34ss06aruBBygOKO9jCk2Y2fGVpLMiUHrXI
         LE6Lep9wERBSv9edvF2R2doBF6UAXzV/t6wvEqJGmP2fv/BKT/WdMvx9o3EnhCP6JLVi
         Q1xUeqe6Uu/vuhmQBEe7HAqerEUcGEq2nQwgaTgrpDmXvvfR5zTO9Gvv6n00nixmJ40E
         IwnKLpjoF9/iK0H8bBSdj24Ftf0Wj/OpGR7dBsrwYGZC2Z+nEBeRufIeob+3TLmbiUHU
         tgVSzrE7cn5YGxROsHaRqAZ4NEXXzsPQLOwEu1nPCsTN9ZyJANwF9wGuLlNEpwaEPI9O
         /iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGLM9fPNY7+GT4p8nJCSTip3uZZh4KalRevc6NBKqSw=;
        b=nus3LfA59MLOAizJNf2l5QMc2co/JsupGkgJ1AXX3X2Ftk/hEmpiQ2uEYJ2gEuD6qy
         GJ0i5h/IBCwz/l3Hh7xAWNmH/5JhIl989/vVrTJXAB5ItqCSKKSoZojgwkZbDa7Gz4bC
         VQ85rtShn/YObx+aRNB6rR3gfdnPUCD0N5ogYzOfrAjD1GYirZV8GcajtMdG94XYtZxg
         l+08lQkxhzscePK2+LRAJWdtk/wyCk+DcW/XekJSg6TvbTNcvXjT+xox8qIqg3jcSV/p
         UaVz37oulapZ+Jv4/ff6HoueKIO6t+0JQ3MthmbF3XRaktjvohPV5506+QR5wFNe8OWC
         7Dtg==
X-Gm-Message-State: AOAM533M3djVX3agqvk4AGwf9uBqyZ/BlppTOpHfBYa1qm0qSEqm5HZv
        j/1Sl5aXD7FCUHm/wUNp/Epx1zwJN2hcL2MBVxptHQ==
X-Google-Smtp-Source: ABdhPJw4l95Aug60napiBX1bSOo2GaerufcLINoM+ZkU5hACFyVVdkrKEpvI/w+Qkg+bt6DgzwF/QHjFBj4ZnqZLbQo=
X-Received: by 2002:a2e:8604:: with SMTP id a4mr8277742lji.100.1605015253248;
 Tue, 10 Nov 2020 05:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org> <20201106042710.55979-2-john.stultz@linaro.org>
In-Reply-To: <20201106042710.55979-2-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 14:34:02 +0100
Message-ID: <CACRpkdYf-SGfqjbE_SFfJLidH8v+Q3=_hwKkHZGfKNgD_GdLMg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
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

> Tweaks to allow pinctrl-msm code to be loadable as a module.
>
> This is needed in order to support having the qcom-scm driver,
> which pinctrl-msm calls into, configured as a module.
>
> This requires that we tweak Kconfigs selecting PINCTRL_MSM to
> also depend on QCOM_SCM || QCOM_SCM=n so that we match the
> module setting of QCOM_SCM.
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
