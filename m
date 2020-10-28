Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB14529D2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgJ1VhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgJ1VhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390FC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:37:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so565440pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XegyVj+nKJZySlbg1aooffXXRVjlzMTjgACCsCZVjV8=;
        b=LVdDIlVnTSe5M3cOXfDKY/yoHCuAgiUhVYAKweEXnCXPK98JcwHeT6d1J7q4C5B/Zs
         kGek2AzWNEygiKEITXCTOoypC79xAnu5RB2xxnLYJ2CjrJGQ1J+7A/3cdQ+jNOcYNt5W
         dEtAZZ6qEGLyUT/hqdxLKve8EzhULmUA7HN5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XegyVj+nKJZySlbg1aooffXXRVjlzMTjgACCsCZVjV8=;
        b=ne1h6iZAawApN1YQfLwbVc3p6Lu/BkdmJAKZRavqiUkPUHh5UmiChdSJjOn9+x5iik
         /+ZSOeMVpR8zWTtllfYfKbjHQ0RLi3Wfs18ITB1uRWXUFLv1WsPWJsmAbwfoaUVsmxtk
         v2cABQD/vtsTUpNy8QHjZhuJBD2cJ8r3GUQSD2KyxOP8RXsm5VLQA7Z/xYo6eUuvr4mG
         18hyF+OJfbeaJr3gnNofFRceQpDPce5tIi0Zt2sqNRIDpbelhq74a3D+8lDC2Ez0G0Ao
         gcWw2RlJiTsShbcn3PmAFlKhuThUEnjDkuXPFe1Zmi8eKpL1slGTWgVvEXpiu69vIMN0
         B/kw==
X-Gm-Message-State: AOAM5302btl1NskC0eqMYp8a4vdFpa3Rw0pqtzY/W1V+bn1C7IL2RIin
        K3S/OQXJpLZx8RM6yjkIgJbsypXLtSgiiFvmy5yo1vGBq5odUA==
X-Google-Smtp-Source: ABdhPJxZQ0BHtn1iP9Sa96xmeiH3d9xkjNIwwbKTU26Ow70h5eYTCHXvJ5Q2a5LLSTo886NZ9Q62P1+bQ7EjNgyE1Oo=
X-Received: by 2002:a05:6e02:c:: with SMTP id h12mr4681231ilr.177.1603859788644;
 Tue, 27 Oct 2020 21:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027201436.1597726-1-trix@redhat.com>
In-Reply-To: <20201027201436.1597726-1-trix@redhat.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 27 Oct 2020 21:36:17 -0700
Message-ID: <CAJCx=g=zFHVevqtmHtP_MJS481aypAGB5PMMdsXdCNB_ZiPwoA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:14 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/iio/light/apds9960.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 9afb3fcc74e6..547e7f9d6920 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -561,7 +561,7 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
>                 }
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         return 0;
>  }
> --
> 2.18.1
>
