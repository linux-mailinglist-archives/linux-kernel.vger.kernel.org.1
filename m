Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE92BB04E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgKTQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgKTQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:20:44 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9DEC0613CF;
        Fri, 20 Nov 2020 08:20:44 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 79so9194287otc.7;
        Fri, 20 Nov 2020 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVxJeqbvblEOj3ny+TuW/O1CmBk2ivCSjlTJ1PlvcUk=;
        b=Gs2Qu+CUxLtsn+6NjJIX1X8+VSuXr9dW9qEwFr/zrx8f+1h/Yn9ZT4dnValPE86gCT
         KY7MuVdV4pXee4icJvJ9anuOFjcpjTBndNUEH6+LfavukFfqAwMt6GTi0U2LCXji/hDf
         dJwQX5qvIPJgZMW72/F5SplUb8+MWPJeL+0OVW2jvx0f8gGksxX8IUuQSbZjS615o44X
         lsSB3XsD/5l8kmDpIsrcxDPw4sWDIDpCPGfFwYzcEpaT8ns8NhGlAftKqCAABBXi8cS0
         cFvHJdHM3ItJiNFpXPJEeMdXbfs4WivDq+EczMkx7o7MGTpL5xm2VZ4IfcDCxNoseMdI
         u80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVxJeqbvblEOj3ny+TuW/O1CmBk2ivCSjlTJ1PlvcUk=;
        b=bzOnx3lMY6IhzkPa7bql50hr/jNcEt0yhCmp8Y35dxdIOxUR/iIoWdcodg13MhBX4R
         1tPqdgtvyOjyKiS3nf5dpiqPZB0VoPpMG9e02uRizKJIoMiagkec3dgaEzdIFZ41M35j
         Aw+qn6Snk8FVxy2pnqDyayNETU09/BS7r2p2vEjUCTcYL4s4VzQPao8ESdd34ThYfNmx
         HEiq6uux3vU26GDMfq8tnB3z6gHeB5UQ6tsPrUoN6IPc2qR7R4vkN6tYJ5qcPG75rKU8
         UWdjcR8mL5UD6TPkn99MkJKmAokImurZ69R+r0OsDxT4DpvXmM3z26UAFkbwlkaA2jGw
         czZQ==
X-Gm-Message-State: AOAM5304kSW6hPb88vIYdrs9LNoOuFHh76pVfqcU1aGxwClUvPb9rCjE
        y5Z9f7cvRlyHb2fIqcyTJZpBi6lAJ6eUfgQ+8A8aY6uO185zZw==
X-Google-Smtp-Source: ABdhPJwmav0/PNrs7PMR5pjq2q2Pw6ET6CbJBnx58x5yQBYy+EdAOkRA5TdObvP/SSqXdWAKKXhJZJx80IvcrCGZKlg=
X-Received: by 2002:a05:6830:160d:: with SMTP id g13mr3193376otr.74.1605889243799;
 Fri, 20 Nov 2020 08:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 20 Nov 2020 17:20:32 +0100
Message-ID: <CAMhs-H8bUuSQ+ROr4PNJXYaGFnjG2=zpjGK7UAAfoPMPbFBb1Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] MT7621 PCIe PHY
To:     vkoul@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Thu, Nov 19, 2020 at 4:43 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> This series adds support for the PCIe PHY found in the Mediatek
> MT7621 SoC.
>
> There is also a 'mt7621-pci' driver which is the controller part
> which is still in staging and is a client of this phy.
>
> Both drivers have been tested together in a gnubee1 board.
>
> This series are rebased on the top of linux-next:
> commit 4e78c578cb98 ("Add linux-next specific files for 20201030")
>
> Changes in v5:
>   - PATCH 1/4: Recollect Rob's Reviewed-by of bindings.
>   - PATCH 4/4: Recollect Greg's Acked-by for removing stuff from
>     staging area.
>   - Make Vinod's review comments changes in [0]:
>     * Use FIELD_GET and FIELD_PREP apis and avoid multiple *_VAL and
>       *_SHIFT custom definitions.
>     * Remove phy-read and phy-write internal functions and directly
>       call regmap_read and regmap_write in 'mt7621_phy_rmw'.
>     * Change some traces from info to debug log level.
>     * Note that I have maintained 'mt7621_phy_rmw' instead of use
>       'regmap_update_bits'. This is because in order to get a reliable
>       boot registers must be written event the contained value in
>       that register is the same. I have preferred doing in this way
>       instead of using 'regmap_update_bits_base' passing 'false' for
>       async and 'true' for the force write. If this way of using
>       'regmap_update_bits_base' is preferred just let me know.

I notice we already have 'regmap_write_bits' function. I will use this
and avoid mt7621_phy_rmw
and send v6 of this series.

Also, do you have any preference of where you want this series to be rebased on?

Best regards,
    Sergio Paracuellos
>
> Changes in v4:
>   - Bindings moved from txt to yaml so previous Rob's Reviewed-by
>     is not in the new patch with the yaml file.
>   - 'phy-cells' property means now if phy is dual-ported.
>   - Avoid custom 'xlate' function and properly set registers
>     when the phy is dual ported.
>   - Add use of 'builtin_platform_driver'.
>   - Added a patch including myself as maintainer in the
>     MAINTAINERS file.
>   - Add a patch removing patch from staging to make easier
>     the complete inclusion and avoid possible problems might
>     appear in 'linux-next' if the series are included.
>
> Changes in v3:
>   - Recollect Rob's Reviewed-by of bindings.
>   - Make Kishon Vijay suggested changes in v2:
>    (See https://lkml.org/lkml/2019/4/17/53)
>   - Kconfig:
>     * Add depends on COMPILE_TEST
>     * Select REGMAP_MMIO
>   - Make use of 'soc_device_attribute' and 'soc_device_match'
>   - Use regmap mmio API instead of directly 'readl' and 'writel'.
>   - Use 'platform_get_resource' instead of 'of_address_to_resource'.
>
> Changes in v2:
>   - Reorder patches to get bindings first in the series.
>   - Don't use child nodes in the device tree. Use #phy-cells=1 instead.
>   - Update driver code with new 'xlate' function for the new device tree.
>   - Minor changes in driver's macros changing some spaces to tabs.
>
> Thanks in advance for your time.
>
> Best regards,
>     Sergio Paracuellos
>
> [0]: http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2020-November/148864.html
>
> Sergio Paracuellos (4):
>   dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
>   phy: ralink: Add PHY driver for MT7621 PCIe PHY
>   MAINTAINERS: add MT7621 PHY PCI maintainer
>   staging: mt7621-pci-phy: remove driver from staging
>
>  .../phy}/mediatek,mt7621-pci-phy.yaml         |   0
>  MAINTAINERS                                   |   6 +
>  drivers/phy/ralink/Kconfig                    |   8 ++
>  drivers/phy/ralink/Makefile                   |   1 +
>  .../ralink/phy-mt7621-pci.c}                  | 103 +++++++-----------
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/mt7621-pci-phy/Kconfig        |   8 --
>  drivers/staging/mt7621-pci-phy/Makefile       |   2 -
>  drivers/staging/mt7621-pci-phy/TODO           |   4 -
>  10 files changed, 53 insertions(+), 82 deletions(-)
>  rename {drivers/staging/mt7621-pci-phy => Documentation/devicetree/bindings/phy}/mediatek,mt7621-pci-phy.yaml (100%)
>  rename drivers/{staging/mt7621-pci-phy/pci-mt7621-phy.c => phy/ralink/phy-mt7621-pci.c} (76%)
>  delete mode 100644 drivers/staging/mt7621-pci-phy/Kconfig
>  delete mode 100644 drivers/staging/mt7621-pci-phy/Makefile
>  delete mode 100644 drivers/staging/mt7621-pci-phy/TODO
>
> --
> 2.25.1
>
