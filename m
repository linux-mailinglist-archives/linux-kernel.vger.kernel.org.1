Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CDF2EC0E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbhAFQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:14:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726919AbhAFQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609949578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MJwMIALmYdGDT3QzvGXrA2eWBMG09d0S+iP+E+HlFI=;
        b=KKgmyd9wj9HexBmSFYvpCckisXqo9cWuAs7ish88uGEhPD3q0MEJ9PMV+kH58UeaXFtyvP
        0B1afRDV4EiRX0AB/UWyotPp9lWtpJ1csei6fV2W6HTs2AxASbj/E7MTFv1iqe/UtIJMz3
        hDfM7UJ+ElqgHLjqrcAEBANSfRjg68s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-vS3DMgieN4iOMf0WqBiptw-1; Wed, 06 Jan 2021 11:12:57 -0500
X-MC-Unique: vS3DMgieN4iOMf0WqBiptw-1
Received: by mail-ed1-f70.google.com with SMTP id cq17so2080920edb.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 08:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/MJwMIALmYdGDT3QzvGXrA2eWBMG09d0S+iP+E+HlFI=;
        b=sWsD4Y13lYdaXY+DhF2GDGQvPZc98eHKDlqDNFJ4wsBe/zYnIg4Y3NZk6m2U6j1tH2
         xGAeg42sqqUC+maUCXaE7zqwLz07Q6lXnKKC/WRv4CsYKvB4eZJLFSZLICaNIZFxjCqf
         sv1l9ExdI4TGvfDYEuqD6X/gTVOpQSb2/bhitmh/Fi7Gt3oucpZ1+ZXjeOCRvfArONHO
         QsgBIgPS/ZgYamFPjnd1tNJotkoWYoFKSQWJupoOIAgcGzdfo8oiCAGZ+JCvfEnnc2OO
         R/x/GPzicKdACefMVgAMUci0oTV8Io9b8Dv5VLvlHyhTuR33g3pMUoc/VxsQKBnMGD3f
         SJKw==
X-Gm-Message-State: AOAM533nktfDnVCNZZ1IqllUpN/BXeVOgEvg/8O6nI5ibWZzrWyj6uRS
        Ddp3hgnr/WzdggZuTF7FuzdXyeDeo4Mwpjku4BCpihP7ewHp02DOBkHru0Uehxt59/tKcAKfH9U
        6xC+HBs8sb5wytMVBXpdJywei
X-Received: by 2002:a17:907:3e02:: with SMTP id hp2mr1734659ejc.411.1609949575769;
        Wed, 06 Jan 2021 08:12:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyntH/OCzGtE/+g97D+DUOtBem9e810yAipQfVpUxvAQEnhbqhsMW3/dvmYfD93nwefrJ+tHQ==
X-Received: by 2002:a17:907:3e02:: with SMTP id hp2mr1734643ejc.411.1609949575624;
        Wed, 06 Jan 2021 08:12:55 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t26sm1463214eji.22.2021.01.06.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 08:12:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] x86/Hyper-V: Support for free page reporting
In-Reply-To: <20210106153523.nbnrkp4papebxqwy@liuwe-devbox-debian-v2>
References: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <87v9cagpor.fsf@vitty.brq.redhat.com>
 <20210106153523.nbnrkp4papebxqwy@liuwe-devbox-debian-v2>
Date:   Wed, 06 Jan 2021 17:12:54 +0100
Message-ID: <87pn2igi2h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Wed, Jan 06, 2021 at 02:28:20PM +0100, Vitaly Kuznetsov wrote:
> [...]
>> 
>> > +bool hv_query_ext_cap(u64 cap_query)
>> > +{
>> > +	u64 *cap;
>> > +	unsigned long flags;
>> > +	u64 ext_cap = 0;
>> > +
>> > +	/*
>> > +	 * Querying extended capabilities is an extended hypercall. Check if the
>> > +	 * partition supports extended hypercall, first.
>> > +	 */
>> > +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
>> > +		return 0;
>> > +
>> > +	/*
>> > +	 * Repurpose the input page arg to accept output from Hyper-V for
>> > +	 * now because this is the only call that needs output from the
>> > +	 * hypervisor. It should be fixed properly by introducing an
>> > +	 * output arg once we have more places that require output.
>> > +	 */
>> 
>> I remember there was a patch from Wei (realter to running Linux as root
>> partition) doing the job, we can probably merge it early to avoid this
>> re-purposing.
>> 
>
> We want to be frugal regarding memory usage, so in my patch the output
> page is only allocated when Linux is running as the root partition.
>
> This patch is mostly only useful when Linux is running as a child
> partition. This is a different use case.

Well, yea, while one 4k page per CPU is probably not much, why
allocating something we don't really need? The whole 're-purposing' idea
comes from the misleading 'hyperv_pcpu_input_arg' name, which can be
just 'hyperv_pcpu_arg' (and we can allocate two pages for root
partition).

All this is not a big deal, we can take a look again after root
partition support lands and do some cleanup if needed.

-- 
Vitaly

