Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4B2B9543
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgKSOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728375AbgKSOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605796962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXJi6DRS1g5967aleSjY/K3Znu8fKKEqU1paO32EoLU=;
        b=WYf47WctkpALQz4XopWqrXdrlbkcnxm2yxGmsKPQBwWj4+85zYEwj0JkkfjPcqV9+tDKOq
        l7g2rhtc2dvCQTuduPKsaAPvb0w2TWUKShFtHKIJB+6ORZSWvig+gVjf8h+3ogHt0Fy6z6
        kGOezYzvTFDEACQ24NhNBkY75dqUgPY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-3IW04n1oOgm5K-C3Z26wIg-1; Thu, 19 Nov 2020 09:42:39 -0500
X-MC-Unique: 3IW04n1oOgm5K-C3Z26wIg-1
Received: by mail-ej1-f70.google.com with SMTP id k2so466133eji.21
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXJi6DRS1g5967aleSjY/K3Znu8fKKEqU1paO32EoLU=;
        b=hqp7M035wnV4DkHMysgYM+lG6ebWG6LI77Lh9il/b3UNuPIDGdjqtxNpfnG8BCqXLa
         dJyUIxh+A/hmKU9FMk8C2k+msnQhqGfgTJ2zd9GaM05pUhQ0//RUpNVFb0jMPD1OGWon
         35RGwt17c+ROwMYynFVkX6xPLqfTtblGuWSio+33gKz2Vp6R1OEFMLUUE79MbxBs7kpC
         ieEqYa0RTWVYuy2jqCOevOCYWD97t5CTRPvlSvvMr3RefGXPRdB/wYyqp2YbLPqGsSXO
         NxNNDg+Kx9mT+pi4pv1poCFhdMe4I/Uf8a5Z0WZyV8Ltp9bIAYIz1wK/pHcdnd+F1EVq
         Y+pA==
X-Gm-Message-State: AOAM5338Kz26FTHrgdevLYKswxxh/INVSNhcAgwIhjOAQmCK/Y+Ofg0H
        HcKTTmVQztzOLaVCDuVHTSlP7WjaUc1EP7VprSBRAwX8YbqA4wUxCriYfdOpsMUKggU5eSCoQBG
        S1UfduhZ2qTbK/1y892BC7maT
X-Received: by 2002:aa7:d711:: with SMTP id t17mr31129233edq.83.1605796957724;
        Thu, 19 Nov 2020 06:42:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkCEJ3v69NoINUNh5mGrvZkw5er0zsBVVCKGbtBGCkBcPLGWhFIYNhH3lXuxr7oJN9nLU4wA==
X-Received: by 2002:aa7:d711:: with SMTP id t17mr31129214edq.83.1605796957449;
        Thu, 19 Nov 2020 06:42:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id n22sm1278563edo.43.2020.11.19.06.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 06:42:36 -0800 (PST)
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <77498b10-cf2c-690b-8dad-78cbd61712ba@redhat.com>
Date:   Thu, 19 Nov 2020 15:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87d009c0pn.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/19/20 7:36 AM, Jerry Snitselaar wrote:
> 
> Matthew Garrett @ 2020-10-15 15:39 MST:
> 
>> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>>
>>> There is a misconfiguration in the bios of the gpio pin used for the
>>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>>> driver code this results in an interrupt storm. This was initially
>>> reported when we attempted to enable the interrupt code in the tpm_tis
>>> driver, which previously wasn't setting a flag to enable it. Due to
>>> the reports of the interrupt storm that code was reverted and we went back
>>> to polling instead of using interrupts. Now that we know the T490s problem
>>> is a firmware issue, add code to check if the system is a T490s and
>>> disable interrupts if that is the case. This will allow us to enable
>>> interrupts for everyone else. If the user has a fixed bios they can
>>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>>> kernel command line.
>>
>> I think an implication of this is that systems haven't been
>> well-tested with interrupts enabled. In general when we've found a
>> firmware issue in one place it ends up happening elsewhere as well, so
>> it wouldn't surprise me if there are other machines that will also be
>> unhappy with interrupts enabled. Would it be possible to automatically
>> detect this case (eg, if we get more than a certain number of
>> interrupts in a certain timeframe immediately after enabling the
>> interrupt) and automatically fall back to polling in that case? It
>> would also mean that users with fixed firmware wouldn't need to pass a
>> parameter.
> 
> I believe Matthew is correct here. I found another system today
> with completely different vendor for both the system and the tpm chip.
> In addition another Lenovo model, the L490, has the issue.
> 
> This initial attempt at a solution like Matthew suggested works on
> the system I found today, but I imagine it is all sorts of wrong.
> In the 2 systems where I've seen it, there are about 100000 interrupts
> in around 1.5 seconds, and then the irq code shuts down the interrupt
> because they aren't being handled.

Is that with your patch? The IRQ should be silenced as soon as
devm_free_irq(chip->dev.parent, priv->irq, chip); is called.

Depending on if we can get your storm-detection to work or not,
we might also choose to just never try to use the IRQ (at least on
x86 systems). AFAIK the TPM is never used for high-throughput stuff
so the polling overhead should not be a big deal (and I'm getting the feeling
that Windows always polls).

Regards,

Hans



> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 49ae09ac604f..478e9d02a3fa 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -27,6 +27,11 @@
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
> 
> +static unsigned int time_start = 0;
> +static bool storm_check = true;
> +static bool storm_killed = false;
> +static u32 irqs_fired = 0;
> +
>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
> 
>  static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
> @@ -464,25 +469,31 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>         return rc;
>  }
> 
> -static void disable_interrupts(struct tpm_chip *chip)
> +static void __disable_interrupts(struct tpm_chip *chip)
>  {
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>         u32 intmask;
>         int rc;
> 
> -       if (priv->irq == 0)
> -               return;
> -
>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>         if (rc < 0)
>                 intmask = 0;
> 
>         intmask &= ~TPM_GLOBAL_INT_ENABLE;
>         rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +}
> +
> +static void disable_interrupts(struct tpm_chip *chip)
> +{
> +       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> 
> +       if (priv->irq == 0)
> +               return;
> +
> +       __disable_interrupts(chip);
>         devm_free_irq(chip->dev.parent, priv->irq, chip);
>         priv->irq = 0;
> -       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>  }
> 
>  /*
> @@ -528,6 +539,12 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>         int rc, irq;
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> 
> +       if (unlikely(storm_killed)) {
> +               devm_free_irq(chip->dev.parent, priv->irq, chip);
> +               priv->irq = 0;
> +               storm_killed = false;
> +       }
> +
>         if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>                 return tpm_tis_send_main(chip, buf, len);
> 
> @@ -748,6 +765,21 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>         u32 interrupt;
>         int i, rc;
> 
> +       if (storm_check) {
> +               irqs_fired++;
> +
> +               if (!time_start) {
> +                       time_start = jiffies_to_msecs(jiffies);
> +               } else if ((irqs_fired > 1000) && (jiffies_to_msecs(jiffies) - jiffies < 500)) {
> +                       __disable_interrupts(chip);
> +                       storm_check = false;
> +                       storm_killed = true;
> +                       return IRQ_HANDLED;
> +               } else if ((jiffies_to_msecs(jiffies) - time_start > 500) && (irqs_fired < 1000)) {
> +                       storm_check = false;
> +               }
> +       }
> +
>         rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>         if (rc < 0)
>                 return IRQ_NONE;
> 

