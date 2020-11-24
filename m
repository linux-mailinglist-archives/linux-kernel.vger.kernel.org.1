Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4F2C2360
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbgKXK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:57:32 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:30 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id a186so381789vkh.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGqCXsAxRO0vpXRIrXdtGnKP6NWRnyZrBio4pD9FBxU=;
        b=qa4OStBxNJ4t7DhNZQtDfxC202qJPSIlKtVc6ZvMq7c37gCG7CIByVlcIEv6WdgPg7
         Tb86pwKvzRMdpAvb0OLf3u9uIeYia5SVWrccEhex8nYW6Scz5pppPr9XxZKq/VyiBtuX
         6XzsKlnzsoeTgXnnVRNz0Hk2GvwQsRM/67z7xsxFQz10dGWFrXq+wCOxzZY388T4Vx1o
         tHb/TQ882z8Bj0B9ZOpJFV19eiydAiim/w2SDOZpL19zBaZWCsj2YtEjS6bcPLbXJwi2
         GMFHHQqk8IV6eml+eqpB9nw8eSTRJgWCmF9j5fWIaCY3CWEXwFArSTQS7Vwd2W/Hk+Dd
         RgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGqCXsAxRO0vpXRIrXdtGnKP6NWRnyZrBio4pD9FBxU=;
        b=LdGLafznBK193mMAHZ7e6vs1XvOSxomZoOSdcaRz6gyMlqtDffkW6PEJhOR05bXwZo
         2BzyLQ4i/7fqqk4aYP5YJeRxcxKveQAqiiH74cjftKWOxfq34DpD9yGzZUgkhNJAs9HV
         4gazw5DEocvYXFeBdY4Y33cTd+6c5LzrwZ4W6tlo2Jcuk+HeX9TRqYiYQDt1QsBFwG8x
         aTK0FpqNOmzN/JnyAZRpgGLMDGivk1j4CBeHSLsIybxWDtJ4W3iB8AsUyA8rmhmG6DnE
         wAnPQyOg+aAtDG3LjIeSLOURF9t+oagIlr+VqY0sxijyV4UHSEHivFk5z1VJsUJhw34s
         httw==
X-Gm-Message-State: AOAM533cvSj6vG8BNrWC90v81OgM6w4ALMc6ipjVbRRMrasOo1kSnGK7
        +F76DsPXBk7KCE40d5brLjxTjPrpmh4t72rrp7Y1mg==
X-Google-Smtp-Source: ABdhPJxR3a7b2r6PVA9tDyW4dZn7HD8HNGH15EGBz1efj4Bijjl6l208JSIoLFktYsS85Wh1XfXoshaJAh/DiVhtGs0=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr3175248vkd.6.1606215450002;
 Tue, 24 Nov 2020 02:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de> <20201124103242.2971199-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201124103242.2971199-3-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 11:56:53 +0100
Message-ID: <CAPDyKFpwnqORRPcqV30YQ8R+zR+QeJ1aHN3S7Om72UnH+p1uPw@mail.gmail.com>
Subject: Re: [PATCH 3/4] amba: Make the remove callback return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 at 11:33, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Most amba drivers return 0 in their remove callback. Together with the
> driver core ignoring the return value anyhow, it doesn't make sense to
> return a value here.
>
> So add a warning to the only driver that could return an error code and
> change the remove prototype to return void, which makes it explicit that
> returning an error value doesn't work as expected. This simplifies changi=
ng
> the core remove callback to return void, too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

[...]

> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers=
/hwtracing/coresight/coresight-replicator.c
> index 6772f23e5c4b..de71058d131d 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -390,7 +390,7 @@ static int dynamic_replicator_probe(struct amba_devic=
e *adev,
>
>  static int __exit dynamic_replicator_remove(struct amba_device *adev)

Looks like you missed to convert this to void.

>  {
> -       return replicator_remove(&adev->dev);
> +       replicator_remove(&adev->dev);
>  }

Other the above, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
