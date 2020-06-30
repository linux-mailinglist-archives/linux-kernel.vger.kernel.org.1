Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A320FAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgF3RoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgF3RoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:44:14 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:44:14 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d4so19113078otk.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvrPSyad64a06y3emmBaHBraeMnCfgt6QtYJn+H41Ho=;
        b=AIvFwiVmHfWa0dr/Zj/nl3/Gf+Dd7lJR5y4sPWVHQ6irUWAzRxeWoOb/p2Glgrk5x7
         TDEjkGmBqHJFS3FeMsKSUuM+D3gUcPWXfX8izqzDYuu0i5RlpD4ZYEGNnt5HD5TFGK/4
         +VZg7MDSEIbgEZSrQtROVsWPTIRaGegwbqGtn6aYm7ZDVsTuiNa6Vz1uvzRXOMzrKN6M
         vrZA71ayaPMxJ7T9dyamhd8XLmDYQA3mCTowCoZLR+iNzAZTh88X+FxrewQAkskd6ncd
         EOt1xr66NGeLzGOPzxdLzf+Wr/iHl7eww9QdEkZ4ZlS5fCywYXwwCJ9aTWMyMziBOyS6
         r9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvrPSyad64a06y3emmBaHBraeMnCfgt6QtYJn+H41Ho=;
        b=RnHIhj+iYdfBi5wuNJ16oSIOcrSz5j/XguGE9rLBFC2UR4dMizJFK3TLXhIOaz35PP
         7ZZlpfxNawuDaqtKwnWBi/W25y4jvfm3Tpo4DodoDAgGVuYIXCOxiKhrvqtUgU1k/V/B
         IjKHZx1+B64tbJflrxDxuYkTT6X2odQowE88jU3dmaXJERmunSFmj2B0ngn6dZlvUwZV
         OLYTxEjcTbS4/QLZ1woWQflZZueWBTMFTuFp79D4eLRn5dm0xnZ5kwvn4G090sHqp5Eu
         Es9R4Q6BmZaamA4e7wiyjERNG2Mv4wkwUAgUeSdZ73aTRaW/caebWwdW31KBMn4TcucN
         MV1w==
X-Gm-Message-State: AOAM5300W2mdsVYPngnwhk+izk2azftY8vQ9XLLCSMdiieY+WsNvmpYX
        jeXFh3UWPLNwsLP54UhFbbc4A71jerfTDhLOQ0wC/Q==
X-Google-Smtp-Source: ABdhPJxvmOdBgLv+Am0qzfX+NxBE+/4lC8/0GP2QXouYO+Xni8icBayVXFLmI+l2lGzBS6ZBGHtQIVdLNxB8n7tHCR8=
X-Received: by 2002:a9d:8ea:: with SMTP id 97mr11889961otf.231.1593539053111;
 Tue, 30 Jun 2020 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com> <20200630044943.3425049-6-rajatja@google.com>
In-Reply-To: <20200630044943.3425049-6-rajatja@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Jun 2020 10:43:37 -0700
Message-ID: <CAGETcx9hgV70DVdbOvCF+tO4b-6+1JzN1_OmPmnWjj9qJhB_dw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 9:49 PM Rajat Jain <rajatja@google.com> wrote:
>
> Add a new (optional) field to denote the physical location of a device
> in the system, and expose it in sysfs. This was discussed here:
> https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
>
> (The primary choice for attribute name i.e. "location" is already
> exposed as an ABI elsewhere, so settled for "site"). Individual buses
> that want to support this new attribute can opt-in by setting a flag in
> bus_type, and then populating the location of device while enumerating
> it.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: (Initial version)
>
>  drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++
>  include/linux/device.h     | 42 ++++++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h |  8 ++++++++
>  3 files changed, 85 insertions(+)
>

<snip> I'm not CC'ed in 4/7, so just replying

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024a..a4143735ae712 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -428,6 +428,31 @@ enum dl_dev_state {
>         DL_DEV_UNBINDING,
>  };
>
> +/**
> + * enum device_site - Physical location of the device in the system.
> + * The semantics of values depend on subsystem / bus:
> + *
> + * @SITE_UNKNOWN:  Location is Unknown (default)
> + *
> + * @SITE_INTERNAL: Device is internal to the system, and cannot be (easily)
> + *                 removed. E.g. SoC internal devices, onboard soldered
> + *                 devices, internal M.2 cards (that cannot be removed
> + *                 without opening the chassis).
> + * @SITE_EXTENDED: Device sits an extension of the system. E.g. devices
> + *                 on external PCIe trays, docking stations etc. These
> + *                 devices may be removable, but are generally housed
> + *                 internally on an extension board, so they are removed
> + *                 only when that whole extension board is removed.
> + * @SITE_EXTERNAL: Devices truly external to the system (i.e. plugged on
> + *                 an external port) that may be removed or added frequently.
> + */
> +enum device_site {
> +       SITE_UNKNOWN = 0,
> +       SITE_INTERNAL,
> +       SITE_EXTENDED,
> +       SITE_EXTERNAL,
> +};
> +
>  /**
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
> @@ -513,6 +538,7 @@ struct dev_links_info {
>   *             device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu:     Per device generic IOMMU runtime data
> + * @site:      Physical location of the device w.r.t. the system
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:   Set after successful invocation of bus type's .offline().
> @@ -613,6 +639,8 @@ struct device {
>         struct iommu_group      *iommu_group;
>         struct dev_iommu        *iommu;
>
> +       enum device_site        site;   /* Device physical location */
> +
>         bool                    offline_disabled:1;
>         bool                    offline:1;
>         bool                    of_node_reused:1;
> @@ -806,6 +834,20 @@ static inline bool dev_has_sync_state(struct device *dev)
>         return false;
>  }
>
> +static inline int dev_set_site(struct device *dev, enum device_site site)
> +{
> +       if (site < SITE_UNKNOWN || site > SITE_EXTERNAL)
> +               return -EINVAL;
> +
> +       dev->site = site;
> +       return 0;
> +}
> +
> +static inline bool dev_is_external(struct device *dev)
> +{
> +       return dev->site == SITE_EXTERNAL;
> +}

I'm not CC'ed in the rest of the patches in this series, so just
responding here. I see you use this function in patch 6/7 to decide if
the PCI device is trusted. Anything other than EXTERNAL is being
treated as trusted. I'd argue that anything that's not internal should
be distrusted. For example, I can have a hacked up laptop dock that I
can share with you when you visit my home/office and now you are
trusting it when you shouldn't be.

Also, "UNKNOWN" is treated as trusted in patch 6/7. I'm guessing this
is because some of the devices might not have the info in their
firmware? At which point, this feature isn't even protecting all the
PCI ports properly? This adds to Greg point that this should be a
userspace policy so that it can override whatever is wrong/missing in
the firmware.

-Saravana
