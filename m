Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62D2A0886
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgJ3OyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgJ3OyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:54:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7359C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:54:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id za3so9004473ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q691nw1GaPkDFqjRLqSBRGymD9FCcdqizVVQkT/qKrs=;
        b=Ieu76FGZe4nrpc4PkAIX5Dz2qLRwmQwgBp7/L/cmwA0z5C5IecMAhDZbj63ThJrQVD
         /6s8Dfklit41Djj466ondkBnfpUzP6J9mi/+irdrwtbbGC1gFqttEQUu/lvC93HqB4Fn
         G/LExXcbPyAJVGmyS2VjFLwP4Caoo4w15E5plTM0h58TYOIFLDsDkvnx6qs+4e0GSv0n
         2Qq5d/m6zKjDlRVpafCEewxohpBSchLw3NRMu3YVrCT0Y4ew5l4Cu4D5pxGFAQbzHM46
         2y64CWuUud6oSSnVOdgmbPXin9SrJ0bhZS/GVtNeUfjjxzt6bKLabkkVMHlbkIRalprH
         BR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q691nw1GaPkDFqjRLqSBRGymD9FCcdqizVVQkT/qKrs=;
        b=sfhXBXHZo9xeXNejyAft9Ylq9ohhSf2alJa3LsSe1OSxbi/0Sl6jJ93gMXUhG4Hr3o
         +4t1BR4WhKGXx82vZcY1xM9vbfFtgTAahx7wcsfVM6Zsdt/mgKTegoFe461XD2gSIY/8
         TYD03GHZpt60zaINrPt13K56XXK0jZZlJgkEWg5BVnBIJKWDKowE8Mrlqz1X1ovJsypP
         lsfehwZqS/BRBRnAel1MQ40le8n9Anrk5YNFB8WCHlpXp2PLLNkqkjpFCnZMDNZZBO3D
         LB0j2kllmaUCTxle0/UNeP0xDHLluk//utu3rMJgD37ky9hW7q+IvpAWQUN5iHFSZaq/
         NqeQ==
X-Gm-Message-State: AOAM5318fBMw5KFYAzHTVAD9k4K+CEWmuQXvozxEsYgfYeggcDHovNPC
        2WnMhPOWryGstHC6wsWNTDTf8CM0Zv1GzocL/dOM8s7bVok=
X-Google-Smtp-Source: ABdhPJy7SBvOS7vtF6Cq3aM89II0s9Z1P7hOcvRuJ7tQSVs+YT+zaLUVxAmIqd810u7gn+Kos4guy7+p0UQK3IpMcLM=
X-Received: by 2002:a17:906:7d0:: with SMTP id m16mr2773722ejc.445.1604069646371;
 Fri, 30 Oct 2020 07:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201029084832.13933-1-warthog618@gmail.com>
In-Reply-To: <20201029084832.13933-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 30 Oct 2020 15:53:55 +0100
Message-ID: <CAMpxmJXoK=39ZBCNLUOGASAhxUfEkem0Z+i3g4XbKgZ0NMTD=g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: add GPIO_V2_LINE_FLAG_EDGE_BOTH and use it
 in edge_irq_thread()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 9:48 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add GPIO_V2_LINE_FLAG_EDGE_BOTH macro and use it in edge_irq_thread() to
> improve readability of edge handling cases.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index ea787eb3810d..5eb4435afa64 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -510,6 +510,8 @@ struct linereq {
>         (GPIO_V2_LINE_FLAG_EDGE_RISING | \
>          GPIO_V2_LINE_FLAG_EDGE_FALLING)
>
> +#define GPIO_V2_LINE_FLAG_EDGE_BOTH GPIO_V2_LINE_EDGE_FLAGS
> +
>  #define GPIO_V2_LINE_VALID_FLAGS \
>         (GPIO_V2_LINE_FLAG_ACTIVE_LOW | \
>          GPIO_V2_LINE_DIRECTION_FLAGS | \
> @@ -569,8 +571,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
>         line->timestamp_ns = 0;
>
>         eflags = READ_ONCE(line->eflags);
> -       if (eflags == (GPIO_V2_LINE_FLAG_EDGE_RISING |
> -                      GPIO_V2_LINE_FLAG_EDGE_FALLING)) {
> +       if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
>                 int level = gpiod_get_value_cansleep(line->desc);
>
>                 if (level)
> --
> 2.29.0
>

Applied, thanks!

Bartosz
