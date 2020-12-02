Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8252D2CBDD4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgLBNHL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 08:07:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgLBNHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:07:10 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kkRpz-00048h-ET
        for linux-kernel@vger.kernel.org; Wed, 02 Dec 2020 13:06:27 +0000
Received: by mail-pf1-f198.google.com with SMTP id e68so1210485pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 05:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GrUGOpTpSp2pqBXebtTh/akmaDHoTwi3ZKp6lCKMafw=;
        b=WsJ1yXhRWjkYbqtdp7eRos7weL/AkfT4tSEY8yhomInAFWMVdqiiRM8X1bTNgn1rEl
         9/GnE7TneewtDcLuZ2X3gGaV+kolUE1OplulEQGAwpQf5AfzY9zhEMqM0ccJgdTcnur8
         N6omkZ1RzGnWejZc/didGShTmFH8Lc2BmuRF9oQp7y9e18xYCrIRfsi/tWblxdJgQnPE
         qT5kJk87tdQp2Y5jtkj+8ALofKfoAKWh0TiR8U88KXPdCEL+8EOXg/Ng+eP0C4/b6+8p
         +CG7v6snRdALsTxcFE6vGyMqBAdL+tE7VbY0qya9vcQENE0Vt0XqYb8gUqJt0QrH7ziQ
         97Pw==
X-Gm-Message-State: AOAM531nLa8VXlgmieqCp2GlKG79avq/j7KIqQs/B2WAvS6AEH1jpCuW
        pkqWuRjDh0Otjz5WOrq0wPZKUl0sOKquNOknwf7cMlWowwvfP7hu59+aZY8778JGwCKvapNU9ZL
        18fHQy6d1s3YaZnE+gB2AQibvk9AHbiyuYS1G0zmEzg==
X-Received: by 2002:a65:5302:: with SMTP id m2mr2524334pgq.231.1606914385336;
        Wed, 02 Dec 2020 05:06:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhMGBtC/6GcEajV0sdiVtaR4pXRdCldIz7ymjMzJ/3J4tFYYxsodX9NzuDcueBTUHz4tK24g==
X-Received: by 2002:a65:5302:: with SMTP id m2mr2524290pgq.231.1606914384979;
        Wed, 02 Dec 2020 05:06:24 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b24sm2014203pjq.10.2020.12.02.05.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 05:06:24 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/2][v3] e1000e: Leverage direct_complete to speed up
 s2ram
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <b8896b7748e516e9c440ab22e582e30f1389776c.1606757180.git.yu.c.chen@intel.com>
Date:   Wed, 2 Dec 2020 21:06:19 +0800
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        "Neftin, Sasha" <sasha.neftin@intel.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DF79FD96-31E6-4D9A-BF0D-40B7FC563C0B@canonical.com>
References: <cover.1606757180.git.yu.c.chen@intel.com>
 <b8896b7748e516e9c440ab22e582e30f1389776c.1606757180.git.yu.c.chen@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

> On Dec 1, 2020, at 09:21, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> The NIC is put in runtime suspend status when there is no cable connected.
> As a result, it is safe to keep non-wakeup NIC in runtime suspended during
> s2ram because the system does not rely on the NIC plug event nor WoL to wake
> up the system. Besides that, unlike the s2idle, s2ram does not need to
> manipulate S0ix settings during suspend.
> 
> This patch introduces the .prepare() for e1000e so that if the NIC is runtime
> suspended the subsequent suspend/resume hooks will be skipped so as to speed
> up the s2ram. The pm core will check whether the NIC is a wake up device so
> there's no need to check it again in .prepare(). DPM_FLAG_SMART_PREPARE flag
> should be set during probe to ask the pci subsystem to honor the driver's
> prepare() result. Besides, the NIC remains runtime suspended after resumed
> from s2ram as there is no need to resume it.
> 
> Tested on i7-2600K with 82579V NIC
> Before the patch:
> e1000e 0000:00:19.0: pci_pm_suspend+0x0/0x160 returned 0 after 225146 usecs
> e1000e 0000:00:19.0: pci_pm_resume+0x0/0x90 returned 0 after 140588 usecs
> 
> After the patch:
> echo disabled > //sys/devices/pci0000\:00/0000\:00\:19.0/power/wakeup
> becomes 0 usecs because the hooks will be skipped.
> 
> Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Well, I was intended to send it, but anyway :)

> ---
> v2: Added test data and some commit log revise(Paul Menzel)
>    Only skip the suspend/resume if the NIC is not a wake up device specified
>    by the user(Kai-Heng Feng)
> v3: Leverage direct complete mechanism to skip all hooks(Kai-Heng Feng)
> ---
> drivers/net/ethernet/intel/e1000e/netdev.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b30f00891c03..b210bba3f20a 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -25,6 +25,7 @@
> #include <linux/pm_runtime.h>
> #include <linux/aer.h>
> #include <linux/prefetch.h>
> +#include <linux/suspend.h>
> 
> #include "e1000.h"
> 
> @@ -6957,6 +6958,12 @@ static int __e1000_resume(struct pci_dev *pdev)
> 	return 0;
> }
> 
> +static int e1000e_pm_prepare(struct device *dev)
> +{
> +	return pm_runtime_suspended(dev) &&
> +		pm_suspend_via_firmware();
> +}
> +
> static __maybe_unused int e1000e_pm_suspend(struct device *dev)
> {
> 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
> @@ -7665,7 +7672,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
> 	e1000_print_device_info(adapter);
> 
> -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);

This isn't required for pci_pm_prepare() to use driver's .prepare callback.

> 
> 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
> 		pm_runtime_put_noidle(&pdev->dev);
> @@ -7890,6 +7897,7 @@ MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
> 
> static const struct dev_pm_ops e1000_pm_ops = {
> #ifdef CONFIG_PM_SLEEP
> +	.prepare	= e1000e_pm_prepare,

How do we make sure a link change happened in S3 can be detect after resume, without a .complete callback which ask device to runtime resume?

Kai-Heng

> 	.suspend	= e1000e_pm_suspend,
> 	.resume		= e1000e_pm_resume,
> 	.freeze		= e1000e_pm_freeze,
> -- 
> 2.17.1
> 

