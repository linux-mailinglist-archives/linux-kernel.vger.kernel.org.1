Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD41E2F2C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbhALKOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404541AbhALKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610446358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VM6GM0IaDz2hlz0q8YXUt3l7SKM8QedYnXh/3FqjAaU=;
        b=K5DEFVI/iYBloRGckBONZHe+dD8VJyKapz8eWX6G7a22bwWpNfmqAjuefMRcxFhOD0vCeY
        L2hwb2saXAF4mBQaLaBhnND+T3mUCGuD3kcdnuJFqwXMZPBhXBKMEXmPL9W9G/AhhW2G2G
        n5XAvFlh5QQGYm/NeR8Z/H7xSRlS5jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-v0tmCiTpO1WOMG5Rp9d6fA-1; Tue, 12 Jan 2021 05:12:34 -0500
X-MC-Unique: v0tmCiTpO1WOMG5Rp9d6fA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57D79CDA0;
        Tue, 12 Jan 2021 10:12:32 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55C771975F;
        Tue, 12 Jan 2021 10:12:31 +0000 (UTC)
Subject: Re: [PATCH 1/5] mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-2-osalvador@suse.de>
 <21932014-3027-8ad9-2140-f63500c641d7@redhat.com>
 <20210112072643.GA10774@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <feef406c-105c-138a-b8af-345684876e25@redhat.com>
Date:   Tue, 12 Jan 2021 11:12:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112072643.GA10774@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 08:26, Oscar Salvador wrote:
> On Mon, Jan 11, 2021 at 05:52:19PM +0100, David Hildenbrand wrote:
>> On 17.12.20 14:07, Oscar Salvador wrote:
>>> In order to use self-hosted memmap array, the platform needs to have
>>> support for CONFIG_SPARSEMEM_VMEMMAP and altmap.
>>> Currently, only arm64, PPC and x86_64 have the support, so enable those
>>> platforms with ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE.
>>
>> "In the first version, only .... will support it".
> 
> I will try to be more specific.
> 
>>
>> I'd probably split off enabling it per architecture in separate patches
>> and the end of the series.
> 
> You mean introducing only mm/Kconfig change in this patch, and then
> arch/*/Kconfig changes in separate patches at the end of the series?

Yeah, or squashing the leftovers of this patch (3 LOC) into patch #2.

> 
> I can certainly do that, not sure how much will help with the review,
> but it might help when bisecting.

It's usually nicer to explicitly enable stuff per architecture, stating
why it works on that architecture (and in the best case, even was
tested!). :)

-- 
Thanks,

David / dhildenb

