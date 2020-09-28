Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FC27B7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgI1XOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgI1XNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC316C0613AB;
        Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so2194510pgl.2;
        Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCRYpdT7NGRtkVazdgtf6o3aGwT35lyfsAF6rcG5spo=;
        b=nLn/8LCzs7yTYeAM2DPkPN9MMDmgUbgRT/r6oGGCl5jgtytupzFVBrasvsFLiiQOOc
         HciVOoQ5GgquoUpsbblwGP3RhXwHcqJJgRI+tdm/NFHaoB84JLr1H9oszSSSC2qkcpyp
         5SBvQQAfSJs/BP2GTaE3H6riH1s+xZmIyjrifR7apIYjL4c4yRbHgVu9jj29FXDlDKS8
         mmtqhJVf6YiRxCQvs6l7x91ZBjY0bb7DJIYQbBmJYu9aHHV/zBc9Jehot2UzWT3LfTrm
         eTErYau3Gwg8tRiDucCstblmr5nVLCNj/QyCM9MojdffZOlEXXYK7chIJ8klLzw2be5H
         qPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCRYpdT7NGRtkVazdgtf6o3aGwT35lyfsAF6rcG5spo=;
        b=UhcBFTwcM8+VrCPX3qs2NlzHLqPgaiSnE2y08oFnsfQrpyCE9jbDwx1+sZaYfZNkL/
         Qg496iYE86xoWehb8//0x0sPFdKGu11K2LHN03aEBRBfP01egelAcc5JgPV7vzbKetX9
         8wEtU6s4Ndns93PXxrhKzccoVvTyMVIWhNMfq4xp4mkkDw2LCJSoQrYdx1DPQlZfbaYw
         KS6T8VMs64PxNgEvrP53iOC7x4E67FqSMRAof+sK5u0rRIr0Lls0tEjqNBDarQfGiATV
         WGELJgAG6XPJbxqL2dAInZENUiZB0iMFFGVkt4bkcnFAHP1DbrRyMCXHVHQkIu1PdWcb
         deqA==
X-Gm-Message-State: AOAM533TosCL6uSKWsFy7CmeHe24DMUBCwZZUBsjdOIzhojnMhDE/EoY
        A/wHXnZTjqTTDezwi3Vt7Go=
X-Google-Smtp-Source: ABdhPJzb7jOPaSs4Eb+q5ngvBKrHtOrxzcBCSLUk3NX2KbTSI4kOj+0aUPnEe/ZxWKipEjBtooz5zg==
X-Received: by 2002:a17:902:9047:b029:d2:8d1f:1629 with SMTP id w7-20020a1709029047b02900d28d1f1629mr1537691plz.44.1601332698344;
        Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id bj2sm2404418pjb.20.2020.09.28.15.38.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:33:01 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     joro@8bytes.org, krzk@kernel.org, vdumpa@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/tegra-smmu: Add PCI support
Message-ID: <20200928223301.GB4816@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-5-nicoleotsuka@gmail.com>
 <20200928075545.GG2837573@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928075545.GG2837573@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:55:45AM +0200, Thierry Reding wrote:
> On Sat, Sep 26, 2020 at 01:07:18AM -0700, Nicolin Chen wrote:
> > +#ifdef CONFIG_PCI
> > +	if (!iommu_present(&pci_bus_type)) {
> > +		pci_request_acs();
> > +		err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
> > +		if (err < 0) {
> > +			bus_set_iommu(&platform_bus_type, NULL);
> > +			iommu_device_unregister(&smmu->iommu);
> > +			iommu_device_sysfs_remove(&smmu->iommu);
> > +			return ERR_PTR(err);
> 
> It might be worth factoring out the cleanup code now that there are
> multiple failures from which we may need to clean up.

Will do.

> Also, it'd be great if somehow we could do this without the #ifdef,
> but I guess since we're using the pci_bus_type global variable directly,
> there isn't much we can do here?

Probably no -- both pci_bus_type and pci_request_acs seem to depend
on it.
