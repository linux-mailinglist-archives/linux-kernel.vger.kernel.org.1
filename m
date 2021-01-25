Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D33021D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbhAYF2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbhAYF1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:27:52 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 21:27:11 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 2so5689375qvd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 21:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKTBOeeUx6wXeRV6P9Jfat4kGoUSJVEmxQdNQfrFvYE=;
        b=j695vV5wc3nWbcMyhTthhn8OdI8FeBU0NIYpfGjClWPlG3p0NydLWU3g8ZsUMYwpBb
         KW2JNRKyHSLj5NbF3zgv98LTNXR/FI39adb5P8g5Ov78xV8+1I3sJLAx/58VQjev1KK9
         XKN6U58W3kDgBuh9ixEWML+5uiYTRljv9/vcApapM+BuN0SafT8eT2cq36/M2Nhx4pOJ
         J+dP+esVrOb1dc6faQd7ITFMjpT86ScCGU+zUJalRsk7qImxfM17ctgNIbj4tyIuQypR
         1Iiztz5jbMamKVvZAj8X7V/REhVlSgRHspm0lD1mMncTqhuBLErXKvrpx0VXyNdgEZ0T
         x3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GKTBOeeUx6wXeRV6P9Jfat4kGoUSJVEmxQdNQfrFvYE=;
        b=ACpmy/YkPkdLEIGftf/EIk+poo2i+wIRMLTFYkS9RaHzVqxSdz24R1GKd5gOyyJZCj
         QZ3xnT4kHcJrVqh/ubxvPr6xvQTkdELDKBirWl4g6/ob+6Rp95HIaSQCzBc2sgLV2+Hh
         M9w09tC+Ey/R2JYGS3Qn8NVHC2Ode/+DPclNwpifgMCyTdLeNfJrFBrw2GDhkTh5mqAV
         FlB64X0l0zb5zYV7IO7/AUKg5qeO40NOgMLjL50rBglhzUJaE0jH5l/vZ/dtzcgzXylK
         lhKq9AREKWFb85dAA7PDSJZtMC4CgJXBCJYOP6wJrdPFM+JNE5prau6SJE8AmPYVLLXi
         FhBw==
X-Gm-Message-State: AOAM531CvSg38ConMWSIpc2ZMaeUM8RTSdgc3KFZajy8OeGcD1wwzVna
        xrBJ5N2CE/sG0MMIv4RU8kkBMA==
X-Google-Smtp-Source: ABdhPJx6twpOFiNUXkHrytF4tAaeP9jbL+fIEfsueCOWmVBETzURbZy1jFgpbjKAN/zJfi4NlaTIRA==
X-Received: by 2002:ad4:4e86:: with SMTP id dy6mr6025332qvb.4.1611552430534;
        Sun, 24 Jan 2021 21:27:10 -0800 (PST)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id x49sm10447908qth.95.2021.01.24.21.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 21:27:09 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Claire Chang <tientzu@chromium.org>
Cc:     heikki.krogerus@linux.intel.com, peterz@infradead.org,
        grant.likely@arm.com, paulus@samba.org,
        Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
        Joerg Roedel <joro@8bytes.org>, rafael.j.wysocki@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
        dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>, boris.ostrovsky@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jgross@suse.com, Nicolas Boichat <drinkcat@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>, rdunlap@infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org, xypron.glpk@gmx.de,
        Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <20210106185241.GA109735@localhost.localdomain>
 <CALiNf2-HDf6tFcvVgCttr-ta=88ZMH=OvB5XoryTPc6MNvwV+Q@mail.gmail.com>
 <20210107175740.GA16519@char.us.oracle.com>
 <aa5af7d1-779e-f0f6-e6ba-8040e603523f@gmail.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <a843a970-afec-6541-c54b-4bc2a3c4750a@jonmasters.org>
Date:   Mon, 25 Jan 2021 00:26:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aa5af7d1-779e-f0f6-e6ba-8040e603523f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 1:09 PM, Florian Fainelli wrote:
> On 1/7/21 9:57 AM, Konrad Rzeszutek Wilk wrote:
>> On Fri, Jan 08, 2021 at 01:39:18AM +0800, Claire Chang wrote:
>>> Hi Greg and Konrad,
>>>
>>> This change is intended to be non-arch specific. Any arch that lacks DMA access
>>> control and has devices not behind an IOMMU can make use of it. Could you share
>>> why you think this should be arch specific?
>>
>> The idea behind non-arch specific code is it to be generic. The devicetree
>> is specific to PowerPC, Sparc, and ARM, and not to x86 - hence it should
>> be in arch specific code.
> 
> In premise the same code could be used with an ACPI enabled system with
> an appropriate service to identify the restricted DMA regions and unlock
> them.
> 
> More than 1 architecture requiring this function (ARM and ARM64 are the
> two I can think of needing this immediately) sort of calls for making
> the code architecture agnostic since past 2, you need something that scales.
> 
> There is already code today under kernel/dma/contiguous.c that is only
> activated on a CONFIG_OF=y && CONFIG_OF_RESERVED_MEM=y system, this is
> no different.

<unrelated to these patches, which are useful for the case cited>

Just a note for history/archives that this approach would not be 
appropriate on general purpose Arm systems, such as SystemReady-ES 
edge/non-server platforms seeking to run general purpose distros. I want 
to have that in the record before someone at Arm (or NVidia, or a bunch 
of others that come to mind who have memory firewalls) gets an idea.

If you're working at an Arm vendor and come looking at this later 
thinking "wow, what a great idea!", please fix your hardware to have a 
real IOMMU/SMMU and real PCIe. You'll be pointed at this reply.

Jon.

-- 
Computer Architect
