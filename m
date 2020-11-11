Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9B2AEC85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKKI7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKKI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:59:42 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54950C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:59:42 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p12so1185373ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4L7dpT+OEGMpiVCbkHb6XBjBe4OQb72L+wppEiYlus=;
        b=S7h8dogyIxYZeMvlMQXOHPz9oUPsBRsGs4+MCVmWC/+kROJRdZ0Pd5r2M3MrPiLMk0
         t5uC7AA1hHSTJ5Ga1ecq+CDVv3b5N2dlwR0ZwV5XJCGYBOfZNpuGAkp53jgwpjZOgcTB
         Txj0BownMIyamV7lnasC+ZCOWhp/Sft09RiRfzPIHjpnFMU09J7FveQOJMA3K4Cc54qT
         zRa6qKoNDNqG3xdarMjwhohMopCv/QM51ujg7KfCStlhO57F5srPOon4jZdAX2BJTr7z
         k2EWr3c9iPr+YS9KUax3AXiL8FsejISST5I2jYzQMYBnvjPKQuqfJnjI2aQDGiFraI8e
         ttUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4L7dpT+OEGMpiVCbkHb6XBjBe4OQb72L+wppEiYlus=;
        b=YoDMGMh+0RkNriLqvZq3R9ejaDc4KpPgZwx2puBUKo5dlfBbkQgXeEC02uo1TWbUF5
         tpzo/WzdYuzCvOAlpqtqbs2FFAN+3NDAHg+KJ9gBAKcLJffhEPEbx2o3rSvq/dZdJ86W
         a/qS6zLEFKAz8J80wN5HbqmVeXW5FlLwF2mxD9MD88Fh3e5NvYN8q/LTAMIhmrpyd0yg
         A3CNH92YI+t1tnGWz8gj0Ioz5LkhXceALcPG1mA3T7dy8j3Zkj0HcCEce0P+qethxwZ+
         WWEFZA+L5hGNs2nWN6P34Ml5i337elVR4B0UpZ2HnfTpGZSssMah8luVjTyp3jYrHyyn
         RiTg==
X-Gm-Message-State: AOAM531q8q1gbgrQd13KKTLWcbRH1cwplOKIRT36AGX3kW+wF2/G5tzC
        QGQqvvcfuTlDeaa8Kllr/s0mLzugVJNmiMEcLvTUPQ==
X-Google-Smtp-Source: ABdhPJxXnwzBa9kfKfYbjzQ+KHo2KJdokHzuPcXV+ntv/2nhEqhtRqzcDlPiibLVQdhpK5/5gvuKsyW2FXzOqI7KQeo=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr9190090lji.338.1605085180723;
 Wed, 11 Nov 2020 00:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20201111043610.177168-1-vkoul@kernel.org>
In-Reply-To: <20201111043610.177168-1-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 09:59:29 +0100
Message-ID: <CACRpkdZtiUpF7dtJCjTDovZxPp4MziB6Tu5XTdFk4A5MYODudQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sdx55: update kconfig dependency
To:     Vinod Koul <vkoul@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:36 AM Vinod Koul <vkoul@kernel.org> wrote:

> Commit be117ca32261 ("pinctrl: qcom: Kconfig: Rework PINCTRL_MSM to be a
> dependency rather then a selected config") moved the qcom pinctrl drivers
> to have PINCTRL_MSM as dependency rather then a selected config, so do
> this change for SDX55 pinctrl driver as well.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied!

Yours,
Linus Walleij
