Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC672815C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbgJBOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbgJBOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:50:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D5C0613E2;
        Fri,  2 Oct 2020 07:50:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b19so1401133lji.11;
        Fri, 02 Oct 2020 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=icdFDe/cdsShYJe56p6ssMuQsoQOC58YVV62WDTMBW0=;
        b=YUYEjVJXtGilO0I8BpRRXsmf/EUah8NX57KAzvzCVZWt4cW/TYEg6cXA6MeepCZqa1
         u7ArwvnsYG5IHazbc0HXlIRzqdMhLTSzQogC1xPoVqYONsYzIdv50SdeOARAqaSgqxCY
         Bynav+aQx+Ap1Ec+5VUTEgy22ZeTP2UKNaerL38fCN6owZ3/B/daCiGm8AYhvqo8ahAl
         lYmTCSeNUvUl06fQ/M6ehFLykpnGnCj+xlDd/0OPXO8BD7QVE4CGk0lB2YOlYVgb05vW
         uh5qxI0SpwVzr+pHGy+5BLCIb8NkLdlKsjVWYxrwPpwRKSaksBPIm0cCi1yCjMXrSJwh
         mcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=icdFDe/cdsShYJe56p6ssMuQsoQOC58YVV62WDTMBW0=;
        b=d1wWeeIBMglsL3Ij8jTCVAEmc9j/MTKGyLcmM5s87SsIveowaKkb8sYAnl7gY2seV6
         hefU4s7/Bqke5c8VnAkcH1NPOrB9Zx9k7jWiWYXDpxIQpPpVQSZQHDTIWCKsgVG7GYbw
         XUVN1dgD7DFTGaMJiznvJ4Rh7hlVG6bHOnQhhwGR+9dOtqcefBnOuJEwulU+jNeu+k7k
         o126KZHor+2Y5kv5s6D04jFTCnWuMIjcJLjC44gDJbT9OPPwNc7vB/d4NS4A3apM9S1Z
         RKO0hypg5MAKPMWcKg7ZB34NpICje4vdnBHB3Gd0zDJVrlsAPJ9qPDAc/7zKQNUgpNk+
         tl4w==
X-Gm-Message-State: AOAM5314HMI7+TUYkMnacRwTyEwZoSHOq+PgwzYy7p/7p1BqgEL/kek6
        7JYZ/wX1MlXfL+OnWtDQkHPyLJhXZIU=
X-Google-Smtp-Source: ABdhPJzk76ag8TT9nnz/AUf2dbIh1ndd+Rk83HU3cBelCn557Nxb5dCa1QoNUEh8XhIU/rPZ77bbaA==
X-Received: by 2002:a05:651c:1397:: with SMTP id k23mr907389ljb.263.1601650209915;
        Fri, 02 Oct 2020 07:50:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru. [109.252.91.252])
        by smtp.googlemail.com with ESMTPSA id u20sm326506lfo.156.2020.10.02.07.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 07:50:09 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
Message-ID: <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
Date:   Fri, 2 Oct 2020 17:50:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.10.2020 17:22, Dmitry Osipenko пишет:
>>  static int tegra_smmu_of_xlate(struct device *dev,
>>  			       struct of_phandle_args *args)
>>  {
>> +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
>> +	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
>>  	u32 id = args->args[0];
>>  
>> +	of_node_put(args->np);
>> +
>> +	if (!mc || !mc->smmu)
>> +		return -EPROBE_DEFER;
> platform_get_drvdata(NULL) will crash.
> 

Actually, platform_get_drvdata(NULL) can't happen. I overlooked this.
