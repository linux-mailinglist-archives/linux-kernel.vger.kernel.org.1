Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F082F5470
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 22:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhAMVCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 16:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAMU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:58:53 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20395C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:57:04 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d14so4001850qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbqeiVwt2EXlzz5dyIHq4TsEikGp2nPn0lptTHpqnOk=;
        b=DsxbrMHMUXJrpKPwhmfnA5SGQp+cNvfZjRpmvqAZXck1ivmaMlNtEUIVYTRPoJySKj
         /+vp6Y1gNPB3FwS7/QxDSZB3MmfRgK0t/5yuSzxChEuA4swSWvmbTf/I+f59NMMIwl5g
         fS0jq2EQ/BpLXYVjCvymTC3PpWqOfg75Ob8WGK8uNsG474Qgkeb216KtvtNluUj1+09u
         8cC8VTaRC7kFna/NYnhRRKTMaGpVn8QUr9/b9ESfojQU1f4SEvorqB8pcm2zC3ztqyc/
         IA0HvEVaL6dZTkDcayJ6ZkZP/OGXX8q9niqL/eAF8Ua3l9vYGBt7E01hdmg018801aR+
         fiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbqeiVwt2EXlzz5dyIHq4TsEikGp2nPn0lptTHpqnOk=;
        b=QK7DcgaM3P/4M9M0xw9Jx1lnMM4mFXBLWD1HaSOHxca8SE3SVatE0cEXyNToErESq2
         VW4BvAqjrTXtGN0PCrP+oPbO1tC2/nMZ9y6Ww5S3edK5pJfmGPUbpvpvP6bpxpODZAc9
         /raLXaWg4BgO49ol31KHyLxMxQcX5OuHvNwFkbVCBqdYrKP9IC7hXKaHe99MJiap7lYz
         e9cNwgOQBqnxwMpInv/ajtYaBX6ioGULhZNGEk3NkyjaJW7c13FLWhlwlfazEaL1+h93
         WrNDwzyHxLzLBnrPO5SxeWSOrb6ZigWTWWmf+dUqZ1I+W0FIWaPU8ZtAYUrCf1tylPmS
         OKyw==
X-Gm-Message-State: AOAM530ET2aSWel8EZ79QMaMxyBXkvdHdwPMaurwxktyjOlC9X3yH1+h
        w4+cK5UlDT3Mik/3YEtgrqABwdg/esrobHFwH5e/3g==
X-Google-Smtp-Source: ABdhPJxSmOiDk5Ew2SHly/Gwj4wQUQ7NAr1Zzx1qtPjNAoJHkuC/0D4ZiHEO47TP7YsiyRrN3nUX8cQpd/oH57n1dpg=
X-Received: by 2002:a25:7491:: with SMTP id p139mr5887155ybc.346.1610571423014;
 Wed, 13 Jan 2021 12:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <X/dpkgTnUk+inKHK@kroah.com> <e28e1f38d87c12a3c714a6573beba6e1@kernel.org>
In-Reply-To: <e28e1f38d87c12a3c714a6573beba6e1@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 Jan 2021 12:56:26 -0800
Message-ID: <CAGETcx9SOVRXLcuBGq7EAZe2HzZjWM2s56Vp-XFE-tf-FGd-9Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 3:11 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-01-07 20:05, Greg Kroah-Hartman wrote:
> > On Thu, Dec 17, 2020 at 07:16:58PM -0800, Saravana Kannan wrote:
> >> As discussed in LPC 2020, cyclic dependencies in firmware that
> >> couldn't
> >> be broken using logic was one of the last remaining reasons
> >> fw_devlink=on couldn't be set by default.
> >>
> >> This series changes fw_devlink so that when a cyclic dependency is
> >> found
> >> in firmware, the links between those devices fallback to permissive
> >> mode
> >> behavior. This way, the rest of the system still benefits from
> >> fw_devlink, but the ambiguous cases fallback to permissive mode.
> >>
> >> Setting fw_devlink=on by default brings a bunch of benefits
> >> (currently,
> >> only for systems with device tree firmware):
> >> * Significantly cuts down deferred probes.
> >> * Device probe is effectively attempted in graph order.
> >> * Makes it much easier to load drivers as modules without having to
> >>   worry about functional dependencies between modules (depmod is still
> >>   needed for symbol dependencies).
> >>
> >> Greg/Rafael,
> >>
> >> Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
> >> see some issues due to device drivers that aren't following best
> >> practices (they don't expose the device to driver core). Want to
> >> identify those early on and try to have them fixed before 5.11
> >> release.
> >> See [1] for an example of such a case.
> >
> > Now queued up in my tree, will show up in linux-next in a few days,
> > let's see what breaks!  :)
> >
> > And it is scheduled for 5.12-rc1, not 5.11, sorry.
>
> For the record, this breaks my rk3399 board, (NanoPC-T4) as no mass
> storage can be discovered (it lives on PCIe):
>
> (initramfs) find /sys -name 'waiting_for_supplier'| xargs grep .| egrep
> -v ':0$'
> /sys/devices/platform/ff3d0000.i2c/i2c-4/4-0022/waiting_for_supplier:1
> /sys/devices/platform/f8000000.pcie/waiting_for_supplier:1
> /sys/devices/platform/fe320000.mmc/waiting_for_supplier:1
> /sys/devices/platform/sdio-pwrseq/waiting_for_supplier:1
> /sys/devices/platform/ff3c0000.i2c/i2c-0/0-001b/waiting_for_supplier:1
>
> Enabling the debug prints in device_links_check_suppliers(), I end up
> with
> the dump below (apologies for the size).
>
> This seems to all hang on the GPIO banks, but it is pretty unclear what
> is wrong with them.
>
> Happy to test things further.

Thanks for the logs Marc. Looks like a majority/all of the issue is
due to gpio device nodes [1] being "probed" without creating a proper
struct device for it.

You can see here [2] how the driver for the parent device just loops
through the child DT nodes and initializes them. This would be okay if
the DT nodes didn't have a "compatible" property for the gpio device
[1]. So to fix this, the driver[2] needs to be updated to properly
populate the child devices and then probe them using a proper driver
for "rockchip,gpio-bank". And most of the gpio init code into this new
driver.

The DT implementation of fw_devlink has the expectation that device
tree nodes with "compatible" properties will have struct devices
created for them. Without this expectation, it has no way to know how
far up the ancestor chain fw_devlink needs to walk up before it can
expect a supplier device to create a device link to.

Heiko,

Could you please refactor drivers/pinctrl/pinctrl-rockchip.c to create
and probe struct devices for "rockchip,gpio-bank" nodes? This allows
fw_devlink to work for these devices and makes sure devices probe in
the right order, suspend/resume in the right order, etc.

-Saravana

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399.dtsi#n1956
[2] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/pinctrl-rockchip.c#n3566

>
>          M.
>
>   platform vcc3v3-sys: probe deferral - supplier vcc12v0-sys not ready
>   platform vcc5v0-sys: probe deferral - supplier vcc12v0-sys not ready
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcc3v0-sd: probe deferral - supplier vcc3v3-sys not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vbus-typec: probe deferral - supplier vcc5v0-sys not ready
>   platform vcc5v0-host0: probe deferral - supplier vcc5v0-sys not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform fe320000.mmc: probe deferral - wait for supplier pmic@1b
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - wait for supplier pmic@1b
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform fe320000.mmc: probe deferral - wait for supplier pmic@1b
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform fe380000.usb: probe deferral - supplier
> ff770000.syscon:usb2-phy@e450 not ready
>   platform fe3c0000.usb: probe deferral - supplier
> ff770000.syscon:usb2-phy@e460 not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   platform fe3a0000.usb: probe deferral - supplier
> ff770000.syscon:usb2-phy@e450 not ready
>   platform fe3e0000.usb: probe deferral - supplier
> ff770000.syscon:usb2-phy@e460 not ready
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>   platform vcc1v8-s3: probe deferral - supplier 0-001b not ready
>   platform vcca0v9-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform vcca1v8-s3: probe deferral - supplier vcc1v8-s3 not ready
>   platform f8000000.pcie: probe deferral - wait for supplier
> gpio2@ff780000
>   i2c 0-001b: probe deferral - wait for supplier gpio1@ff730000
>   platform fe320000.mmc: probe deferral - wait for supplier
> gpio0@ff720000
>   platform fe300000.ethernet: probe deferral - supplier 0-001b not ready
>   platform sdio-pwrseq: probe deferral - wait for supplier gpio0@ff720000
>
> --
> Jazz is not dead. It just smells funny...
