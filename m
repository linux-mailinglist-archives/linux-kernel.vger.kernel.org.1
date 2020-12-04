Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C832CEA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgLDIz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:55:57 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6CC061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:55:17 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id q13so6633057lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w11pISD3ZzCp+PCHo3vHRCO9EBjGTo8P0aXtAJmnTo4=;
        b=fgfeaSr4dZ0rRbcUlwIHDyO/G44Arb5zXnT+n42ij23Uv6FesC5DuO4rSkJsU62+oK
         6bs1UjbBeQGnkJhvJ2pxdyM6wp1POla4qNbmrnNIg07vJhO7J1bJT8Xoq5DV994CwLK9
         jxOFbwfPP+CyK9N/ynjjPYb7OmALM4TgS9tUKXWTQUgylIsfwHx4NFaxGO7EOtsZ16wv
         jCTxlgpWZDiuoKA6rkUwUsiR5Eu7r9I6TSFB27D6RJCRVAXQZr36BNG178rMo1T3obq4
         5RpNb4seqeG7O7fzxVxm333qQWqoH7WlGGtziRYgXzrX9s2qsGnD7MabeFqvIt2V1fUF
         /0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w11pISD3ZzCp+PCHo3vHRCO9EBjGTo8P0aXtAJmnTo4=;
        b=XBcr8sS3mxEK3gLrvYW3GMJiwO7WSmGwNdcN+XkfX4N5Cov2k2l2wEHtdvA9TuYVr6
         xPiIFGoSThXgRqcqF2IYDZl7SOZiRnzorbes15mzXdMIOvUon4KTc6dmscZSBB4Za0Ow
         MXKM7f+LsSialhZNBLBJMcz2A6K0acRNe8Z1mtaYov2o8C+ltmZgIoRoStOLycT59w3I
         Zmt+11jCTJfP1k+PAELIbOXijX4o192WHKc3eb/kVW41C7aJhm8bIjJUcXTSBtfyU5C7
         Wlag3Ar6yFfheWrdlbEhY7sj3x3oRp5iS4uXqNTGgW4PrNfgbE2IqfFJmKnDGDq0bPte
         ahMQ==
X-Gm-Message-State: AOAM53098WGX3/rTtBbPzavbjXJtubVNmZFM+fkPohL4eUNkjApkoTAd
        du5cogOMM+/oGD8+Ol7hFyof2RfY4YLbYUyT8Ak2Ew==
X-Google-Smtp-Source: ABdhPJzRAVBef0NNjG8hXo9GslnzbC1enX5sHI4l2bPqpkojJh7SNn+3F8d8H2uAIItko0ROzOWp935Bwubt4c44eK8=
X-Received: by 2002:a19:8d8:: with SMTP id 207mr2748031lfi.441.1607072116080;
 Fri, 04 Dec 2020 00:55:16 -0800 (PST)
MIME-Version: 1.0
References: <1606209423-4742-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1606209423-4742-1-git-send-email-yangtiezhu@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:55:05 +0100
Message-ID: <CACRpkdb_2uCoJhYK5QKXK5YDiOrfjpa1-uUp=zqY63fFJHT6WA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: Make PINCTRL_AT91PIO4 depend on
 HAS_IOMEM to fix build error
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> If CONFIG_HAS_IOMEM is not set, devm_platform_ioremap_resource() will
> be not built in drivers/base/platform.c and then there exists a build
> error about undefined reference to "devm_platform_ioremap_resource"
> in pinctrl-at91-pio4.c under COMPILE_TEST and CONFIG_PINCTRL_AT91PIO4,
> make PINCTRL_AT91PIO4 depend on HAS_IOMEM to fix it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Patch applied as non-critical fix for v5.11.

Yours,
Linus Walleij
