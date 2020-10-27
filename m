Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0993F29A5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507969AbgJ0HnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:43:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49165 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgJ0HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:43:01 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kXJdC-000240-Rk
        for linux-kernel@vger.kernel.org; Tue, 27 Oct 2020 07:42:59 +0000
Received: by mail-pl1-f200.google.com with SMTP id w16so441569ply.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vjBTmlur4S+6L78WlNF3x++nFUbCLvDVi46xZz3zYpE=;
        b=b8wgA9bJlmerlS1LZn9LT8wHn29lcow9bYGHUNLalhH1VbSWIt2tjJ+BD4sjmbyOd8
         21DXqXa/lIuY1/bsE/Ay2xK6iXbqcSxUAIkzHpS82p2C7+gU9jk+Y9t5aaRhnN6G6F1u
         3X3Y2NBjLefNDtwHzgAJQySPns88VVqOEYkplaTP9bOn/sovM55f8V5aSLdDxXcpN4WF
         PEsnRsD5nywltRyzRJRFtObm3C90zw1DcXTsW9qzPxrZB4QTK9v8zTP3ZjBkY6tmawF4
         L7gqjzRI+dcAd6VSA0u/SsH/7D04AmqhaOvFGsYkQgnuC/X+P3BleuxcS7dJ2vbDjsfZ
         U6tA==
X-Gm-Message-State: AOAM532WMruWA/ppOrHZ/F23Y3H0h6mPlpFdL8gyRfAMU6aQlkeTXwTU
        J0CQMJLwI4uu2P35Cze+LMj+e4RyAZ73lY686SdxzaxJI6I9kiqWCJdljhJ7NT5xgv+9xNgkTuF
        HrCQpVHv9Fa8/qxVHetInBgyPgH6KR/wxHwqi/hUbcQ==
X-Received: by 2002:a65:508a:: with SMTP id r10mr842463pgp.307.1603784576584;
        Tue, 27 Oct 2020 00:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpWh5uvxiSN6j6mhUOK56nhuZlhIjzT3g50otq4ptMM3LFXs8p+I7SF+v5vqGOHjNuYzcwIw==
X-Received: by 2002:a65:508a:: with SMTP id r10mr842439pgp.307.1603784576242;
        Tue, 27 Oct 2020 00:42:56 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id s131sm998111pgc.18.2020.10.27.00.42.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 00:42:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 2/4] ALSA: hda: Stop mangling PCI IRQ
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hmu082k8s.wl-tiwai@suse.de>
Date:   Tue, 27 Oct 2020 15:42:52 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Hui Wang <hui.wang@canonical.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5A5FF9D8-25B6-4AE0-B7A0-449BB6E40D98@canonical.com>
References: <20201027054001.1800-1-kai.heng.feng@canonical.com>
 <20201027054001.1800-3-kai.heng.feng@canonical.com>
 <s5hmu082k8s.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 27, 2020, at 15:36, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 27 Oct 2020 06:39:59 +0100,
> Kai-Heng Feng wrote:
>> 
>> The code predates 2005, it should be unnecessary now as PCI core handles
>> IRQ much better nowadays.
>> 
>> So stop PCI IRQ mangling in suspend/resume callbacks.
>> 
>> Takashi Iwai mentioned that IRQ number can change after S3 on some
>> really old hardwares. We should use quirks to handle those platforms, as
>> most modern systems won't have that issue.
> 
> I believe it was S4.  And this pretty much depends on BIOS, hence it's
> hard to apply the quirk, honestly speaking.

Ok, S4 is indeed hard to handle.

> 
> And, if we know that we need a quirk, dropping the code completely now
> is a bad move.  If any, this should be applied conditionally to the
> "known to be modern" platforms, but this will make the code rather
> messier, OTOH.
> 
> Do we need this change inevitably?  Otherwise I'd skip this one.

Ok, please drop this one.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
> 
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Wording.
>> - Add info on IRQ # can change on old hardwares.
>> 
>> sound/pci/hda/hda_intel.c | 15 ---------------
>> 1 file changed, 15 deletions(-)
>> 
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 749b88090970..b4aa1dcf1aae 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1022,13 +1022,11 @@ static int azx_suspend(struct device *dev)
>> {
>> 	struct snd_card *card = dev_get_drvdata(dev);
>> 	struct azx *chip;
>> -	struct hdac_bus *bus;
>> 
>> 	if (!azx_is_pm_ready(card))
>> 		return 0;
>> 
>> 	chip = card->private_data;
>> -	bus = azx_bus(chip);
>> 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
>> 	/* An ugly workaround: direct call of __azx_runtime_suspend() and
>> 	 * __azx_runtime_resume() for old Intel platforms that suffer from
>> @@ -1038,14 +1036,6 @@ static int azx_suspend(struct device *dev)
>> 		__azx_runtime_suspend(chip);
>> 	else
>> 		pm_runtime_force_suspend(dev);
>> -	if (bus->irq >= 0) {
>> -		free_irq(bus->irq, chip);
>> -		bus->irq = -1;
>> -		chip->card->sync_irq = -1;
>> -	}
>> -
>> -	if (chip->msi)
>> -		pci_disable_msi(chip->pci);
>> 
>> 	trace_azx_suspend(chip);
>> 	return 0;
>> @@ -1060,11 +1050,6 @@ static int azx_resume(struct device *dev)
>> 		return 0;
>> 
>> 	chip = card->private_data;
>> -	if (chip->msi)
>> -		if (pci_enable_msi(chip->pci) < 0)
>> -			chip->msi = 0;
>> -	if (azx_acquire_irq(chip, 1) < 0)
>> -		return -EIO;
>> 
>> 	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
>> 		__azx_runtime_resume(chip, false);
>> -- 
>> 2.17.1
>> 

