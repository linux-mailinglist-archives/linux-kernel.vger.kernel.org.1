Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230832814F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgJBOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:22:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE5C0613D0;
        Fri,  2 Oct 2020 07:22:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y11so2079132lfl.5;
        Fri, 02 Oct 2020 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8PpHqO+OTs0E0egHq3QrOMDpgYOfO6HQTLXz2o3ta2Y=;
        b=Na/t7KEirUUI/kEktEVwqr6PJ1OPUtBlWi1T6fDHlbeuagh7zkbMYg2gBAEbHR066D
         2wLzUfdHaxkh1qZYZUeHXhX5zd+B1Bn5YFk82T/bzDTOm2LPUh4ejZvOiGB/T1onl+Vg
         Ay0tUiebdAgCO9IQ3fYzICBDXecxFODJ5NybRf8v6KiASsjGrZ88JTGblZMYC7xPX1iU
         O0utZmj3tnpjuIiZX6YeJ/gZGfN8rMehTnLqKK1G8NdUaZrBjUShcnIeeDn8KRpw283g
         dHVGF+fiWdsQBGjPx0gIW6I9nCe99S7k98t/VEhaq0cI/urkP4xMFNl2WNoGew0jVN32
         zWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8PpHqO+OTs0E0egHq3QrOMDpgYOfO6HQTLXz2o3ta2Y=;
        b=if8FGjj4kQOU9lmVOEU1Re+wnmJR/8huKaJuPVrZqGsDjrmVdnSR3Ca2jWb3hnBjL9
         m+12WShg39A6RCQq2vJJTVzsVq6GqhYaFqN1ehUqJbxE5BqGLtWFri1YGuu+EvP9JZu6
         uaMi767QMRYPn08YYzCM1T04g7wW+T0L8PHpjleKDRqNS/uiUkq+2Z/z/wUKlvs+XOIu
         r5MkAJ5tVv7LD6QS7xQOxo8hPsUpp0y3hrwCn33+3PfUcPcSIEp9hxg17kdD2QZpiUIb
         13OV7tqWAARUXZs8yXRqXdDJk78nZ+f+SOPIwlmEO1bHy9KEU19h5HubnWX83cQfqSbu
         P/vA==
X-Gm-Message-State: AOAM531zqNLFg94eCTaEpuLzkTEiHosZK7mlXKteMzrXlF0Li4KUSD/G
        70B05WkTJaljUMLP7z7Fo5Ki0xCxfvU=
X-Google-Smtp-Source: ABdhPJzROLRfb/tKFALlhopua1rVZr0C+e1zGBUzkVUxywn6lViZMGoxABsTqgJnKBejrlcFzN8QDg==
X-Received: by 2002:a19:84ca:: with SMTP id g193mr960092lfd.85.1601648562338;
        Fri, 02 Oct 2020 07:22:42 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru. [109.252.91.252])
        by smtp.googlemail.com with ESMTPSA id k21sm251450ljb.43.2020.10.02.07.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 07:22:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
Date:   Fri, 2 Oct 2020 17:22:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.10.2020 09:08, Nicolin Chen пишет:
>  static int tegra_smmu_of_xlate(struct device *dev,
>  			       struct of_phandle_args *args)
>  {
> +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
> +	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
>  	u32 id = args->args[0];
>  
> +	of_node_put(args->np);
> +
> +	if (!mc || !mc->smmu)
> +		return -EPROBE_DEFER;

platform_get_drvdata(NULL) will crash.

> +	dev_iommu_priv_set(dev, mc->smmu);

I think put_device(mc->dev) is missed here, doesn't it?

Why sun50i-iommu driver doesn't have this error-checking? Is it really
needed at all?
