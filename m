Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4170827EB77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgI3OxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3OxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:53:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223AAC061755;
        Wed, 30 Sep 2020 07:53:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so2488656lfy.10;
        Wed, 30 Sep 2020 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cBiTt8w7J1gPwC7ywtmeoqJg6ORKtAlvgvECsQBVk8Y=;
        b=NlfsUy9vpCET0GRm9FHJO2K/tAdRODKdiVwSRuXxY9aIjSk+P8E07sDuQVrncTqOnk
         yLjQa9f5zZJW2Nk4T5FeI3xtvXvJ7rQIcZomW13YTDrlbCI7+8bsuN7mZtjKZmTAGyYY
         /Q1FJt8d8rf6BEmJv4D80BLFeYGO/xAmZknESkR7Wcqxb+WN+o+/CNZWuuMaum+aCRrR
         QOslN4pcvCFOoqD1cAVMYMGaSSNRbqlVG2Y6+DD0IHlHzvxHGjkqVVFzf0DEER3fpn8U
         rfvtz8l/CGQ9/FprYEoB5e572iLGsyDWdUS0IIR3dbX5PpLjuS6JmWotz77EBJTnKwN5
         wR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cBiTt8w7J1gPwC7ywtmeoqJg6ORKtAlvgvECsQBVk8Y=;
        b=WUGSAqSd1aK6ZXC2c9mflWgu4Atx+Wvo01o/OZIYxMwo/5vFDHns4dy4QGQHJVXzoe
         ct3v1pv2+aci1J3ppla3KQJ/Vz6ufGtNa8ZlIKpeEAwJ+Rxo2lPL/jeBN5eUeUerK8Gl
         DBvMT9ibt/22beVsLCI50MHDdL4pCN8DGmz6wbe8jnt1oUPPrOQ28DohaTFq619ofFwD
         oTrFkol6TJF1dPZz+dDCzE6OOaIseBgXLWyQuJ2WJSKBnNr26ucZmbwzDBTPJvdVhDvY
         TG8UCDExFLgG1eHpOcUc3W8bYLMH13PeSlaZ67TptvoQDo+BOkadkKJrrMRn9h3VYAiQ
         AmgA==
X-Gm-Message-State: AOAM533Rs5s5CaaHMYX5uySNlvjntlLyFEM9RORHsj0plS8c690WVGYM
        uw9LVOqbNEw35MFZz28+B8/KF7nWP6E=
X-Google-Smtp-Source: ABdhPJxlcOW6WbGbdJT6g8UnmJSwMo6kLgrWGSydiTS1ApgR68IHgbXhqhZlSVyJZKmuJWr/2QUsYQ==
X-Received: by 2002:a05:6512:36cd:: with SMTP id e13mr1088472lfs.165.1601477601361;
        Wed, 30 Sep 2020 07:53:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id j3sm218964lfb.185.2020.09.30.07.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 07:53:20 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] iommu/tegra-smmu: Add PCI support
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org, krzk@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-4-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a308ee8-abf7-97e4-9814-2156ee56fe8b@gmail.com>
Date:   Wed, 30 Sep 2020 17:53:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930084258.25493-4-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> +#ifdef CONFIG_PCI
> +	if (!iommu_present(&pci_bus_type)) {


In the previous reply you said that you're borrowing this check from the
arm-smmu driver, but arm-smmu also has a similar check for
platform_bus_type, while Tegra SMMU driver doesn't have it. Hence I'm
objecting the necessity of having this check.

Please give a rationale for having this check in the code. And please
note that cargo cult isn't a rationale to me.
