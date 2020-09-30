Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F827DFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgI3FKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3FKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:10:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E192C061755;
        Tue, 29 Sep 2020 22:10:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y11so563350lfl.5;
        Tue, 29 Sep 2020 22:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7RnkfJsbUh7g8qsHmACv/an5jdB38y9vYVUYMMT0u78=;
        b=BUhHy378W4exgOXZlV4eCaAU4SbYB7fpjBC3E/n9eviTkbV85pXEayvBbdfpsed3na
         1WX8w0QvYZdoWN8diheM4S6lo9mvzBHsoL7AtQEqEIqyR97gt1XBL8Mqj2TJVqmru6Br
         ngOM51RhA0HTZsqiSrJoluAyfUWQzxwU2YJKwSm8sxIvlTu5sA8JWUgmWYHBBOMmggMi
         IJcfMfLJw6Uaf1AmhAQ3Rpc2DPTPrZCugGDbPvzA7jE9SzRgPggfdPKgNfefp8seiAtQ
         AhGKMecbSPT+qcM6STPVW52YbLZMvfGi03edB2shNz/YulVehZaxZgBp62hsQVzpJCxg
         93Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7RnkfJsbUh7g8qsHmACv/an5jdB38y9vYVUYMMT0u78=;
        b=KnJr9fv5QH0cBPrGyuXI9OC5FBBRk3BITtF5EFyRCRpl4j/KgfG2FfMZPMzxn4Xxda
         5AVjfHiRCLJ8oisgg3eWVjWc9epvqdCVJb/2Xhn1ALura0lG5uWPwaXqMXlMEnZjBRom
         nMLXfXhaCXQjGypCnE+KBAU0lQFikh007WZTbZhds199EghKrt6remNtsoO0yZYMzeEz
         cJwS4Mn6HwVwNLVmwUL8cy/KjuaZKzQ/OdSUWb7UHDtOn+0G2FTafWJff4feO9iI53gB
         +1ejgXh8J8PRJKmnYcYHmiC6kcsddTQl9YuOG3ypHRpzDwUWSaLRNhGt2jngP9hbAJTB
         oqZA==
X-Gm-Message-State: AOAM533IoKkxzE2aBItQdPcNEAwlsCPHuMbA0N9LiBpA1r1/FbRmZcTz
        xUKR5Ayu5iLulJ6Vf9KdpEsZIvwKVyE=
X-Google-Smtp-Source: ABdhPJzrza9LR+W/N7Worn8hDU5s/IFqvxn2I9BcBC/SgGIU106E75sWouaottg9OJzsXQeoWV38Fg==
X-Received: by 2002:a05:6512:36cd:: with SMTP id e13mr257448lfs.165.1601442636882;
        Tue, 29 Sep 2020 22:10:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 78sm55706lfi.81.2020.09.29.22.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 22:10:36 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org, krzk@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a91f07c-bc27-7607-915c-e98a7a0c4b24@gmail.com>
Date:   Wed, 30 Sep 2020 08:10:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003013.31289-4-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.09.2020 03:30, Nicolin Chen пишет:
>  void tegra_smmu_remove(struct tegra_smmu *smmu)
>  {
> +	bus_set_iommu(&platform_bus_type, NULL);

Why only platform_bus? Is this really needed at all?

>  	iommu_device_unregister(&smmu->iommu);
>  	iommu_device_sysfs_remove(&smmu->iommu);

