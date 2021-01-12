Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9262F3CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437580AbhALVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436953AbhALUa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:30:29 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:29:49 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a13so1550807qvv.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpVWwEPUmolljz0bygjZEnHC+kQY90YrQfm8bas35/A=;
        b=ZqQdSWXFn78oCcz2KV8xPQb/CHeriM/t6XdeHAXl1kQ4+L8e/qR1NGczyGd3R3Bwyi
         9EHz54uNMI3JmuBvRKrRakJ3b/872Qg5FcN3akkPTEbUhn0UM0R6hEz5mt4sUXmxfnIb
         +2UeLZiJy6CTbsdGdlcV1rtBzFHjf09ZCKM9mOcoHeJyWX74H9n8Tysgs2xCIRApPCF4
         nfVWVyzKeAYocOGxP+wtA7+ucMHZ1CZ8JhvUxQnI/VAvNjDMAdMKtS9SIMXXzP+rByL9
         3DGwsTlgE91BMPPlS/ZK1rbWXwXSH4T2KTT4oJ4vPc8X0gnB14fgOF1UIWY97mMsPv1n
         jwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpVWwEPUmolljz0bygjZEnHC+kQY90YrQfm8bas35/A=;
        b=tLJ2z1aNW/ip+eWoKE5qB4XtiFHeQXv0dPacVjJDpcsll5eiWoITzlrtPurpIlMqSW
         dl70SxqgAhsDv4wVyxYatFja4GpM6/tVheGOMAvUulyK3SN5mJzqKqWBFg1cxCplH1UA
         cC0okOV3BaOrVtRmnPiu7N0GHx2V+fFe3pqRQbUGCo23eijugUv6wenlloaa8rKuAGnD
         JRtc4STktFijIxzYeOI+rqH0/pJm9C+Bjgbcc8berMKFFEVd8GcL3s7FtgTzZiMR/egy
         R/ydJehSpAQ++eVIHsf+IJ80CwaYAQkaBcuBnZt4/TdwR8SCC1pQTv6phyBMe4QdCiD5
         sI6Q==
X-Gm-Message-State: AOAM531mvhy9CqPA0myRYYaxUXlzV5bcoP0PwUWRasiy5z8I2uuh/d77
        VoA9RqJMDQSYmoqYzeVbJWeHbZKaoyUyxrOjX64=
X-Google-Smtp-Source: ABdhPJzzNhvbzPuZ+g8DPiRoyU2S3Jx0eslstzY3LMxX8uPmaKtgx3akxR8UHh8ZXD5kye0yZ/rgJu7U9xupBM3WwpU=
X-Received: by 2002:a0c:cc12:: with SMTP id r18mr845366qvk.51.1610483388234;
 Tue, 12 Jan 2021 12:29:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com> <20210107130319.GA2986@willie-the-truck>
 <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
In-Reply-To: <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
From:   Ajay Kumar <ajaykumar.rs1989@gmail.com>
Date:   Wed, 13 Jan 2021 01:59:37 +0530
Message-ID: <CADe9J7Er0wnP5ZZbWM1CkUx7ry0znKr05Lvx7PEMdHuwKr_RZQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Ajay Kumar <ajaykumar.rs@samsung.com>, mark.rutland@arm.com,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-07 13:03, Will Deacon wrote:
> > On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
> >> When PCI function drivers(ex:pci-endpoint-test) are probed for already
> >> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
> >> then we encounter a situation where the function driver tries to attach
> >> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
> >> an already initialized STE. This causes ste_live BUG_ON() in the driver.
>
> Note that this is actually expected behaviour, since Stream ID aliasing
> has remained officially not supported until a sufficiently compelling
> reason to do so appears. I always thought the most likely scenario would
> be a legacy PCI bridge with multiple devices behind it, but even that
> seems increasingly improbable for a modern SMMUv3-based system to ever see.
Thanks to Will and Robin for reviewing this. I am pretty new to PCI,
sorry about that.
I assumed that the support for stream-id alias is already handled as
part of this patch:
https://www.spinics.net/lists/arm-kernel/msg626087.html
which prevents STE re-initialization. But, what I do not understand is
why the path
taken by the arm-smmu-v3 driver misses the aforementioned check for my usecase.

> > I don't understand why the endpoint is using the same stream ID as the root
> > complex in this case. Why is that? Is the grouping logic not working
> > properly?
>
> It's not so much that it isn't working properly, it's more that it needs
> to be implemented at all ;)
The pci_endpoint_test picks up the same of_ DMA config node as the PCI RC
because they sit on the same PCI bus [via pci_dma_configure( )]
While in the arm-smmu-v3 driver, I can see that the pci_device_group( ) hands
over the same iommu group as the Root Complex to the newly added master
device (pci_endpoint_test in our case) because they share the same stream ID.
Shouldn't they?

> >> There is an already existing check in the driver to manage duplicated ids
> >> if duplicated ids are added in same master device, but there can be
> >> scenarios like above where we need to extend the check for other masters
> >> using the same stream-id.
> >>
> >> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
> >>   1 file changed, 33 insertions(+)
> >
> > It doesn't feel like the driver is the right place to fix this, as the same
> > issue could surely occur for other IOMMUs too, right? In which case, I think
> > we should avoid getting into the situation where different groups have
> > overlapping stream IDs.
>
> Yes, this patch does not represent the correct thing to do either way.
> The main reason that Stream ID aliasing hasn't been supported so far is
> that the required Stream ID to group lookup is rather awkward, and
> adding all of that complexity just for the sake of a rather unlikely
> possibility seemed dubious. However, PRI support has always had a more
> pressing need to implement almost the same thing (Stream ID to device),
> so once that lands we can finally get round to adding the rest of proper
> group support relatively easily.
I hope the support will be added soon. Also, can you point me to few drivers
which already handle this type of stream-ID aliasing?

Thanks,
Ajay Kumar
> ______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
