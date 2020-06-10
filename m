Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C221F531C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgFJL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFJL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:27:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE0C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:27:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so1967686lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvVT0Q6Hk8gXd3AYI+J/EIVEwNiVTODM/dshgyMDZU4=;
        b=eJlXWXK3K5XrtvFPG7WyT6EXN1A2QpNzdCQR8UdhjweohwHMPIAfLe5THR/v4OWxZW
         gT88jxdjvmN/se7OGh129REdPvN5JDnuhuc9sXKlF3NxbAZcJDuBD1S7in1wdtwjL0aw
         w7W/oyY4iyLgTrMqvZIdlx/ZjNOidsb7RfSP8uC2Rn3BecNlv6LX9NJvAA1W4iNR1ZQ/
         MN9OCNDZxfg+pIbfSoGZMI99CqN8dztkduCqXhFamv1W2ZmFK89Satd4uQJQOrHcCtZW
         t+E+oMcDt3s+2IlY3tTiRm8zrqi1Cz9ZBJL+jfDOLEp6KfO0V8e+hsLtBpysqWbqB74X
         gciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvVT0Q6Hk8gXd3AYI+J/EIVEwNiVTODM/dshgyMDZU4=;
        b=LIgBKlS2/fpCRywDAbvvXyQnRnUcNFX7CCDfGEMKWh3ljd04de8pxh0Nx+mABfhlPF
         jhZGFLZOBCkXECczHJAvgGwa/8pyxFWYvs08s+W+l3/6UmTPvpnftLROpljxfx3hexPU
         HYJdI7MBvvhRIUxS0JUAUiEQzxSdZoR/VnKd92+M73A0SIpuZUKpeOmOQJBUzPSg0UdH
         WsjndIo3YM2in/IeahFKNUvjCtj6RlHCbnNgeL5Ay7jOb03ELN5I1rgStnHyjb8MtlEK
         1HEN1y1X0nilypmPr2dcoV15uOxK3Wn6e5aT1GOaud40ul87keYvNSkDXf+C4kl4ntEz
         SmLQ==
X-Gm-Message-State: AOAM530cA6+GiC6fvlC/I1CJDjTN0g3/TXtwS+4Ey7Fb0mE8/9R8vpK3
        T1mhoAOsqA2NVEo8Vlg+NwIZpPTMfHYmUExq5hnYNA==
X-Google-Smtp-Source: ABdhPJwNdb4XRg+9MmMDiZBQ2MdKsAyMHvs0gAkzW5F+xrKheuex5CzAkMV3Bl/mxWe97JW6UDqlvoZNaQDjG2HnEf0=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr1425096ljo.338.1591788429960;
 Wed, 10 Jun 2020 04:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200608134300.76091-1-andriy.shevchenko@linux.intel.com> <20200608134300.76091-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200608134300.76091-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 13:26:59 +0200
Message-ID: <CACRpkdZD5VNxZzycwbFWrzpT1TxkkViBuzAp5P0KQOW4oWjpVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] gpio: dwapb: Read GPIO base from snps,gpio-base property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 3:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> For backward compatibility with some legacy devices, introduce
> a new property snps,gpio-base to read GPIO base. Don't advertise
> to discourage users from utilizing it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I usually have a very negative gut reaction to any attempts to hardcode
the heavily deprecated use of the gpio_base for the global GPIO
numberspace. The reason is clear from drivers/gpio/TODO I think.

I need a really good explanation why this is needed, the only reason
people have been pushing this in the past is "oh we are using the
sysfs and we don't wanna change the GPIO numbers in our scripts"
which I really want to push back on now that we have the chardev and
the libgpiod utils.

If this is needed for something driver internal, it should stay in a
driver-local
variable.

Yours,
Linus Walleij
