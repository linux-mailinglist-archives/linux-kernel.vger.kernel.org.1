Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718C82C4520
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgKYQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbgKYQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:26:00 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C07C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:26:00 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f27so1986421qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h5OiZu6vTvK6XWjc+RkVgvjVORaQjHWO8Ke4kDMuing=;
        b=cibaq2ZE0223rWmS9l3E8vhTt5nrAe+bT4Iqd2VUPAWWUh52VJj5Qnj9no7+2fPkSg
         ZnAaEvpRQpK9TYQBvwODG2owhPWA1udPCI0wDheOGLfoCp6SBHIZeBIvAeTXOB4cvpQC
         5xBeRlc6T64A0qV4ZmNYOc9INo+DVSbzRPvsUA6FC8NKiah4f9rwPcM79VFzT0CZdphV
         uBmyB+/Cj3YbGT0t+oYXel4jNPia7HJGK0F2ujRE24Ju3dkP4gn61e3dyZR91fpYX9G7
         UPawm9zER+hW6nC1m42IXtO/rqRbMjxs+5b8+dZIJ4AqE8PJ/yjbepgZMQHrovVl4rkM
         4y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h5OiZu6vTvK6XWjc+RkVgvjVORaQjHWO8Ke4kDMuing=;
        b=QpeE8YFfq80NyJVhigPhQ/uJfxl/+nc2EqFOw0g8cqaiu0JDA2oZx7O1NirUfJaj75
         pCsHJI5/XOhP+7xDCd4Y6l1rRaMyJPbi/b6ak10ZRzIffr48R+p/7QSI2QBGlAdOb64o
         KMyV1O3DsHVTW5grkeh3zh0ucwn8rKZGdr/MSnVKS56QFj3yWU4yhxBhAicJ0swv7DI+
         EB/xVA2M/IpdGrSrTQY6jIoaK8slBlwwTOh5sjSJzk2d5qDi28FoiCGa9t0FXuzh+ZXv
         PMZ96TLPT70SAtgoObXoHjkNSChJ86UcWGkk7iI9RILilbZBcbAohTRy68/CdgDnpfZu
         7Y+A==
X-Gm-Message-State: AOAM530gFSiPwC0jEKLeFhJOOESVizZIvNm+Zh/XzSgEx0z0YSpC/4qp
        TA5ryA3prKdOPYDUUNgKGHY=
X-Google-Smtp-Source: ABdhPJyZdMGnJBPHMk1TvP4dbDSPI58cBVyatSXb16RvjJtS8B1sGM6iwNLE1SPYu811OfQEHedgQA==
X-Received: by 2002:ac8:5c05:: with SMTP id i5mr3874253qti.34.1606321559878;
        Wed, 25 Nov 2020 08:25:59 -0800 (PST)
Received: from localhost.localdomain (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.208.110])
        by smtp.gmail.com with ESMTPSA id n41sm3132846qtb.18.2020.11.25.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:59 -0800 (PST)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Wed, 25 Nov 2020 11:25:56 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ning Sun <ning.sun@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        catalin.marinas@arm.com, kernel-team@android.com, x86@kernel.org,
        tboot-devel@lists.sourceforge.net,
        Adrian Huang <ahuang12@lenovo.com>,
        iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is
 forced on
Message-ID: <20201125162556.GA30183@localhost.localdomain>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
 <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
 <20201125154153.GA29929@localhost.localdomain>
 <20201125155130.GA16839@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125155130.GA16839@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:51:30PM +0000, Will Deacon wrote:
> Hi Konrad,
> 
> On Wed, Nov 25, 2020 at 10:41:53AM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 25, 2020 at 02:05:15PM +0000, Will Deacon wrote:
> > > On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> > > > After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> > > > domain"), swiotbl could also be used for direct memory access if IOMMU
> > > > is enabled but a device is configured to pass through the DMA translation.
> > > > Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> > > > if "iommu=pt" kernel parameter is used.
> > > 
> > > Applied to arm64 (for-next/iommu/fixes), thanks!
> > > 
> > > [1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
> > >       https://git.kernel.org/arm64/c/e2be2a833ab5
> > 
> > But tboot never ran on ARM. It is a Intel specifc.
> > 
> > I think either me or Thomas should take this patch.
> 
> FWIW, I did check with Thomas before I picked it up. I know it looks weird
> going via arm64, but that's only because I'm temporarily handling the IOMMU
> tree there (including vt-d changes) while Joerg is away. Since this fixes a
> vt-d regression, I thought I'd pick it up along with the other IOMMU fixes I
> have queued for -rc6.
> 

Aah, I missed the memo :-)

> That said, if you insist, then I can revert it. I'm really only trying to
> help here.

Nah. Enjoy picking up patches!

Thanks!
> 
> Will
