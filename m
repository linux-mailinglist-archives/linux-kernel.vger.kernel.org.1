Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84AE27F2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgI3UJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:09:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A78C061755;
        Wed, 30 Sep 2020 13:09:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gm14so424075pjb.2;
        Wed, 30 Sep 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mF6OBaV2Z1T8RbNcXXxjuhHlV5z+chFjrK3EuAVe1S8=;
        b=WMfd5xc6Ph1nthN0qdG7EhSNrzY9LYw5S+OUHOHhgFtZJNGp2pQCw8EmtS8P9yvkBw
         CpzKZQo9nwNWp5AGk0iByMUP5px/NhZ6r6c6nnk8GI+ndf/ieAHdqBvloSKRa3Bv7AZk
         gBhlPdnnUskp/hUCnpCHIASdSeY81XNcOgOLzmhBIbHtcaKZeqMzuTaFVafxC/e6T8d4
         bxpc0xnq1gDAwmw93cNgUpDOrCDE7AKyy9wcEvB6srPfBeB7erDn64vEUIjn3bzCwd+1
         o0YMsAlAFnM17TxLmwu2rC30iWU/tlaUQEm+GEbKqXM3/kO3NHh/VD8ysH8NKniHMdOY
         cbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mF6OBaV2Z1T8RbNcXXxjuhHlV5z+chFjrK3EuAVe1S8=;
        b=f2+Qrbw80ljp493wXCcdfxtAokkC5JjchNE82m1T+2gCxhZzLcUauh9lAAdBnj7Vte
         M/V8BNWYH+llJUC5tFB7Dc/JTKsuujskPzfZnV/g7SN6nkxH8zhijg4RN4YWjtlGFEEX
         f9VVwSLKy/1t66KIF3TTCaSJPwY2+C0p7CA9+ZygHChxksNJU9RsKlJ2RDGgXqpCCq3U
         /ymqqsivB8/WkgV7QwshG2NTktqeVdkxiarGZHkFRXHUrTmSXd4LuzO/HXDx0OsA61MF
         bfbunbLLt6AtzhhNGBdKXId8vSfJTKTKrH4cGx2EbovaWw/G1DlDqLXtCBdBQIf7sehj
         KDkA==
X-Gm-Message-State: AOAM532gCiRpI8kvVzVeXJy81VuI0sQ5eN1pMPo/YvDc8EZYjX4I3MMs
        0fn/e4IFiHO10kPUidT2PIDIhx5l5/A=
X-Google-Smtp-Source: ABdhPJzgWRMrpNTOiKpQZHAAZjzyGRR1vepTsaY3MKRWSEnOwicW3KYudNirETxFSWRE5W3Gctye9Q==
X-Received: by 2002:a17:90a:dc13:: with SMTP id i19mr4078281pjv.18.1601496548639;
        Wed, 30 Sep 2020 13:09:08 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v21sm3171041pjn.4.2020.09.30.13.09.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 13:09:08 -0700 (PDT)
Date:   Wed, 30 Sep 2020 13:03:31 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20200930200331.GB2110@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-4-nicoleotsuka@gmail.com>
 <0a308ee8-abf7-97e4-9814-2156ee56fe8b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a308ee8-abf7-97e4-9814-2156ee56fe8b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:53:20PM +0300, Dmitry Osipenko wrote:
> ...
> > +#ifdef CONFIG_PCI
> > +	if (!iommu_present(&pci_bus_type)) {
> 
> 
> In the previous reply you said that you're borrowing this check from the
> arm-smmu driver, but arm-smmu also has a similar check for
> platform_bus_type, while Tegra SMMU driver doesn't have it. Hence I'm
> objecting the necessity of having this check.
> 
> Please give a rationale for having this check in the code. And please
> note that cargo cult isn't a rationale to me.

Okay, okay....I will remove it upon testing.
