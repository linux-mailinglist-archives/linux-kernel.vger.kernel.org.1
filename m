Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1F285C09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJGJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgJGJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:48:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4735C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 02:48:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so1541623lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20GH/MytvGYbKKPijdXnWxAJl9+uE7J4D+YmHkLcQ5A=;
        b=S17RO4U0amB2x6k2kTZ9a18WHLzjOusfpWIWq3gOC5WbJcLVOQQ2mXbUadcpfjSLuN
         iq9HbMPS7bsUvfdMQRN0OEww/kG2tmlBZpVnZGfgw64AZbZNiPMLY8MTBbTZXtADdlSY
         JpNA4LV9CHidiERNGKQWk3gLfntluuMxih6wstN+Gt8NwcomqfSG3hX4r/J4kAg+CZ8V
         WmqK4BGMP8vrRcVI9ZeNJt2Iq/BOmP7rGeEtzsVfVJ5hmAHhIdeR1EFJgzi+2p37A2+3
         KRSqRDcp3IAn7uKXTdzSeXnJk35WLrteOP6tZI80rkAGLKBZyNQHZB8Yo4tuTGZu2ISg
         8WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20GH/MytvGYbKKPijdXnWxAJl9+uE7J4D+YmHkLcQ5A=;
        b=ANltThrb5UAVI4zrSgy3JAGS9zws7wVViJ+iXerTkaE8KJYk4coQWXKBgm4dQMihng
         xtoYdCwKK65U5DTJossLkgSRvssSLurz9mdh7M7PJ03jblCVEAn/9L7PzP7Dkty+XNPk
         p8pq3bVqHOGX9YLyp5Sc5uUayzFLh6mt0MKxh7vOw5wOl4uVfhBRICqnM4WGpu3GwkAh
         /rQ7FEXomoHFeqqlNxNbfZjA37UiQh4cf0maqz8O6OiPc55Hvf7Tk/mZwFMnzK4mtMDa
         gI+of52ODWxHE/BvNfJFehasseQJgicMhYwQobzQcJMAsjHvpxfGor6GaqjxmASTYkED
         aYhw==
X-Gm-Message-State: AOAM531XaD/zYVwFOKI9EHQapTVHLaA6kvQ2NDFiQtY5w42C3llFtY94
        hktoo+P7WyeukKxElJtpBmli7uZZ40o50tsQOfctfg==
X-Google-Smtp-Source: ABdhPJzPH5Uv1yv+cQeuLvKQdejQZpjVdeaTjLNvb2JO6s6Fuweb5qiZpIdL9lRhrTSe2A1ziwDNSyID033hvbeRNlc=
X-Received: by 2002:ac2:42d8:: with SMTP id n24mr625051lfl.502.1602064097182;
 Wed, 07 Oct 2020 02:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201005140217.1390851-1-maz@kernel.org>
In-Reply-To: <20201005140217.1390851-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 11:48:06 +0200
Message-ID: <CACRpkdbctO9cWZZhVQHWkA1DN7YRTsLRo4Ub9g2x7q6BBSD=Ug@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Survive spurious interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 4:02 PM Marc Zyngier <maz@kernel.org> wrote:

> The pca953x driver never checks the result of irq_find_mapping(),
> which returns 0 when no mapping is found. When a spurious interrupt
> is delivered (which can happen under obscure circumstances), the
> kernel explodes as it still tries to handle the error code as
> a real interrupt.
>
> Handle this particular case and warn on spurious interrupts.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Patch applied for fixes.

Yours,
Linus Walleij
