Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AEF2B8BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgKSGg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgKSGg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605767786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMc/gvKwqM4AzkZ+P2n75WcftR/IHFubAtNec01gIhI=;
        b=EHw+1sN2O8+cZm7aNpgOxl9dYpwIThVDKDwVzDeasCVGnmflRZcErgjAopiruR3F6lMgzq
        Wiqf6mb6u/ISL1xmMdJOzIsv3nxOxCUQi7Ha1qGfsmvhnPoyVFpF0o9TO1SISeEBvnIE9o
        GjyCsV3yLA7KQXw3HNmm/rJVLBPa6lM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-ET4HHYKsM9OvNQqw5FqTRQ-1; Thu, 19 Nov 2020 01:36:23 -0500
X-MC-Unique: ET4HHYKsM9OvNQqw5FqTRQ-1
Received: by mail-io1-f71.google.com with SMTP id z7so3917349iom.14
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=iMc/gvKwqM4AzkZ+P2n75WcftR/IHFubAtNec01gIhI=;
        b=f0pGGlS0+Tcr6HaFUkEj3JJTUc2F1xc6OJk+kM3JcopIP+VvG9aU53yIOoWpo50SYS
         4SwZ/vwztV/hr6I0/lRg3Xsvguvq90UtM3bvDVEy7070qT6CdOgE2kAyGM+Rp0NLX8Yv
         CX5pEPvOj/LRn+8O1bfXSjt9w17FY7ToINU9mVuKxOZx4LmrfMEw5lfD9CH/vbeB/nl1
         3cOVEcWfLICbivCWv80st3JMAV4Eds8KTMxE8S6bkRfhIZIooBmA+45HV+o8KHX1L7Vy
         4GTLcp2S4aXpws0Z+FY2yk7QDuzq5Bs2hKoD9Jd999Nld1lyLJ/hnHHnxoq7K4FwHiYU
         Ncnw==
X-Gm-Message-State: AOAM530BgwlYBrQtI7PnPQa4kamp95gdRhsxY+j7gd6C0oU/4Ui2qEfG
        OZhPXz9k9wwDCWWKZBfQ7xez+azn6z4Pj18DnV8cO9oe8nxXVHD3GG5uhtKrXFeoWTz3Uvu9tqb
        Nv+dmfrO3vwY3jgO4bvh92zS9
X-Received: by 2002:a92:dd91:: with SMTP id g17mr17780374iln.12.1605767783260;
        Wed, 18 Nov 2020 22:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUlv74DqDRPtC8qPdQ8fwEPR18nkvA8Itzpp4H34wf7FxcIXXI77Cz6yyypbD4U5uD+lQqLA==
X-Received: by 2002:a92:dd91:: with SMTP id g17mr17780357iln.12.1605767782910;
        Wed, 18 Nov 2020 22:36:22 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b4sm16931032ile.13.2020.11.18.22.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 22:36:22 -0800 (PST)
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
In-reply-to: <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
Date:   Wed, 18 Nov 2020 23:36:20 -0700
Message-ID: <87d009c0pn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Garrett @ 2020-10-15 15:39 MST:

> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>
>> There is a misconfiguration in the bios of the gpio pin used for the
>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>> driver code this results in an interrupt storm. This was initially
>> reported when we attempted to enable the interrupt code in the tpm_tis
>> driver, which previously wasn't setting a flag to enable it. Due to
>> the reports of the interrupt storm that code was reverted and we went back
>> to polling instead of using interrupts. Now that we know the T490s problem
>> is a firmware issue, add code to check if the system is a T490s and
>> disable interrupts if that is the case. This will allow us to enable
>> interrupts for everyone else. If the user has a fixed bios they can
>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>> kernel command line.
>
> I think an implication of this is that systems haven't been
> well-tested with interrupts enabled. In general when we've found a
> firmware issue in one place it ends up happening elsewhere as well, so
> it wouldn't surprise me if there are other machines that will also be
> unhappy with interrupts enabled. Would it be possible to automatically
> detect this case (eg, if we get more than a certain number of
> interrupts in a certain timeframe immediately after enabling the
> interrupt) and automatically fall back to polling in that case? It
> would also mean that users with fixed firmware wouldn't need to pass a
> parameter.

I believe Matthew is correct here. I found another system today
with completely different vendor for both the system and the tpm chip.
In addition another Lenovo model, the L490, has the issue.

This initial attempt at a solution like Matthew suggested works on
the system I found today, but I imagine it is all sorts of wrong.
In the 2 systems where I've seen it, there are about 100000 interrupts
in around 1.5 seconds, and then the irq code shuts down the interrupt
because they aren't being handled.


diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 49ae09ac604f..478e9d02a3fa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -27,6 +27,11 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"

+static unsigned int time_start = 0;
+static bool storm_check = true;
+static bool storm_killed = false;
+static u32 irqs_fired = 0;
+
 static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);

 static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
@@ -464,25 +469,31 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
        return rc;
 }

-static void disable_interrupts(struct tpm_chip *chip)
+static void __disable_interrupts(struct tpm_chip *chip)
 {
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
        u32 intmask;
        int rc;

-       if (priv->irq == 0)
-               return;
-
        rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
        if (rc < 0)
                intmask = 0;

        intmask &= ~TPM_GLOBAL_INT_ENABLE;
        rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
+}
+
+static void disable_interrupts(struct tpm_chip *chip)
+{
+       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

+       if (priv->irq == 0)
+               return;
+
+       __disable_interrupts(chip);
        devm_free_irq(chip->dev.parent, priv->irq, chip);
        priv->irq = 0;
-       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
 }

 /*
@@ -528,6 +539,12 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
        int rc, irq;
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

+       if (unlikely(storm_killed)) {
+               devm_free_irq(chip->dev.parent, priv->irq, chip);
+               priv->irq = 0;
+               storm_killed = false;
+       }
+
        if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
                return tpm_tis_send_main(chip, buf, len);

@@ -748,6 +765,21 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
        u32 interrupt;
        int i, rc;

+       if (storm_check) {
+               irqs_fired++;
+
+               if (!time_start) {
+                       time_start = jiffies_to_msecs(jiffies);
+               } else if ((irqs_fired > 1000) && (jiffies_to_msecs(jiffies) - jiffies < 500)) {
+                       __disable_interrupts(chip);
+                       storm_check = false;
+                       storm_killed = true;
+                       return IRQ_HANDLED;
+               } else if ((jiffies_to_msecs(jiffies) - time_start > 500) && (irqs_fired < 1000)) {
+                       storm_check = false;
+               }
+       }
+
        rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
        if (rc < 0)
                return IRQ_NONE;

