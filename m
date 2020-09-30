Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B265027E270
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgI3HRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:17:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EAC061755;
        Wed, 30 Sep 2020 00:17:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so515457pgf.12;
        Wed, 30 Sep 2020 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SATX+yBCLXXjqiez9Tnf9l7cIDz62fOgQbhS4ETQ5yQ=;
        b=uVAsy1IP7fkjUycX+Ge5M2rkDhVaWrw6jrYanW0tg5N6L/WPjZe7zqXCg6aCRS6Vko
         sJadbahrKxhzzQKrXczU0Egn+pdH4aE7Qh2NHwCM7gOBg2TgBEi6tzngrTDkkc/D0P2R
         AYewwzO1+AxcABTCvw3EGOmcQoLMqEeL0zrGGI6Yi2J1PEc6xumer+jum8cwcztq3ISJ
         4YrfyTzmNGZsJvR7lXFLmawc00eQUVs0cJhf9bwbiniv0RF21CYtCyeSl/Bmmo0zwygg
         y4X4vb+Xq50bBSLJEi67ALoAZew2RVCa3+08Uz3+KYCCVXePJ1lKY0bq5ae9SVmUBfxI
         CsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SATX+yBCLXXjqiez9Tnf9l7cIDz62fOgQbhS4ETQ5yQ=;
        b=CqyaMIXn9ey+gQ+H2ibTxxAriF5712dFfVYbBPuUBj+sU+fl2+RtcBx6oz44zDHRv1
         fqDPon6DiwkqLiCy0PtJ1K8sDoubNe86M0DoMoT/s9doXN7/7aw35P24cwOjHG6dkNoC
         /S1+rmc+0Xrek2ObeDBIIQTqYQjGNV6ojcRGtR1JZBA/tnxrefZhJDITzFuk2ShqDOoe
         OW2g81qkXJpBvW8ve5XJ53wmFh4BwauxGbEnrNSJAXRZiyO3BfUDnU3jKZHtidE6CKfr
         JX5Jccj6VQ48KkiBj/wPukCGP66kkohjDmSVPRH4eEKtvPIh0VivgI+dG7BaGDMyvpRB
         G3pQ==
X-Gm-Message-State: AOAM5331z3sfElMlx5cDyjJDOlCVLQAIkgE1flEmcqDkOY0AW0GWSzsI
        a7F9YMDCYlNLj3TRxQGJeeI=
X-Google-Smtp-Source: ABdhPJznBREyrIM8kWonCXk01Di+K4rbkU4w4E5kpyQV5G7rxm4yz+Ji8inYERq2GeDN2G0bJgxz4A==
X-Received: by 2002:a62:62c3:0:b029:151:223b:3ba0 with SMTP id w186-20020a6262c30000b0290151223b3ba0mr1157265pfb.28.1601450267941;
        Wed, 30 Sep 2020 00:17:47 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 9sm1088537pgx.76.2020.09.30.00.17.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 00:17:47 -0700 (PDT)
Date:   Wed, 30 Sep 2020 00:12:14 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20200930071213.GA13876@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
 <5a91f07c-bc27-7607-915c-e98a7a0c4b24@gmail.com>
 <20200930053425.GC31821@Asurada-Nvidia>
 <84f05ebd-1123-5dfb-94fe-62564a21706f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84f05ebd-1123-5dfb-94fe-62564a21706f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:01:09AM +0300, Dmitry Osipenko wrote:
> 30.09.2020 08:34, Nicolin Chen пишет:
> > On Wed, Sep 30, 2020 at 08:10:35AM +0300, Dmitry Osipenko wrote:
> >> 30.09.2020 03:30, Nicolin Chen пишет:
> >>>  void tegra_smmu_remove(struct tegra_smmu *smmu)
> >>>  {
> >>> +	bus_set_iommu(&platform_bus_type, NULL);
> >>
> >> Why only platform_bus? Is this really needed at all?
> > 
> > I see qcom_iommu.c file set to NULL in remove(), Probably should
> > have added pci_bus_type too though.
> > 
> > Or are you sure that there's no need at all?
> > 
> 
> It wasn't here before this patch and platform_bus is unrelated to the
> topic of this patch. But it probably should be there.
> 
> On the other hand, the tegra_smmu_remove() is unused and maybe it could
> be better to get rid of this unused function at all.

I will drop this line then, since no one is calling it. And maybe
we can submit a clean up patch later.
