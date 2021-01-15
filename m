Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B49D2F7139
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbhAODxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbhAODxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:53:52 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E0C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:53:11 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q2so14058823iow.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zn/E5DSPd3qJg+DTv9IwC7Z6z2pECZsgPkasFqGe2mo=;
        b=SlbAB2R28TVOPw4dT3y4+YKxnBvZIXRjddrKEDVYjmW3vvG3MDP0dEXICbitCBjDsh
         shg/YaDMPSBJC8TmtKZMEExrMsM7sLlrF7dj4kE9P1DHob7nRhpZZQNoE756taUh2vVw
         OwHAOHom27x10XansCH8DvCa2BNXVtylJjjRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zn/E5DSPd3qJg+DTv9IwC7Z6z2pECZsgPkasFqGe2mo=;
        b=RC/cf5m1m2d+i3wquUaghWWT4nohzTF9l+L0bX0bwTJeZDeq3bIOI7hmxrZZNwpCX+
         w44d8vPmIUUB7LG1E7W4atyWbJ5jlJMAEEOIxMVOECO4UHaMpWUQsTjcEOkYPqo5Qgvg
         eMIz/rGi58p5ki4c2UTE9DX+I//tQaQwgbFN5kvW4ewdGw7oG/ak1esCpcIhVLn98KoN
         mABr0YOTYJhsZkF47iw/tmMzrbcIWSv/PY8ZAL7b1UGRHeMiC1CSKpDbpNojqb8pUtre
         15X2F85C3hnTLvpEs3bm52DJaT0nXfJaFQ96bh66VJmiu0CQk9jSujEb0k9oU747YktB
         46Bg==
X-Gm-Message-State: AOAM5304YkLcv4QoXhfyl9rlQJsCRsPhB1bAMWFWjS5jO3YbiN/e41/E
        k5f2LHeqfyWxahbTPvxd9RH1k6PZeQ82XA==
X-Google-Smtp-Source: ABdhPJyePeLi8yXUufZXtX5KzjMmH6kS86EJl3wVT5sCM4R31vFtXmh1zBULOXll1nlTQjcGEiTSgA==
X-Received: by 2002:a92:b60a:: with SMTP id s10mr9304713ili.135.1610682790762;
        Thu, 14 Jan 2021 19:53:10 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id p25sm3496257ioj.21.2021.01.14.19.53.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 19:53:10 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id d81so570597iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:53:10 -0800 (PST)
X-Received: by 2002:a5d:9588:: with SMTP id a8mr2906589ioo.34.1610682391276;
 Thu, 14 Jan 2021 19:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-7-tientzu@chromium.org>
 <95e6dd76-5e18-e445-c351-19fba18f36de@gmail.com> <CALiNf29+8Yi93RacsZHr=qYBhQRwqujW6KZVVD=9xPMhpLH5pA@mail.gmail.com>
 <5f276678-3ab2-ddc8-640c-6dbbe173463c@gmail.com>
In-Reply-To: <5f276678-3ab2-ddc8-640c-6dbbe173463c@gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 15 Jan 2021 11:46:20 +0800
X-Gmail-Original-Message-ID: <CALiNf28nW0CKsBRw-HQmz=jBJ3vK6cjoQZPu8Zx=Yn=RWPdVWQ@mail.gmail.com>
Message-ID: <CALiNf28nW0CKsBRw-HQmz=jBJ3vK6cjoQZPu8Zx=Yn=RWPdVWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/6] of: Add plumbing for restricted DMA pool
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, will@kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rdunlap@infradead.org, dan.j.williams@intel.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:52 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/14/21 1:08 AM, Claire Chang wrote:
> > On Wed, Jan 13, 2021 at 7:48 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 1/5/21 7:41 PM, Claire Chang wrote:
> >>> If a device is not behind an IOMMU, we look up the device node and set
> >>> up the restricted DMA when the restricted-dma-pool is presented.
> >>>
> >>> Signed-off-by: Claire Chang <tientzu@chromium.org>
> >>> ---
> >>
> >> [snip]
> >>
> >>> +int of_dma_set_restricted_buffer(struct device *dev)
> >>> +{
> >>> +     struct device_node *node;
> >>> +     int count, i;
> >>> +
> >>> +     if (!dev->of_node)
> >>> +             return 0;
> >>> +
> >>> +     count = of_property_count_elems_of_size(dev->of_node, "memory-region",
> >>> +                                             sizeof(phandle));
> >>
> >> You could have an early check for count < 0, along with an error
> >> message, if that is deemed useful.
> >>
> >>> +     for (i = 0; i < count; i++) {
> >>> +             node = of_parse_phandle(dev->of_node, "memory-region", i);
> >>> +             if (of_device_is_compatible(node, "restricted-dma-pool"))
> >>
> >> And you may want to add here an of_device_is_available(node). A platform
> >> that provides the Device Tree firmware and try to support multiple
> >> different SoCs may try to determine if an IOMMU is present, and if it
> >> is, it could be marking the restriced-dma-pool region with a 'status =
> >> "disabled"' property, or any variant of that scheme.
> >
> > This function is called only when there is no IOMMU present (check in
> > drivers/of/device.c). I can still add of_device_is_available(node)
> > here if you think it's helpful.
>
> I believe it is, since boot loader can have a shared Device Tree blob
> skeleton and do various adaptations based on the chip (that's what we
> do) and adding a status property is much simpler than insertion new
> nodes are run time.
>
> >
> >>
> >>> +                     return of_reserved_mem_device_init_by_idx(
> >>> +                             dev, dev->of_node, i);
> >>
> >> This does not seem to be supporting more than one memory region, did not
> >> you want something like instead:
> >>
> >>                 ret = of_reserved_mem_device_init_by_idx(...);
> >>                 if (ret)
> >>                         return ret;
> >>
> >
> > Yes. This implement only supports one restriced-dma-pool memory region
> > with the assumption that there is only one memory region with the
> > compatible string, restricted-dma-pool, in the dts. IIUC, it's similar
> > to shared-dma-pool.
>
> Then if here is such a known limitation it should be both documented and
> enforced here, you shouldn ot be iterating over all of the phandles that
> you find, stop at the first one and issue a warning if count > 1?

What I have in mind is there might be multiple memory regions, but
only one is for restriced-dma-pool.
Say, if you want a separated region for coherent DMA and only do
streaming DMA in this restriced-dma-pool region, you can add another
reserved-memory node with shared-dma-pool in dts and the current
implementation will try to allocate the memory via
dma_alloc_from_dev_coherent() first (see dma_alloc_attrs() in
/kernel/dma/mapping.c).
Or if you have vendor specific memory region, you can still set up
restriced-dma-pool by adding another reserved-memory node in dts.
Dose this make sense to you? I'll document this for sure.

> --
> Florian
