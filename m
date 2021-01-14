Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93982F5CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbhANJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbhANJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:09:19 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01800C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:08:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id b19so7242629ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoX/j54i0jG8qEsxZKby76Lqj61QzippjPHzsTsj+5Y=;
        b=nY1GnsLlZi0Sxxm+zSGIGaqKpSxx6JueftrzPps7oTAcG91/bM9YfHLXW3YxSFcLzK
         y6cH1olpZ/FXA0Mp0cE9+mqoheJMPU0KT0091/GVtf67wUxU6MGGIWncH2X6oPgNN5KO
         QvrKMhyV8u8UB5lLj67P7d++Su0Uyq/z5gAtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoX/j54i0jG8qEsxZKby76Lqj61QzippjPHzsTsj+5Y=;
        b=D8qocMZzSaFnU5+EbkzDa8MBOyHlbI1c6Zz/WWMlicEKFYZu8sKsCWBVgJqjIBEqTJ
         Up82mDsNg8h/uBB2gXeoU0+Y8y0ZzyM8wER9k/g+3FirraalYnfbDX4Icu9foXbnfC5F
         dqdJTxQ+9rrDE0mASNXqXYvjTE79DpIi4NwRBmTZ+Vw5AzruzBfvTpE27xbeygWDch81
         zurof5Y6T++vXnuvyu7JFh/0MtW/mVtOyXkEKKcfpM1UrosJD8GmmkbZ5F2IxdrsyTJP
         bNsHZbRXjsF3BIm9xPRUAbgyEiHvyDM5PbEng8chybstNfWbI8xmh0ndSw9Mn4n1Bs75
         S5zA==
X-Gm-Message-State: AOAM531S7H7G10vGcv2MZb7qO3NVP7gpb2b+QXTNcoI3OZeF961Il3Fh
        qLH9Sxdhl5umRaqGuQJigBlL6vM/hLVXpA==
X-Google-Smtp-Source: ABdhPJw/hK3yzfLeBJ7gJSm8a+wvhoBLJwDYZedhGPdRyuWmsR1lzXoirpMXv9hvGvZY4twctf9rEg==
X-Received: by 2002:a92:9153:: with SMTP id t80mr5800284ild.216.1610615318053;
        Thu, 14 Jan 2021 01:08:38 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id s4sm2478973ioc.33.2021.01.14.01.08.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 01:08:37 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id z5so9704061iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:08:36 -0800 (PST)
X-Received: by 2002:a92:c206:: with SMTP id j6mr5789564ilo.189.1610615314989;
 Thu, 14 Jan 2021 01:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-7-tientzu@chromium.org>
 <95e6dd76-5e18-e445-c351-19fba18f36de@gmail.com>
In-Reply-To: <95e6dd76-5e18-e445-c351-19fba18f36de@gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 14 Jan 2021 17:08:24 +0800
X-Gmail-Original-Message-ID: <CALiNf29+8Yi93RacsZHr=qYBhQRwqujW6KZVVD=9xPMhpLH5pA@mail.gmail.com>
Message-ID: <CALiNf29+8Yi93RacsZHr=qYBhQRwqujW6KZVVD=9xPMhpLH5pA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/6] of: Add plumbing for restricted DMA pool
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, will@kernel.org,
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
        linuxppc-dev@lists.ozlabs.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org, Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 7:48 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/5/21 7:41 PM, Claire Chang wrote:
> > If a device is not behind an IOMMU, we look up the device node and set
> > up the restricted DMA when the restricted-dma-pool is presented.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
>
> [snip]
>
> > +int of_dma_set_restricted_buffer(struct device *dev)
> > +{
> > +     struct device_node *node;
> > +     int count, i;
> > +
> > +     if (!dev->of_node)
> > +             return 0;
> > +
> > +     count = of_property_count_elems_of_size(dev->of_node, "memory-region",
> > +                                             sizeof(phandle));
>
> You could have an early check for count < 0, along with an error
> message, if that is deemed useful.
>
> > +     for (i = 0; i < count; i++) {
> > +             node = of_parse_phandle(dev->of_node, "memory-region", i);
> > +             if (of_device_is_compatible(node, "restricted-dma-pool"))
>
> And you may want to add here an of_device_is_available(node). A platform
> that provides the Device Tree firmware and try to support multiple
> different SoCs may try to determine if an IOMMU is present, and if it
> is, it could be marking the restriced-dma-pool region with a 'status =
> "disabled"' property, or any variant of that scheme.

This function is called only when there is no IOMMU present (check in
drivers/of/device.c). I can still add of_device_is_available(node)
here if you think it's helpful.

>
> > +                     return of_reserved_mem_device_init_by_idx(
> > +                             dev, dev->of_node, i);
>
> This does not seem to be supporting more than one memory region, did not
> you want something like instead:
>
>                 ret = of_reserved_mem_device_init_by_idx(...);
>                 if (ret)
>                         return ret;
>

Yes. This implement only supports one restriced-dma-pool memory region
with the assumption that there is only one memory region with the
compatible string, restricted-dma-pool, in the dts. IIUC, it's similar
to shared-dma-pool.


> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index aedfaaafd3e7..e2c7409956ab 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -182,6 +182,10 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
> >       arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> >
> >       dev->dma_range_map = map;
> > +
> > +     if (!iommu)
> > +             return of_dma_set_restricted_buffer(dev);
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> > index d9e6a324de0a..28a2dfa197ba 100644
> > --- a/drivers/of/of_private.h
> > +++ b/drivers/of/of_private.h
> > @@ -161,12 +161,17 @@ struct bus_dma_region;
> >  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
> >  int of_dma_get_range(struct device_node *np,
> >               const struct bus_dma_region **map);
> > +int of_dma_set_restricted_buffer(struct device *dev);
> >  #else
> >  static inline int of_dma_get_range(struct device_node *np,
> >               const struct bus_dma_region **map)
> >  {
> >       return -ENODEV;
> >  }
> > +static inline int of_dma_get_restricted_buffer(struct device *dev)
> > +{
> > +     return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_OF_PRIVATE_H */
> >
>
>
> --
> Florian
