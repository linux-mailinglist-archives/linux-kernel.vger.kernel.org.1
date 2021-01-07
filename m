Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5142EE9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbhAGXk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbhAGXk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:40:59 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D525C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:40:19 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k4so7746689ybp.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNazPB7Jeoa5X+cD/sTfop5smhcyCpGaf+477JfNu7A=;
        b=lgRq7zbQObCFfB0sgaWsDIvTDnlcsZdFYji3RzJ/Ec0VXrLwY/TbDV6G7ujtpULKI7
         P3g+jsL4+YPhjajJX2CTqrk8C36XuHSF8IQx2Akzq7VBl1HBKascapvobiLPK+l4k9KQ
         HG0GCf6QJue/ZSBoXQKnNuoFFKq3TofvJXwEKCA+rRdC3sY+NKaI8bl9xX73eKL1P3+O
         X3r7oCoBa15UfrNQU6q3Gyl5X1+z7idww2d9i3EEFBpkmUE41OP+XPvNikHmpwnvVbd8
         nzj92rCtYddEwAupCw+KtSGw3UnTPR3ykHGWGwxczP/vPzopII763mFDIYyYcRsl9JCe
         Rz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNazPB7Jeoa5X+cD/sTfop5smhcyCpGaf+477JfNu7A=;
        b=L3TmsXOufNqyP6gDtdeRl6e99cuwwSz/leViKtmH79D7nOzOKOZQX3q9uR+Bv5b+JU
         kuRJlUD7K/2n36ay9IHFgULJ1AE3hSp5f3WISsABpBlTifsyYxFW1g3VuYR4aNfBx6i2
         PDqiBOa19hc2MaLXY+V4GZRj6+ZhPyElErfMdLSbXsLaQb+YSzaCO5sFoEqRSWQeLKDs
         VVlwSKvz8ODSbpm027yc1i6fnpB6AzvJPldEqj028OvTZhXvGfW1VmteIDOal7Nq3E9i
         FRTAqlh2RKVlO3be+piL+osW0hp0QmEPjr2R5zVov4sdt9OFqEVHVvcrOEkDJNUOYEeg
         P+BA==
X-Gm-Message-State: AOAM5330Ef71e4ncLqlDAH6AUdovnMVoJIvmXVXLGpvgD8ZHz6dDoWks
        fsKOeRwj7GKmUd5Ozg6aXHjCsvwf8Vn7c/oaMkWJIQ==
X-Google-Smtp-Source: ABdhPJxh8jcW6enUGOXxeX3wyDdBPBWoJNcJHKUCU2pSY23Vian++Tlg/OPIkg75R7NjxyENi5m/xduVQppxWiELHQg=
X-Received: by 2002:a25:7491:: with SMTP id p139mr1803436ybc.346.1610062818122;
 Thu, 07 Jan 2021 15:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20210106232641.459081-1-saravanak@google.com> <305deba691b59aec2414dee611c23e69@walle.cc>
In-Reply-To: <305deba691b59aec2414dee611c23e69@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 15:39:41 -0800
Message-ID: <CAGETcx9J-WzdE+HAvftERPj9K5Q5gV_F03GKAOrQ9Vv733+szw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix device link device name collision
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 1:56 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Saravana,
>
> Am 2021-01-07 00:26, schrieb Saravana Kannan:
> > The device link device's name was of the form:
> > <supplier-dev-name>--<consumer-dev-name>
> >
> > This can cause name collision as reported here [1] as device names are
> > not globally unique. Since device names have to be unique within the
> > bus/class, add the bus/class name as a prefix to the device names used
> > to
> > construct the device link device name.
> >
> > So the devuce link device's name will be of the form:
> > <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>
> >
> > [1] -
> > https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
> > Reported-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> missing Fixes: tag?
>
> > Can you please test this? This should fix your issue.
>
> Unfortunately, not:
>
> [    4.234617] fsl_enetc 0000:00:00.0: Adding to iommu group 1
> [    4.346768] fsl_enetc 0000:00:00.0: enabling device (0400 -> 0402)
> [    4.353012] fsl_enetc 0000:00:00.0: no MAC address specified for SI1,
> using 3e:6a:a1:57:9c:b0
> [    4.361580] fsl_enetc 0000:00:00.0: no MAC address specified for SI2,
> using 9e:8b:7b:e3:e2:ad
> [    4.370539] libphy: Freescale ENETC MDIO Bus: probed
> [    4.376751] libphy: Freescale ENETC internal MDIO Bus: probed
> [    4.383060] fsl_enetc 0000:00:00.1: Adding to iommu group 2
> [    4.494764] fsl_enetc 0000:00:00.1: enabling device (0400 -> 0402)
> [    4.501012] fsl_enetc 0000:00:00.1: no MAC address specified for SI1,
> using ee:99:cb:b1:24:4c
> [    4.509580] fsl_enetc 0000:00:00.1: no MAC address specified for SI2,
> using 66:60:f4:0d:9e:e0
> [    4.518556] sysfs: cannot create duplicate filename
> '/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/consumer:0000:00:00.1'
> [    4.530882] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.11.0-rc2-next-20210107-00017-g392ec8cbdef5 #303
> [    4.540317] Hardware name: Kontron KBox A-230-LS (DT)
> [    4.545385] Call trace:
> [    4.547834]  dump_backtrace+0x0/0x1b8
> [    4.551517]  show_stack+0x20/0x70
> [    4.554844]  dump_stack+0xd8/0x134
> [    4.558258]  sysfs_warn_dup+0x6c/0x88
> [    4.561932]  sysfs_do_create_link_sd.isra.2+0x10c/0x110
> [    4.567175]  sysfs_create_link+0x2c/0x50
> [    4.571109]  devlink_add_symlinks+0x110/0x1b8
> [    4.575484]  device_add+0x460/0x798
> [    4.578982]  device_link_add+0x46c/0x628
> [    4.582917]  fw_devlink_create_devlink+0xb8/0xc8
> [    4.587549]  __fw_devlink_link_to_suppliers+0x84/0x180
> [    4.592705]  __fw_devlink_link_to_suppliers+0x134/0x180
> [    4.597948]  device_add+0x778/0x798
> [    4.601445]  device_register+0x28/0x38
> [    4.605205]  __mdiobus_register+0x94/0x340
> [    4.609317]  of_mdiobus_register+0xb4/0x380
> [    4.613513]  enetc_pf_probe+0x73c/0xb10
> [    4.617362]  local_pci_probe+0x48/0xb8
> [    4.621125]  pci_device_probe+0x120/0x1c0
> [    4.625146]  really_probe+0xec/0x3c0
> [    4.628732]  driver_probe_device+0x60/0xc0
> [    4.632842]  device_driver_attach+0x7c/0x88
> [    4.637039]  __driver_attach+0x60/0xe8
> [    4.640799]  bus_for_each_dev+0x7c/0xd0
> [    4.644647]  driver_attach+0x2c/0x38
> [    4.648232]  bus_add_driver+0x194/0x1f8
> [    4.652079]  driver_register+0x6c/0x128
> [    4.655927]  __pci_register_driver+0x4c/0x58
> [    4.660213]  enetc_pf_driver_init+0x2c/0x38
> [    4.664412]  do_one_initcall+0x54/0x2d8
> [    4.668260]  kernel_init_freeable+0x200/0x26c
> [    4.672631]  kernel_init+0x1c/0x120
> [    4.676131]  ret_from_fork+0x10/0x30
> [    4.679758] libphy: Freescale ENETC MDIO Bus: probed
> [    4.686590] fsl_enetc 0000:00:00.2: Adding to iommu group 3
> [    4.798764] fsl_enetc 0000:00:00.2: enabling device (0400 -> 0402)
> [    4.805010] fsl_enetc 0000:00:00.2: no MAC address specified for SI0,
> using 2a:90:8e:f9:ee:5d
> [    4.814279] fsl_enetc 0000:00:00.6: Adding to iommu group 4
> [    4.819992] fsl_enetc 0000:00:00.6: device is disabled, skipping
> [    4.826146] fsl_enetc_mdio 0000:00:00.3: Adding to iommu group 5
> [    4.938764] fsl_enetc_mdio 0000:00:00.3: enabling device (0400 ->
> 0402)
> [    4.945601] libphy: FSL PCIe IE Central MDIO Bus: probed
>
> Please note the:
> [    4.518556] sysfs: cannot create duplicate filename
> '/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/consumer:0000:00:00.1'
>
> Your patch just addresses the link names, but not the ones for
> "consumer:"
> and "supplier:" under the device itself, right?

Ah, this is another location where I needed to fix the collision. Will
send out a v2.

> > Having said that, do you have some local DT changes when you are
> > testing
> > this?
>
> No. But keep in mind that this is also PCI and there might be other
> devices too.

Right, but fw_devlink is only parsing DT to figure out the
dependencies. So I'm confused where these dependencies are inferred
from DT. I did check all the DT includes, but it's hard to tell if you
have downstream changes or if I'm missing something. Looks like the
mdio bus or one of its children is dependent on both the mdio bus node
AND the PCI root node. Do you know which one that might be? Can you
point to it in DT?

If not, can you change both the dev_dbg() calls in device_link_add()
to dev_info() and share the boot log with me? Maybe even enable
initcall_debug? My v2 should fix your collision issue, but I still
want to make sure the refactor isn't creating any links it shouldn't
be creating.

-Saravana

> > Because it's not obvious from the DT in upstream what dependency
> > is even being derived from the firmware. I don't see any dependency in
> > upstream DT files between mdio_bus/0000:00:00.1 and
> > pci0000:00/0000:00:00.1
>
> I guess that would be this:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/freescale/enetc/enetc_pf.c#L748
>
> which registers an mdio bus on the same PCI device as the ENETC.
>
> -michael
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
