Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF982C95C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgLAD1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgLAD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606793171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvfW+fviF6jxkM+6v1ZjUq0xrU6vbi09UMUegRZAFnI=;
        b=GRLDm65kRyxP7zolg058TRlgC2j7bPXk4F5fTehRMjMw0B51za0wRfQJ5okCh7ah6vDVnm
        3AzpvcDDr01sErwUpipQ4VOEPwPyzd8+ep80nkmV1tGQ0zbJ/tZR+8Lk2qDho4b1Kgf6oK
        KlOLFyfqEbYDUA81uxkPlRYoX1qSy8s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-iX5hbIUuOEmFR27gQlCpMA-1; Mon, 30 Nov 2020 22:26:09 -0500
X-MC-Unique: iX5hbIUuOEmFR27gQlCpMA-1
Received: by mail-qt1-f199.google.com with SMTP id a22so162836qtx.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 19:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=jvfW+fviF6jxkM+6v1ZjUq0xrU6vbi09UMUegRZAFnI=;
        b=C9RvW7mfjldfpJJujnIwOfFrMWEafI4RRKJfDSD1ikF7LIOFqhZOyvL5gAtvpjWcWi
         g+7/o6p0KQ4q668cNXO49Nkbcb+9agYBwyU93II33IHjo5yv2ua7v7NGD1nvKhsbM81f
         bQMfIqPItB5qtLecqwsJFoSbWK+xvgXLg9vMA4ZkAx8B108+PdzxtQfVsYvss4KWgE56
         XqUhQMc8glejOi+1hbSeKv35NgKUzojI8cN0Ju56gqLgUXQ3HK/wTiV1dWRvBhC4XFHI
         ufP1o84yQkN99G4/6WzvEll1MuOGEHbbaGZ5CYRDNpxmBQ1NOpG3uMq4mWsw4/uKoiFi
         64Rw==
X-Gm-Message-State: AOAM530fGXBZ7lAMvVsyN+vLcIwFl1jzGMp7F9xNT4tIegyCzhk4sG89
        uDAbpEiulrOzqWawL4CL8HjnsSO4YybRQ09G6w1i9xh+kWdRyhSkngrlGROE05XttYPJsPImzt0
        BQc7Cy4B9SFVNeEQ+XIr9pNjSWuGR5upHEf0tKUzjB63xSHv7MiP2ZAWLJrmVem1wlIvm+TcVdU
        Po
X-Received: by 2002:a05:620a:688:: with SMTP id f8mr873073qkh.151.1606793168747;
        Mon, 30 Nov 2020 19:26:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVl6T2zjtcb0sb1286WE6fgYQ8dN4yhblpupqsRiLzncAkKZC2zQkAcGL2elX+LJCtwZKPng==
X-Received: by 2002:a05:620a:688:: with SMTP id f8mr873049qkh.151.1606793168480;
        Mon, 30 Nov 2020 19:26:08 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j63sm525165qke.67.2020.11.30.19.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 19:26:07 -0800 (PST)
References: <20201130232338.106892-1-jsnitsel@redhat.com>
 <20201201025807.162241-1-jsnitsel@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm detected
In-reply-to: <20201201025807.162241-1-jsnitsel@redhat.com>
Date:   Mon, 30 Nov 2020 20:26:06 -0700
Message-ID: <87czzujjg1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jerry Snitselaar @ 2020-11-30 19:58 MST:

> When enabling the interrupt code for the tpm_tis driver we have
> noticed some systems have a bios issue causing an interrupt storm to
> occur. The issue isn't limited to a single tpm or system manufacturer
> so keeping a denylist of systems with the issue isn't optimal. Instead
> try to detect the problem occurring, disable interrupts, and revert to
> polling when it happens.
>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> v2: drop tpm_tis specific workqueue and use just system_wq
>
> drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 23b60583928b..72cc8a5a152c 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -24,6 +24,8 @@
>  #include <linux/wait.h>
>  #include <linux/acpi.h>
>  #include <linux/freezer.h>
> +#include <linux/workqueue.h>
> +#include <linux/kernel_stat.h>
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> @@ -745,9 +747,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  {
>  	struct tpm_chip *chip = dev_id;
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	static bool check_storm = true;
> +	static unsigned int check_start;
>  	u32 interrupt;
>  	int i, rc;
>  
> +	if (unlikely(check_storm)) {
> +		if (!check_start) {
> +			check_start = jiffies_to_msecs(jiffies);
> +		} else if ((kstat_irqs(priv->irq) > 1000) &&
> +			   (jiffies_to_msecs(jiffies) - check_start < 500)) {
> +			check_storm = false;
> +			schedule_work(&priv->storm_work);
> +		} else if (jiffies_to_msecs(jiffies) - check_start >= 500) {
> +			check_storm = false;
> +		}
> +	}
> +
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>  	if (rc < 0)
>  		return IRQ_NONE;
> @@ -987,6 +1003,14 @@ static const struct tpm_class_ops tpm_tis = {
>  	.clk_enable = tpm_tis_clkrun_enable,
>  };
>  
> +static void tpm_tis_storm_work(struct work_struct *work)
> +{
> +	struct tpm_tis_data *priv = container_of(work, struct tpm_tis_data, storm_work);
> +
> +	disable_interrupts(priv->chip);
> +	dev_warn(&priv->chip->dev, "Interrupt storm detected, using polling.\n");
> +}
> +
>  int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		      const struct tpm_tis_phy_ops *phy_ops,
>  		      acpi_handle acpi_dev_handle)
> @@ -1003,6 +1027,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> +	priv->chip = chip;
> +	INIT_WORK(&priv->storm_work, tpm_tis_storm_work);
> +
>  #ifdef CONFIG_ACPI
>  	chip->acpi_dev_handle = acpi_dev_handle;
>  #endif
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index edeb5dc61c95..5630f294dc0c 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -95,6 +95,8 @@ struct tpm_tis_data {
>  	u16 clkrun_enabled;
>  	wait_queue_head_t int_queue;
>  	wait_queue_head_t read_queue;
> +	struct work_struct storm_work;
> +	struct tpm_chip *chip;
>  	const struct tpm_tis_phy_ops *phy_ops;
>  	unsigned short rng_quality;
>  };

I've tested this with the Intel platform that has an Infineon chip that
I found the other week. It works, but isn't the complete fix. With this
on top of James' patchset I sometimes see the message "Lost Interrupt
waiting for TPM stat", so I guess there needs to be a check in
wait_for_tpm_stat and request_locality to see if interrupts were
disabled when the wait_event_interruptible_timeout call times out.

