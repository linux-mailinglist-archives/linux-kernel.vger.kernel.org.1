Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84272F294F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbhALH4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbhALH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:56:10 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA318C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:55:29 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e15so1017377qte.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7gLFMlxBCQENVWtNxS2npLHFlF1Oh0HPmJ2b4uXz4E=;
        b=Muj3J6AUcKeWXk2QVKpBxfCJmD1ZNU3ECoTrLMhnZ3l10BcmT1KWV3KJZVJiyjnmgp
         tXnYNLGybukalejR/JL4Ccq0hthA+yksiWl3Xj9n38DlJXhcHL4x7k7Hi60j74u9oC5X
         xVXg0JvakYs/Mgnk3DB5tWgDJ2Wm5qz5NT8oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7gLFMlxBCQENVWtNxS2npLHFlF1Oh0HPmJ2b4uXz4E=;
        b=LakH1Re7u16u1XGHpOzDSpsRb/UOlB04HTlKbJ6lO5L7k06CW65SN/xqI1ieV/qyaN
         ZvkopHLqYEs0RyDEbNAvgS6N5ZUFCIU0xn8cJToC6VT41sWkDu6S4zmS7owANMMtHqVc
         7lQmVu0/859vmh03FwJ7LCjjI9IpgdCP69N4/MhFIDP+OyXBMOmn+rRUE2MnWJWXlOEe
         cAD1cYHrIoo0n6/bfgHPqeHS4oUZhc2VV+5FFoVuVm/YZqPcKfenoGPmw//Cb/VCfz8G
         W0DrvF2wwUGK1gowL3gobVi0+k3DXzm15+SxwgnV+RLI2Cv4ylAYsqVMmqSS9VQFP8V5
         lfIA==
X-Gm-Message-State: AOAM530tma8ba3fFS5xeb6ZoUrWrzJfmLhKU+2AY/7bbXkMdxVIDGTUf
        C2uQKqMZKLO4+zVce84E2GctW/CZrgKFZpdK
X-Google-Smtp-Source: ABdhPJyf0dKIDuXfeOX/A2mx1ErYVRAC4nx/jlfMjwhDmw1r0O8/HePbwWulvWUCZRREFTMyw1rogg==
X-Received: by 2002:aed:2d83:: with SMTP id i3mr3422782qtd.248.1610438127818;
        Mon, 11 Jan 2021 23:55:27 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id d25sm990574qkl.97.2021.01.11.23.55.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 23:55:27 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id h4so1153704qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:55:27 -0800 (PST)
X-Received: by 2002:a05:6638:c52:: with SMTP id g18mr3073726jal.84.1610437670186;
 Mon, 11 Jan 2021 23:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-6-tientzu@chromium.org>
 <20210106185757.GB109735@localhost.localdomain> <CALiNf2_dV13jbHqLt-r1eK+dtOcAKBGcWQCVMQn+eL6MuOrETQ@mail.gmail.com>
 <20210107180032.GB16519@char.us.oracle.com> <4cce7692-7184-9b25-70f2-b821065f3b25@gmail.com>
In-Reply-To: <4cce7692-7184-9b25-70f2-b821065f3b25@gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 12 Jan 2021 15:47:39 +0800
X-Gmail-Original-Message-ID: <CALiNf29Kqr1WP3BEjX-y5Xtife7AinqiXAcRD2g4eB9isTaXfQ@mail.gmail.com>
Message-ID: <CALiNf29Kqr1WP3BEjX-y5Xtife7AinqiXAcRD2g4eB9isTaXfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, will@kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
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

On Fri, Jan 8, 2021 at 2:15 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/7/21 10:00 AM, Konrad Rzeszutek Wilk wrote:
> >>>
> >>>
> >>>  - Nothing stops the physical device from bypassing the SWIOTLB buffer.
> >>>    That is if an errant device screwed up the length or DMA address, the
> >>>    SWIOTLB would gladly do what the device told it do?
> >>
> >> So the system needs to provide a way to lock down the memory access, e.g. MPU.
> >
> > OK! Would it be prudent to have this in the description above perhaps?
>
> Yes this is something that must be documented as a requirement for the
> restricted DMA pool users, otherwise attempting to do restricted DMA
> pool is no different than say, using a device private CMA region.
> Without the enforcement, this is just a best effort.

Will add in the next version.

> --
> Florian
