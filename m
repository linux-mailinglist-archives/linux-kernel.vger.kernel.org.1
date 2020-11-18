Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393342B7744
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKRHvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKRHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:51:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23614C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:51:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z21so1550824lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nURpr5ov7X95SvLLKy2lkPIJH+JjfdX/rQVQdnuFd1g=;
        b=s14qkvV5paJ7J6mI/ajn2/Y/Gxn7p2v9QVXPa8/w2DK94QMpSw4p0028up0SpYUVzc
         pZ2FgFTTiQ2NCZ4rB0YwzIjTWoQ2bUbicM7/Dv68jPyOjO7iA9MrKmajrgKfsRrvYL6D
         8Tjj4IcuuuSXaNgPcoTv2Yji9wM7K/sZjRkyjzviZAJUBpNpdbmwuqyj1wYF1Lm11m4F
         bG88koXS+gxnadOqHac36lajnV56qv4kr915CZVDx8lJE2xRb3SgT4gD9PQleMEqqacy
         rm/6afJ2sHM6KJHWoF5g6zEr8X9ZhSnlDu7TH0sx/PVaFoc8Mu0WrwBr01r/uE5ljCyU
         MzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nURpr5ov7X95SvLLKy2lkPIJH+JjfdX/rQVQdnuFd1g=;
        b=D5WtVtm6V+MkRdo0FXth7xPJZXvG4Npo7KtQ9VrUxY20uHzKHLz+HMXhvFk1gN27Rg
         qa5gknM4A8IBv2SH3yz8M5Gfbhz9HQxa2fZthwjUWspDxhByvkGpwFHkzTyIEiwiDJ5v
         XeEYAQsQthAnDHCvMk+AZNJnWyOvrojD/0hTvdAJCgK6uTRpwDGY+mWQgsY8kLRe6kwm
         scPEEGJYFLAf3EboZblXsEZpbzrFtnh5hbLZ+0wHCTp7wsFPPg3UeI75lFWWV5eoNZTj
         p9QE7v2ySxjmK3tAZDnX9debS1v9ns7mJ9FtHPTkHHgu5YBRCqRX+WVpRJmOHEz24vev
         gE5Q==
X-Gm-Message-State: AOAM531r91SHgB7wsHloCs50l/fXb3mTqT8hBpztcT003j76KGRv89z9
        6O/2FQgoMiwubByP8sBuOYqqe11DLQEm6SoOdcq/Zg==
X-Google-Smtp-Source: ABdhPJzftdofGTDH82fljYiqAsjomn3HTKrhzXm8n4LFPcN0Wryvjf4aAskijgV/qGKOSgCyMCSpqLwt7KF8GtpmGhE=
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr3049595lfp.572.1605685860624;
 Tue, 17 Nov 2020 23:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20201118143049.337c37d9@canb.auug.org.au>
In-Reply-To: <20201118143049.337c37d9@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 08:50:49 +0100
Message-ID: <CACRpkdYJtZJs7CNR7tagGuwjD6OXmH8rHWWS7nW4NDz1HujkKw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 4:30 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> drivers/gpio/gpio-xilinx.c: In function 'xgpio_remove':
> drivers/gpio/gpio-xilinx.c:275:2: error: implicit declaration of function 'pm_runtime_disable' [-Werror=implicit-function-declaration]
>   275 |  pm_runtime_disable(&pdev->dev);
>       |  ^~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   fbbeb6c0a1d0 ("gpio: gpio-xilinx: Add remove function")

Ooops my fault for merging patches out-of-order, I'll go in
and fix it up manually by removing the pm call from remove().

Yours,
Linus Walleij
