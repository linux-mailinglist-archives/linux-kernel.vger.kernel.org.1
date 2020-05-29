Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A851E85E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 19:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgE2Rza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgE2Rz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:55:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E9C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:55:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so4694378wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/iWA+NM93lmEOR8BD3HSGFwn5myHStX/svocCwc2zk=;
        b=T3isW0BRXt8VQajj1U69CHubFeUebbA7xMKa/VSv/g1vunIpEUnbEgqdlAUG3dmxSY
         h+2fFSUWz5RSeir9VQUHRlYjikdIavLXyI7LELfjSHOEqDzuDt0smviqOBdljinxME5+
         KoE49ljxnvFhdKvzrug2mC7bA9NKZ1hJTbk3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/iWA+NM93lmEOR8BD3HSGFwn5myHStX/svocCwc2zk=;
        b=CBIE5t12QF3+DaWugQ+9eMXZs3eRNo0ig4fJ82hdI1U08ctJMKiPvzKrLNpybrcgFr
         eOvkeghDi/PFNKXthess0nbwewBUtOWJpnzkB0v+oLKxwGJT8IHi7SCR5rcE1+8kGyUr
         i3f1f1jzQP0kreg9LEjbsD6gBRI/NqvfB0UPJduEsEkQ5zux8GfZ/iEJWTopJj5I8a2v
         tjQoW8PENIPK5LWjGv5wLyicdF0bshol/ZG1DdOHfEGRnlb08fmfMsxGCufsqIFGulOr
         v4BLcftLFamytb/JKiXsk+D3pKzHnvR2tc0GeejoxJF0T30tmmtmKL9bwa23TSGAgQQV
         ouiQ==
X-Gm-Message-State: AOAM533S1ZUtU5QeWfYE5qq2z3ZUIFB4gu66io3SWVP3/Z/nSFquuxsE
        eDYMpvYvQyvlqUfzrhKV6ZoSwo5BD7qiOtPsKtjx4Q==
X-Google-Smtp-Source: ABdhPJyddc3wujxmrCvzPzUS9jR6GnyypGU54L49z504ymdkHZAWzgGRss7csUxJVRpywWwHWAFmXu42cGVgC/AI5dc=
X-Received: by 2002:a05:600c:280c:: with SMTP id m12mr10012502wmb.92.1590774925565;
 Fri, 29 May 2020 10:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com> <20200529174858.GA2640397@bogus>
In-Reply-To: <20200529174858.GA2640397@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 29 May 2020 13:55:13 -0400
Message-ID: <CA+-6iNydfUPe4J_eMY_9OXR9Y+Bwc65wtKQRGAwuW+K=drCVqQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] PCI: brcmstb: enable PCIe for STB chips
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corey Minyard <minyard@acm.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Julien Grall <julien.grall@arm.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 1:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 26, 2020 at 03:12:39PM -0400, Jim Quinlan wrote:
> > v2:
> > Commit: "device core: Add ability to handle multiple dma offsets"
> >   o Added helper func attach_dma_pfn_offset_map() in address.c (Chistoph)
> >   o Helpers funcs added to __phys_to_dma() & __dma_to_phys() (Christoph)
> >   o Added warning when multiple offsets are needed and !DMA_PFN_OFFSET_MAP
> >   o dev->dma_pfn_map => dev->dma_pfn_offset_map
> >   o s/frm/from/ for dma_pfn_offset_frm_{phys,dma}_addr() (Christoph)
> >   o In device.h: s/const void */const struct dma_pfn_offset_region */
> >   o removed 'unlikely' from unlikely(dev->dma_pfn_offset_map) since
> >     guarded by CONFIG_DMA_PFN_OFFSET_MAP (Christoph)
> >   o Since dev->dma_pfn_offset is copied in usb/core/{usb,message}.c, now
> >     dev->dma_pfn_offset_map is copied as well.
> >   o Merged two of the DMA commits into one (Christoph).
> >
> > Commit "arm: dma-mapping: Invoke dma offset func if needed":
> >   o Use helper functions instead of #if CONFIG_DMA_PFN_OFFSET
> >
> > Other commits' changes:
> >   o Removed need for carrying of_id var in priv (Nicolas)
> >   o Commit message rewordings (Bjorn)
> >   o Commit log messages filled to 75 chars (Bjorn)
> >   o devm_reset_control_get_shared())
> >     => devm_reset_control_get_optional_shared (Philipp)
> >   o Add call to reset_control_assert() in PCIe remove routines (Philipp)
> >
> > v1:
> > This patchset expands the usefulness of the Broadcom Settop Box PCIe
> > controller by building upon the PCIe driver used currently by the
> > Raspbery Pi.  Other forms of this patchset were submitted by me years
> > ago and not accepted; the major sticking point was the code required
> > for the DMA remapping needed for the PCIe driver to work [1].
> >
> > There have been many changes to the DMA and OF subsystems since that
> > time, making a cleaner and less intrusive patchset possible.  This
> > patchset implements a generalization of "dev->dma_pfn_offset", except
> > that instead of a single scalar offset it provides for multiple
> > offsets via a function which depends upon the "dma-ranges" property of
> > the PCIe host controller.  This is required for proper functionality
> > of the BrcmSTB PCIe controller and possibly some other devices.
>
> If you can enable the h/w support without the multiple offset support,
> then I'd split up this series. The latter part might take a bit more
> time.
>
> Rob
Unfortunately, the STB PCIe  controller depends on the multiple PFN
offset functionality.
Thanks,
Jim
