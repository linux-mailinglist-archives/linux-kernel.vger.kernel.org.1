Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FA2CCAD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgLCAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:04:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727474AbgLCAEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606953774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpSPL5S+eK2YN+IDF2O7p/fQBnAF7ZUdMUMMwgAm0bo=;
        b=SBAwabITp+rw95+nlCR01DZmWgxXGyueDOwBmX5RKqyzuSBlAEOHh9+sAnC0Cb6TWOJJit
        e8faiil49frBmJaCIjAqlMmWwOwOjHKSrwV/ke5TiDPG94GkwZEOP0PXqc2UspwEGVRmUH
        Ifs6qnHz7465pXFWW5LoH5mQT3za2sI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-JtkhXGD9NRiwHkSJ8dUo8Q-1; Wed, 02 Dec 2020 19:02:53 -0500
X-MC-Unique: JtkhXGD9NRiwHkSJ8dUo8Q-1
Received: by mail-qt1-f199.google.com with SMTP id v9so169199qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DpSPL5S+eK2YN+IDF2O7p/fQBnAF7ZUdMUMMwgAm0bo=;
        b=i23YU2bB7ORPts2Q971zjHSTgqbCUjeih75B6jla11mmWQXqH38tXs4JdCzACCICQ2
         KovnnrOd7gN21J2soolWMYe++VePifV2ZITHQSwSit5YMlYE6JvkFLdukueiBz1IuHz2
         eIh5hhOZbjSvqECbAkTWgwKfTaememFfahnuxiMv5eTowqXs/lZfPy6/Lowutni9wxCX
         J2YNLDEKTaUXIYyV7yO9SvS9bd2mIsA1K0jZuDqRK45A0YmChxLRjrlpORMjAALTVIy1
         dgXi5TEMmgkSAB5hax6gKbylzcsOPk1JdgxfN25qvryd9c8wj1eQbyX9hcjmqEI/uR/9
         rwuQ==
X-Gm-Message-State: AOAM531Fzcmuv4e5tXbvSrTRY44u/nVV70JyVEPep873aFkdvQKK6Zm5
        oEml+Fqc1BuQ6yE4xKVAijmnxjg0okcuUUvgTC4689bTyPwa1ikpLmwbIX3IwMdrxmVWOvyf9If
        IgX2M64+8NHf5jj1scAWoXnEs
X-Received: by 2002:a05:620a:4f4:: with SMTP id b20mr353504qkh.312.1606953773247;
        Wed, 02 Dec 2020 16:02:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLfJT6IrMLN763uYcNKj9ZBhKQLRG/d9niB/EMTLK/uFwQC/3Oz0r9LuONEm2GWjzQohoIBg==
X-Received: by 2002:a05:620a:4f4:: with SMTP id b20mr353484qkh.312.1606953773016;
        Wed, 02 Dec 2020 16:02:53 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id l66sm247224qkd.105.2020.12.02.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:02:52 -0800 (PST)
References: <20201130232338.106892-1-jsnitsel@redhat.com>
 <20201201025807.162241-1-jsnitsel@redhat.com> <87czzujjg1.fsf@redhat.com>
 <878sahmh5w.fsf@redhat.com> <20201202164931.GA91318@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm detected
In-reply-to: <20201202164931.GA91318@kernel.org>
Date:   Wed, 02 Dec 2020 17:02:50 -0700
Message-ID: <87sg8noixh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jarkko Sakkinen @ 2020-12-02 09:49 MST:

> On Tue, Dec 01, 2020 at 12:59:23PM -0700, Jerry Snitselaar wrote:
>> 
>> Jerry Snitselaar @ 2020-11-30 20:26 MST:
>> 
>> > Jerry Snitselaar @ 2020-11-30 19:58 MST:
>> >
>> >> When enabling the interrupt code for the tpm_tis driver we have
>> >> noticed some systems have a bios issue causing an interrupt storm to
>> >> occur. The issue isn't limited to a single tpm or system manufacturer
>> >> so keeping a denylist of systems with the issue isn't optimal. Instead
>> >> try to detect the problem occurring, disable interrupts, and revert to
>> >> polling when it happens.
>> >>
>> >> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> >> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> >> Cc: Peter Huewe <peterhuewe@gmx.de>
>> >> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>> >> Cc: Matthew Garrett <mjg59@google.com>
>> >> Cc: Hans de Goede <hdegoede@redhat.com>
>> >> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> >> ---
>> >> v2: drop tpm_tis specific workqueue and use just system_wq
>> >>
>> >> drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++++++++++
>> >>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>> >>  2 files changed, 29 insertions(+)
>> >>
>> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> >> index 23b60583928b..72cc8a5a152c 100644
>> >> --- a/drivers/char/tpm/tpm_tis_core.c
>> >> +++ b/drivers/char/tpm/tpm_tis_core.c
>> >> @@ -24,6 +24,8 @@
>> >>  #include <linux/wait.h>
>> >>  #include <linux/acpi.h>
>> >>  #include <linux/freezer.h>
>> >> +#include <linux/workqueue.h>
>> >> +#include <linux/kernel_stat.h>
>> >>  #include "tpm.h"
>> >>  #include "tpm_tis_core.h"
>> >>  
>> >> @@ -745,9 +747,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>> >>  {
>> >>  	struct tpm_chip *chip = dev_id;
>> >>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> >> +	static bool check_storm = true;
>> >> +	static unsigned int check_start;
>> >>  	u32 interrupt;
>> >>  	int i, rc;
>> >>  
>> >> +	if (unlikely(check_storm)) {
>> >> +		if (!check_start) {
>> >> +			check_start = jiffies_to_msecs(jiffies);
>> >> +		} else if ((kstat_irqs(priv->irq) > 1000) &&
>> >> +			   (jiffies_to_msecs(jiffies) - check_start < 500)) {
>> >> +			check_storm = false;
>> >> +			schedule_work(&priv->storm_work);
>> >> +		} else if (jiffies_to_msecs(jiffies) - check_start >= 500) {
>> >> +			check_storm = false;
>> >> +		}
>> >> +	}
>> >> +
>> >>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>> >>  	if (rc < 0)
>> >>  		return IRQ_NONE;
>> >> @@ -987,6 +1003,14 @@ static const struct tpm_class_ops tpm_tis = {
>> >>  	.clk_enable = tpm_tis_clkrun_enable,
>> >>  };
>> >>  
>> >> +static void tpm_tis_storm_work(struct work_struct *work)
>> >> +{
>> >> +	struct tpm_tis_data *priv = container_of(work, struct tpm_tis_data, storm_work);
>> >> +
>> >> +	disable_interrupts(priv->chip);
>> >> +	dev_warn(&priv->chip->dev, "Interrupt storm detected, using polling.\n");
>> >> +}
>> >> +
>> >>  int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>> >>  		      const struct tpm_tis_phy_ops *phy_ops,
>> >>  		      acpi_handle acpi_dev_handle)
>> >> @@ -1003,6 +1027,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>> >>  	if (IS_ERR(chip))
>> >>  		return PTR_ERR(chip);
>> >>  
>> >> +	priv->chip = chip;
>> >> +	INIT_WORK(&priv->storm_work, tpm_tis_storm_work);
>> >> +
>> >>  #ifdef CONFIG_ACPI
>> >>  	chip->acpi_dev_handle = acpi_dev_handle;
>> >>  #endif
>> >> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> >> index edeb5dc61c95..5630f294dc0c 100644
>> >> --- a/drivers/char/tpm/tpm_tis_core.h
>> >> +++ b/drivers/char/tpm/tpm_tis_core.h
>> >> @@ -95,6 +95,8 @@ struct tpm_tis_data {
>> >>  	u16 clkrun_enabled;
>> >>  	wait_queue_head_t int_queue;
>> >>  	wait_queue_head_t read_queue;
>> >> +	struct work_struct storm_work;
>> >> +	struct tpm_chip *chip;
>> >>  	const struct tpm_tis_phy_ops *phy_ops;
>> >>  	unsigned short rng_quality;
>> >>  };
>> >
>> > I've tested this with the Intel platform that has an Infineon chip that
>> > I found the other week. It works, but isn't the complete fix. With this
>> > on top of James' patchset I sometimes see the message "Lost Interrupt
>> > waiting for TPM stat", so I guess there needs to be a check in
>> > wait_for_tpm_stat and request_locality to see if interrupts were
>> > disabled when the wait_event_interruptible_timeout call times out.
>> 
>> As kernel test robot pointed out. kstat_irqs isn't visible when tpm_tis
>> builds as a module. It looks like it is only called by kstat_irq_usrs,
>> and that is only by the fs/proc code. I have a patch to export it, but
>> the i915 driver open codes their own version instead of using it. Is
>> there any reason not to export it?
>
> If you add a patch that exports it, then for coherency it'd be better to
> also patch i915 driver. Jani?
>
> /Jarkko

It looks like this might not solve all cases. I'm having Lenovo test
another build to make sure I gave them the right code, but they reported
with the L490 that the system hangs right when it is initializing
tpm_tis. I'm working on getting a build on the T490s I have to try there
as well. With the Intel system it spits out that it detects the
interrupt storm, and continues on its way.

