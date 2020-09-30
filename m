Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E487027E193
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgI3Gnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Gnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:43:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E8C061755;
        Tue, 29 Sep 2020 23:43:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so411405plt.9;
        Tue, 29 Sep 2020 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3+GU4zxm0Td/KM5SRNzPIJUthrCnvW7q6ZorJHiP25c=;
        b=akm+iSr6qnW70fDV3jaZfWWqU3vhS6CWumvkgTeR4+hpoVUb0TeAiyfFFvEkvbtzxQ
         zC1uH6jgIW84OTxKT7una4YVN8x6wz4G/sXdWo9hfFVQvxk4LO1WecENt87rFgQWIbk8
         H6VlRIPVbU+gNgkEBskDrRNbNdd2a8Nf2mlFx2MPnVsoHx3FRVu6x1YwRxM00WlZ+3tm
         GG3TaAO4baKb/luzBXlXkJdrM7FxNgItX4udQZeZMXqNdq536ikZ7sjO+iKUL6SsmAF1
         HqVN8uyev/WaKIM6BQu63zKW1781GcZyyP/5khDrckTMqCyQT0MxUVLI80zVGySFacnt
         l2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3+GU4zxm0Td/KM5SRNzPIJUthrCnvW7q6ZorJHiP25c=;
        b=QZGQaVSEdvlV9Q9zZNnmBAfWa/ecSFedFBzy2BCH5vFE1nPXEMFbBFkmWB+kNfLcNz
         JdeqIMdYpD+ZREN10IUPbEDa/KEg3PT7PxSiGdspR6HGZgkJaYPO0VI7Xm3hvQPxBfUa
         asr3rfzM1bEeveHOkOHL+goEVnS6QkFv7986cUXqxC7lHZZiMxgnr8ksVpRMe383Kofi
         BMn69fGbjVCmBRj7uH4kAG2zxJaugRR0N1eEXecBDLGyugF507tiAgJl/NPD8LL2EOud
         huYJPgP2HNCBNPTLRLAgDyw5cGaZJAR0gwr8wlSDCzJqB9FRPtCmcWQBEF80uZYfNZjV
         LxPw==
X-Gm-Message-State: AOAM533uMy6peR9B3Aenghx4QeJFiSdktFDcCopjdOSoGOxOiFrxGyo7
        wM+C2Kvah9X2U6MB0uM0Ipg=
X-Google-Smtp-Source: ABdhPJwysfEAZOo8P4hlopqTLpZc4kTN+he7jDU+vAlyRRSPVRDKHWaVI9riTckyYU663STgPg5MNQ==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr1179816pjb.116.1601448231098;
        Tue, 29 Sep 2020 23:43:51 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z9sm1023556pfk.118.2020.09.29.23.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Sep 2020 23:43:50 -0700 (PDT)
Date:   Tue, 29 Sep 2020 23:38:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
Message-ID: <20200930063820.GD16460@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
 <93803d8b-9863-e977-fa87-a03e877b095d@gmail.com>
 <20200930054455.GF31821@Asurada-Nvidia>
 <2f752179-5ad3-c000-8794-494c79f7b21f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f752179-5ad3-c000-8794-494c79f7b21f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:32:20AM +0300, Dmitry Osipenko wrote:
> 30.09.2020 08:44, Nicolin Chen пишет:
> > On Wed, Sep 30, 2020 at 08:12:10AM +0300, Dmitry Osipenko wrote:
> >> 30.09.2020 03:30, Nicolin Chen пишет:
> >> ...
> >>>  int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
> >>>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
> >>> +struct tegra_mc *tegra_get_memory_controller(void);
> >>>  
> >>>  #endif /* __SOC_TEGRA_MC_H__ */
> >>>
> >>
> >> This will conflict with the tegra20-devfreq driver, you should change it
> >> as well.
> > 
> > Will remove that in v3.
> > 
> > Thanks
> > 
> 
> Please also consider to add a resource-managed variant, similar to what
> I did here:
> 
> https://github.com/grate-driver/linux/commit/2105e7664063772d72fefe9696bdab0b688b9de2
> 
> I was going to use it in the next iteration of the memory interconnect
> series.
> 
> But now it also will be good if you could add the devm variant to yours
> SMMU patchset since you're already about to touch the tegra20-devfreq
> driver. I'll then rebase my patches on top of yours patch.

Just saw this reply. Yea, I think this'd be better. Thanks
