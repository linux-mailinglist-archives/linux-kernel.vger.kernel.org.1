Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E997280452
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgJAQy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJAQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:54:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B10C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 09:54:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so9138026ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcY5sR068ean6onHI2ckcFdlXy4IjyUiGqqLhTP4BDE=;
        b=yCNULK1n3abFX9Y+iMGYX4f2JcfN9L0Hdk+mfBgX04LDJVKbxdT7dfYejv1D7tAI3R
         uTTdqoRLHOFJkFkKGbYpJFa+LJYas5kW5i9V5oKCulOvmz4nCfucExd9yojQoKjCE7kk
         ysrEGywF0fUCLJX88KeZP/3Xa9nXcJuhJ/649SVuoJwxLIoorTYmdeclxvSVuCMUrQAB
         kPtf74qHtOfyvTKSR/WP4sD5qYKzQ3fxWg97siVzPuqtrKZ8DT4Csoer5QkA5N0B+Qx2
         8XFRjdjXRCcLaCDKegdEcrFcYwarEIqvqTFtqaaLuMorbVqivvlfTu2jvqAyU/+4txJI
         GkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcY5sR068ean6onHI2ckcFdlXy4IjyUiGqqLhTP4BDE=;
        b=FtQyKTwGQMLjJ+TrndEG4d+z+28hdfyaJZS3z0QDzIjZj20G5/MpX5uyMP5pSZeADL
         ZtIeZQyRjf1w/DUBNU9DmM0suELrtwL64oBAsI6QyGO+aGNwM1M8cAnXwN+bBO+BbZ6T
         ohMKEoSIzQ03rdLs06xulQ4Je/6B28kjmsrKTPJoT/YnSyLmvM21w3L99sKqqyvlRT74
         6w0qQM8+uxsVsKFFfNg8hnZnIYj7b8dnRAcSmkA1iXTqSivlLBVcnANbHfh4Qm4+84dG
         VJAJemy+6v8ZfcBkBTHSm8QKhyqC5eN09oqStjHSiV1EdiqS6c5/L+t1X1JfDGey+HXB
         LriQ==
X-Gm-Message-State: AOAM532Uc2ZJyXc1sWbmpqk8HU4WN7KSB1la7dKe0ZWccYyMdmXgS4wE
        pR1HyRASpbfDrKVOORA0QF/ileC7mHP8vIaw9XX5xQ==
X-Google-Smtp-Source: ABdhPJxk5/IDh9YndGD6zVOKlgna3zc1IsQMRPKkgMnVoVbcwa8mbzwGedraAr6tDfvEQflyyxrdbiGSJWLAMqa04+0=
X-Received: by 2002:a17:906:8245:: with SMTP id f5mr8644133ejx.264.1601571265618;
 Thu, 01 Oct 2020 09:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106110513.30709.4303239334850606031.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e3b7c947-c221-8be7-41ae-aed2f481d640@redhat.com>
In-Reply-To: <e3b7c947-c221-8be7-41ae-aed2f481d640@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 1 Oct 2020 09:54:13 -0700
Message-ID: <CAPcyv4io6a7qaX+oa8uL9C0nc9J9UMx0CfC5E1DYdhSPvYVeOw@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] device-dax: make pgmap optional for instance creation
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jia He <justin.he@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:41 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.09.20 21:11, Dan Williams wrote:
> > The passed in dev_pagemap is only required in the pmem case as the
> > libnvdimm core may have reserved a vmem_altmap for dev_memremap_pages() to
> > place the memmap in pmem directly.  In the hmem case there is no agent
> > reserving an altmap so it can all be handled by a core internal default.
> >
> > Pass the resource range via a new @range property of 'struct
> > dev_dax_data'.
> >
> > Link: https://lkml.kernel.org/r/159643099958.4062302.10379230791041872886.stgit@dwillia2-desk3.amr.corp.intel.com
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Brice Goglin <Brice.Goglin@inria.fr>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jia He <justin.he@arm.com>
> > Cc: Joao Martins <joao.m.martins@oracle.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c              |   29 +++++++++++++++--------------
> >  drivers/dax/bus.h              |    2 ++
> >  drivers/dax/dax-private.h      |    9 ++++++++-
> >  drivers/dax/device.c           |   28 +++++++++++++++++++---------
> >  drivers/dax/hmem/hmem.c        |    8 ++++----
> >  drivers/dax/kmem.c             |   12 ++++++------
> >  drivers/dax/pmem/core.c        |    4 ++++
> >  tools/testing/nvdimm/dax-dev.c |    8 ++++----
> >  8 files changed, 62 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index dffa4655e128..96bd64ba95a5 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -271,7 +271,7 @@ static ssize_t size_show(struct device *dev,
> >               struct device_attribute *attr, char *buf)
> >  {
> >       struct dev_dax *dev_dax = to_dev_dax(dev);
> > -     unsigned long long size = resource_size(&dev_dax->region->res);
> > +     unsigned long long size = range_len(&dev_dax->range);
> >
> >       return sprintf(buf, "%llu\n", size);
> >  }
> > @@ -293,19 +293,12 @@ static ssize_t target_node_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(target_node);
> >
> > -static unsigned long long dev_dax_resource(struct dev_dax *dev_dax)
> > -{
> > -     struct dax_region *dax_region = dev_dax->region;
> > -
> > -     return dax_region->res.start;
> > -}
> > -
> >  static ssize_t resource_show(struct device *dev,
> >               struct device_attribute *attr, char *buf)
> >  {
> >       struct dev_dax *dev_dax = to_dev_dax(dev);
> >
> > -     return sprintf(buf, "%#llx\n", dev_dax_resource(dev_dax));
> > +     return sprintf(buf, "%#llx\n", dev_dax->range.start);
> >  }
> >  static DEVICE_ATTR(resource, 0400, resource_show, NULL);
> >
> > @@ -376,6 +369,7 @@ static void dev_dax_release(struct device *dev)
> >
> >       dax_region_put(dax_region);
> >       put_dax(dax_dev);
> > +     kfree(dev_dax->pgmap);
> >       kfree(dev_dax);
> >  }
> >
> > @@ -412,7 +406,12 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> >       if (!dev_dax)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     memcpy(&dev_dax->pgmap, data->pgmap, sizeof(struct dev_pagemap));
> > +     if (data->pgmap) {
> > +             dev_dax->pgmap = kmemdup(data->pgmap,
> > +                             sizeof(struct dev_pagemap), GFP_KERNEL);
> > +             if (!dev_dax->pgmap)
> > +                     goto err_pgmap;
> > +     }
> >
> >       /*
> >        * No 'host' or dax_operations since there is no access to this
> > @@ -421,18 +420,19 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> >       dax_dev = alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);
> >       if (IS_ERR(dax_dev)) {
> >               rc = PTR_ERR(dax_dev);
> > -             goto err;
> > +             goto err_alloc_dax;
> >       }
> >
> >       /* a device_dax instance is dead while the driver is not attached */
> >       kill_dax(dax_dev);
> >
> > -     /* from here on we're committed to teardown via dax_dev_release() */
> > +     /* from here on we're committed to teardown via dev_dax_release() */
> >       dev = &dev_dax->dev;
> >       device_initialize(dev);
> >
> >       dev_dax->dax_dev = dax_dev;
> >       dev_dax->region = dax_region;
> > +     dev_dax->range = data->range;
> >       dev_dax->target_node = dax_region->target_node;
> >       kref_get(&dax_region->kref);
> >
> > @@ -458,8 +458,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> >               return ERR_PTR(rc);
> >
> >       return dev_dax;
> > -
> > - err:
> > +err_alloc_dax:
> > +     kfree(dev_dax->pgmap);
> > +err_pgmap:
> >       kfree(dev_dax);
> >
> >       return ERR_PTR(rc);
> > diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> > index 299c2e7fac09..4aeb36da83a4 100644
> > --- a/drivers/dax/bus.h
> > +++ b/drivers/dax/bus.h
> > @@ -3,6 +3,7 @@
> >  #ifndef __DAX_BUS_H__
> >  #define __DAX_BUS_H__
> >  #include <linux/device.h>
> > +#include <linux/range.h>
> >
> >  struct dev_dax;
> >  struct resource;
> > @@ -21,6 +22,7 @@ struct dev_dax_data {
> >       struct dax_region *dax_region;
> >       struct dev_pagemap *pgmap;
> >       enum dev_dax_subsys subsys;
> > +     struct range range;
> >       int id;
> >  };
> >
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 8a4c40ccd2ef..6779f683671d 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -41,6 +41,7 @@ struct dax_region {
> >   * @target_node: effective numa node if dev_dax memory range is onlined
> >   * @dev - device core
> >   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> > + * @range: resource range for the instance
> >   * @dax_mem_res: physical address range of hotadded DAX memory
> >   * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
> >   */
> > @@ -49,10 +50,16 @@ struct dev_dax {
> >       struct dax_device *dax_dev;
> >       int target_node;
> >       struct device dev;
> > -     struct dev_pagemap pgmap;
> > +     struct dev_pagemap *pgmap;
> > +     struct range range;
> >       struct resource *dax_kmem_res;
> >  };
> >
> > +static inline u64 range_len(struct range *range)
> > +{
> > +     return range->end - range->start + 1;
> > +}
>
> include/linux/range.h seems to have this function - why is this here needed?

It's there because I add it later in this series. I waited until
"mm/memremap_pages: convert to 'struct range'" to make it global as
that's the first kernel-wide visible usage of it.
