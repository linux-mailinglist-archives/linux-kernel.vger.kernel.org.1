Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8B2FA048
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404188AbhARMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404225AbhARMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:41:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:40:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a9so12864027wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUBLkn8FySf4zUY7MqtXXjbLm3L09Eo0TSDMqMBMKfM=;
        b=s+BO5FOhDlp/nvtnTNCkYC6pw9spNOEnIrmM8K3dL6rIqWMqrHTs4ctKLMPxUWh9bn
         V/XtJhkA7/T7NtgDrwnotnjn6IDm7cM3jHVSatn8EtA2s2bXb+SloN4taNrAVY/gCHKq
         53Imgctex7mIxH2wd4piVk7A9h1ryVXK/B385VKK7GeUPFCaPscNRS0aKmudUQpjzjKu
         QuPWa9k+leDRdYbTtL53a/O74tP8BaOZuCz8s1LKKjCIinLJ9CDexduuXltbfdf8a+Tc
         O3Vys75aAG+nHFnw52+45/6WJqkIiXlTLiyczkt7RSz4QAZ4xuRs5gf0fvtwKJ6pbuMG
         e/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUBLkn8FySf4zUY7MqtXXjbLm3L09Eo0TSDMqMBMKfM=;
        b=fwV2ALpWjnbsJ6ijUAJdDvmXCqawOkMrrcOedM0+jwhFgzM1KvF/BufMXZOFWqQ3Wi
         vhEP15+TvJkXbg8TBJIsoKFrTaxpPu8cUILHul7VqqMv39BGSmAUh5kJbc/xKdrW5g0i
         uIcIkvJvKk0RIiBlCU/orMKa6StA0CsorqT0lQMS8mpM1U5UCeIEJZI8YtpiWTq0XMaM
         Emq0tcAlDPMm10jV+3KK+Pv9xXWijR1qm5r0x3Ok5re1m4r1g5rMtHjFrcqdWhFcTeE9
         PILgNU4xUZs2yecqIROiK5yQxbwPT8pSaAIG5TLEsLK+9nN42uDb8bpo7/AMr/Wp/FEP
         3M2A==
X-Gm-Message-State: AOAM531MgIupTsgXKpbeCNtwI4qYkwE+2F30vFa82+BiONvIYn0H8b/V
        hGKs9NPsJXW/CkLU6cfSPe4GHQ==
X-Google-Smtp-Source: ABdhPJyTQTZCstJ7L8ysfkZ8fDJGZ+Lqupod6BQqyMC/JgHxJ1RmnMf/6HdQOfp86UHm3doCUXOy3Q==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr25320885wrq.47.1610973648680;
        Mon, 18 Jan 2021 04:40:48 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u5sm9394625wmg.9.2021.01.18.04.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 04:40:48 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:40:29 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
Message-ID: <YAWBvVPESMsRvacj@myrica>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
 <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com>
 <YAVeDOiKBEKZ2Tdq@myrica>
 <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:55:52AM +0000, John Garry wrote:
> On 18/01/2021 10:08, Jean-Philippe Brucker wrote:
> > > > Any idea why that's happening?  This fix seems ok but if we're expecting
> > > > allocation failures for the loaded magazine then we could easily get it
> > > > for cpu_rcaches too, and get a similar abort at runtime.
> > > It's not specifically that we expect them (allocation failures for the
> > > loaded magazine), rather we should make safe against it.
> > > 
> > > So could you be more specific in your concern for the cpu_rcache failure?
> > > cpu_rcache magazine assignment comes from this logic.
> > If this fails:
> > 
> > drivers/iommu/iova.c:847: rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> > 
> > then we'll get an Oops in __iova_rcache_get(). So if we're making the
> > module safer against magazine allocation failure, shouldn't we also
> > protect against cpu_rcaches allocation failure?
> 
> Ah, gotcha. So we have the WARN there, but that's not much use as this would
> still crash, as you say.
> 
> So maybe we can embed the cpu rcaches in iova_domain struct, to avoid the
> separate (failable) cpu rcache allocation.
> 
> Alternatively, we could add NULL checks __iova_rcache_get() et al for this
> allocation failure but that's not preferable as it's fastpath.
> 
> Finally so we could pass back an error code from init_iova_rcache() to its
> only caller, init_iova_domain(); but that has multiple callers and would
> need to be fixed up.
> 
> Not sure which is best or on other options.

I would have initially gone with option 2 which seems the simplest, but I
don't have a setup to measure that overhead

Thanks,
Jean
