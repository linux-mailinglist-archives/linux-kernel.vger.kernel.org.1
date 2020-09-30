Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44E727E0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgI3GBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3GBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:01:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E972C061755;
        Tue, 29 Sep 2020 23:01:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id q8so670132lfb.6;
        Tue, 29 Sep 2020 23:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZRiEJBWDysqXykX7LZJIMVz3EmdkbeX5DELEMvvroE=;
        b=jEL/fBpb5jUlSXs3zKi99e3d538DZXOvDY+2fRaejkHKoNwIsuKc3cyvVXr9Vw4yf7
         vcX964+N4Aibf0zlaYMx1lOUUZ0HSsO+2LlL8Uru3KMtYR1pfzTo5CbUd5IOYBNeTMAF
         JfoUkQOQl5L4MATHkwtBxRzzg6AAnBgL94WcM2N/JoxmgntavMT7RRwq0QsMGlhV8y1V
         HGApcAF8HmrHp1XQ2Q6Z6Uzvi1LogcisN0LOBd60Fbxh08GX44FDvixlO6o03/T+Ri5+
         p+oqU2n+ZzH2o5bWt95tjWGnvuN4ULR2p/5sqXwyPFBnWyDf8F17iAXlk1dCtOroOALl
         dZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZRiEJBWDysqXykX7LZJIMVz3EmdkbeX5DELEMvvroE=;
        b=cM08zhS5wMHtVG1Slfb8umelWGyLvV3hmkMfdABPHyqNeF78GRgnKJ9u1W4aOtJgZD
         3pv4dbjlsuyrGzU78Cc5TmbURAEJAGVSrj9GuE4K+I1fAMd5rikuFRBeVk/sM80C3e5l
         d6CXKqhn9grVW0sm9AuQjMoWLsnln2or3sGvfZu4iukpp2mShxufitM6AbkOzX0eQ9DU
         Paw9Lj2vXXRtMiPqFD0upqHygckFV/hkWCUDo3rg40oQRIvT1RTo/9Eh23xASw61osq0
         jWz1CXqjw1YbKeLSm7H9pkppFLnlVKrHMkjXLUSfrmX4m5jrdLZCF7xGGs4cgb0kP3J9
         P0Dg==
X-Gm-Message-State: AOAM533zTlfdznf3PRN+mFh99Evi0RLGRPHqrDdCuHhViq7O6Owwe7b7
        hUX/5UPU5plZVpwcqkSzMLu6uzSg9oc=
X-Google-Smtp-Source: ABdhPJyLJ0f8T4q/c6ARPYSGllUwWK9lma/QaD6GqKd7zu3KRujUgBTZhdD5fY+D0Zln64L58p4X7g==
X-Received: by 2002:a19:c154:: with SMTP id r81mr303719lff.424.1601445671172;
        Tue, 29 Sep 2020 23:01:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id m19sm57798lji.112.2020.09.29.23.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 23:01:10 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
 <5a91f07c-bc27-7607-915c-e98a7a0c4b24@gmail.com>
 <20200930053425.GC31821@Asurada-Nvidia>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <84f05ebd-1123-5dfb-94fe-62564a21706f@gmail.com>
Date:   Wed, 30 Sep 2020 09:01:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930053425.GC31821@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.09.2020 08:34, Nicolin Chen пишет:
> On Wed, Sep 30, 2020 at 08:10:35AM +0300, Dmitry Osipenko wrote:
>> 30.09.2020 03:30, Nicolin Chen пишет:
>>>  void tegra_smmu_remove(struct tegra_smmu *smmu)
>>>  {
>>> +	bus_set_iommu(&platform_bus_type, NULL);
>>
>> Why only platform_bus? Is this really needed at all?
> 
> I see qcom_iommu.c file set to NULL in remove(), Probably should
> have added pci_bus_type too though.
> 
> Or are you sure that there's no need at all?
> 

It wasn't here before this patch and platform_bus is unrelated to the
topic of this patch. But it probably should be there.

On the other hand, the tegra_smmu_remove() is unused and maybe it could
be better to get rid of this unused function at all.
