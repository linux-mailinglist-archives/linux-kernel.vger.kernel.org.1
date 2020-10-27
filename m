Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CC29ADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbgJ0NmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:42:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41532 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbgJ0NmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:42:22 -0400
Received: by mail-vk1-f193.google.com with SMTP id t67so363104vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIvGudOi7kPwId5o0/m4lZbj/CH7bqGmSDB8r0nOFw0=;
        b=rXyuGq7qrMc3UfdHaG0NoGRnZ463iXKCCb9Z1zeZou8ZCL9mRoOAEOoYRZKxv2iMz0
         JMk/jHah0Mi87BEvpK9WUXq7nADIw3a597Lk9By76iRbAn8dlPA0L8uL73vQmbyib+EM
         SrDkJqBO2pc+ZorsJrrXsKNRR0diVYZTPVsPwdxaj/skHIUjIj7eYGA/5j5k4FJBnQXz
         KVSPKM1SWNvStQUIRpgg4ikBD72nofFOOdYysrEb6wQv3OKMz5ocLqS/mWzRM/H51KrU
         pW1JT/sn6hUq0t2AMgfs6wRb6jU3syCQjnXP0F3IFkA7vSFba/+wmwa8ITNbBAFNs8OG
         kcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIvGudOi7kPwId5o0/m4lZbj/CH7bqGmSDB8r0nOFw0=;
        b=EK+7C+ft4T4+URFPKjrhCin3d7GHn7f9X+2hOMy5sGZSmrw4Q+qB3XiJ4+z97Q+lzP
         e/A+YNLquKa9Jgwr68r+kLlqkfl2HFgQ9iDIlLUGMlHCkBatLVx2QCX8eqxktuI2Q2ZK
         o3pG7eVKTI2y86BaEGF97uny9q5g1RFx9Y32HOOnNz+Cn8Sye7nMWJLG5wPvGgh+4y72
         i/wDaVJAdR77tGKCSdnV4K10PK4cMD/ep83Jdgy1v69fP/IWXRG7qbz56z/TuJLcOXzS
         pkbzRoELi9Amo8Ufi9zX4ZmSiIM6C4ZtHp6rLMbCR3r5soeXn8pqFMGSUWYOcAmShUks
         FSug==
X-Gm-Message-State: AOAM533e9xVf+yuYMCJ8e9kvLl9G18EpP7HevsDEdg5czC0BY/VqK3+U
        uZtrqAN9oVyCx/janUW9NEbY4J1sciKAy93Q8c6awg==
X-Google-Smtp-Source: ABdhPJwZIaM15qKzaR9vU9aLsZgRwoKkxtpzrUHOBDcbwnnrnc/JYmY94hyCz8n6Uo0fnwZPV4Pvs8AXAWyzUB1zmvM=
X-Received: by 2002:a1f:2ed2:: with SMTP id u201mr1413348vku.7.1603806140662;
 Tue, 27 Oct 2020 06:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201026153810.89512-1-krzk@kernel.org>
In-Reply-To: <20201026153810.89512-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:43 +0100
Message-ID: <CAPDyKFoHdmdeMqYLzR0sDz96ffvWBbkcicQtSeb1CV5THoxGjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: s3cmci: include GPIO descriptor consumer header
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 at 16:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver uses GPIO Descriptor Consumer Interface so include proper
> header to fix compile test errors like:
>
>     drivers/mmc/host/s3cmci.c: In function =E2=80=98s3cmci_check_sdio_irq=
=E2=80=99:
>     drivers/mmc/host/s3cmci.c:304:7: error:
>         implicit declaration of function =E2=80=98gpiod_get_value=E2=80=
=99; did you mean =E2=80=98gpio_get_value=E2=80=99? [-Werror=3Dimplicit-fun=
ction-declaration]
>
>     drivers/mmc/host/s3cmci.c: In function =E2=80=98s3cmci_probe_pdata=E2=
=80=99:
>     drivers/mmc/host/s3cmci.c:1451:19: error:
>         implicit declaration of function =E2=80=98devm_gpiod_get_index=E2=
=80=99 [-Werror=3Dimplicit-function-declaration]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 643d54eceef6..a33a7823c265 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -17,7 +17,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> --
> 2.25.1
>
