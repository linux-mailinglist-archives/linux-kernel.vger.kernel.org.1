Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9959727F491
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgI3V4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgI3V4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:56:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54CC061755;
        Wed, 30 Sep 2020 14:56:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so2897310ljg.9;
        Wed, 30 Sep 2020 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4v1Rqtf8JVCwJCj2DIQWVh+hszuC1ak27UuWq627Tw=;
        b=TuQ/Jkj6MHCpiYxy2xBdJKJB2aGd4oWNFivqUaMBEVJuCFgOXZOqWY1NmlohAU9OMc
         ohMZNRJ95teLwYIXdEYfCHlzF4kQ798Qm6Jo+kgeYxGK50F21IkBGdyxAbP2/7/gSoAk
         dpC+sWK38lsiC6EUZU1GH/q2dBc0V/7OpmsAKG9EOgVHnGbQW4sIiVtaOb8J9/NcgENF
         wFhJM307doFqLOWoIz9aPDgSgpDKK5lxBYWSSY+2sHn+bPw9iWdAk/4fBNaIEIRGfAfA
         td/pUQ0Xi4XcbbErpqOdC9Ps3H1dXUBGS/q0cTOUC6RL/hhcqyJ0ZdkzFBUIcwq6cU6H
         sZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4v1Rqtf8JVCwJCj2DIQWVh+hszuC1ak27UuWq627Tw=;
        b=FPpdT7CcNF3JhEzuDh+CY+ffEK+NzH3+DKT0FrbecYqRGlZZizamgTawZES3KGo3TG
         TIdnj1W8aSzY6rJsqlAO29Zf2OeGrXkNsLxvRg+wGPfvRqqXNWdIVLjL6RJn7tsQ6DzT
         8xyPuzWbDH18hAEzk3W7c2rs6Zw2Zpt1XSRrtVnFSf+Ipep/T36MHIIn6LGd/BiuxLCd
         QOY1lUGYaEDhpJge7uObTLPfnu9HXBzGOOD9LQZyTRdxgg/8UOpktCIhMduKJEt3e2dr
         8Qn5QUjd4yq99AHginkLgZnBsXYKD2v1msZ02Scb2YMF50cupoD1rUmZhLQlsHQ4/WTG
         la3Q==
X-Gm-Message-State: AOAM530oTDi9xZ8EEl8IIHo+LG3fBnIZrAlQ2uJjhLM7vtXJKX+YiqFP
        /yYt1YlT1zBnn4lHIVQMfx26ImHj784=
X-Google-Smtp-Source: ABdhPJy71Zq7RRgjGwcTuu/+eYGrfcM5iZCBTgqk/k/1z1F09LrJXac+jA2l2r6FiHiLkyCbegyaNQ==
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr1599589ljm.200.1601503007550;
        Wed, 30 Sep 2020 14:56:47 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t23sm259746ljc.125.2020.09.30.14.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 14:56:47 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, joro@8bytes.org,
        krzk@kernel.org, vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo> <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
Date:   Thu, 1 Oct 2020 00:56:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930213244.GA10573@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.10.2020 00:32, Nicolin Chen пишет:
> On Thu, Oct 01, 2020 at 12:24:25AM +0300, Dmitry Osipenko wrote:
>> ...
>>>> It looks to me like the only reason why you need this new global API is
>>>> because PCI devices may not have a device tree node with a phandle to
>>>> the IOMMU. However, SMMU support for PCI will only be enabled if the
>>>> root complex has an iommus property, right? In that case, can't we
>>>> simply do something like this:
>>>>
>>>> 	if (dev_is_pci(dev))
>>>> 		np = find_host_bridge(dev)->of_node;
>>>> 	else
>>>> 		np = dev->of_node;
>>>>
>>>> ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
>>>> sure that exists.
>>>>
>>>> Once we have that we can still iterate over the iommus property and do
>>>> not need to rely on this global variable.
>>>
>>> I agree that it'd work. But I was hoping to simplify the code
>>> here if it's possible. Looks like we have an argument on this
>>> so I will choose to go with your suggestion above for now.
>>
>> This patch removed more lines than were added. If this will be opposite
>> for the Thierry's suggestion, then it's probably not a great suggestion.
> 
> Sorry, I don't quite understand this comments. Would you please
> elaborate what's this "it" being "not a great suggestion"?
> 

I meant that you should try to implement Thierry's solution, but if the
end result will be worse than the current patch, then you shouldn't make
a v4, but get back to this discussion in order to choose the best option
and make everyone agree on it.
