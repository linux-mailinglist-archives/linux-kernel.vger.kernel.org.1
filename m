Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D6B2F4A12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbhAML05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhAML04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:26:56 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B9C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:47 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id a6so422301vkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZjBC9IS3ALIShgw1ZhhoVFP1AZzmhy3hY6ZT3+U1ss=;
        b=V2uMbNbhNZst+H/TYGRgtysleA3JPsjdK4sECoBkAvVuDCXwiRjcheJf8Lo78ew8D6
         xWx8cZgq0zq0eOta627uTeJZX8LPBS3qJi/o20ewOXSGjsj9F8LoJNZCq24zU2hlmqwF
         /Ol2P4F/1CUI5h2bFH0AR+1sgecOluUjKHzktJZoN5Vr9s9Ece6rkMZ9RWQc+tF+kU/l
         CIco4YwTX37KwW8JHRmD73XnMq+zVVz0Iwp4wNZzdlJM8AMy1lI++03Bte0XB/gsm4Tv
         /AXoPZ+8UZK5gIRqY+2ZRU8JxOUzzHXs8gEYijpk9iZHZBK3b3ati00kaRBt9xPMv7+n
         kO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZjBC9IS3ALIShgw1ZhhoVFP1AZzmhy3hY6ZT3+U1ss=;
        b=G3DRyfT+OqGhsPVH1q75uhn90ymzJ47viZf5j5SUwpZe1YjcmLjmJZCNNa8Pl/3BmF
         /t+pofJgRwq8mzW2cBxX8O6VWzmD9beW3eMFrAsplbZWQ+kjC9fa27qTeWvQmMREFkNG
         uni7rWWbvVP5e6DV76meJMz0i+4ohLSXXlPa8OoTL0XYqxu+LrHLE/PEef/ri6+vWP5h
         swTwy903mqLQf7zTRInPH6pjcepAa9mH5sV0+IAoQsiGUHhMqrnMPDqp6zWX+ccfwv09
         kZnSatAm2tGUqwL+S5gr4O2xNWoL7WvXIDHnZArd75qH8boqdrTxTNzGbG/adF/EFW9/
         XTAA==
X-Gm-Message-State: AOAM532W7nvSemLA7jnVxAfLstE2RxgpEZU7xVsw0Cc4wvrUXDoX2ZNm
        30guzdQZPzEnvs666/sFVSVmAMMEJx5qiJi3eWhvKQ==
X-Google-Smtp-Source: ABdhPJxE0pjNPFnk6j4rT66SlZyUcOMUI+HVkflRZ3WAqPhd0uZgXyN8uFdovzRTWPocXRoEK+SywdQ3L6hunKqmNUk=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr1477335vka.7.1610537146860;
 Wed, 13 Jan 2021 03:25:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608714110.git.hns@goldelico.com> <b6f2168b863e4273c6bca5a22fbd4a3a8ddf68d6.1608714110.git.hns@goldelico.com>
In-Reply-To: <b6f2168b863e4273c6bca5a22fbd4a3a8ddf68d6.1608714110.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:10 +0100
Message-ID: <CAPDyKFpe5v=05rgUAjC7vSyE-GJjbS_Yvk+65G067Y7dR=XcVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: omap: remove unused struct component card_detect_irq
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 at 10:05, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> I have not found any user for this struct component.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/platform_data/mmc-omap.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
> index f0b8947e6b07d8..91051e9907f34e 100644
> --- a/include/linux/platform_data/mmc-omap.h
> +++ b/include/linux/platform_data/mmc-omap.h
> @@ -108,8 +108,7 @@ struct omap_mmc_platform_data {
>                 const char *name;
>                 u32 ocr_mask;
>
> -               /* Card detection IRQs */
> -               int card_detect_irq;
> +               /* Card detection */
>                 int (*card_detect)(struct device *dev, int slot);
>
>                 unsigned int ban_openended:1;
> --
> 2.26.2
>
