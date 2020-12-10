Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8132C2D52C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgLJEZC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Dec 2020 23:25:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47714 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgLJEYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:24:45 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1knDUn-0007CR-SZ
        for linux-kernel@vger.kernel.org; Thu, 10 Dec 2020 04:24:02 +0000
Received: by mail-pl1-f199.google.com with SMTP id 4so2278952pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 20:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xxeClgeGs/2JEP816OvChR5X9c6DTeVLIbpKuxRYfqc=;
        b=oG8qUhFqDt9MoJJ1uQrBo3bUyiVuw8nnABkQto8pAEX9qOdbLKh6P1MtW8TEAo5NsY
         jQgmBL6UWpdFYlyK+L2rzPtZKUAj8hV702rK0VTdKpNOXkzA3W2L/35g6CzXhSFj3Yxd
         +YPrmR2PNPtx2WksKrzViB9qmQyx+L+2/UnW08s1oxC0OzSN2uHGDt7xxQDAY4FjhnBz
         0dC56nPOZRAuDECWkvqwGURUXS9Sn5G7Pt757CBgMF9nTelJhfGWo8idWQSJ5yB8HxJg
         H49sVBXmMozoo3gAkRiPQeDzRC0KL2kyAUBFTOXRhuBKJQamRbQd/d52mRRG9PagHQTh
         xs6w==
X-Gm-Message-State: AOAM533Xu3+sb+ehK4UONlby1lHYyiOrnKtujlBQCSrHIsTSubUlAdbl
        zSfj1FgHHudeto0yp4uoStkFMqwPejDrySTGqy0EBv/+z0ogvs6P7uaM8zOhVQHTwEnFHrx0C16
        46wCl9mvbF7cBTf/0w+ooW+63FXO+/GCZXHA4/fzpCg==
X-Received: by 2002:a65:5903:: with SMTP id f3mr4890616pgu.109.1607574240515;
        Wed, 09 Dec 2020 20:24:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXta5IJs4wtS8oGMf0kmnlZfW1VYiba7OOrImVrUL6boZiYFq/Fgq/FopECC48jx9zlbQ6OQ==
X-Received: by 2002:a65:5903:: with SMTP id f3mr4890603pgu.109.1607574240088;
        Wed, 09 Dec 2020 20:24:00 -0800 (PST)
Received: from [192.168.1.104] (36-229-231-79.dynamic-ip.hinet.net. [36.229.231.79])
        by smtp.gmail.com with ESMTPSA id s7sm4565702pfh.207.2020.12.09.20.23.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 20:23:59 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [Regression] Can only do S3 once after "tpm: take TPM chip power
 gating out of tpm_transmit()"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201208101746.GA45313@kernel.org>
Date:   Thu, 10 Dec 2020 12:23:57 +0800
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C9737DC9-6484-4497-83F4-494DBFD90D9C@canonical.com>
References: <7E60C7F0-85C6-4A9A-B905-904D37A5E67B@canonical.com>
 <20201208101746.GA45313@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 8, 2020, at 18:17, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> On Mon, Dec 07, 2020 at 12:42:53PM +0800, Kai-Heng Feng wrote:
>> Hi Jarkko,
>> 
>> A user report that the system can only do S3 once. Subsequent S3 fails after commit a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()").
>> 
>> Dmesg with the issue, collected under 5.10-rc2:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/14
>> 
>> Dmesg without the issue, collected under 5.0.0-rc8:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/16
>> 
>> Full bug report here:
>> https://bugs.launchpad.net/bugs/1891502
>> 
>> Kai-Heng
> 
> Relevant part:
> 
> 
> [80601.620149] tpm tpm0: Error (28) sending savestate before suspend
> [80601.620165] PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x90 returns 28
> [80601.620172] PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 28
> [80601.620178] PM: Device 00:01 failed to suspend: error 28
> 
> Looking at this there are two issues:
> 
> A. TPM_ORD_SAVESTATE command failing, this a new regression.
> B. When tpm_pm_suspend() fails, it should not fail the whole suspend
>   procedure. And it returns the TPM error code back to the upper
>   layers when it does so, which makes no sense. This is an old
>   issue revealed by A.
> 
> Let's look at tpm_pm_suspend():
> 
> /*
> * We are about to suspend. Save the TPM state
> * so that it can be restored.
> */
> int tpm_pm_suspend(struct device *dev)
> {
> 	struct tpm_chip *chip = dev_get_drvdata(dev);
> 	int rc = 0;
> 
> 	if (!chip)
> 		return -ENODEV;
> 
> 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> 		goto suspended;
> 
> 	if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
> 	    !pm_suspend_via_firmware())
> 		goto suspended;
> 
> 	if (!tpm_chip_start(chip)) {
> 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 			tpm2_shutdown(chip, TPM2_SU_STATE);
> 		else
> 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> 
> 		tpm_chip_stop(chip);
> 	}
> 
> suspended:
> 	return rc;
> }
> EXPORT_SYMBOL_GPL(tpm_pm_suspend);
> 
> I would modify this into:
> 
> /*
> * We are about to suspend. Save the TPM state
> * so that it can be restored.
> */
> int tpm_pm_suspend(struct device *dev)
> {
> 	struct tpm_chip *chip = dev_get_drvdata(dev);
> 	int rc = 0;
> 
> 	if (!chip)
> 		return -ENODEV;
> 
> 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> 		goto suspended;
> 
> 	if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
> 	    !pm_suspend_via_firmware())
> 		goto suspended;
> 
> 	if (!tpm_chip_start(chip)) {
> 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 			tpm2_shutdown(chip, TPM2_SU_STATE);
> 		else
> 			tpm1_pm_suspend(chip, tpm_suspend_pcr);
> 
> 		tpm_chip_stop(chip);
> 	}
> 
> suspended:
> 	return rc;
> }
> EXPORT_SYMBOL_GPL(tpm_pm_suspend);
> 
> I.e. it's a good idea to put something into klog but that should not
> fail the whole suspend procedure. TPM is essentially opt-in feature.
> 
> Of course issue A needs to be also sorted out but would this work as
> a quick initial fix? I can queue a patch for this. Is it possible to
> try out this fix for if I drop a patch?

Yes, possible test result from affected user.

I had to cut those code and do a diff side by side to find what changed.
Hopefully next time I can get one from `git diff`...

Kai-Heng

> 
> /Jarkko

