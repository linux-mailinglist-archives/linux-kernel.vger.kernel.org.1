Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B12F49C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbhAMLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbhAMLMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:12:25 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9B622286;
        Wed, 13 Jan 2021 11:11:44 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kze3x-007EVt-Lk; Wed, 13 Jan 2021 11:11:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jan 2021 11:11:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
In-Reply-To: <X/dpkgTnUk+inKHK@kroah.com>
References: <20201218031703.3053753-1-saravanak@google.com>
 <X/dpkgTnUk+inKHK@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e28e1f38d87c12a3c714a6573beba6e1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, saravanak@google.com, rafael@kernel.org, kernel-team@android.com, linux-kernel@vger.kernel.org, Jisheng.Zhang@synaptics.com, khilman@baylibre.com, john.stultz@linaro.org, nsaenzjulienne@suse.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-07 20:05, Greg Kroah-Hartman wrote:
> On Thu, Dec 17, 2020 at 07:16:58PM -0800, Saravana Kannan wrote:
>> As discussed in LPC 2020, cyclic dependencies in firmware that 
>> couldn't
>> be broken using logic was one of the last remaining reasons
>> fw_devlink=on couldn't be set by default.
>> 
>> This series changes fw_devlink so that when a cyclic dependency is 
>> found
>> in firmware, the links between those devices fallback to permissive 
>> mode
>> behavior. This way, the rest of the system still benefits from
>> fw_devlink, but the ambiguous cases fallback to permissive mode.
>> 
>> Setting fw_devlink=on by default brings a bunch of benefits 
>> (currently,
>> only for systems with device tree firmware):
>> * Significantly cuts down deferred probes.
>> * Device probe is effectively attempted in graph order.
>> * Makes it much easier to load drivers as modules without having to
>>   worry about functional dependencies between modules (depmod is still
>>   needed for symbol dependencies).
>> 
>> Greg/Rafael,
>> 
>> Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
>> see some issues due to device drivers that aren't following best
>> practices (they don't expose the device to driver core). Want to
>> identify those early on and try to have them fixed before 5.11 
>> release.
>> See [1] for an example of such a case.
> 
> Now queued up in my tree, will show up in linux-next in a few days,
> let's see what breaks!  :)
> 
> And it is scheduled for 5.12-rc1, not 5.11, sorry.

For the record, this breaks my rk3399 board, (NanoPC-T4) as no mass
storage can be discovered (it lives on PCIe):

(initramfs) find /sys -name 'waiting_for_supplier'| xargs grep .| egrep 
-v ':0$'
/sys/devices/platform/ff3d0000.i2c/i2c-4/4-0022/waiting_for_supplier:1
/sys/devices/platform/f8000000.pcie/waiting_for_supplier:1
/sys/devices/platform/fe320000.mmc/waiting_for_supplier:1
/sys/devices/platform/sdio-pwrseq/waiting_for_supplier:1
/sys/devices/platform/ff3c0000.i2c/i2c-0/0-001b/waiting_for_supplier:1

Enabling the debug prints in device_links_check_suppliers(), I end up 
with
the dump below (apologies for the size).

This seems to all hang on the GPIO banks, but it is pretty unclear what
is wrong with them.

Happy to test things further.

         M.

  platform vcc3v3-sys: probe deferral - supplier vcc12v0-sys not ready
  platform vcc5v0-sys: probe deferral - supplier vcc12v0-sys not ready
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcc3v0-sd: probe deferral - supplier vcc3v3-sys not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vbus-typec: probe deferral - supplier vcc5v0-sys not ready
  platform vcc5v0-host0: probe deferral - supplier vcc5v0-sys not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform fe320000.mmc: probe deferral - wait for supplier pmic@1b
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform fe320000.mmc: probe deferral - wait for supplier pmic@1b
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform fe380000.usb: probe deferral - supplier 
ff770000.syscon:usb2-phy@e450 not ready
  platform fe3c0000.usb: probe deferral - supplier 
ff770000.syscon:usb2-phy@e460 not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  platform fe3a0000.usb: probe deferral - supplier 
ff770000.syscon:usb2-phy@e450 not ready
  platform fe3e0000.usb: probe deferral - supplier 
ff770000.syscon:usb2-phy@e460 not ready
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
  platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
  platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
  platform f8000000.pcie: probe deferral - wait for supplier 
gpio2@ff780000
  i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
  platform fe320000.mmc: probe deferral - wait for supplier 
gpio0@ff720000
  platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
  platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000

-- 
Jazz is not dead. It just smells funny...
