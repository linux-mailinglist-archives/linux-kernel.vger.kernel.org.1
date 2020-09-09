Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B900262EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgIIMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgIIMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:37:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F948C06179F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:28:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so2157417wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bzjsTr5kC67DEeYAVhxYZ6Zkc76tWoGyMm9YFgDJ7W0=;
        b=HwTdDD0X+rwiiQin2TkIDpkh88a6lCE3QyKtyAXwZ7m5ea9XJb2s3LW9La77utJeSH
         2rHKjyEKnpu1cPngR2Mhz8dj1WrmtauSu+Go5Q+W8lc+CrXcet4klBHOksn8s80CDenh
         Ee7WY//OYs1C+EQY/3R+w9TvjZMTe1gtKHFmsbEtfD0Vq6ZXovL+hL45uNHtHBi/ncXt
         zbhR+e5qdg4fbdG8zAvUb6eFYgO/oyIkQYmcQepgmJtlDLXNTOk56Kj4i0JwyZxpiyQM
         MNGlMihmMH+p617vfGrFkMmPple0coJuyLpUYbA7b7nT/XGH7AskRatDFA3mG897nrWx
         lvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bzjsTr5kC67DEeYAVhxYZ6Zkc76tWoGyMm9YFgDJ7W0=;
        b=m9y7z5IlaVgghah4bjQmSfR2i+ip0/nOGi7kiWMi/UbyomZOBIo61UY9DSMZCWkJC+
         PC/dgjtH7zq7ipS4pdUmuqdSqty2jIe8v3nA6C0Nj6ehn66TYVF2m5Ih1WTOowpyUhsd
         AmLsErYrdTgib3DPqexvz0BJ51N+eIIongdT/aj+OpUmJpTGyQWw8kxPmMDFwkzrPWim
         c8u1tmBM+nsIM15NrbZmTCle91l3DltGsV8/xOF69jHNwBkfqqyYQD3/PCih+vqG78mG
         7rorBASBa+ZVFoDpdYHvRQZ7rsWLDjwoiqZVl+ZutpcMdXk05bOAKcf2a3S1UHkaTYw0
         wqBw==
X-Gm-Message-State: AOAM530rks0PrS035Wg8YR3mX6wta84TcR8/iXmStNp1n1pm3M3aq1iD
        QSwPmP+2PtnlP/HFVWPLAq0Q7g==
X-Google-Smtp-Source: ABdhPJxuUnuBWGaJoZ859QwCIJF5VXyQRPPa5JNmtgVgaf5Zy7CIIa+C1x/2AMNOyjn9IVz476/onA==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr3331056wma.158.1599654479560;
        Wed, 09 Sep 2020 05:27:59 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id l19sm3726548wmi.8.2020.09.09.05.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:27:58 -0700 (PDT)
Subject: Re: [PATCH 1/5] iommu/io-pgtable-arm: Add BROKEN_NS quirk to disable
 shareability on ARM LPAE
To:     Steven Price <steven.price@arm.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-2-narmstrong@baylibre.com>
 <f8ec460a-d61f-852d-2620-a49306bb1de4@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <b6886f02-d2a0-22cc-8419-e964656e4967@baylibre.com>
Date:   Wed, 9 Sep 2020 14:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f8ec460a-d61f-852d-2620-a49306bb1de4@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2020 14:23, Steven Price wrote:
> Subject: s/BROKEN_NS/BROKEN_SH/

Thanks,
Neil

> 
> Steve
> 
> On 08/09/2020 16:18, Neil Armstrong wrote:
>> The coherency integration of the IOMMU in the Mali-G52 found in the Amlogic G12B SoCs
>> is broken and leads to constant and random faults from the IOMMU.
>>
>> Disabling shareability completely fixes the issue.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 7 ++++---
>>   include/linux/io-pgtable.h     | 4 ++++
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index dc7bcf858b6d..d2d48dc86556 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -440,7 +440,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>                   << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>       }
>>   -    if (prot & IOMMU_CACHE)
>> +    if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_BROKEN_SH)
>> +        pte |= ARM_LPAE_PTE_SH_NS;
>> +    else if (prot & IOMMU_CACHE)
>>           pte |= ARM_LPAE_PTE_SH_IS;
>>       else
>>           pte |= ARM_LPAE_PTE_SH_OS;
>> @@ -1005,8 +1007,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>>   {
>>       struct arm_lpae_io_pgtable *data;
>>   -    /* No quirks for Mali (hopefully) */
>> -    if (cfg->quirks)
>> +    if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_BROKEN_SH))
>>           return NULL;
>>         if (cfg->ias > 48 || cfg->oas > 40)
>> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
>> index 23285ba645db..efb9c8f20909 100644
>> --- a/include/linux/io-pgtable.h
>> +++ b/include/linux/io-pgtable.h
>> @@ -86,6 +86,9 @@ struct io_pgtable_cfg {
>>        *
>>        * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
>>        *    for use in the upper half of a split address space.
>> +     *
>> +     * IO_PGTABLE_QUIRK_ARM_BROKEN_SH: (ARM LPAE format) Disables shareability
>> +     *    when coherency integration is broken.
>>        */
>>       #define IO_PGTABLE_QUIRK_ARM_NS        BIT(0)
>>       #define IO_PGTABLE_QUIRK_NO_PERMS    BIT(1)
>> @@ -93,6 +96,7 @@ struct io_pgtable_cfg {
>>       #define IO_PGTABLE_QUIRK_ARM_MTK_EXT    BIT(3)
>>       #define IO_PGTABLE_QUIRK_NON_STRICT    BIT(4)
>>       #define IO_PGTABLE_QUIRK_ARM_TTBR1    BIT(5)
>> +    #define IO_PGTABLE_QUIRK_ARM_BROKEN_SH    BIT(6)
>>       unsigned long            quirks;
>>       unsigned long            pgsize_bitmap;
>>       unsigned int            ias;
>>
> 

