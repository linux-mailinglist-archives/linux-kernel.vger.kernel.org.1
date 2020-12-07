Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98112D0D67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgLGJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLGJwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:52:12 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F6C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:51:32 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so18592191ejj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDproOdcsujjsvAHCgcoIw5qD1NH0yafrww5RZ0rAYo=;
        b=v/lPNlrI+spy8ENH+siV8TRv9D/gzdb+wn2WpEVq6QujJsT6lP3ViRFQCgOYnAyaVP
         ouWFjVkBONwwhwcCZGEdxrTB9FPe4ts2NOCY1MuH6bM0Q/ujet6Rf0hJJDbuJDXBqRCA
         K1dXDnGLuoEsGh2mZq9xWwR1hQTcnlM/s6YDFRPJxbInvrXgi5WaKnwOi1MVind3zo3R
         AOaDclMHK91OSLU/fNgjh3Tni2jA8UJ91hmcRsC4JfprD4Kd1b6pSOqSXDr0UxMSqolC
         Jn3BPaYleMhQmUfQ0afwo9/u53/EzPZnq96+BoUThWLAVE8Oz6Eoc5vVFWvyAwWm//0K
         UvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDproOdcsujjsvAHCgcoIw5qD1NH0yafrww5RZ0rAYo=;
        b=lG27MFIDF9jIH73lE4ooKq4xOKu2Zj4l01sxCsH3inZPzQnV3CNGshPRHjSqv2VkjW
         FF+mjdB1tbuSWIqGnRXlIgI8lUDiSpcWu6n9+TuLhPAklZ7vqFMdgyIxL70TwGA8DaKF
         Tu7YaxJ0x+szGiHEZy7djFGAxViiFIu9S4H7NtH66DuKDtZ+aWCYPFJNgSSdEo4Mt7Qq
         oDvSk3CD5CA5rPiT+jdPN8IFcGDb9hMJQgOSNECDty1/oiITPoSnTwG8481cHnPqU0Fu
         fGiZaZF3LeHIzKba54adSqk7U1c3CPU49BXs/SNo2lAfx9WpCKXkzWABvFJUWN2vnBKc
         4USQ==
X-Gm-Message-State: AOAM530fUoqKCUQMsZ9fYMRuSaHc33SiUoFDq+EK9GtDoqlOzx79U2AI
        TmzKm3u6p4X43Tv8fw+9yMQ9Ky1I2GQokIlEHr8xZ1IEgRs=
X-Google-Smtp-Source: ABdhPJypxapTmTppqyHWf55vXCBIa6VWMormBWGK9JMx9Vm58ZVC0/zo0o12BxOItlzJ1ETzsPcPHwClAB/hOa8qJCg=
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr17804481ejb.470.1607334691230;
 Mon, 07 Dec 2020 01:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20201205231449.610980-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20201205231449.610980-1-alexandre.belloni@bootlin.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Dec 2020 10:51:20 +0100
Message-ID: <CAMpxmJVd7NrCQMq99iGLj7BsKooK0B5qNz3iEE=sPri90zdEAw@mail.gmail.com>
Subject: Re: [PATCH] rtc: fix RTC removal
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 6, 2020 at 12:14 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Since the rtc_register_device, removing an RTC device will end with a
> refcount_t: underflow; use-after-free warning since put_device is called
> twice in the device tear down path.
>
> Fixes: fdcfd854333b ("rtc: rework rtc_register_device() resource management")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/class.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index e6b44b7c4ad3..5c6748dfa55d 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -335,7 +335,6 @@ static void devm_rtc_unregister_device(void *data)
>         cdev_device_del(&rtc->char_dev, &rtc->dev);
>         rtc->ops = NULL;
>         mutex_unlock(&rtc->ops_lock);
> -       put_device(&rtc->dev);
>  }
>
>  static void devm_rtc_release_device(void *res)
> --
> 2.28.0
>

Eek! Thanks for fixing that.

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
