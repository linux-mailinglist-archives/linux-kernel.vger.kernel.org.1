Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFE2FEB37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbhAUNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729383AbhAUM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611233838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/QDx1uICxO7SRgcCMtNojL+VasBQOuT1uJCUPAbo6Y=;
        b=El4hhktXGBU9DHfON+EtYA6MIRMTnlZT1sDCCGAQGhJvEI/PFL4J4XAfNOWxKOHOWa+BLu
        7hrBFMl86dCjlxN6vTnCQKe0s6/34LYTMTa7ZVQxyVW3Yl8hc4qSAPF5B2CXN4CtEVaLyN
        6vchIF6PABbyPL6KrYdzPGU63AKZeyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-LBeykFJWPiqHrgC7_AUeUQ-1; Thu, 21 Jan 2021 07:57:14 -0500
X-MC-Unique: LBeykFJWPiqHrgC7_AUeUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CCFB19611AD;
        Thu, 21 Jan 2021 12:57:13 +0000 (UTC)
Received: from [10.72.12.73] (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76DDB60C6D;
        Thu, 21 Jan 2021 12:57:10 +0000 (UTC)
Subject: Re: [PATCH 2/2 v2] iommu: use the __iommu_attach_device() directly
 for deferred attach
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-3-lijiang@redhat.com>
 <20210119152939.GB3453587@infradead.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <0ee9d0a5-25f7-60ce-e6de-f7cacea990fa@redhat.com>
Date:   Thu, 21 Jan 2021 20:57:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210119152939.GB3453587@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph

在 2021年01月19日 23:29, Christoph Hellwig 写道:
>> +int iommu_do_deferred_attach(struct device *dev,
>> +			     struct iommu_domain *domain)
> 
> I'd remove the "do_" from the name, it doesn't really add any value.
> 
OK.

>> +{
>> +	const struct iommu_ops *ops = domain->ops;
>> +
>> +	if (unlikely(ops->is_attach_deferred &&
>> +		     ops->is_attach_deferred(domain, dev)))
>> +		return __iommu_attach_device(domain, dev);
>> +
>> +	return 0;
> 
> Now that everyting is under the static key we don't really need to
> bother with the unlikely micro optimization, do we?
> 
Good understanding. I can remove it, otherwise it should use the likely().

>> +extern int iommu_do_deferred_attach(struct device *dev,
>> +				    struct iommu_domain *domain);
> 
> No need for the extern.
> 
Sounds good. I will remove the 'extern' when I post again.

Thanks.
Lianbo

