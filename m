Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B62C201B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgKXIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbgKXIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:34:18 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD1C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:34:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so27647382lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOsLiTbxYXKFhYn23AnKm0GCKqtrauKi3T2pGJSrzE4=;
        b=CHpi3zXM+ZBBjFWt8aYVGwBA1uUi15+6FWT6qz27hAldi+pwaVb0kEHyHvVJ9IWDqU
         78qWvzydSs+QGI4nZKHsOjiUkxhCks2W7zFbtEsqKAYTa6RTZC1qplbbxH9OCZUkkKed
         hPwnVsxYfLJbg1GSu5+d7iwpLOve5ztHF7PmP71nG4fuEV3rFzbF4CcNmez3CqiUH2xm
         p3AwMbsnrjuAH9sL7Gw3mdqyzcgoxESpbXsbPxWgGzR50Vma/y970yd5OwyDbjIhbiRm
         ueIB3bgljndM2dhF8XQzvlS/2Tmt7TwgNyHt9GHTyt1jM2cpi2p9aZXh+575xm60+uwu
         AM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOsLiTbxYXKFhYn23AnKm0GCKqtrauKi3T2pGJSrzE4=;
        b=q2yncsvwoLDA4ZMYKdgDjDjmWMZzJ13LEK3UbkCMHjVSTo5Jn4Y3Im/VzSKwZMEggk
         sPnuK8QE9vU3ZSFTH8SwMeiP+V6gELkMADZ9L0GuGYlZ/hw5waP+wa23c0wR5sYt7BZU
         7QUUv9spCp0dpNi5MslR3SCJ78wblaehx463PGkKsv5NKcWEmbyya+yU/puiQs0G68TJ
         zZJ/PccelQ0ygLh9nDrC1oGyqVkM6mpdxb95CegWBwco4dbtiJPffZnIVOupOCS2iUNR
         +x7VJJLXCBT+Dtlnj9qlpWCfFsbS3i4sKTb+UA0ExVFsc2/4tZbP6VZdUThFDsCoeDiE
         1KMQ==
X-Gm-Message-State: AOAM53356Jtcm7K5fDeyKqpOW7wZJWedYm4mdvRh90II46Yez3vmSq4f
        10fNnaOux3lDXNgCQuLznwodSipowULBWC3cft4JFQ==
X-Google-Smtp-Source: ABdhPJwxXRCbLjcqM5cNFxRoLZTAopE19twHnC2FECcsw9s6HGoSZ1ZUv8r91e1dNjCEe2qNGc+bjQNoHSzhHXZbocs=
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr1218244lfq.585.1606206856836;
 Tue, 24 Nov 2020 00:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20201110215619.86076-1-john.stultz@linaro.org>
In-Reply-To: <20201110215619.86076-1-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:34:06 +0100
Message-ID: <CACRpkdZHufAsjySL7wWb1fSFJTgUhdiNjs_L4He+pHTpKfUy2g@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: Fix msm8953 Kconfig entry to depend on,
 not select PINCTRL_MSM
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Vladimir Lypak <junak.pub@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:56 PM John Stultz <john.stultz@linaro.org> wrote:

> One fixup following my patch commit be117ca32261 ("pinctrl:
> qcom: Kconfig: Rework PINCTRL_MSM to be a depenency rather then
> a selected config") being queued in LinusW's tree, as a new
> config entry was added for the msm8953 that also needs the
> change.
>
> Applies to LinusW's pinctrl devel tree.
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Prasad Sodagudi <psodagud@codeaurora.org>
> Cc: Vladimir Lypak <junak.pub@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I9e8e83b1ea57aff338074be9174fce53cef29eff
> ---
> v2:
> * Fix flipped numbers in the soc name, pointed out by
>   Jeffrey Hugo

Patch applied, for some reason this got lost in my inbox.

Yours,
Linus Walleij
