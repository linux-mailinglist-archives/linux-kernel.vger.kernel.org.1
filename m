Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5727E03F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgI3FYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI3FYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:24:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07301C061755;
        Tue, 29 Sep 2020 22:24:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so560590lfs.13;
        Tue, 29 Sep 2020 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ot3MZsmMh+in5tzB7tORReS9fh89HDHDYfyogfhhys4=;
        b=Uft+bpWGreE5DPXFYxtByJqubq9odg8n0wjA4K1m/WQRVFEAZziEgBjp2pkPluGZd0
         p5WZX5pFp3mkGHxXwAdEuMJJIh8yGUe00P+TAGakxz9zwDlz9LhoYNA4ASNvi8VdMQOc
         tXwX7STTrUZS1kBIEPcKNp0mEBErHNEI3cV6FXLPR7WvGWX9fCZpuGD+fhYCIp1e0aHZ
         B0B1bNpp8w9sHXT+W0ggaYguMdVvP4x2IQDqLJWzJYObFzoZqvD00o9J4w6cDzpQJSQH
         XnC3yMuhVDmrWcjRBqbomi6OMvn/IianJyAQCZujv42RMG0jV2L5vCJVPp20l+aKVm5b
         FlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ot3MZsmMh+in5tzB7tORReS9fh89HDHDYfyogfhhys4=;
        b=svAKGx4CbeQK+nemmYzTthfxi8y4MOpmT05hAizZS/UW8JicJVun/6LB1PLbvGoQNV
         mvgOuv3hv4rpRoJK2owg1+NJSuGb8mBxi4NdmSjUga4fyN2anyWmASIj7M7G0lvKTkOx
         vVwx2xjG3FnvVG+w/OhR39FQ9ujndWkUd3wBbKcrkgSX3K6u+DxcuI1M/Kc40vwpy+bO
         +XCHOwDkimpuPXPaqcdBPugvowlHgsASAFGZu2l6Ml6MFCT+8GDo+2JTpXgbksJ+rIVL
         BE24wxdf9SnEUNc/rj4x8WMGkffs1xAzFysA/b/hiXa4VzA1G/yL6/8M23xLPhTjnst7
         kk1g==
X-Gm-Message-State: AOAM532pwoPYI5fWZx+a3v8yHvKqafEI+7743qIZrVTj5zuawJVilPqS
        ctvex28N6fP8TTNsJr2Wz4JuhypLJps=
X-Google-Smtp-Source: ABdhPJwDBPWzwz3GwxdwEPu+VPyq/at1/Wupik0bBexVWeHa0Xn/PAezWYH+KNyBA/YTIf6gTYQB6w==
X-Received: by 2002:a19:c20b:: with SMTP id l11mr295703lfc.438.1601443443327;
        Tue, 29 Sep 2020 22:24:03 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id y25sm50423ljd.79.2020.09.29.22.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 22:24:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org, krzk@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <03710107-b6ad-5256-4550-09c610d0fded@gmail.com>
Date:   Wed, 30 Sep 2020 08:24:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003013.31289-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.09.2020 03:30, Nicolin Chen пишет:
> +	/*
> +	 * IOMMU core allows -ENODEV return to carry on. So bypass any call
> +	 * from bus_set_iommu() during tegra_smmu_probe(), as a device will
> +	 * call in again via of_iommu_configure when fwspec is prepared.
> +	 */
> +	if (!mc->smmu || !fwspec || fwspec->ops != &tegra_smmu_ops)
>  		return ERR_PTR(-ENODEV);

The !mc->smmu can't be true.
