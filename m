Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BFD281A20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbgJBRvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:51:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C5C0613D0;
        Fri,  2 Oct 2020 10:51:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j19so1316969pjl.4;
        Fri, 02 Oct 2020 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PnAopDPoMZi0dRcrP3NcJfF5hKVlLOzrzm1DdVKLhR0=;
        b=iR4dVeX6+D3IklROSom59UJ0jVN/HSI9HYBhftutQ7t/p9Sc93B6dsD2bggivEaekj
         mdROrHJ32eSroJ+v72lDTgS95D15OBGgLQ0tlMbZ5SwUHmiY9T82W2hULzi03LF3XS4l
         re6HEUDChFGGoPbUCHHBDTJ6qS4JrZpd4k3KXJz7pT+CMEDI2kqlx92vtXXoBkG/OK/M
         18tVRTqtcSiTt/6rD9JfglugpC7jckj8Q/ZXmK33ZpnKSasV8z8EEPWsGxyyPOsRHYH6
         KnjClTRyFZo/0O50SDaqd7JsuP6JXk+sLbXIwYojiy3BNm+Y+Ig1EYYS8PcOsHgSJa/S
         YrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PnAopDPoMZi0dRcrP3NcJfF5hKVlLOzrzm1DdVKLhR0=;
        b=T0idHqPMjfJ9CuOprBAW0mwkZ2rKszM+sH8ePnEbxvr0zChxUO2e3KxsfUUK9rdDTT
         pIzQmzKwqX3IGdknwZGkivgTwxm3YrCQKhAQR7ZRafZ/Bt9YIkzSsMlvVLDGyLVk3GJB
         tvJccegJSbgCIH3s8QiecPEB78JwaVMyXnx/khex4UZqK7hQbPFAN2rzR16EqWcrrcAF
         8BJdKnAawLl5pFsadL9yBGr/95FDQP4PHoBhlo9/le8fuldnjjBHn6ENkFTpNn54Ockf
         u39di08u97KOEwOxffPA4XAesLYcWUBTn8qj7Ht2nzlzaY+EfBc2nKzZmINkU3czdgTb
         a4Ig==
X-Gm-Message-State: AOAM533VpzRWDEv5JPXZlF9sZFupjxjV1SXHDkPE4b0dplibAX6CSoDd
        cbb7nlpqp/un5M3enpaROkQ=
X-Google-Smtp-Source: ABdhPJwlv/hIGmASSyoKCV7NfPLJj/nUKPUI5UhUDO2/qVQbgPa0oKgv034ju05VtBMeh5p5Y/QqXA==
X-Received: by 2002:a17:90a:62c3:: with SMTP id k3mr3841487pjs.157.1601661091645;
        Fri, 02 Oct 2020 10:51:31 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x13sm2625375pfj.199.2020.10.02.10.51.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Oct 2020 10:51:31 -0700 (PDT)
Date:   Fri, 2 Oct 2020 10:45:32 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, vdumpa@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201002174532.GA29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-4-nicoleotsuka@gmail.com>
 <eba0d5ff-dfb2-7c17-50c2-5709c506f62e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eba0d5ff-dfb2-7c17-50c2-5709c506f62e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 05:35:24PM +0300, Dmitry Osipenko wrote:
> 02.10.2020 09:08, Nicolin Chen пишет:
> > @@ -865,7 +866,11 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
> >  	group->smmu = smmu;
> >  	group->soc = soc;
> >  
> > -	group->group = iommu_group_alloc();
> > +	if (dev_is_pci(dev))
> > +		group->group = pci_device_group(dev);
> > +	else
> > +		group->group = generic_device_group(dev);
> > +
> >  	if (IS_ERR(group->group)) {
> >  		devm_kfree(smmu->dev, group);
> >  		mutex_unlock(&smmu->lock);
> > @@ -1069,22 +1074,32 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
> >  	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
> >  
> >  	err = iommu_device_register(&smmu->iommu);
> > -	if (err) {
> > -		iommu_device_sysfs_remove(&smmu->iommu);
> > -		return ERR_PTR(err);
> > -	}
> > +	if (err)
> > +		goto err_sysfs;
> >  
> >  	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
> > -	if (err < 0) {
> > -		iommu_device_unregister(&smmu->iommu);
> > -		iommu_device_sysfs_remove(&smmu->iommu);
> > -		return ERR_PTR(err);
> > -	}
> > +	if (err < 0)
> > +		goto err_unregister;
> > +
> > +#ifdef CONFIG_PCI
> > +	err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
> > +	if (err < 0)
> > +		goto err_bus_set;
> > +#endif
> >  
> >  	if (IS_ENABLED(CONFIG_DEBUG_FS))
> >  		tegra_smmu_debugfs_init(smmu);
> >  
> >  	return smmu;
> > +
> > +err_bus_set: __maybe_unused;
> 
> __maybe_unused?

In order to mute a build warning when CONFIG_PCI=n...
