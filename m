Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42B2ED5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhAGRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbhAGRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:46:29 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E7C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:45:49 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q5so7503851ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpWY74vWVa1L8Raewx13V4/TopbXG6j16e2kYWK8TMo=;
        b=RjsCv0SB3G2nr2VhqjbT5oDz8W7DNBKHdnzTnNqkj1iJof0+bV7fP3DrwRkndy/u4k
         Ygt4ObgL6c6fDwINAZBbrt6q9Nyu03KM8Jtf+6CaIHJDQhHurg1bvBaIn5xYb5DYi3P3
         O7pPyZUh0Fpetb+g793rmuwtHVk+BC0HuhiVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpWY74vWVa1L8Raewx13V4/TopbXG6j16e2kYWK8TMo=;
        b=jgAqUdR4WR0mgFfXkmsXaaL1caw8m9h6lEBXTkaz05c480Xn7cPEgDOA3blwf/vnAr
         vbL2PJke5usVVG4lDDUItXUigd4xcesULHVnhq70BTs9s9Gxn2O+2jMFUHPzMl+cuGE5
         PcpH3lkgxaNoD+/sEzlsQOQz1S2MgRCBemuuWr1/zsMN7N8jj2c0ajHKYDtqI8QNzqte
         zhLKvB/W8iIdZdcHwCi+QnNGg/7mR42KvbJqPwz6/cnxRmDLvILihzTsa7LHkpIZbDZH
         7gGWleBgvpFHKd6tpMvwTwDP5dbulSOnWoxLjuZI+DBmrRRAXa83zEJoAPrukGBVam4n
         G2lw==
X-Gm-Message-State: AOAM531Tj/Gyfv4ROGD6ucZaFsCm/Y+LHz3bJJivYXNtePsq97mPbjss
        w+cpkwf18fer5nF6gKpujCQrKxUWseILwgTI
X-Google-Smtp-Source: ABdhPJyFrckwHeD6dLqWdz5ona/VOdUP3263FNQxb9QB51QvOg1d0r9SX/7/5CW4Ka0OzKjQAY0KwA==
X-Received: by 2002:a92:5a5a:: with SMTP id o87mr12317ilb.138.1610041548697;
        Thu, 07 Jan 2021 09:45:48 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id h2sm4504484ili.56.2021.01.07.09.45.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:45:48 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id u26so6980235iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:45:48 -0800 (PST)
X-Received: by 2002:a92:c206:: with SMTP id j6mr9799328ilo.189.1610041168940;
 Thu, 07 Jan 2021 09:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-3-tientzu@chromium.org>
 <20210106185241.GA109735@localhost.localdomain>
In-Reply-To: <20210106185241.GA109735@localhost.localdomain>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 8 Jan 2021 01:39:18 +0800
X-Gmail-Original-Message-ID: <CALiNf2-HDf6tFcvVgCttr-ta=88ZMH=OvB5XoryTPc6MNvwV+Q@mail.gmail.com>
Message-ID: <CALiNf2-HDf6tFcvVgCttr-ta=88ZMH=OvB5XoryTPc6MNvwV+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, will@kernel.org,
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
        linuxppc-dev@lists.ozlabs.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org, Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Konrad,

This change is intended to be non-arch specific. Any arch that lacks DMA access
control and has devices not behind an IOMMU can make use of it. Could you share
why you think this should be arch specific?

Thanks!
